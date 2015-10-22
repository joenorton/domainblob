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
            start(q)
        end

        def start(q)
            w = Whois::Client.new
            q.each do |domain|
                domain_available?(w, domain)
            end
        end
    end
end
