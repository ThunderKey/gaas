class Gaas::ResourcesController < GaasController
  def index
    @resources = Gaas::Resource.all
  end

  def show
    @resource = Gaas::Resource.find params[:id]
  end

  def new
    @resource = Gaas::Resource.new
  end

  def update_data
    @resource = Gaas::Resource.find params[:resource_id]
    @resource.start_update!
    flash[:notice] = %Q{Started to update "#{@resource.name}"}
    redirect_back fallback_location: @resource
  end

  def create
    @resource = Gaas::Resource.new resource_params
    if @resource.save
      flash[:notice] = %Q{Successfuly saved "#{@resource.name}"}
      redirect_to @resource
    else
      render :new
    end
  end

  def edit
    @resource = Gaas::Resource.find params[:id]
  end

  def update
    @resource = Gaas::Resource.find params[:id]
    @resource.update_attributes resource_params
    if @resource.save
      flash[:notice] = %Q{Successfuly saved "#{@resource.name}"}
      redirect_to @resource
    else
      render :edit
    end
  end

  def destroy
    @resource = Gaas::Resource.find params[:id]
    @resource.destroy
    flash[:notice] = %Q{Successfuly deleted "#{@resource.name}"}
    redirect_to gaas_resources_path
  end

  private

  def resource_params
    params.require(:gaas_resource).permit(:name, :resource_type, :path, :build_url, :build_image_url)
  end
end
