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
end
