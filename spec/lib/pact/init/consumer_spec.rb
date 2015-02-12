require 'spec_helper'
require 'pact/init/consumer'

describe Pact::Init::Consumer do
  describe '#new' do

    context 'when no arguments are specified' do

      let(:provider_dir) { 'specz/some_provider_dir' }
      let(:pact_helper_file) { provider_dir + '/' + 'pact_helper.rb' }

      before do
        allow_any_instance_of(Pact::Init::Consumer).to receive(:provider_dir).and_return(provider_dir)
        expect(Dir.exists?('specz/service_providers')).to eq(false)
        Pact::Init::Consumer.run
      end

      after do
        FileUtils.rm_rf('specz')
      end

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      xit 'generates the sample code with default consumer provider names' do

      end
    end

    context 'when --consumer and --provider args are specified' do

      xit 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      xit 'creates the file with the given names' do

      end

      xit 'generates sample code with given consumer provider names' do


      end

    end

    context 'when --consumer arg is specified only' do

      xit 'creates the directory' do

      end

      xit 'creates the helper file' do

      end

      xit 'generates sample code with given consumer name and default provider name' do


      end

    end

    context 'when --provider arg is specified only' do

      xit 'creates the directory' do

      end

      xit 'creates the helper file' do

      end

      xit 'generates sample code with given provider name and default consumer name' do

      end

    end

end

end
