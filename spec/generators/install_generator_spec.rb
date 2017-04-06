require 'rails_helper'

RSpec.describe Gaas::InstallGenerator, type: :generator do
  destination File.join(Gaas::ROOT_PATH, 'tmp')

  before do
    prepare_destination
  end

  it 'creates the correct migration' do
    Timecop.freeze DateTime.new(2017, 4, 6, 13, 30, 54)
    run_generator

    expected_file = 'db/migrate/20170406133054_create_gaas_tables.rb'
    assert_file expected_file, /\Aclass CreateGaasTables < ActiveRecord::Migration\[5\.0\]/
    tables = File.read(File.join(destination_root, expected_file)).scan(/create_table.:(\w+)/).flatten
    expect(tables).to eq ['resources', 'gem_infos', 'gem_versions', 'gem_usages', 'vulnerabilities']
  end
end
