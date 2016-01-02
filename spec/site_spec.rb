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

    describe "class instance" do
      subject { @site }

      it { is_expected.to respond_to :save }
      it { is_expected.to respond_to :filename }

      it { is_expected.to respond_to :add_scope }
      it { is_expected.to respond_to :add_directive }
      it { is_expected.to respond_to :scopes }
      it { is_expected.to respond_to :directives }

      it { is_expected.to_not respond_to :scopes= }
      it { is_expected.to_not respond_to :directives= }
    end

    describe '#to_s' do
      subject { @site.to_s }
      it { is_expected.to_not match /000-default/ }
      it { is_expected.to match /<VirtualHost \*:80>/ }
      it { is_expected.to match /DocumentRoot\s+\/test/ }
    end
  end

  context 'after save' do
    before do
      Yapfac.configure do |config|
        config.apache_path = "spec/test_files"
      end

      @site2 = Yapfac::Apache::Site.new('001-example') do |site|
        site.add_directive "DocumentRoot"
        site.add_scope "VirtualHost"
      end

      @site2.save

      puts @site2.filename
    end

    describe '#filename' do
      it { expect(@site2.filename).to eq "spec/test_files/sites-available/#{@site2.name}.conf" }
    end

    describe 'config file' do
      it 'is expected to exist' do
        File.file?(@site2.filename)
      end

      it { expect(File.read(@site2.filename)).to eq @site2.to_s }
    end

    after do
      FileUtils.rm @site2.filename
      Yapfac.configuration.reset!
    end
  end
end
