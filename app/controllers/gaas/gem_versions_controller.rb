class Gaas::GemVersionsController < GaasController
  def show
    @gem_version = Gaas::GemInfo.find(params[:gem_info_id]).gem_versions.find params[:id]
  end
end
