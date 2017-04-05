Gaas.configure do |c|
  c.rails_root = File.join Gaas::ROOT_PATH, 'spec', 'dummy'
  c.test_tmp_dir = File.join c.rails_root, 'tmp'
  c.private_dir = File.join c.test_tmp_dir, 'private'
end
