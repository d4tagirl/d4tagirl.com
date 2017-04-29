---
layout: post
title:  How to fetch Twitter users with R
date: "2017-04-20 12:11:29 UYT"
published: true
tags: [rstats, r, Twitter, rtweet, purrr, map, ggmap]
description: How to fetch Twitter users and clean the data using R!
---
Here I show how to fetch Twitter users using the `rtweet` package, and clean the data using the `tidyverse` set of packages, for later usage in plotting animated maps.  

<!--more-->

Recently [I came across this post](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/), and I knew I had to make a similar map for the [R-Ladies' chapters](http://rladies.org/) (probably the purple color had plenty to do with that 💜 ). So my idea was to map all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it, since it's  

If I wanted to show everything I've done in a single post, it would be almost as long as my first one! And I didn't want that 😝 . So I decided to make 2 _tutorial-like_ posts: one for the data preparation (this very one), and the second one about making the maps and animating them. And finally other post where I just go through what I did without getting into too many details, focusing on the visualisation results. 

So here I go!

# Getting Twitter users

I had to learn how to retrieve data from the Twitter API, and I chose to use the `rtweet` package, which is super easy to use! 

Every R-Ladies' chapter uses a standard handle, using the *RLadiesLocation* format (thankfully they are very compliant with this!). By setting the `q` parameter to `'RLadies'` I'm setting the query to be searched. `n = 1000` sets the amount of users to retrieve, being 1000 the maximum number of users returned from a single search. As I want a dataframe as a result, I set the `parse` parameter to `TRUE`.

Since I only use public data I don't have to worry about getting my Twitter personal access token (for now at least).




```r
library(rtweet)

users <- search_users(q = 'RLadies',
                      n = 1000,
                      parse = TRUE)
```

Let's see what it returns:


```r
library(DT)
datatable(users[, c(2:5)], rownames = FALSE,
          options = list(pageLength = 5))
```

<!--html_preserve--><div id="htmlwidget-6303853a6981f6a0d267" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6303853a6981f6a0d267">{"x":{"filter":"none","data":[["R-Ladies Global","R-Ladies SF","R-Ladies London","R-Ladies RTP","R-Ladies Connecticut","Alice Data","Gabriela de Queiroz","Chiin","Mine Dogucu","Jennifer Thompson","R-Ladies Istanbul","R-Ladies BCN","R-Ladies NYC","R-Ladies Boston 🐟","R-Ladies LA 🌴","R-Ladies Madrid","R-Ladies AU","R-Ladies Paris","R-Ladies Lisbon","R-Ladies Berlin","R-Ladies Valencia","R-Ladies Nashville","R-Ladies Columbus","R-Ladies Austin","R-Ladies Ames","R-Ladies DC","R-Ladies LdnOnt","R-Ladies BuenosAires","RLadiesDublin","R-Ladies Manchester","R-Ladies Tbilisi","R-Ladies Munich","R-Ladies Adelaide","Dr Louise J. Slater","Daniela Vázquez","Katherine Scranton","Nurse Stephanie","R Ladies Twin Cities","R-Ladies Budapest","RLadiesIzmir","R-Ladies Munich","R-Ladies Adelaide","Dr Louise J. Slater","Daniela Vázquez","Katherine Scranton","Nurse Stephanie","R Ladies Twin Cities","R-Ladies Budapest","RLadiesIzmir","R-Ladies Lima","R-Ladies Cape Town","RLadiesRio","楽天市場のレディースファッション配信","JuniorRangers ladies","R-Ladies Santa Rosa","WomenRLadies","pacificatré","Royal Ladies","R-Ladies Montreal","rockNroyaltyl","R-Ladies Munich","R-Ladies Adelaide","Dr Louise J. Slater","Daniela Vázquez","Katherine Scranton","Nurse Stephanie","R Ladies Twin Cities","R-Ladies Budapest","RLadiesIzmir","R-Ladies Lima","R-Ladies Cape Town","RLadiesRio","楽天市場のレディースファッション配信","JuniorRangers ladies","R-Ladies Santa Rosa","WomenRLadies","pacificatré","Royal Ladies","R-Ladies Montreal","rockNroyaltyl","R-Ladies Munich","R-Ladies Adelaide","Dr Louise J. Slater","Daniela Vázquez","Katherine Scranton","Nurse Stephanie","R Ladies Twin Cities","R-Ladies Budapest","RLadiesIzmir","R-Ladies Lima","R-Ladies Cape Town","RLadiesRio","楽天市場のレディースファッション配信","JuniorRangers ladies","R-Ladies Santa Rosa","WomenRLadies","pacificatré","Royal Ladies","R-Ladies Montreal","rockNroyaltyl"],["RLadiesGlobal","RLadiesSF","RLadiesLondon","RLadiesRTP","RLadiesCT","alice_data","gdequeiroz","AnalyticsPanda","MineDogucu","jent103","RLadiesIstanbul","RLadiesBCN","RLadiesNYC","RLadiesBoston","RLadiesLA","RLadiesMAD","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesValencia","RLadiesNash","RLadiesColumbus","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesLdnOnt","RLadiesBA","RLadiesDublin","RLadiesManchest","RLadiesTbilisi","RLadiesMunich","RLadiesAdelaide","LouiseJES","d4tagirl","DrScranto","QueensRLadies","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesMunich","RLadiesAdelaide","LouiseJES","d4tagirl","DrScranto","QueensRLadies","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadies_LF","Junior_RLadies","RLadiesSR","WomenRLadies","Rstn_RLadies13","RLadies","RLadiesMTL","RnRladies","RLadiesMunich","RLadiesAdelaide","LouiseJES","d4tagirl","DrScranto","QueensRLadies","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadies_LF","Junior_RLadies","RLadiesSR","WomenRLadies","Rstn_RLadies13","RLadies","RLadiesMTL","RnRladies","RLadiesMunich","RLadiesAdelaide","LouiseJES","d4tagirl","DrScranto","QueensRLadies","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadies_LF","Junior_RLadies","RLadiesSR","WomenRLadies","Rstn_RLadies13","RLadies","RLadiesMTL","RnRladies"],["The World","San Francisco","London, England","Durham, NC","Connecticut, USA","London","San Francisco","London, England","Columbus, OH","Nashville","İstanbul, Türkiye","Barcelona, Spain","New York","Boston, MA","Los Angeles, CA","Madrid, Spain","Melbourne, Victoria","Paris, France",null,"Berlin, Deutschland","Valencia, España","Nashville, TN","Columbus, OH","Austin, TX","Ames, IA","Washington, DC","London, Ontario","Buenos Aires, Argentina","Dublin City, Ireland","Manchester, England","Tbilisi","Munich, Bavaria","Adelaide, South Australia","Loughborough University","Montevideo, Uruguay","Los Angeles, CA","NY-PA...NC","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Munich, Bavaria","Adelaide, South Australia","Loughborough University","Montevideo, Uruguay","Los Angeles, CA","NY-PA...NC","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","東京","orpington","Santa Rosa, Argentina","Wisconsin Rapids, WI","Buku Tahunan Sekolah","Italia",null,null,"Munich, Bavaria","Adelaide, South Australia","Loughborough University","Montevideo, Uruguay","Los Angeles, CA","NY-PA...NC","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","東京","orpington","Santa Rosa, Argentina","Wisconsin Rapids, WI","Buku Tahunan Sekolah","Italia",null,null,"Munich, Bavaria","Adelaide, South Australia","Loughborough University","Montevideo, Uruguay","Los Angeles, CA","NY-PA...NC","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","東京","orpington","Santa Rosa, Argentina","Wisconsin Rapids, WI","Buku Tahunan Sekolah","Italia",null,null],["Promoting Gender Diversity in the #rstats community via meetups, mentorship &amp; global collaboration! 30+ groups worldwide: US|Europe|Oceania|LatAm|Asia #RLadies","R-Ladies is the first group dedicated to women and R. It was founded in Oct 2012 to promote knowledge, support and inclusivity. #rstats #RLadies","The first R programming meetup for Minority Genders in the UK! Promoting Diversity &amp; Inclusivity in STEM/Data Science\nlondon@rladies.org \n#RLadiesLondon #rstats",null,"Promoting &amp; connecting women (and self-identified) interested in R programming throughout Connecticut!","Data Scientist @BritishMuseum | Trained in quantbio+conservation loves R, science, improv | Proud Introvert #quiet | @RLadiesGlobal co-founder #RLadies🌍","Founder of #RLadies | Lead Data Scientist @SelfScore | Past: @Sharethrough, @AlpineDataLabs, @ensp, @IMSUERJ | ❤️ #rstats","Head of #DataScience, #RLadies Tech Community Leader, Humanist. ENTJ. Gender Equality &amp; STEM access, Open Source. ex-@Cambridge_Uni Econs. F1+Burger junkie","Statistics | DataScience | MissingData | Feminism | Languages | founder of @RLadiesColumbus  | fan of #rstats | fan of #RLadies | views my own","A well-rounded conversationalist and a standup woman. Statistician, aunt, traveler, knitter, among other things. Co-founder, #RLadies Nashville (@RLadiesNash).","Istanbul's first R Programming Meetup for Women #rladies #rstats Come and join us!","We are part of a world-wide organization to promote gender diversity in the #rstats community #RLadies https://t.co/mWCmJ4f1lr Tweets by @Rebitt &amp; @ma_salmon","We are the proud Ladies who R! In New York via Meetup, mentoring and collaboration #rstats #RLadies","R-Ladies Boston is part of a world-wide organization to promote\ngender diversity in the R community #RLadies #rstats #rcodladies","R-Ladies Los Angeles is part of a world-wide organization to promote gender diversity in the R community #RLadies #rstats https://t.co/mWCmJ4wCcZ","R-Ladies es la comunidad que ayuda a aumentar la diversidad de género en la comunidad #rstats y los trabajos en el campo STEM. #RLadiesMAD | 100% A TOPE","Aims to create a community for women interested in R language in Melbourne. No matter how you define your gender, join us if you support the diversity!","We're a group of Ladies who love #Rstats. Come join us at our upcoming meet-up!","Olá! Welcome to R Ladies Lisbon - Promoting the role of women in the R community as part of #RLadiesGlobal initiative. Collaborate, learn and share with us.","R-Ladies Berlin is a local chapter of the worldwide R-Ladies group. More information at https://t.co/hmY7DgRF77.","Promoting the role of women in the R community as part of #RLadiesGlobal initiative. #rstats #RLadiesValencia","R-Ladies Nashville is part of a worldwide organization to promote gender diversity in the R community. More info: https://t.co/hmY7DgRF77 #RLadies #rstats","R-Ladies Columbus is part of a world-wide organization to promote gender diversity in the R community. #RLadies #rstats  columbus@rladies.org","R-Ladies Austin is part of a world-wide organization to promote gender diversity in the R community #RLadies #rstats","R-Ladies Chapter for the Ames, Iowa, USA, area.","R-Ladies DC is part of a worldwide organization to promote Gender Diversity in the R community.","R-Ladies London, Ontario is part of a worldwide organization to promote Gender Diversity in the R community.","R-Ladies Buenos Aires es parte de una organización mundial para promover la Diversidad de Género en la comunidad R.\n#RLadies #rstats","RLadies Dublin is part of a world-wide organization to promote gender diversity in the R community #RLadies #rstats email us dublin (at) rladies (dot) org","R-Ladies aims to increase gender diversity in #rstats community via local meetups &amp; mentorship!","R-Ladies თბილისი","R-Ladies Munich is part of a worldwide organization to promote gender diversity in the R community. More info: https://t.co/hmY7DgRF77  #RLadies #rstats","R-Ladies Adelaide is a part of global R-Ladies community. Our goal is to bring diversity into R community and get more women excited about technology.","UK University Lecturer @lborogeog | Floods | Data science | Forecasting | Fluvial geomorphology | Climate | #R #RLadies","Data Scientist; #NASADatanauts; #rstats and #RLadies fan; @RLadiesBA co-organizer; Past: @Equifax; I love painting 🎨 (she/her)","Quantitative ecologist, postdoc at UCLA, cheese addict, owner of a very good dog #Rladies #rstats","22y.o. New nurse{4/5/14}. A Tru Queen is Always a Lady 1st. Inspiring&amp;Wise #teamJamaican #NursingIsLife #PlayboyFanatic #NCCU14","Serving self identified women and gender queer folks interested in #rstats, especially #RCatLadies","Az R-Ladies Budapest célja az adatelemzés és az R nyelv iránt érdeklődő, vagy e területeken már jártas lányok számára egy barátságos szakmai fórum létrehozása.","Izmir's first R Programming Meetup for Women #rladies #rstats Come and join us!","R-Ladies Munich is part of a worldwide organization to promote gender diversity in the R community. More info: https://t.co/hmY7DgRF77  #RLadies #rstats","R-Ladies Adelaide is a part of global R-Ladies community. Our goal is to bring diversity into R community and get more women excited about technology.","UK University Lecturer @lborogeog | Floods | Data science | Forecasting | Fluvial geomorphology | Climate | #R #RLadies","Data Scientist; #NASADatanauts; #rstats and #RLadies fan; @RLadiesBA co-organizer; Past: @Equifax; I love painting 🎨 (she/her)","Quantitative ecologist, postdoc at UCLA, cheese addict, owner of a very good dog #Rladies #rstats","22y.o. New nurse{4/5/14}. A Tru Queen is Always a Lady 1st. Inspiring&amp;Wise #teamJamaican #NursingIsLife #PlayboyFanatic #NCCU14","Serving self identified women and gender queer folks interested in #rstats, especially #RCatLadies","Az R-Ladies Budapest célja az adatelemzés és az R nyelv iránt érdeklődő, vagy e területeken már jártas lányok számára egy barátságos szakmai fórum létrehozása.","Izmir's first R Programming Meetup for Women #rladies #rstats Come and join us!","R-Ladies Lima es la 1era comunidad latinoamericana de R para mujeres.Somos parte de R-Ladies Global,cuyo fin es aumentar la presencia femenina en la comunidad R","R programming community for women. Promoting gender diversity and inclusivity in the #rstats community #RLadies https://t.co/mWCmJ4f1lr","Oi! Welcome to R Ladies Rio. We are part of #RLadiesGlobal, a world-wide organization to promote gender diversity \nin the R community. Join us! Participe!","楽天市場のレディースファッション\r\nのランキングを定期的に配信\r\n相互フォロー１００％返します。","Junior Rangers is a newly established club that is looking to expand and have a ladies section and girls youth section email:juniorrangers.ladies@aol.co.uk","Grupo de mujeres que usamos R y nos gusta la Tecnología","Only here to praise and admire ALL women. \r\nI only hope to make each and everyone of them feel confident, appreciated, and self-assured each day!!!","Official Twitter Account for our beloved friends from Resistance 3 2013 &amp; VOC 2013.",null,null,null,"R-Ladies Munich is part of a worldwide organization to promote gender diversity in the R community. More info: https://t.co/hmY7DgRF77  #RLadies #rstats","R-Ladies Adelaide is a part of global R-Ladies community. Our goal is to bring diversity into R community and get more women excited about technology.","UK University Lecturer @lborogeog | Floods | Data science | Forecasting | Fluvial geomorphology | Climate | #R #RLadies","Data Scientist; #NASADatanauts; #rstats and #RLadies fan; @RLadiesBA co-organizer; Past: @Equifax; I love painting 🎨 (she/her)","Quantitative ecologist, postdoc at UCLA, cheese addict, owner of a very good dog #Rladies #rstats","22y.o. New nurse{4/5/14}. A Tru Queen is Always a Lady 1st. Inspiring&amp;Wise #teamJamaican #NursingIsLife #PlayboyFanatic #NCCU14","Serving self identified women and gender queer folks interested in #rstats, especially #RCatLadies","Az R-Ladies Budapest célja az adatelemzés és az R nyelv iránt érdeklődő, vagy e területeken már jártas lányok számára egy barátságos szakmai fórum létrehozása.","Izmir's first R Programming Meetup for Women #rladies #rstats Come and join us!","R-Ladies Lima es la 1era comunidad latinoamericana de R para mujeres.Somos parte de R-Ladies Global,cuyo fin es aumentar la presencia femenina en la comunidad R","R programming community for women. Promoting gender diversity and inclusivity in the #rstats community #RLadies https://t.co/mWCmJ4f1lr","Oi! Welcome to R Ladies Rio. We are part of #RLadiesGlobal, a world-wide organization to promote gender diversity \nin the R community. Join us! Participe!","楽天市場のレディースファッション\r\nのランキングを定期的に配信\r\n相互フォロー１００％返します。","Junior Rangers is a newly established club that is looking to expand and have a ladies section and girls youth section email:juniorrangers.ladies@aol.co.uk","Grupo de mujeres que usamos R y nos gusta la Tecnología","Only here to praise and admire ALL women. \r\nI only hope to make each and everyone of them feel confident, appreciated, and self-assured each day!!!","Official Twitter Account for our beloved friends from Resistance 3 2013 &amp; VOC 2013.",null,null,null,"R-Ladies Munich is part of a worldwide organization to promote gender diversity in the R community. More info: https://t.co/hmY7DgRF77  #RLadies #rstats","R-Ladies Adelaide is a part of global R-Ladies community. Our goal is to bring diversity into R community and get more women excited about technology.","UK University Lecturer @lborogeog | Floods | Data science | Forecasting | Fluvial geomorphology | Climate | #R #RLadies","Data Scientist; #NASADatanauts; #rstats and #RLadies fan; @RLadiesBA co-organizer; Past: @Equifax; I love painting 🎨 (she/her)","Quantitative ecologist, postdoc at UCLA, cheese addict, owner of a very good dog #Rladies #rstats","22y.o. New nurse{4/5/14}. A Tru Queen is Always a Lady 1st. Inspiring&amp;Wise #teamJamaican #NursingIsLife #PlayboyFanatic #NCCU14","Serving self identified women and gender queer folks interested in #rstats, especially #RCatLadies","Az R-Ladies Budapest célja az adatelemzés és az R nyelv iránt érdeklődő, vagy e területeken már jártas lányok számára egy barátságos szakmai fórum létrehozása.","Izmir's first R Programming Meetup for Women #rladies #rstats Come and join us!","R-Ladies Lima es la 1era comunidad latinoamericana de R para mujeres.Somos parte de R-Ladies Global,cuyo fin es aumentar la presencia femenina en la comunidad R","R programming community for women. Promoting gender diversity and inclusivity in the #rstats community #RLadies https://t.co/mWCmJ4f1lr","Oi! Welcome to R Ladies Rio. We are part of #RLadiesGlobal, a world-wide organization to promote gender diversity \nin the R community. Join us! Participe!","楽天市場のレディースファッション\r\nのランキングを定期的に配信\r\n相互フォロー１００％返します。","Junior Rangers is a newly established club that is looking to expand and have a ladies section and girls youth section email:juniorrangers.ladies@aol.co.uk","Grupo de mujeres que usamos R y nos gusta la Tecnología","Only here to praise and admire ALL women. \r\nI only hope to make each and everyone of them feel confident, appreciated, and self-assured each day!!!","Official Twitter Account for our beloved friends from Resistance 3 2013 &amp; VOC 2013.",null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>name<\/th>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>description<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br/>
This is great! It retrieves the user if it matches the user's _description_ as well as _name_ and _screen\_name_ (handle), with 36 variables regarding the user. I'm only showing the ones I'm going to use, but there is a lot of extra information there.

I used `DT::datatable` just in case someone wants to go through whats on the whole table (of course here I'm thinking about the R-Ladies community). It was not easy to set up the environment for my blog to show this table (it uses `HTML widgets`), but luckily my hubby was more than willing to help me with that part 😅 . If you are using RStudio it is just as simple as installing the `DT` package, or you can always use `knitr::kable(head(users[, c(2:5)]), format = "html")` to see the first rows.

# Cleaning the data

First I make sure I don't have any duplicates, and then I keep only the handles that comply with the stipulated format, using a regular expression. I filter out 3 additional handles: _'RLadies'_ (whose _name_ is _'Royal Ladies'_ and I assume has something to do with royalty by the crown on their picture), _'RLadies\_LF'_ (a Japanese account that translated as follows on _Google Translator_: _'Rakuten Ichiba fashion delivery'_), and _'RLadiesGlobal'_, because it is not a chapter, so I don't want to include it on the plot. 

I also correct the missing values on `location` that I'll need to geocode the chapters, format the date class variable `created_at` as `%Y-%m-%d` (just because seeing the hours, minutes and seconds annoys me!) and generate the age in days `age_days` (for reproducibility, I set a fixed date to compare it with).

Finally I select the variables I will use for my analysis.

So it's time to clean up this data:


```r
library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)

rladies <- unique(users) %>%
  filter(str_detect(screen_name, '^(RLadies).*') & 
           !screen_name %in% c('RLadies', 'RLadies_LF', 'RLadiesGlobal')) %>% 
  mutate(location = ifelse(screen_name == 'RLadiesLx', 'Lisbon',
                         ifelse(screen_name == 'RLadiesMTL', 'Montreal', location)),
         created_at = format(as.Date(created_at), format = '%Y-%m-%d'),
         age_days = difftime(as.Date('2017-4-25'), created_at, unit = 'days')) %>%
  select(screen_name, location, created_at, followers = followers_count, age_days)
```

There are two additional chapters with no presence on Twitter: one in Taipei, Taiwan, and the other in Warsaw, Poland. I add them according to their creation date and using the number of members on their Meetup account as followers.


```r
rladies <- rladies %>% 
  add_row(      
    screen_name = 'RLadiesTaipei',
    location = 'Taipei',
    created_at = as.Date('2014-11-15'),
    followers = 347) %>% 
  add_row(      
    screen_name = 'RLadiesWarsaw',
    location = 'Warsaw',
    created_at = as.Date('2016-11-15'),
    followers = 80)

datatable(rladies, rownames = FALSE,
          options = list(pageLength = 5))
```

<!--html_preserve--><div id="htmlwidget-0d256aa6514938ec62bb" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0d256aa6514938ec62bb">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesLondon","RLadiesRTP","RLadiesCT","RLadiesIstanbul","RLadiesBCN","RLadiesNYC","RLadiesBoston","RLadiesLA","RLadiesMAD","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesValencia","RLadiesNash","RLadiesColumbus","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesLdnOnt","RLadiesBA","RLadiesDublin","RLadiesManchest","RLadiesTbilisi","RLadiesMunich","RLadiesAdelaide","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadiesSR","RLadiesMTL","RLadiesTaipei","RLadiesWarsaw"],["San Francisco","London, England","Durham, NC","Connecticut, USA","İstanbul, Türkiye","Barcelona, Spain","New York","Boston, MA","Los Angeles, CA","Madrid, Spain","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Valencia, España","Nashville, TN","Columbus, OH","Austin, TX","Ames, IA","Washington, DC","London, Ontario","Buenos Aires, Argentina","Dublin City, Ireland","Manchester, England","Tbilisi","Munich, Bavaria","Adelaide, South Australia","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","Santa Rosa, Argentina","Montreal","Taipei","Warsaw"],["2012-10-15","2016-04-20","2016-06-28","2016-11-24","2016-09-06","2016-10-11","2016-09-01","2016-09-06","2016-08-29","2016-09-03","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-11-13","2016-09-28","2016-10-04","2016-12-15","2016-11-30","2016-12-08","2017-01-19","2017-01-05","2017-01-21","2016-10-08","2016-11-29","2017-03-21","2017-02-20","2015-04-04","2017-01-23","2016-10-19","2016-10-08","2017-03-06","2017-01-15","2017-04-06","2017-04-13","16389","17120"],[886,1102,215,134,425,360,256,247,309,384,404,247,182,192,146,179,173,100,115,114,75,174,71,128,85,46,26,86,61,88,37,44,18,5,1,347,80],[1652.91666666667,369.875,300.875,151.875,230.875,195.875,235.875,230.875,238.875,233.875,234.875,217.875,180.875,203.875,162.875,208.875,202.875,130.875,145.875,137.875,95.875,109.875,93.875,198.875,146.875,34.875,63.875,751.875,91.875,187.875,198.875,49.875,99.875,18.875,11.875,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":3}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br />
As my ultimate goal is to plot the chapters on a map, I need to obtain the latitude and longitude for each one of them. The `ggmap` package really comes in handy for this kind of task. It interacts with _Google Maps_ to retrieve latitude and longitude, and I don't even have to worry about getting the location into a specific format, because it is so good at interpreting it! (I actually tried extracting the cities first, because I thought it would be the best way, but many of the chapters didn't match or matched wrongly, so I tried it like that and worked perfectly!)

Since the `ggmap::geocode` function returns 2 columns, the first thing I thought was to call it twice: once for the longitude and once for the latitude. But I didn't like it because it was awfully inefficient, and the geocoding takes some time. It was going to be something like this:


```r
library(ggmap)

rladies <- rladies %>% 
  mutate(lon = geocode(location)[,1],
         lat = geocode(location)[,2])
```

Doing some research I finally decided to use the `purrr::map` function for capturing both values in a single column of the dataframe, and then with `tidyr::unnest` I transform it into two separate columns. All of this with never having to leave the `tidyverse` world :)

