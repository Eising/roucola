Sequel.migration do
    change do
        alter_table :snippets do
            rename_column :tags, :keywords
        end
    end
end
