require 'spec_helper'
require 'pact/init/consumer'

describe Pact::Init::Consumer do
  describe '#run' do

    let(:spec_dir) { 'tmp/specz' }
    let(:provider_dir) { 'tmp/specz/service_providers' }
    let(:pact_helper_file) { provider_dir + '/' + 'pact_helper.rb' }

    before do
      FileUtils.rm_rf('tmp/specz')
    end

    context 'when no arguments are specified' do
      before { Pact::Init::Consumer.call spec_dir: spec_dir }

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates the sample code with default consumer provider names' do
        expected = File.read('spec/fixtures/consumer/pact_helper.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

    context 'when consumer and provider args are specified' do
      let(:consumer) { 'Foo Consumer' }
      let(:provider) { 'Bar Provider' }

      let(:consumer_and_provider_args) { {consumer: consumer, provider: provider, spec_dir: spec_dir} }

      before { Pact::Init::Consumer.call(consumer_and_provider_args) }

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the file with the given names' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates sample code with given consumer provider names' do
        expected = File.read('spec/fixtures/consumer/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

    context 'when either of the arguments have been given with leading and traliing white space' do
      let(:consumer) { '    Foo Consumer     ' }
      let(:provider) { '    Bar Provider     ' }

      let(:consumer_and_provider_args) { {consumer: consumer, provider: provider, spec_dir: spec_dir} }

      before { Pact::Init::Consumer.call(consumer_and_provider_args) }

      it 'strips the white space from both ends' do
        expected = File.read('spec/fixtures/consumer/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end
  end
end
