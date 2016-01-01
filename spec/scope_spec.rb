require 'spec_helper'

describe Yapfac::Apache::Scope do
  subject { Yapfac::Apache::Scope }

  before(:all) do
    @scope = Yapfac::Apache::Scope.new("VirtualHost", "*:80")
    @scope.add_directive Yapfac::Apache::Directive.parse("DocumentRoot /test")
    @scope.add_directive "Order", "allow,deny"
    @scope.add_scope Yapfac::Apache::Scope.new("Directory", "/test")
  end

  it { expect(@scope).to respond_to :scopes }
  it { expect(@scope).to respond_to :params }
  it { expect(@scope).to respond_to :name }
  it { expect(@scope).to respond_to :directives }

  context "when adding itsself as scope" do
    it { expect { @scope.add_scope @scope }.to raise_error RuntimeError }
  end

  describe "#scopes" do
    subject { @scope.scopes }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(1).items }
    it { expect(@scope.scopes.first.name).to eq "Directory" }
  end

  describe "#directives" do
    subject { @scope.directives }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(2).items }
    it { expect(@scope.directives.first.name).to eq "DocumentRoot" }
    it { expect(@scope.directives.last.name).to eq "Order" }
  end

  describe "#name" do
    subject { @scope.name }
    it { is_expected.to be_kind_of String }
    it { is_expected.to eq "VirtualHost" }
  end

  describe "#params" do
    subject { @scope.params }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(1).items }
    it { is_expected.to include("*:80") }
  end

  describe "#to_h" do
    subject { @scope.to_h }
    it { is_expected.to be_kind_of Hash }
    it { expect(subject.keys).to include(:name, :params, :scopes, :directives) }
    
    describe ":name" do
      subject { @scope.to_h[:name] }
      it { is_expected.to eq "VirtualHost" }
    end

    describe ":params" do
      subject { @scope.to_h[:params] }
      it { is_expected.to have_at_least(1).items }
      it { is_expected.to include("*:80") }
    end

    describe ":scopes" do
      subject { @scope.to_h[:scopes] }
      it { is_expected.to include(@scope.scopes.first.to_h) }
    end

    describe ":directives" do
      subject { @scope.to_h[:directives] }
      it { is_expected.to include(@scope.directives.first.to_h) }
    end
  end

  describe "#to_s" do
    subject { @scope.to_s }
    it { is_expected.to be_kind_of String }
    it { is_expected.to match /<VirtualHost \*:80>/ }
    it { is_expected.to match /DocumentRoot \/test/ }
    it { is_expected.to match /<\/VirtualHost>/ }
  end
end
