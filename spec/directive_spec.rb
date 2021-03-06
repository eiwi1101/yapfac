require 'spec_helper'

describe Yapfac::Apache::Directive do

  context "with no name" do
    it { expect { Yapfac::Apache::Directive.new }.to raise_error ArgumentError }
  end

  context "with name: Foo" do
    subject { Yapfac::Apache::Directive.new("Foo") }

    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :params }

    describe "#name" do
      it { expect(subject.name).to eq "Foo" }
    end

    describe "#params" do
      it { expect(subject.params).to be_empty }
    end
  end

  describe ":parse" do
    context "when parsing 'Foo bar baz'" do
      subject { Yapfac::Apache::Directive.parse("Foo bar baz") }
      
      describe "#name" do
        it { expect(subject.name).to eq "Foo" }
      end

      describe "#params" do
        it { expect(subject.params.count).to eq 2 }
        it { expect(subject.params).to include("bar", "baz") }
      end
    end

    context "with params: bar, baz" do
      subject { Yapfac::Apache::Directive.parse("Foo", "bar baz") }

      describe "#params" do
        it { expect(subject.params.count).to eq 2 }
        it { expect(subject.params).to include("bar", "baz") }
      end
    end

    context "with quoted params: 'bar baz', qux, \"frobulate all\"" do
      subject { Yapfac::Apache::Directive.parse("Foo", %q{'bar baz' qux "frobulate all"}) }

      describe "#params" do
        it { expect(subject.params.count).to eq 3 }
        it { expect(subject.params).to include("bar baz", "qux", "frobulate all") }
      end
    end
  end

  context "with params: bar, 'baz qux'" do
    subject { Yapfac::Apache::Directive.new("Foo", "bar", "baz qux") }

    describe "#params" do
      it { expect(subject.params.count).to eq 2 }
      it { expect(subject.params).to include("bar", "baz qux") }
    end

    describe "#to_s" do
      it { expect(subject.to_s).to be_kind_of String }
      it { expect(subject.to_s).to eq "Foo bar \"baz qux\"" }
    end
  end

end
