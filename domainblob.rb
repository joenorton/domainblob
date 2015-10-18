##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://softwarebyjoe.com
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
  arg_dup = ARGV.map(&:dup)
  if arg_dup[0]
    if arg_dup[0] == '-h' || arg_dup[0] == '--help'
      help?
      return false
    end
    q = arg_dup
 elsif File.file?(PHRASE_LIST_FILENAME)
    q = File.read(PHRASE_LIST_FILENAME)
    q = q.split('\n')
 else
   help?
 end
  q.each do |thePhrase|
   @whoiscounter, @httpcounter, @whoisdotnetcounter = 0, 0, 0
   @avail = []

   thePhrase = sanitize_input(thePhrase)
   timeThen = Time.now

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
   availNum = @avail.length
   @avail = @avail.sort_by(&:length)
   #
   write_results(blobResults)
   #
   timeEnd = Time.now
   timeDiff = timeEnd - timeThen
   #
   ending_output(timeDiff, availNum, blobResults)
   blobResults.close
   File.rename(thePhrase + RESULT_FILE_EXT, thePhrase + availNum.to_s + RESULT_FILE_EXT)
   #
   ending_output(timeDiff, availNum)
   Dir.chdir('..')
 end
end
domainblob_main
