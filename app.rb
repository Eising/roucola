#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bundler"
require 'yaml'

Bundler.require

class Roucola < Sinatra::Base
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
    register Sinatra::AssetPack
    register Sinatra::ConfigFile

    assets do
        js :application, [
            '/js/*.js'
        ]
        css :application, [
            '/css/screen.css'
        ]
        js_compression :jsmin
        css_compression :simple
    end
    config_file "config/config.yml"

    # Flash
    enable :sessions
    register Sinatra::Flash

    # Specify the views folder (although default)
    set :views, settings.root + '/views'
    
    

end

# Load the environment specific settings

require File.dirname(__FILE__) + "/config/environments.rb"

# Load all helpers

Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each do |file| 
  require file

end

# Load up all models next
Dir[File.dirname(__FILE__) + "/models/*.rb"].each do |file| 
  require file
end

# Load up all controllers last
Dir[File.dirname(__FILE__) + "/controllers/*.rb"].each do |file| 
  require file
end
