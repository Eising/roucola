class Roucola < Sinatra::Base
    # This file configures the different environments
    
    # Configure the development environment here
    configure :development do
        # Database settings
        if settings.database["driver"] == "sqlite"
            DB = Sequel.connect("sqlite://#{settings.database["uri"]}")
        elsif settings.database["driver"] == "mysql2"
            DB = Sequel.mysql2 settings.database["database"], :user => settings.database["user"], :password => settings.database["password"], :host => settings.database["host"], :encoding => 'utf8'
        else
            DB = Sequel.connect("#{settings.database["driver"]}://#{settings.database["user"]}:#{settings.database["password"]}@#{settings.database["host"]}/#{settings.database["database"]}")
        end
        set :session_secret, "asfdsadsduy097"


    end


    # configure the production environment here
    configure :production do
        # Database settings
        if settings.database["driver"] == "sqlite"
            DB = Sequel.connect("sqlite://#{settings.database["uri"]}")
        elsif settings.database["driver"] == "mysql2"
            DB = Sequel.mysql2 settings.database["database"], :user => settings.database["user"], :password => settings.database["password"], :host => settings.database["host"], :encoding => 'utf8'
        else
            DB = Sequel.connect("#{settings.database["driver"]}://#{settings.database["user"]}:#{settings.database["password"]}@#{settings.database["host"]}/#{settings.database["database"]}")
        end




    end

end
