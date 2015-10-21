##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby

module Domainblob
    class SeedGenerator < DomainChecker
        def initialize(q, options)
            super
            @phrase_list_filename = q if options['phraselist']
            load_prefixes_and_suffixes
            if options['phraselist']
                start(File.readlines(@pwd + '/' + @phrase_list_filename))
            else
                start(q)
            end
            finish
        end
        def start(q)
            make_and_or_nav_to_dir(RESULT_DIR_NAME)
            q.each do |seed_keyword|
                #
                seed_keyword = sanitize_input(seed_keyword)
                #
                @result_file = File.new(seed_keyword + RESULT_FILE_EXT, 'w+')
                #
                @o.start_output(@result_file, seed_keyword)
                # first we check all possible combos for the root phrase
                get_root_domains(seed_keyword)
                # now we cycle through prefixes, then suffixes for this phrase
                cycle_thru_all_prefix_and_suffix_lists(seed_keyword)
            end
        end
        def finish
            avail_num = @avail.length
            @avail = @avail.sort_by(&:length)
            #
            @o.write_results(@result_file, @avail)
            #
            stop_clock
            #
            @o.ending_output(@time_diff, avail_num, @whoiscounter, @httpcounter, @result_file)
            @result_file.close
            #
            File.rename(
              seed_keyword + RESULT_FILE_EXT,
              seed_keyword + avail_num.to_s + RESULT_FILE_EXT
            )
            #
            @o.ending_output(@time_diff, avail_num, @whoiscounter, @httpcounter)
            Dir.chdir('..')
        end
        def load_prefixes_and_suffixes
          Dir[File.join(File.dirname(__FILE__), 'lists', '*.rb')].each {|file| eval(File.read(file)) }

          @prefix_array = [
            @mainPrefixArray,
            # @scientificPrefixArray,
            @bothPreAndSuffixArray,
            # (@latinPrefixArray + @latinPreAndSuffixArray)
          ]

          @suffix_array = [
            @mainSuffixArray,
            @locationSuffixArray,
            @bothPreAndSuffixArray,
           #@latinPreAndSuffixArray
          ]
        end
    end
end
