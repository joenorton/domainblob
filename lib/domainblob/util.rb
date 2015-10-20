##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
module Domainblob
  class Util

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
  end
end
