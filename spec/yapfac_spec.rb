require 'spec_helper'

describe Yapfac do
  it 'has a version number' do
    expect(Yapfac::VERSION).not_to be nil
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
  end
end
