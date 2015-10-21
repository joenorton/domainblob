##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby

module Domainblob
    class CheckFile < DomainChecker

        def initialize(q_file, options)
            super
            q_file = q_file.first
            results_file = File.new(q_file + '_results' + RESULT_FILE_EXT, 'w+')
            start(q_file, results_file)
        end

        def start(q_file, results_file)
            make_and_or_nav_to_dir(RESULT_DIR_NAME)
            @o.start_output(results_file, q_file)
            w = Whois::Client.new
            seeds = File.readlines(@pwd + '/' + q_file + RESULT_FILE_EXT)
            for q in seeds
                q.strip!
                next if q.nil? || q.empty?
                lg(q)
                if valid_url?(q)
                    begin
                        domain_available?(w, q)
                    rescue
                        next
                    end
                else
                    if valid_url?(q+'.com')
                        begin
                            domain_available?(w, q+'.com')
                        rescue
                            next
                        end
                    end
                    next
                end
            end
            finish(q_file, results_file)
        end

        def finish(q_file, results_file)
            avail_num = @avail.length
            @avail = @avail.sort_by(&:length)
            #
            @o.write_results(results_file, @avail)
            #
            stop_clock
            #
            @o.ending_output(
                timeDiff = @time_diff,
                availNum = avail_num,
                whoiscounter = @whoiscounter,
                httpcounter = @httpcounter,
                blobResults = results_file
            )
            results_file.close
            #
            File.rename(
              @pwd + '/' + q_file + '_results'  + RESULT_FILE_EXT,
              @pwd + '/' + q_file + '_results'  + avail_num.to_s + RESULT_FILE_EXT
            )
            #
            Dir.chdir('..')
        end
    end
end
