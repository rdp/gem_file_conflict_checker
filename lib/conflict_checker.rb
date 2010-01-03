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
        file = file.split('/')[1..-1].join('/')
        if existing_list[file]
          # add it to the bad list
          if conflict_list[file]
            conflict_list[file] << name # add it to the list...
          else
           conflict_list[file] = [existing_list[file], name]
         end
        end
        existing_list[file] = name
      end
    end
    conflict_list
  end

  def self.do_all_gems
    all = {}; Gem.source_index.latest_specs.map{|s| all[s.name] = s.lib_files}
    collisions = ConflictChecker.new.check all
    if collisions.length > 0
      puts "warning: collisions detected (they may be unexpected! Your rubygems' have two or more gems with conflicting filenames..."
      for filename, gems in collisions
        puts "\"#{filename}\" was  found redundantly in the libs of: #{gems.inspect}"
      end
    else
      puts "all clean--your rubygems has no reported conflicting filenames"
    end
    collisions
  end
end
