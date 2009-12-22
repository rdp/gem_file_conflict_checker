class ConflictChecker

  def check *dirs
    existing_list = {}
    conflict_list = []

    for dir in dirs
      for file in Dir[dir + '/*'] do
        just_file_name = File.filename(file)
        if existing_list[just_file_name]
          conflict_list << [existing_list[just_file_name], file]
        end
      end
    end
    conflict_list
  end

end