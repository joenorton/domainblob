##################################################################
#####DomainBlob.rb -- quick domain-name lookup and idea generation
#####created by Joe Norton
#####http://softwarebyjoe.com
##LICENSING: GNU GPLv3  License##################################
#! usr/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'whois'
require 'open-uri'
require 'resolv'

load 'prefix_array.rb'
load 'suffix_array.rb'

def ask_whois_dotnet(query)
	begin
		doc = Nokogiri::HTML(open('http://www.whois.net/whois/'+query,'User-Agent' => 'ruby'))
		linkArray = []
		doc.xpath('//div/h1/span').each do |link|
			linkArray.push(link.content)
		end
		$whoisdotnetcounter += 1
		if(linkArray[0] == "available")
			puts "AVAILABLE: " + query
			$avail.push(query)
			return true
		elsif(linkArray[0] == "not available")
			puts "not available: " + query
			return false
		end
	rescue Timeout::Error
		retry #timeout, no info gained, retry?
	end
end

def http_check_domain(query)
	begin
		entry = Resolv.getaddress(query)
	rescue Resolv::ResolvError
		return false #dns could not resolve, may still be registered
	rescue Timeout::Error
		retry #timeout, no info gained, retry?
	end
	if entry
		$httpcounter += 1
		return true #yes, domain is registered
	else
		return false #not sure why it would fail, so lets fail out of this f'n
	end
end

def checkDomain(domain)
	if (http_check_domain(domain)) #if exists - this passes, and we'll return false out of this f'n
		puts "not available: " + domain
		return false #domain not available, false
	else
		begin
			$c = Whois::Client.new(:timeout => nil)
			 r = $c.lookup(domain)
			$whoiscounter += 1
			 if (r.available?)
				puts "AVAILABLE: " + domain
				$avail.push(domain) #yes, true, domain is available
				return true
			 else
				puts "not available: " + domain
				return false #domain not available, false
			 end
		rescue
			whoisdotnet = ask_whois_dotnet(domain)
			return whoisdotnet
		end
	end
end

def get_root_domains(q)
	checkDomain(q+".com")
	checkDomain(q+".org")
	checkDomain(q+".net")
	checkDomain(q+".co")
	checkDomain(q+".io")
	checkDomain(q+".ly")
end

def domainblob_main()
	arg_dup = ARGV.map(&:dup)
	if arg_dup[0]
		q = arg_dup
	elsif (File.file?("totalPhraseList.txt"))
		q = File.read("totalPhraseList.txt")
		q = q.split('\n')
	else
		puts
		puts "###Usage: ruby domainblob.rb phrase"
		puts "##Or, create 'totalPhraseList.txt' and add one phrase per line"
		puts "##Thanks, try again."
		return false
	end
	q.each do |thePhrase|
		$whoiscounter = 0
		$httpcounter = 0
		$whoisdotnetcounter = 0
		$avail = []
		
		thePhrase.capitalize!
		thePhrase.strip!
		timeThen = Time.now

		if File::directory?("blobs")
		 Dir.chdir("blobs")
		 blobResults = File.new(thePhrase+".txt","w+")
		else
		 Dir.mkdir("blobs")
		 Dir.chdir("blobs")
		 blobResults = File.new(thePhrase+".txt","w+")
		end
		puts
		puts "###Started!###"
		puts "Now analyzing domains with root: "+thePhrase
		puts "Please wait while Domainblob processes this request..."
		blobResults.puts
		blobResults.puts "Now analyzing domains with root: "+thePhrase
		#first we check all possible combos for the root phrase
		get_root_domains(thePhrase)
		#now we cycle through prefixes, then suffixes for this phrase
		for each in @prefixArray
			checkDomain(each + thePhrase + ".com")
		end
		for each in @suffixArray
			checkDomain(thePhrase + each + ".com")
		end
		availNum = $avail.length
		blobResults.puts "Available"
		blobResults.puts "#######################"
		for entry in $avail
			blobResults.puts entry
		end
		blobResults.puts
		timeEnd = Time.now
		timeDiff = timeEnd - timeThen
		
		blobResults.puts
		blobResults.puts "Process took: " + timeDiff.to_s + " seconds"
		blobResults.puts availNum.to_s + " domains were AVAILABLE"
		blobResults.puts ($whoiscounter + $whoisdotnetcounter + $httpcounter).to_s + " total domains were checked"
		blobResults.puts "Direct Whois " + $whoiscounter.to_s
		blobResults.puts "WhoisDotNet " + $whoisdotnetcounter.to_s
		blobResults.puts "HTTP Check " + $httpcounter.to_s
		blobResults.close
		File.rename(thePhrase+".txt", thePhrase+availNum.to_s+".txt")

		puts
		puts "Process took: " + timeDiff.to_s + " seconds"
		puts availNum.to_s + " domains were AVAILABLE"
		puts ($whoiscounter + $whoisdotnetcounter + $httpcounter).to_s + " total domains were checked"
		puts "Direct Whois " + $whoiscounter.to_s
		puts "WhoisDotNet " + $whoisdotnetcounter.to_s
		puts "HTTP Check " + $httpcounter.to_s
		Dir.chdir("..")
	end
end
domainblob_main()
