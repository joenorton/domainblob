##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
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

def fetch_opts(arg_dup)
 if arg_dup[0]
    if arg_dup[0] == '-h' || arg_dup[0] == '--help'
      help?
      return false
    end
    q = arg_dup
 elsif File.file?(PHRASE_LIST_FILENAME)
    q = File.read(PHRASE_LIST_FILENAME)
    q = q.split('\n')
 else
   help?
   return false
 end
 return q
end
