module EasyWbs
  module QueriesControllerPatch

    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        if private_method_defined?(:query_class)
          alias_method_chain :query_class, :easy_wbs
        end
      end
    end

    module InstanceMethods

      # Redmine return only direct sublasses but
      # Wbs query inherit from IssueQuery
      def query_class_with_easy_wbs
        case params[:type]
        when 'EasyWbs::IssueQuery'
          EasyWbs::IssueQuery
        else
          query_class_without_easy_wbs
        end
      end

    end

  end
end

RedmineExtensions::PatchManager.register_controller_patch 'QueriesController', 'EasyWbs::QueriesControllerPatch'
