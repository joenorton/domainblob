##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby

module Domainblob
    class QuickCheck < DomainChecker
        def initialize(q, options)
            super
            w = Whois::Client.new
            if domain_available?(w, q)
                return true
            else
                return false
            end
        end
    end
end
