require 'spec_helper'

describe Yapfac do
  it 'has a version number' do
    expect(Yapfac::VERSION).not_to be nil
  end

  it { is_expected.to respond_to :configuration }
  it { is_expected.to respond_to :configure }

  describe "#configuration" do
    subject { Yapfac.configuration }
    it { is_expected.to respond_to :reset! }
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
