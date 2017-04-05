class Gaas::UpdateResourceJob < ApplicationJob
  queue_as :default

  def perform(resource_id)
    service = Gaas::GemsuranceService.new Gaas::Resource.find(resource_id)
    service.update_gems
  end
end
