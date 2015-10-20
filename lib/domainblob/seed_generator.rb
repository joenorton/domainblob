##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby

module Domainblob
    class SeedGenerator < DomainChecker
        def initialize(q, _options)
            super
            q.each do |seed_keyword|
                #
                seed_keyword = sanitize_input(seed_keyword)
                #
                make_and_or_nav_to_dir(RESULT_DIR_NAME)
                #
                f = File.new(seed_keyword + RESULT_FILE_EXT, 'w+')
                #
                @outputter.start_output(f, seed_keyword)
                # first we check all possible combos for the root phrase
                get_root_domains(seed_keyword)
                # now we cycle through prefixes, then suffixes for this phrase
                cycle_thru_all_prefix_and_suffix_lists(seed_keyword)
                #
                avail_num = @avail.length
                @avail = @avail.sort_by(&:length)
                #
                @outputter.write_results(f)
                #
                stop_clock
                #
                @outputter.ending_output(@time_diff, avail_num, f)
                f.close
                #
                File.rename(
                  seed_keyword + RESULT_FILE_EXT,
                  seed_keyword + availNum.to_s + RESULT_FILE_EXT
                )
                #
                @outputter.ending_output(@time_diff, avail_num)
                Dir.chdir('..')
            end
        end
    end
end
