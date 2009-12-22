require 'spec/autorun'
require 'sane'
require __dir__ + '/../lib/conflict_checker'
require 'rubygems'

describe "conflict plugin" do

   before do
    @a = ConflictChecker.new    
  end

  it "should alert you of potential conflicts" do
    @a.check('test1', 'test2').should == [['test1/go.rb', 'test2/go.rb']]
  end
  
  it "should alert you of gem conflicts" do
    _dbg
     @a.check Gem.push_all_highest_version_gems_on_load_path
  end
  
  it "should allow for star" do
    @a.check *Gem.push_all_highest_version_gems_on_load_path
  end
  
  it "should also do subdir clashes"

end