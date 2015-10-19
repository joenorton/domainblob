domainblob
==========
Domain Name Lookup Tool

Required Gems:
==============
* Whois
* Open-uri
* Resolv

How to use:
===========
```
ruby domainblob.rb insert_cool_word_here
```

2 Methods --- Command-line Arguments or Text File

Command-Line Args:  
1. When you run the script, with **ruby domainblob.rb insert_cool_word_here** then it will use your root phrase to check over 5,000 potential domain names for availability.  
2. Sit tight, it takes about 1 second per domain check. This amounts to somewhere between an hour and 2 for an entire batch to run.  
3. When it is done, it will create a text document named after the phrase you used as your seed - followed by the number found to be available. It will put this result file into your newly created 'blobs' folder. Example: blobs/Tech30.txt  

Text File:  
1. Create a txt document named **totalPhraseList.txt** in the same directory as the script  
2. The script will process each line of the **totalPhraseList.txt** document, so put one seed word per each line and they will be run right after another.  
3. When you run the script, with **ruby domainblob.rb** then it will use your root phrase to check a couple hundred potential domain names for availability.  
4. Sit tight.  
5. When it is done, it will create a text document named after the phrase you used as your seed - followed by the number of domains found. Example: blobs/Tech30.txt  

How Long Does it Take?
=====================
It takes a while. We do not use the RegEx & Zone File method for finding domain name availability. While that would be fastest, I do not have Zone File Access and even if I did -- I would not be allowed to distribute that Zone File.

License:
========
GNU GPLv3 (http://www.gnu.org/licenses/gpl.html)
