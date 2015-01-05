class Roucola < Sinatra::Base
    get '/nodes' do
        @pagetitle = "Nodes"
        @pagename = "nodes/index"
        @nodes = Nodes.where(:deleted => false).all
        haml :'nodes/index'
    end

    get '/nodes/add' do
        @pagetitle = "Add node"
        @pagename = "nodes/add"
        @snippets = Snippets.where(:deleted => false).all
        haml :'nodes/add'

    end

    post '/nodes/add' do
        templates = {}
        params[:templates].each do |key, value|
            templates[key] = { "snippet_id" => value }
        end
        params.each do |param, value|
            if res = param.match(/^(\d{7})_(.*)$/)
                begin
                    templates[res[1]][res[2]] = value
                rescue
                    flash['error'] = "Something went horribly wrong. Try again, please."
                    redirect to('/nodes/add')
                end
            end
        end
        
        name = params[:name]
        fqdn = params[:fqdn]

        node = Nodes.create(:name => name, :fqdn => fqdn, :template => template.to_json)
        flash["notice"] = "Node with id #{node.id} created"
        redirect to("/nodes/view/#{node.id}")
    end

    get '/nodes/view/:id' do
        @node = Nodes.where(:id => id, :delete => false).first
        if not @node
            halt(404)
        end
        config = ""
        template = JSON.parse(@node.template)
        template.each do |key, snippet_data|
            snippet_id = snippet_data["snippet_id"]
            snippet = Snippets.where(:id => snippet_id).first
            halt(404) if not snippet
            config += Mustache.render(snippet.template, snippet_data)
        end
        
        @config = config
        haml :'nodes/view'

    end

end
