require "tabledata/rails/view_helpers"

module Tabledata
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "tabledata-rails.view_helpers" do
        ActionView::Base.send(:include, Tabledata::Rails::ViewHelpers)
      end
    end
  end
end
