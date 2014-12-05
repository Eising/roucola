namespace :db do
    desc "Run migrations"
    task :migrate, [:version] do |t, args|
        require 'sequel'
        require 'yaml'
        Sequel.extension :migration
        if ENV['RACK_ENV']
            environment = ENV['RACK_ENV']
        else
            environment = "development"
        end
        config = YAML.load_file('config/config.yml')
        db = config[environment]["database"]
        case db["driver"]
        when "sqlite"
            DB = Sequel.connect("sqlite://#{db["uri"]}")
        when "mysql2"
            DB = Sequel.mysql2 db["database"], :user => db["user"], :password => db["password"], :host => db["host"], :encondig => "utf8"
        end
        if args[:version]
            puts "Migrating to version #{args[:version]}"
            Sequel::Migrator.run(DB, "db/migrations", target: args[:version].to_i)
        else
            puts "Migrating to latest"
            Sequel::Migrator.run(DB, "db/migrations")
        end
    end
end
