class Roucola < Sinatra::Base
    include Haml::Helpers
    def link_to(text, href, args=nil)
        b = Builder::XmlMarkup.new
        if args
            args[:href] = href
        else
            args = {:href => href}
        end
        xml = b.a(text, args)
        xml
    end
    
    def form_tag(url, options={}, &block)
        options = {
            :action => url,
            'accept-charset' => 'UTF-8'
        }
        options[:enctype] = 'multipart/form-data' if options.delete(:multipart)
        b = Builder::XmlMarkup.new
        contents = capture_haml(&block)
        xml = b.form(contents, options)
        xml
    end

    def field_set_tag(options={}, &block)
        contents = capture_haml(&block)
        b = Builder::XmlMarkup.new
        xml = b.fieldset(contents, options)
        xml
    end

    def input_field(type, options={}) 
        b = Builder::XmlMarkup.new
        options.update(:type => type)
        xml = b.input(options)
        xml

    end
    def text_field(name, options={})
        input_field(:text, {:name => name}.update(options))
    end

    def submit_tag(*args)
        options = args.extract_options!
        caption = args.length >= 1 ? args.first : "Submit"
        input_field(:submit, { :value => caption }.merge(options))
    end

end
