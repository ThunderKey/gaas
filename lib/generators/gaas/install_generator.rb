require 'rails/generators'

class Gaas::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.join(Gaas::ROOT_PATH, 'lib/generators/templates')

  def self.next_migration_number(_path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    migration_template "create_gaas_tables.rb", "db/migrate/create_gaas_tables.rb"
  end
end
