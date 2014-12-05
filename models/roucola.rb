class Snippets < Sequel::Model
    def after_save
        super
        # Audit logic
        # AuditTrail.create(
    end
end

class Structures < Sequel::Model

end

class Users < Sequel::Model

end

class Nodes < Sequel::Model

end

class Privileges < Sequel::Model

end

class AuditTrail < Sequel::Model

end
