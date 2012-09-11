require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Manifesto::Inspector" do
  before :all do
    @path = File.dirname(__FILE__) + "/../"
    @inspector = Manifesto::Inspector.new @path
  end

  describe 'initialization' do
    it "takes a path to the root of the project" do
      @inspector.path.should == @path
    end

    it "will raise an error if can't find a Gemfile there" do
      expect {
        Manifesto::Inspector.new '/tmp'
      }.should raise_error
    end

    it "will call #bundle if no lock file is found" do
      File.stub(:new) # to prevent failure further down the init chain
      Manifesto::Inspector.any_instance.should_receive(:bundle)
      Manifesto::Inspector.new File.dirname(__FILE__) + "/fixtures"
    end

    it "stores a reference to the lock file" do
      @inspector.lockfile.should be_a File
      @inspector.lockfile.path.should == "#{@path}/Gemfile.lock"
    end
  end

  describe 'building a gem list' do
    before :all do
      @inspector.find_gems
    end

    it "compiles a list of gems" do
      %w(
        bundler
        diff-lcs
        git
        jeweler
        json
        multi_json
        rake
        rdoc
        rspec
        rspec-core
        rspec-expectations
        rspec-mocks
        simplecov
        simplecov-html
        yard
      ).each do |gem_name|
        @inspector.gem_list.should include gem_name
      end
    end

    it "the gem hash will contain the right version information" do
      @inspector.gems['json']['version'].should == '1.7.5'
    end
  end

  describe 'finding licenses' do
    before :all do
      @inspector.find_licenses
    end

    describe 'licenses bodys will be found in files matching' do
      it "LICENCE" do
        @inspector.gems['bundler']['licenses'][0]['body'].should match(/MIT License/)
        @inspector.gems['simplecov']['licenses'][0]['body'].should match(/Christoph Olszowka/)
      end

      it "licence.*" do
        @inspector.gems['rspec']['licenses'][0]['body'].should match(/David Chelimsky/)
        @inspector.gems['multi_json']['licenses'][0]['body'].should match(/Intridea/)
        @inspector.gems['jeweler']['licenses'][0]['body'].should match(/Josh Nichols/)
        @inspector.gems['diff-lcs']['licenses'][0]['body'].should match(/MIT License/)
      end

      it "COPYING.*" do
        @inspector.gems['json']['licenses'][0]['body'].should match(/copyrighted free software/)
      end

      it "LEGAL.*" do
        matched = false
        @inspector.gems['yard']['licenses'].each do |hash|
          matched ||= hash['body'].match(/lib\/parser\/c_parser.rb/)
        end
        matched.should_not == false
      end

      it "GPL.*" do
        matched = false
        @inspector.gems['json']['licenses'].each do |hash|
          matched ||= hash['body'].match(/GNU GENERAL PUBLIC LICENSE/)
        end
        matched.should_not == false
      end

      it "is empty if no licence is found" do
        @inspector.gems['git']['licenses'].should be_empty
      end
    end

    it "finds licenses for gems not in the standard gem location" do
      @inspector.gems['rake']['licenses'].size.should == 1
      @inspector.gems['rake']['licenses'][0]['body'].should match(/Jim Weirich/)
    end

    it "finds licenses for gems packaged by git" do
      @inspector.gems['wheel.js']['licenses'].size.should == 1
    end

    describe 'license match data' do
      it "includes type" do
        @inspector.gems['bundler']['licenses'][0]['type'].should == 'MIT'
      end
    end
  end
end

