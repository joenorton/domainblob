##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
def help?
  puts "\n###Usage: ruby domainblob.rb phrase\n" \
       "##Or, create 'totalPhraseList.txt' and add one phrase per line\n" \
       '##Thanks, try again.'
end

def start_output(blobResults, thePhrase)
  puts
  puts '###Started!###'
  puts 'Now analyzing domains with root: ' + thePhrase
  puts 'Please wait while Domainblob processes this request...'
  blobResults.puts
  blobResults.puts 'Now analyzing domains with root: ' + thePhrase
  true
end

def ending_output(timeDiff, availNum, blobResults = false)
  long_str = "\nProcess took: " + timeDiff.to_s + " seconds\n" +
             availNum.to_s + " domains were AVAILABLE\n" +
             (@whoiscounter + @httpcounter).to_s + " total domains were checked\n" \
             'Direct Whois ' + @whoiscounter.to_s + "\n" \
             'HTTP Check ' + @httpcounter.to_s
  if blobResults
    blobResults.puts long_str
  else
    puts long_str
  end
  true
end

def write_results(blobResults)
  blobResults.puts 'Available'
  blobResults.puts '#######################'
  for entry in @avail
    blobResults.puts entry
  end
  blobResults.puts
end
