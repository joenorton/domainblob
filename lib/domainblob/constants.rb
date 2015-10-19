##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
module Domainblob
    Dir[File.join(File.dirname(__FILE__), 'lists', '*.rb')].each {|file| eval(File.read(file)) }
    PHRASE_LIST_FILENAME = 'totalPhraseList.txt'
    RESULT_DIR_NAME = 'blobs'
    RESULT_FILE_EXT = '.txt'

    @prefix_array = [
      @mainPrefixArray,
      @statesArray,
      @scientificPrefixArray,
      @bothPreAndSuffixArray,
      (@latinPrefixArray + @latinPreAndSuffixArray)
    ]

    @suffix_array = [
      @mainSuffixArray,
      @locationSuffixArray,
      @bothPreAndSuffixArray,
      @latinPreAndSuffixArray
    ]
end