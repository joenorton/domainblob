##################################################################
# ####DomainBlob.rb -- quick domain-name lookup and idea generation
# ####created by Joe Norton
# ####http://norton.io
# #LICENSING: GNU GPLv3  License##################################
# ! usr/bin/ruby
def http_check_domain(query)
  begin
   entry = Resolv.getaddress(query)
 rescue Resolv::ResolvError
  return false # dns could not resolve, may still be registered
 rescue Timeout::Error
  retry # timeout, no info gained, retry?
 end
  if entry
    @httpcounter += 1
    return true # yes, domain is registered
 else
   return false # not sure why it would fail, so lets fail out of this f'n
 end
end

def domain_available?(w, domain)
  if http_check_domain(domain) # if exists - this passes, and we'll return false out of this f'n
    puts 'not available: ' + domain
    return false # domain not available, false
  else
    r = w.lookup(domain + '.com')
    @whoiscounter += 1
    if r.available?
      puts 'AVAILABLE: ' + domain
      @avail.push(domain) # yes, true, domain is available
      return true
    else
      puts 'not available: ' + domain
      return false
    end
  end
end

def get_root_domains(q)
  w = Whois::Client.new
  domain_available?(w, q + '.com')
  domain_available?(w, q + '.org')
  domain_available?(w, q + '.net')
  domain_available?(w, q + '.co')
  domain_available?(w, q + '.io')
  domain_available?(w, q + '.ly')
end

def cycle_thru_all_prefix_and_suffix_lists(thePhrase)
  Whois::Client.new do |w|
    for each_list in @prefix_array
      for each_entry in each_list
        domain_available?(w, each_entry + thePhrase + '.com')
      end
    end
    for each_list in @suffix_array
      for each_entry in each_list
        domain_available?(w, thePhrase + each_entry + '.com')
      end
    end
  end
end
