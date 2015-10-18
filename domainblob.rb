##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'whois'
require 'open-uri'
require 'resolv'

require_relative('constants.rb')
require_relative('domain_tools.rb')
require_relative('outputs.rb')
require_relative('util.rb')

def domainblob_main
  db_opts = fetch_opts(ARGV.map(&:dup))
  db_opts.each do |thePhrase|
   @whoiscounter, @httpcounter, @whoisdotnetcounter = 0, 0, 0
   @avail = []
   start_time = Time.now
   #
   thePhrase = sanitize_input(thePhrase)
   #
   make_and_or_nav_to_dir(thePhrase)
   #
   blobResults = File.new(thePhrase + RESULT_FILE_EXT, 'w+')
   #
   start_output(blobResults, thePhrase)
   # first we check all possible combos for the root phrase
   get_root_domains(thePhrase)
   # now we cycle through prefixes, then suffixes for this phrase
   cycle_thru_all_prefix_and_suffix_lists(thePhrase)
   #
   avail_num = @avail.length
   @avail = @avail.sort_by(&:length)
   #
   write_results(blobResults)
   #
   end_time = Time.now
   time_diff = end_time - start_time
   #
   ending_output(time_diff, avail_num, blobResults)
   blobResults.close
   #
   File.rename(
    thePhrase + RESULT_FILE_EXT,
    thePhrase + availNum.to_s + RESULT_FILE_EXT
   )
   #
   ending_output(time_diff, avail_num)
   Dir.chdir('..')
  end
end
domainblob_main
