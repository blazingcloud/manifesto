require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Manifesto::MatchMaker' do
  describe '.normalize' do
    it "converts line breaks into a single space" do
      Manifesto::MatchMaker.normalize("foo\nbar").should == "foo bar" 
    end

    it "aggregates grouped spaces characters into a single space character" do
      Manifesto::MatchMaker.normalize("foo    bar").should == "foo bar"
    end

    it "strips beginning and end spaces" do
      Manifesto::MatchMaker.normalize("  foo bar  ").should == "foo bar"
    end

    it "works with multiple lines and formations" do
      str = <<-STR
        Hello World!
        This is a test of the normalization functions of the manifesto!
        Proceed ...
      STR

      Manifesto::MatchMaker.normalize(str).should == 
        "Hello World! This is a test of the normalization functions of the manifesto! Proceed ..."
    end
  end

  describe '.load_licenses' do
    it "will gather all the license files and store the normalized version by key in .licenses" do
      Manifesto::MatchMaker.load_licenses

      Manifesto::MatchMaker.licenses['mit'].should_not be_nil 
      Manifesto::MatchMaker.licenses['ruby'].should_not be_nil
      Manifesto::MatchMaker.licenses['apache_2'].should_not be_nil
      Manifesto::MatchMaker.licenses['bsd'].should_not be_nil
      Manifesto::MatchMaker.licenses['gpl_2'].should_not be_nil
      Manifesto::MatchMaker.licenses['lgpl_2'].should_not be_nil
    end
  end

  describe '.find' do
    before do
      @comparitors_dir = File.dirname(__FILE__) + "/../lib/comparators"
    end

    it "will find exact matches to MIT" do
      mit = File.read("#{@comparitors_dir}/0_mit.txt")
      match = Manifesto::MatchMaker.find(mit)
      match['type'].should == 'MIT'
      match['percent_matched'].should == 100
    end

    it "will find exact matches to MIT with headers" do
      mit = File.read("#{@comparitors_dir}/0_mit.txt")
      mit = "Hey, I am going to write some addition legal stuff!\n\n#{mit}"
      match = Manifesto::MatchMaker.find(mit)
      match['type'].should == 'MIT'
      match['percent_matched'].should > 90
    end

    it "matches to the MIT with a copyright header " do
      mit = File.read("#{@comparitors_dir}/0_mit.txt")
      mit = "Copyright (c) 2012 Blazing Cloud, Inc.\n\n#{mit}"
      match = Manifesto::MatchMaker.find(mit)
      match['type'].should == 'MIT'
      match['percent_matched'].should < 100
    end
  end
end
