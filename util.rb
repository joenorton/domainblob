def make_and_or_nav_to_dir(_thePhrase)
  if File.directory?(RESULT_DIR_NAME)
    Dir.chdir(RESULT_DIR_NAME)
 else
   Dir.mkdir(RESULT_DIR_NAME)
   Dir.chdir(RESULT_DIR_NAME)
 end
end

def sanitize_input(thePhrase)
  thePhrase.capitalize!
  thePhrase.strip!
  thePhrase
end
