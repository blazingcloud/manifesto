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
    it "saves the gems data" do
      @reporter.gems.should == @gems
    end

    it "stores the reports directory" do
      @reporter.dir.should == @dir + "/manifestos"
    end
  end

  describe 'printing' do
    describe '#print' do
      before do
        `rm -rf #{@dir}/manifestos`
        @reporter.print
        @file_path = "#{@dir}/manifestos/manifest.txt"
      end

      after :all do
        `rm -rf #{@dir}/manifestos`
      end

      it "creates a manifestos directory if one does not exist" do
        Dir.exist?("#{@dir}/manifestos").should be_true
      end

      it "creates a file manifest.txt in the manifestos directory" do
        File.exist?(@file_path).should be_true
      end

      it "outputs the header into manifest.txt" do
        File.read(@file_path).should include Manifesto::Reporter::HEADER
      end

      it "outputs the body into manifest.txt" do
        File.read(@file_path).should include @reporter.body
      end
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
  end
end
