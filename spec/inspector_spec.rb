require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Manifesto::Inspector" do
  before do
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
    before do
      @gem_directory = @inspector.find_gem_directory
    end

    it "finds the gem directory and stores it" do
      @inspector.should_receive(:find_gem_directory).and_return(@gem_directory)
      @inspector.find_gems
      @inspector.gem_directory.should match(/\/gems/) # rvm gemset uses a path including /gems
    end

    it "compiles a list of gems" do
      @inspector.find_gems
      @inspector.gem_list.should == %w(
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
      )
    end

    it "the gem hash will contain the right version information" do
      @inspector.find_gems
      @inspector.gems['json']['version'].should == '1.7.5'
    end
  end

  describe 'finding licence information' do
    before do
      pending('not yet implemented')
      @inspector.find_gems
    end

    it "adds a licence key to the gems hash" do
      @inpsector.gems['json']['licence'].should_not be_nil
    end

    it "licence value will be an array of hashes, with keys 'type' and 'body'" do
      @inspector.gems['json']['licence'].should be_an Array
      @inspector.gems['json']['licence'][0].keys should == ['type', 'body']
    end
  end
end

