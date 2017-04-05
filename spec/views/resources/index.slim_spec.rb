require 'rails_helper'

RSpec.describe 'gaas/resources/index.slim' do
  it 'displays all resources correctly' do
    3.times { create :resource }
    assign :resources, Gaas::Resource.all

    render

    expect(rendered).to match /Test App 1/
    expect(rendered).to match /Test App 2/
    expect(rendered).to match /Test App 3/
  end
end
