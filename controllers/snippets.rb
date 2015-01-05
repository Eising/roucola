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
        @snippet = params[:snippet]
        @tags = get_template_tags(@snippet)
        @validators = load_validators
        @name = params[:name]
        @keywords = params[:keywords]

        haml :'snippets/configure'
    end

    post '/snippets/create' do
        # Save the snippet
        keywords = params[:keywords]
        snippet = params[:snippet]
        name = params[:name]
        if keywords
            keywords = keywords.split(/,/).map {|s| s.gsub /^\s?/, '' }
        end
        fields = {}
        params.each do |param, value|
            if param =~ /^tag_(.*)$/
                fields[$1] = value
            end
        end

        res = Snippets.create(:name => name, :keywords => keywords, :template => snippet, :fields => fields.to_json, :version => 1)
        
        flash[:notice] = "Snippet #{res.id} created sucessfully"
        redirect to("/snippets")

    end

    # Present a snippet as a form. Use hourminutesecondmilisecond as unique key
    get '/snippets/:id.form' do
        @key = Time.now.strftime('%H%M%S%L')
        @snippet = Snippets.where(:id => params['id']).first
        @fields = JSON.parse @snippet.fields
        @validators = load_validators
        if not @snippet
            halt(404)
        end

        haml :'snippets/form', :layout =>  false

    end
end

