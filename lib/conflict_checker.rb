class ConflictChecker

  # check some files
  # expects input like
  # :lib1 => 'lib/file1.rb',
  # :lib2 => 'lib/file2.rb'
  def check names_with_files
    existing_list = {}
    conflict_list = {}

    for name, files in names_with_files
      for file in files
        orig_file = file.dup
        file = file.split('/')[1..-1].join('/') # strip off lib/
        
        
        if file =~ /_plugin.rb$/ # ignore lib/rubygems_plugin.rb, which *can* be redundant across gems
          next
        end
        
        if file =~ /(.rb|.so)$/
          file = file.split('.')[0..-2].join('.') # strip off .rb .so
        else
         next # skip directories...
        end
        
        if existing_list[file]
          # add it to the bad list
          if conflict_list[file]
            conflict_list[file] << [name, orig_file] # add it to the list...
          else
           conflict_list[file] = [existing_list[file], [name, orig_file]]
         end
        end
        existing_list[file] = [name, orig_file]
      end
    end
    conflict_list
  end

  def self.do_all_gems
    all = {}; Gem.source_index.latest_specs.map{|s| all[s.name] = s.lib_files}
    collisions = ConflictChecker.new.check all
    if collisions.length > 0
      puts "warning: gem collisions detected! (they may be expected) your rubygems have one or more gems with conflicting filenames..."
      for filename, gems in collisions
        print " \"#{filename}\" was found redundantly in the libs of these gems: "
        puts gems.map{|gem_name, file_name| "#{gem_name} (#{file_name})"}.join(', ')
      end
    else
      puts "all clean--your rubygems has no reported conflicting filenames"
    end
    collisions
  end
end
