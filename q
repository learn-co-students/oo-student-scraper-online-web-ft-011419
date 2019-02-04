
[1mFrom:[0m /home/sim/oo-student-scraper-online-web-ft-011419/lib/scraper.rb @ line 25 Scraper.scrape_profile_page:

    [1;34m18[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m19[0m:       doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m20[0m:       file={}
    [1;34m21[0m:       [1;34m#this is the links css   (".social-icon-container a") .attribute("href").value[0m
    [1;34m22[0m:       links=doc.css([31m[1;31m"[0m[31m.social-icon-container a[1;31m"[0m[31m[0m).map{|data|data.attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value}
    [1;34m23[0m:       links.each [32mdo[0m|tag|
    [1;34m24[0m: 
 => [1;34m25[0m: binding.pry
    [1;34m26[0m:  [1;34m# links are all the links[0m
    [1;34m27[0m: [1;34m#tag is each social media check for validty[0m
    [1;34m28[0m:                 [32mif[0m tag.include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m)
    [1;34m29[0m:                   file[[33m:linkedin[0m]= tag
    [1;34m30[0m:                 [32melsif[0m tag.include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m31[0m:                     file[[33m:github[0m]= tag
    [1;34m32[0m:                   [32melsif[0m tag.include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m33[0m:                       file[[33m:twitter[0m]= tag
    [1;34m34[0m:                     [32melse[0m
    [1;34m35[0m:                         file[[33m:blog[0m]= tag
    [1;34m36[0m:                 [32mend[0m
    [1;34m37[0m:           [32mend[0m
    [1;34m38[0m:           file[[33m:profile_quote[0m] =doc.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text [32mif[0m doc.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m) [1;34m#quote[0m
    [1;34m39[0m:           file[[33m:bio[0m] =doc.css([31m[1;31m"[0m[31m.description-holder[1;31m"[0m[31m[0m).text.gsub([35m[1;35m/[0m[35m[1;35m\s[0m[35m+[1;35m/[0m[35m[0m, [31m[1;31m"[0m[31m [1;31m"[0m[31m[0m) [32mif[0m  doc.css([31m[1;31m"[0m[31m.description-holder[1;31m"[0m[31m[0m)   [1;34m#bio[0m
    [1;34m40[0m: 
    [1;34m41[0m:     [1;34m# binding.pry[0m
    [1;34m42[0m:       file
    [1;34m43[0m:       [32mend[0m

