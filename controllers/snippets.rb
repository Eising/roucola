class Roucola < Sinatra::Base

    get '/snippets' do
        # List all snippets
        
        @snippets = Snippets.all
        haml :'snippets/index'
    end

    get '/snippets/add' do
        @pagetitle = "Add snippet"
        @pagename = "snippets_add"
        # Compose the snippet

        haml :'snippets/add', :layout => :layout
    end

    post '/snippets/configure' do
        # Configure tags
        snippet = params[:snippet]
        @tags = get_template_tags(snippet)
        @validators = load_validators

        haml :'snippets/configure'
    end

    post '/snippets/create' do
        # Save the snippet


    end
end

