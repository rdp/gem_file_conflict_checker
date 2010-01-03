require 'spec/autorun'
require 'sane'
require __dir__ + '/../lib/conflict_checker'
require 'rubygems'

describe "conflict plugin" do

  before do
    @a = ConflictChecker.new
    Gem.clear_paths 
  end

  it "should alert you of potential conflicts" do
    conflict = {:lib1 => ['lib/go.rb'], :lib2 => ['lib/go.rb']}
    @a.check(conflict).should == {'lib/go.rb' => [:lib1, :lib2]}
  end

=begin example  
  # pp Gem.source_index.latest_specs[0].lib_files
["lib/map_reduce",
 "lib/map_reduce.rb",
 "lib/starfish.rb",
 "lib/map_reduce/active_record.rb",
 "lib/map_reduce/array.rb",
 "lib/map_reduce/file.rb"]
=end
  
  it "should alert you of gem conflicts" do
     pending
  
     
     @a.check Gem.push_all_highest_version_gems_on_load_path
  end
  
  it "should also do subdir clashes"

  it "should work with non lib directories"

end