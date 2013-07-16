require 'activeadmin-sortable/version'
require 'activeadmin'
require 'rails/engine'

module ActiveAdmin
  module Sortable
    module ControllerActions
      def sortable
        member_action :sort_up, :method => :post do
          resource.move_higher
          head 200
        end

        member_action :sort, :method => :post do
          resource.insert_at(params[:position].to_i)
          head 200
        end

        member_action :sort_down, :method => :post do
          resource.move_lower
          head 200
        end
      end
    end

    module TableMethods
      HANDLE_UP = '&#x2191;'.html_safe
      HADNLE_SORT = '&#x2195;'.html_safe
      HANDLE_DOWN = '&#x2193;'.html_safe

      def sortable_handle_column
        column '', :class => "activeadmin-sortable" do |resource|
          sort_up_url = url_for([:sort_up, :admin, resource])
          sort_url = url_for([:sort, :admin, resource])
          sort_down_url = url_for([:sort_down, :admin, resource])

          up = content_tag :span, HANDLE_UP, :class => 'handle_up', 'data-sort-url' => sort_up_url
          sort = content_tag :span, HADNLE_SORT, :class => 'handle', 'data-sort-url' => sort_url
          down = content_tag :span, HANDLE_DOWN, :class => 'handle_down', 'data-sort-url' => sort_down_url
          "#{up} #{sort} #{down}".html_safe
        end
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

    class Engine < ::Rails::Engine
      # Including an Engine tells Rails that this gem contains assets
    end
  end
end


