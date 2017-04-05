module Gaas #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def gaas_routes
        scope module: :gaas, as: :gaas do
          resources :resources do
            put :update_data
          end
          resources :gem_infos, path: '/gems', only: [:index, :show]
          resources :gem_versions, path: '/gems/:gem_info_id/versions', only: [:show]
          resources :vulnerabilities, only: [:index]
        end
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, Gaas::Routing::MapperExtensions
