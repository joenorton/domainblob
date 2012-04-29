domainblob
==========
Domain Name Lookup Tool

Required Gems:
==============
*Nokogiri
*Whois
*Open-uri

How to use:
===========
1. Create a txt document named 'totalPhraseList.txt' in the same directory as the script
2. When you run the script, with 'ruby domainblob.rb' then it will use your root phrase to check over 5,000 potential domain names for availability.
3. When it is done, it will create a txt. document named after the phrase you used as your seed.
4. The script will process each line of the totalPhraseList.txt document, so put one word per each phrase

License:
========
GNU GPLv3
