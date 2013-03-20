if Rails.env != 'test' then
  secrets = YAML.load_file(Rails.root.join("config", "highrise.yml"))
  Highrise::Base.site = secrets.fetch('highrise')['site']
  Highrise::ClientId = secrets.fetch('highrise')['client-id']
  Highrise::ClientSecret = secrets.fetch('highrise')['client-secret']
end