I'm doing it in two steps to see the intermediate result, with the two columns in a single variable of the dataframe.


```r
library(ggmap)
library(purrr)

rladies <- rladies %>% 
  mutate(longlat = purrr::map(.$location, geocode)) 

datatable(rladies, rownames = FALSE,
          options = list(pageLength = 5))   
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
   <th style="text-align:left;"> age_days </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 2012-10-15 </td>
   <td style="text-align:right;"> 886 </td>
   <td style="text-align:left;"> 1652.917 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 2016-04-20 </td>
   <td style="text-align:right;"> 1102 </td>
   <td style="text-align:left;"> 369.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 2016-06-28 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:left;"> 300.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 2016-11-24 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:left;"> 151.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 2016-09-06 </td>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:left;"> 230.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 2016-10-11 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:left;"> 195.875 days </td>
  </tr>
</tbody>
</table>


```r
rladies <- rladies %>% 
  unnest() 
```

```
## Error: All nested columns must have the same number of elements.
```

```r
datatable(rladies, rownames = FALSE,
          options = list(pageLength = 5))        
```

<!--html_preserve--><div id="htmlwidget-d8745cfc53cd04b7a0a7" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d8745cfc53cd04b7a0a7">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesLondon","RLadiesRTP","RLadiesCT","RLadiesIstanbul","RLadiesBCN","RLadiesNYC","RLadiesBoston","RLadiesLA","RLadiesMAD","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesValencia","RLadiesNash","RLadiesColumbus","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesLdnOnt","RLadiesBA","RLadiesDublin","RLadiesManchest","RLadiesTbilisi","RLadiesMunich","RLadiesAdelaide","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadiesSR","RLadiesMTL","RLadiesTaipei","RLadiesWarsaw"],["San Francisco","London, England","Durham, NC","Connecticut, USA","İstanbul, Türkiye","Barcelona, Spain","New York","Boston, MA","Los Angeles, CA","Madrid, Spain","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Valencia, España","Nashville, TN","Columbus, OH","Austin, TX","Ames, IA","Washington, DC","London, Ontario","Buenos Aires, Argentina","Dublin City, Ireland","Manchester, England","Tbilisi","Munich, Bavaria","Adelaide, South Australia","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","Santa Rosa, Argentina","Montreal","Taipei","Warsaw"],["2012-10-15","2016-04-20","2016-06-28","2016-11-24","2016-09-06","2016-10-11","2016-09-01","2016-09-06","2016-08-29","2016-09-03","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-11-13","2016-09-28","2016-10-04","2016-12-15","2016-11-30","2016-12-08","2017-01-19","2017-01-05","2017-01-21","2016-10-08","2016-11-29","2017-03-21","2017-02-20","2015-04-04","2017-01-23","2016-10-19","2016-10-08","2017-03-06","2017-01-15","2017-04-06","2017-04-13","16389","17120"],[886,1102,215,134,425,360,256,247,309,384,404,247,182,192,146,179,173,100,115,114,75,174,71,128,85,46,26,86,61,88,37,44,18,5,1,347,80],[1652.91666666667,369.875,300.875,151.875,230.875,195.875,235.875,230.875,238.875,233.875,234.875,217.875,180.875,203.875,162.875,208.875,202.875,130.875,145.875,137.875,95.875,109.875,93.875,198.875,146.875,34.875,63.875,751.875,91.875,187.875,198.875,49.875,99.875,18.875,11.875,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":3}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br />
That's it!

Now the dataframe is ready for me to use it for visualizing these Twitter users on a map (considering their sizes and dates of creation), and make some animations! If you are interested, you can check how I do it [here for using `plotly`](){:target="_blank"} and [here for using `gganimate`](){:target="_blank"}.

Thank you for reading! Please leave your comments and suggestions below or [Mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616) :)
