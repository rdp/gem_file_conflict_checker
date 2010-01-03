Gem.post_install {
  require 'conflict_checker'
  ConflictChecker.do_all_gems
}