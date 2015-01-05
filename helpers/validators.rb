class Roucola < Sinatra::Base
    def load_validators
        validators = YAML.load_file("#{settings.root}/config/validators.yml")
        p validators
        validators
    end
end
