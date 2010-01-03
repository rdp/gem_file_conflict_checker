class ConflictChecker

  # check some files
  # expects input like
  # :lib1 => 'lib/file1.rb',
  # :lib2 => 'lib/file2.rb'
  def check names_with_files
    existing_list = {}
    conflict_list = {}
_dbg
    for name, files in names_with_files
      for file in files
          
          if existing_list[file]
            # add it to the bad list
            conflict_list[file] = [existing_list[file], name]
          end
          existing_list[file] = name
      end
    end
    conflict_list
  end

end