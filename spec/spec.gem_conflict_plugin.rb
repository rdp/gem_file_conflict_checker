require 'spec/autorun'
require 'sane'
require __dir__ + '/../lib/conflict_checker'

describe "conflict plugin" do

   before do
    @a = ConflictChecker.new
    @b = ['test1', 'test2']
  end

  it "should alert you of potential conflicts" do
    _dbg
    @a.check(*@b).should == [['test1/go.rb', 'test2/go.rb']]
  end

end