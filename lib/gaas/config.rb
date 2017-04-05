class Gaas::Config
  attr_accessor :rails_root, :private_dir, :url_regex, :git_command, :test_tmp_dir

  def initialize
    @url_regex = /\A#{URI::regexp(['http', 'https'])}\z/
    @git_command = '/usr/bin/git'
    @rails_root = Gaas::ROOT_PATH
  end

  def private_dir
    @private_dir ||= File.join rails_root, 'private'
  end
end
