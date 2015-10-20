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
            make_and_or_nav_to_dir(RESULT_DIR_NAME)
            @outputter.start_output(results_file, q_file)
            File.readlines(q_file).each do |q|
                q = sanitize_input(q.strip)
                get_root_domains(q)
            end
            avail_num = @avail.length
            @avail = @avail.sort_by(&:length)
            #
            @outputter.write_results(results_file)
            #
            stop_clock
            #
            @outputter.ending_output(@time_diff, avail_num, results_file)
            results_file.close
            #
            File.rename(
              q_file + RESULT_FILE_EXT,
              q_file + availNum.to_s + RESULT_FILE_EXT
            )
            #
            @outputter.ending_output(@time_diff, avail_num)
            Dir.chdir('..')
        end
    end
end
