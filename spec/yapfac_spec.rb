require 'spec_helper'

describe Yapfac do
  it 'has a version number' do
    expect(Yapfac::VERSION).not_to be nil
  end

  it { is_expected.to respond_to :configuration= }
  it { is_expected.to respond_to :configuration }
  it { is_expected.to respond_to :configure }

  describe "#configuration" do
    subject { Yapfac.configuration }
    it { is_expected.to respond_to :reset! }
  end

  describe "#configuration=" do
    subject(:new_config) { Yapfac::Configuration.new }
    it { expect(Yapfac.configuration.apache_path).to eq "/etc/apache2" }

    context "after config assignment" do
      before do
        new_config.apache_path = "/new/config"
        Yapfac.configuration = new_config 
      end

      after { Yapfac.configuration.reset! }

      it { expect(new_config.apache_path).to eq "/new/config" }
      it { expect(Yapfac.configuration.apache_path).to eq "/new/config" }
    end
  end

  describe "#configuration.apache_path" do
    subject { Yapfac.configuration.apache_path }
    it { is_expected.to eq "/etc/apache2" }

    context "after changes" do
      before do
        Yapfac.configure do |config|
          config.apache_path = "/foo/bar"
        end
      end

      it { is_expected.to eq "/foo/bar" }
    end

    context "after reset" do
      before do
        Yapfac.configuration.reset!
      end

      it { is_expected.to eq "/etc/apache2" }
    end
  end
end
