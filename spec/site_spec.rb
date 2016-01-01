require 'spec_helper'

describe Yapfac::Apache::Site do
  subject { Yapfac::Apache::Site }

  it { is_expected.to respond_to :load }
  
  context "when reading from file" do
    subject { Yapfac::Apache::Site.load('spec/test_files/sites-available/000-default.conf') }

    describe "#scopes" do
      it { expect(subject.scopes).to have_at_least(1).items }
      it { expect(subject.scopes.first.name).to eq "VirtualHost" }
      
      describe "#first #directives" do
        it { expect(subject.scopes.first.directives).to have_at_least(1).items }
      end
    end

    describe "#directives" do
      it { expect(subject.directives).to have_at_least(1).items }
    end
  end

  context "new site" do
    before do
      @site = Yapfac::Apache::Site.new('000-default')
      @site.add_scope Yapfac::Apache::Scope.new("VirtualHost", "*:80")
      @site.add_directive "DocumentRoot", "/test"
    end

    describe '#to_s' do
      subject { @site.to_s }
      it { is_expected.to_not match /000-default/ }
      it { is_expected.to match /<VirtualHost \*:80>/ }
      it { is_expected.to match /DocumentRoot\s+\/test/ }
    end
  end
end
