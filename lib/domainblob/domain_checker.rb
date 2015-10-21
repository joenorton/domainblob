##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby

module Domainblob
    class DomainChecker
        require 'whois'
        require 'resolv'
        RESULT_DIR_NAME = 'blobs'
        RESULT_FILE_EXT = '.txt'
          def initialize(q, options)
            @whoiscounter = 0
            @httpcounter = 0
            @whoisdotnetcounter = 0
            @avail = []
            @start_time = Time.now
            @o = Domainblob::Outputs.new
            @pwd = Dir.pwd
            setup_options(options)
          end

          def setup_options(options)
                @verbose = true if options['verbose']
          end

          def make_and_or_nav_to_dir(_thePhrase)
             if File.directory?(RESULT_DIR_NAME)
                Dir.chdir(RESULT_DIR_NAME)
             else
               Dir.mkdir(RESULT_DIR_NAME)
               Dir.chdir(RESULT_DIR_NAME)
             end
          end
          def sanitize_input(q)
            q.strip
          end
          def valid_domain_name?(url)
            if url =~  /[#$&;=\[\]()_~\,?]/
                false
            else
                if url =~  /\./
                    lg('passed')
                    lg(url)
                    true
                else
                    false
                end
            end
          end
          def http_check_domain(query)
            begin
             entry = Resolv.getaddress(query)
           rescue Resolv::ResolvError
            return false # dns could not resolve, may still be registered
           rescue Timeout::Error
            retry # timeout, no info gained, retry?
           end
            if entry
              @httpcounter += 1
              return true # yes, domain is registered
           else
             return false # not sure why it would fail, so lets fail out of this f'n
           end
          end

          def domain_available?(w, domain)
            if http_check_domain(domain) # if exists - this passes, and we'll return false out of this f'n
              puts 'not available: ' + domain
              return false # domain not available, false
            else
              begin
                  r = w.lookup(domain)
                  @whoiscounter += 1
                  if r.available?
                    puts 'AVAILABLE: ' + domain
                    @avail.push(domain) # yes, true, domain is available
                    return true
                  else
                    puts 'not available: ' + domain
                    return false
                  end
              rescue Whois::ConnectionError
                    puts 'ConnectionError - skipping'
                    return false
              end
            end
          end

          def get_root_domains(q)
            w = Whois::Client.new
            domain_available?(w, q + '.com')
            domain_available?(w, q + '.org')
            domain_available?(w, q + '.net')
            domain_available?(w, q + '.co')
            domain_available?(w, q + '.io')
            domain_available?(w, q + '.ly')
          end

          def cycle_thru_all_prefix_and_suffix_lists(thePhrase)
            Whois::Client.new(:timeout => nil) do |w|
              for each_list in @prefix_array
                for each_entry in each_list
                  domain_available?(w, each_entry + thePhrase + '.com')
                end
              end
            end
            Whois::Client.new(:timeout => nil) do |w|
              for each_list in @suffix_array
                for each_entry in each_list
                  domain_available?(w, thePhrase + each_entry + '.com')
                end
              end
            end
          end
        def stop_clock
            @end_time = Time.now
            @time_diff = @end_time - @start_time
        end
        def errlog(msg)
          fail "ERROR: #{msg}"
        end

        def lg(msg)
          puts "### #{msg}" if @verbose
        end
    end
end
