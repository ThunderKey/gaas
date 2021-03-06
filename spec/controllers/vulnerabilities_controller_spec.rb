require 'rails_helper'

RSpec.describe Gaas::VulnerabilitiesController, type: :controller do
  describe 'GET #index' do
    it 'displays 0 resources' do
      get :index
      expect(assigns(:vulnerabilities)).to eq []
    end

    it 'displays 3 resources' do
      resource = create :resource
      v1 = create :vulnerability
      v2 = create :vulnerability
      v3 = create :vulnerability
      v4 = create :vulnerability

      [v1, v2, v4].each do |v|
        resource.gem_versions << v.gem_version
      end

      get :index
      expect(assigns(:vulnerabilities)).to eq [v1, v2, v4]
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end
