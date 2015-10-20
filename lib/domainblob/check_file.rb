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
            File.readlines(@pwd + '/' + q_file + RESULT_FILE_EXT).each do |q|
                q = sanitize_input(q.strip)
                domain_available?(w, q)
            end
            finish(q_file, results_file)
        end

        def finish(q_file, results_file)
            avail_num = @avail.length
            @avail = @avail.sort_by(&:length)
            lg('timediff')
            lg(@time_diff)
            lg('avail num')
            lg(avail_num)
            lg('whoiscounter')
            lg(@whoiscounter)
            lg('httpcounter')
            lg(@httpcounter)
            #
            @o.write_results(results_file, @avail)
            #
            stop_clock
            #
            '''
            @o.ending_output(
                timeDiff = @time_diff || 0,
                availNum = avail_num || 0,
                whoiscounter = @whoiscounter || 0,
                httpcounter = @httpcounter || 0,
                blobResults = results_file
            )
            '''
            results_file.close
            #
            File.rename(
              @pwd + '/' + q_file + '_results'  + RESULT_FILE_EXT,
              @pwd + '/' + q_file + '_results'  + avail_num.to_s + RESULT_FILE_EXT
            )
            #
            @o.ending_output(@time_diff, avail_num)
            Dir.chdir('..')
        end
    end
end
