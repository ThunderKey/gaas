class Gaas::GemInfosController < GaasController
  include JsChartHelper

  def index
    @gem_infos = Gaas::GemInfo.all
  end

  def show
    @gem_info = Gaas::GemInfo.find params[:id]
    @versions_data = transform_to_chart_data @gem_info.gem_versions.map {|v| {name: v.version, data: v.resources.count} }
  end
end
