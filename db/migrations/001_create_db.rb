Sequel.migration do
    change do
        create_table :snippets do
            primary_key :id
            String :name
            String :tags
            String :template, :text => true
            String :fields, :text => true
            DateTime :timestamp, :null => false, :default => Time.now
            Fixnum :version
            TrueClass :deleted, :default => false
        end
        create_table :audit_trail do
            primary_key :id
            DateTime :timestamp, :null => false, :default => Time.now
            Fixnum :user_id
            String :action, :text => true
        end
        create_table :users do
            primary_key :id
            String :login, :null => false
            String :realname, :null => false
            String :email
            String :password
            Fixnum :privilege_level
        end
        create_table :nodes do
            primary_key :id
            String :name, :null => false
            String :fqdn, :null => false
            String :template, :text => true
            TrueClass :deleted, :default => false
            TrueClass :published, :default => false
            DateTime :timestamp, :default => Time.now
        end
        create_table :privileges do
            primary_key :id
            String :uri
            Fixnum :privilege_level
        end
    end
end
