APP_CONFIG = YAML.load(File.read("#{RAILS_ROOT}/config/config.yml"))[RAILS_ENV]
