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

end
