##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
module Domainblob
    class CLI
        def initialize(q, options)
            if options['checkfile']
                Domainblob::CheckFile.new(q, options)
            elsif options['quickcheck']
                Domainblob::QuickCheck.new(q, options)
            else
                Domainblob::SeedGenerator.new(q, options)
            end
        end
    end
end