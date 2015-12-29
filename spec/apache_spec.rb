require 'spec_helper'

describe Yapfac::Apache do
  subject { Yapfac::Apache }

  before do
    Yapfac.configure do |config|
      config.apache_path = "spec/test_files"
    end
  end

  after do
    Yapfac.configuration.reset!
  end

  # Basic Things

  it { is_expected.to respond_to :load_site }
  it { is_expected.to respond_to :sites_available }
  it { is_expected.to respond_to :sites_enabled }

  # Future Things
  # When complete, move to the Basic Things block and replace
  # pending with 'it'.

  pending { is_expected.to respond_to :a2ensite }
  pending { is_expected.to respond_to :a2dissite }
  pending { is_expected.to respond_to :a2ensite! }
  pending { is_expected.to respond_to :a2dissite! }
  pending { is_expected.to respond_to :reload! }
  pending { is_expected.to respond_to :restart! }

  describe ':load_site' do
    subject { Yapfac::Apache.load_site '000-default' }
    it { is_expected.to be_kind_of Yapfac::Apache::Site }
  end

  describe ':sites_available' do
    subject { Yapfac::Apache.sites_available }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(2).items }
    it { is_expected.to include('000-default') }
  end

  describe ':sites_enabled' do
    subject { Yapfac::Apache.sites_enabled }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(1).items }
    it { is_expected.to include('000-default') }
  end

end
