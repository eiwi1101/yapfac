require 'spec_helper'

describe Yapfac::Apache::Scope do
  subject { Yapfac::Apache::Scope }

  context "instance" do
    subject { Yapfac::Apache::Scope.new("VirtualHost", "*:80") }
    
    before do
      subject.add_directive Yapfac::Apache::Directive.parse("DocumentRoot /test")
      subject.add_scope Yapfac::Apache::Scope.new("Directory", "/test")
    end

    it { is_expected.to respond_to :scopes }
    it { is_expected.to respond_to :params }
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :directives }

    context "when adding itsself as scope" do
      it { expect { subject.add_scope subject }.to raise_error RuntimeError }
    end

    describe "#scopes" do
      subject { subject.scopes }
      it { is_expected.to be_kind_of Array }
      it { is_expected.to have_at_least(1).items }
    end

    describe "#directives" do
      subject { subject.directives }
      it { is_expected.to be_kind_of Array }
      it { is_expected.to have_at_least(1).items }
    end

    describe "#name" do
      subject { subject.name }
      it { is_expected.to be_kind_of String }
    end

    describe "#params" do
      subject { subject.params }
      it { is_expected.to be_kind_of Array }
      it { is_expected.to have_at_least(1).items }
    end

    describe "#to_h" do
      subject { subject.to_h }
      it { is_expected.to be_kind_of Hash }
      # TODO: Validate hash output.
    end
  end
end
