require 'erb'

module Pact
  module Init
    class Provider

      def self.call(options = {})
        new.run(options)
      end

      def run(options)
        @options = parse_options(options)
        @spec_dir = options[:spec_dir] || 'spec'
        create_directory
        create_files
        generate_pact_helper
        generate_provider_states
      end

      def create_directory
        FileUtils.mkdir_p(consumer_dir)
      end

      def create_files
        FileUtils.touch(consumer_dir+'/'+'pact_helper.rb')
        FileUtils.touch(consumer_dir+'/'+'provider_states_for_my_consumer.rb')
      end

      def consumer_dir
        File.join(@spec_dir, 'service_consumers')
      end

      def generate_pact_helper
        template_string = File.read(File.expand_path( '../templates/provider/pact_helper.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(consumer_dir+'/'+'pact_helper.rb', "w+"){ |f| f.write(render) }
      end

      def generate_provider_states
        template_string = File.read(File.expand_path('../templates/provider/provider_states_for_my_consumer.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(consumer_dir+'/'+'provider_states_for_my_consumer.rb', "w+"){ |f| f.write(render) }
      end

      def parse_options(options)
        options[:consumer] ||= 'My Consumer' unless options.has_key? :consumer
        options[:provider] ||= 'My Provider' unless options.has_key? :provider
        options
      end

      def consumer_name
        @options[:consumer].strip
      end

      def provider_name
        @options[:provider].strip
      end
    end
  end
end
