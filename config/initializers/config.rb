APP_CONFIG = YAML.load(File.read("#{Rails.root}/config/config.yml")).symbolize_keys
