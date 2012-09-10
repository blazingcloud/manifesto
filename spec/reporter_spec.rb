require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Manifesto::Reporter' do
  before :all do
    inspector = Manifesto::Inspector.new(File.dirname(__FILE__) + "/..")
    inspector.find_licenses
    @gems = inspector.gems
    @dir = File.dirname(__FILE__) + "/.."
  end

  before do
    @reporter = Manifesto::Reporter.new({
      :gems => @gems,
      :dir => @dir
    })
  end

  describe 'initialization' do
    it "stores the gems data" do
      @reporter.gems.should == @gems
    end

    it "stores the reports directory" do
      @reporter.dir.should == @dir + "/manifestos"
    end
  end

  describe 'printing' do
    before do
      `rm -rf #{@dir}/manifestos`
      Manifesto::Reporter.print({
        :gems => @gems,
        :dir => @dir
      })
    end

    after :all do
      `rm -rf #{@dir}/manifestos`
    end

    it "creates a manifestos directory if one does not exist" do
      Dir.exist?("#{@dir}/manifestos").should be_true
    end

    it "creates files for all formats" do
      File.exist?("#{@dir}/manifestos/manifest.txt").should be_true
      File.exist?("#{@dir}/manifestos/manifest.md").should be_true
      File.exist?("#{@dir}/manifestos/manifest.json").should be_true
    end
  end

  describe 'text format' do
    before do
      `rm -rf #{@dir}/manifestos`
      Manifesto::Reporter.print({
        :gems => @gems,
        :dir => @dir
      })
      @reporter = Manifesto::Reporter::Text.new({
        :gems => @gems,
        :dir => @dir
      })
      @file = File.read("#{@dir}/manifestos/manifest.txt")
    end

    after :all do
      `rm -rf #{@dir}/manifestos`
    end

    it "outputs the header into report" do
      @file.should include Manifesto::Reporter::HEADER
    end

    it "outputs the body into report" do
      @file.should include @reporter.body
    end

    it "outputs the exceptions into the report" do
      @file.should include @reporter.exceptions
    end

    describe "#header" do
      it "explains how the manifest was generated" do
        @reporter.header.should match /created by the gem Manifesto/
      end

      it "includes information about the time it was generated" do
        now = Time.now
        Time.stub(:now).and_return(now)
        @reporter.header.should include "Generated at: #{now}"
      end
    end

    describe '#body' do
      it "includes an entry for each gem" do
        body = @reporter.body
        @gems.keys.each do |gem_name|
          body.should include gem_name
        end
      end
    end

    describe '#exceptions' do
      it "lists the gems that have no licenses" do
        @reporter.exceptions.should include "git"
      end
    end
  end
end
