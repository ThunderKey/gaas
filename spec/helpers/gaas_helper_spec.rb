require 'rails_helper'

RSpec.describe GaasHelper, type: :helper do
  describe '#build_image_tag' do
    build_url = 'https://example.com/build'
    build_image_url = 'https://example.com/build.svg'

    it 'generates the image and the link if both are present' do
      resource = create :resource, build_url: build_url, build_image_url: build_image_url
      html = helper.build_image_tag resource
      expect(html).to eq %Q{<a target="_blank" href="#{build_url}"><img class="build-image" src="#{build_image_url}" alt="Build" /></a>}
    end

    it 'generates the image if the build url is missing' do
      resource = create :resource, build_image_url: build_image_url
      html = helper.build_image_tag resource
      expect(html).to eq %Q{<img class="build-image" src="#{build_image_url}" alt="Build" />}
    end

    it 'generates nothing if the build and image url is missing' do
      resource = create :resource
      html = helper.build_image_tag resource
      expect(html).to eq nil
    end

    it 'generates nothing if the image url is missing' do
      resource = create :resource, build_url: build_url
      html = helper.build_image_tag resource
      expect(html).to eq nil
    end
  end

  describe '#absolute_path_regex' do
    it { expect('/').to match helper.absolute_path_regex }
    it { expect('/test').to match helper.absolute_path_regex }
    it { expect('/test/directory/').to match helper.absolute_path_regex }
    it { expect('/test/directory/my-test_project.git').to match helper.absolute_path_regex }
    it { expect('/abcdefghijklmnop').to match helper.absolute_path_regex }
    it { expect('/qrstuvwxyz').to match helper.absolute_path_regex }
    it { expect('/0123456789').to match helper.absolute_path_regex }
    it { expect('/-_').to match helper.absolute_path_regex }
    it { expect('test/directory/').not_to match helper.absolute_path_regex }
    it { expect('/test /directory/').not_to match helper.absolute_path_regex }
  end

  describe '#gemsurance_regex' do
    describe 'matches' do
      it 'a minimal correct output' do
        expect(%Q{Retrieving gem version information...\nRetrieving latest vulnerability data...\nReading vulnerability data...\nGenerating report...\nGenerated report #{Gaas.config.private_dir}/gemsurance_reports/1/gemsurance_report.yml.}).to match helper.gemsurance_regex
      end
      it 'a different formated correct output' do
        expect(<<-TXT).to match helper.gemsurance_regex

  Retrieving gem version information...
  Retrieving latest vulnerability data...
  Reading vulnerability data...
  Generating report...
  Generated report #{Gaas.config.private_dir}/gemsurance_reports/1/gemsurance_report.yml.

TXT
      end
    end

    describe "doesn't match an output" do
      it 'with an invalid path' do
        expect(%Q{Retrieving gem version information...\nRetrieving latest vulnerability data...\nReading vulnerability data...\nGenerating report...\nGenerated report #{Gaas.config.private_dir}/gemsurance_reports/1 /gemsurance_report.yml.}).not_to match helper.gemsurance_regex
      end

      it 'with only an error message' do
        expect(%Q{Could not find bunlder}).not_to match helper.gemsurance_regex
      end

      it 'with an additional error message' do
        expect(%Q{Retrieving gem version information...\nRetrieving latest vulnerability data...\nReading vulnerability data...\nGenerating report...\nGenerated report #{Gaas.config.private_dir}/gemsurance_reports/1/gemsurance_report.yml.But something failed!}).not_to match helper.gemsurance_regex
      end
    end
  end

  describe '#gem_status_tr' do
    it { expect(helper.gem_status_tr('current'){}).to eq '<tr class="current" title="Current"></tr>' }
    it { expect(helper.gem_status_tr('outdated'){}).to eq '<tr class="outdated" title="Outdated"></tr>' }
    it { expect(helper.gem_status_tr('vulnerable'){}).to eq '<tr class="vulnerable" title="Vulnerable"></tr>' }

    it { expect(helper.gem_status_tr('current', color: false){}).to eq '<tr class="" title="Current"></tr>' }
    it { expect(helper.gem_status_tr('current'){'<br/>'.html_safe}).to eq '<tr class="current" title="Current"><br/></tr>' }
  end
end
