module Tabledata
  module Rails
    module ViewHelpers
      def render_tabledata(table, i18n_scope: nil)
        content_tag(:table, class: "table table-striped".freeze) {
          concat(
            content_tag(:thead) {
              content_tag(:tr) {

                table.headers.each_with_index { |header_name, index|
                  next unless is_column_displayed?(table.column_definition(index))

                  concat(
                    content_tag(
                      :th,
                      t(
                        i18n_head_key(
                          table.column_definition(index).accessor,
                          i18n_scope
                        )
                      ),
                      class: ["tabledata-header", table.column_definition(index).accessor],
                    )
                  )
                }
              }
            }
          ).concat(
            content_tag(:tbody) {
              table.body.each { |row|
                concat(
                  content_tag(:tr) {
                    row.present(:view).each_with_index { |column, index|
                      column_definition = table.column_definition(index)
                      next unless is_column_displayed?(column_definition)

                      concat(
                        content_tag(:td, class: error_classes(row, column_definition)) {
                          concat(column)
                          concat(
                            content_tag(
                              :i,
                              "".freeze,
                              class: "error-hint icon-info-sign alert".freeze,
                              data: {toggle: "tooltip".freeze, html: true},
                              title: error_text(row, column_definition, i18n_scope),
                            )
                          ) if column_has_error?(row, column_definition)
                        }
                      )
                    }
                  }
                )
              }
            }
          )
        }
      end

      private

      def error_text(row, column_definition, i18n_scope)
        error_texts = []
        accessor    = column_definition.accessor

        row.column_errors[accessor].each do |key, options|
          error_texts << t(i18n_error_key(accessor, key, i18n_scope), options)
        end

        error_texts.join("<br />".freeze)
      end

      def i18n_head_key(column_name, i18n_scope)
        [
          i18n_scope,
          ".".freeze,
          "tabledata".freeze,
          ".".freeze,
          "header".freeze,
          ".".freeze,
          column_name
        ].compact!.join
      end

      def i18n_error_key(column_name, key, i18n_scope)
        [
          i18n_scope,
          ".".freeze,
          "tabledata".freeze,
          ".".freeze,
          "column_errors".freeze,
          ".".freeze,
          column_name,
          ".".freeze,
          key.to_s
        ].compact!.join
      end

      def column_has_error?(row, column_definition)
        row.column_errors.has_key?(column_definition.accessor)
      end

      def error_classes(row, column_definition)
        column_has_error?(row, column_definition) ? "error".freeze : "success".freeze
      end

      def is_column_displayed?(column_definition)
        column_definition.options.fetch(:html, {display: true})[:display]
      end
    end
  end
end
