class Roucola < Sinatra::Base
    def db_get_template_tags(id)
        snippet_text = Snippets.where(:id => id).first.template
        if snippet_text
            tags = Mustache::Template.new(snippet_text).tags
        else
            tags = []
        end
        tags 
    end
    def get_template_tags(snippet_text)
        begin
            tags = Mustache::Template.new(snippet_text).tags
        rescue
            tags = []
        end
        tags 
    end
end
