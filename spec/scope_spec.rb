require 'spec_helper'

describe Yapfac::Apache::Scope do
  subject { Yapfac::Apache::Scope }

  before(:all) do
    @scope = Yapfac::Apache::Scope.new("VirtualHost", "*:80")
    @scope.add_directive Yapfac::Apache::Directive.parse("DocumentRoot /test")
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
  end

  describe "#directives" do
    subject { @scope.directives }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(1).items }
  end

  describe "#name" do
    subject { @scope.name }
    it { is_expected.to be_kind_of String }
  end

  describe "#params" do
    subject { @scope.params }
    it { is_expected.to be_kind_of Array }
    it { is_expected.to have_at_least(1).items }
  end

  describe "#to_h" do
    subject { @scope.to_h }
    it { is_expected.to be_kind_of Hash }
    # TODO: Validate hash output.
  end
end
