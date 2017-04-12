require 'rails/all'
require 'slim'
require 'sidekiq'
require 'open3'

require 'gaas/config'

module Gaas
  ROOT_PATH = File.dirname(File.dirname(__FILE__))

  mattr_reader :config
  @@config = Config.new

  def self.configure &block
    block.call config
  end
end

require 'gaas/routing'
require 'gaas/git_repository'
require 'generators/gaas/install_generator'

app_dir = File.join Gaas::ROOT_PATH, 'app'

%w{ controllers  helpers  jobs  mailers  models  services }.each do |dir|
  path = File.join app_dir, dir
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end

ActionController::Base.prepend_view_path File.join(app_dir, 'views')

Dir.glob(File.join(Gaas::ROOT_PATH, 'lib', 'locales', '*.{rb,yml}')).each do |f|
  I18n.load_path << f
end
