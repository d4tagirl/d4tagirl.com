---
layout: post
title:  John Oliver
date: "2017-05-25 12:11:29 UYT"
published: TRUE
tags: [rstats, r, john oliver, sentiment analysis, youtube, facebook, tidytext]
description: ..........!
---
.  

<!--more-->

<div align="center"><img src="/figure/source/john-oliver/2017-05-26-john-oliver/banner.jpg"/></div>

# Welcome, welcome,  welcome!

One thing my husband and I enjoy a lot is to watch [*Last Week Tonight with John Oliver*](http://www.hbo.com/last-week-tonight-with-john-oliver) every week. It is an HBO political talk-show that airs on Sunday nights, but we usually watch it while we have dinner some day during the week. We love the show because it covers a huge amount of diverse topics and news from all over the world, plus we laugh a lot (bittersweet laughs mostly 🤷 ).

I think he has a fantastic sense of humor and he is a spectacular communicator, but only if you share the way he sees the world. And because he is so enthusiastic about his views, I believe it is a character you either love or hate. I suspect he (as well as the topics he propose) arouses strong feelings in people and I want to check it by analyzing the comments people leave on [his Youtube videos](https://www.youtube.com/user/LastWeekTonight) and [his Facebook ones](https://www.facebook.com/LastWeekTonight/) as well.

I've been wanting to try [Julia Silge](juliasilge.com) and [David Robinson](http://varianceexplained.org/)'s [`tidytext` package](http://tidytextmining.com/) for a while now, and after I read [Erin's text analysis on the Lizzie Bennet Diaries' Yutube captions](https://eringrand.github.io/lizziebennet_textmining/) I thought about giving Youtube a try 😃 

<br/>
<div align="center"><img src="https://media.giphy.com/media/pOVsnroKZWeNG/giphy.gif"/></div>
<br/>

# Fetching Youtube videos and comments

Every episode has one _main story_ and many _"short stories"_ that are mostly [available online to watch via Youtube](https://www.youtube.com/user/LastWeekTonight).

I'm using [Youtube Data API](https://developers.google.com/youtube/v3/) and the [`tuber` package](https://github.com/soodoku/tuber) to get the info from Youtube (I found a bug in the `get_comment_thread` function on the CRAN version, so I recommend you use the GitHub one insted where this is fixed). The first time you need to do some things to obtain authorization credentials so your application can submit API requests (you can follow [this guide to do so](https://developers.google.com/youtube/v3/getting-started)). Then you just use the `tuber::yt_oauth` function that launches a browser to allow you to authorize the application and you can start retreiving information.

First I search for the Youtube channel, I select the correct one and then I retrieve the `playlist_id` that I'm going to use to fetch all videos.




```r
library(tuber)

app_id <- "####"
app_password <- "####"
yt_oauth(app_id, app_password)

search_channel <- yt_search("lastweektonight")

channel <- search_channel %>%
  slice(1) %>%
  select(channelId) %>%
  .$channelId %>%
  as.character

channel_resources <- list_channel_resources(filter = c(channel_id = channel),
                                                part =  "contentDetails")

playlist_id <- channel_resources$items[[1]]$contentDetails$relatedPlaylists$uploads
```

## Fetching the videos

The `tuber` package is all about lists, and not _tidy dataframes_, so I dedicate a lot of effort to tidying this data.

To get all videos I used the `get_playlist_items` function, but it only retrieve the first 50 elements. I know [soodoku](https://github.com/soodoku) is planning on implementing an argument *ala "get_all"*, but in the meantime I had to implement this myself to get all the videos (I took [more than a few ideas from Erin's script!](https://eringrand.github.io/lizziebennet_textmining/)).


```r
library(dplyr)
library(tuber)
library(purrr)
library(magrittr)
library(tibble)

get_videos <- function(playlist) {
  # pass NA as next page to get first page
  nextPageToken <- NA
  videos <- {}

  # Loop over every available page
  repeat {
    vid      <- get_playlist_items(filter = c(playlist_id = playlist),
                                   page_token = nextPageToken)

    vid_id   <- map(vid$items, "contentDetails") %>%
      map_df(magrittr::extract, c("videoId", "videoPublishedAt"))

    titles   <- lapply(vid_id$videoId, get_video_details) %>%
      map("localized") %>%
      map_df(magrittr::extract, c("title", "description"))

    videos   <- videos %>% bind_rows(tibble(id          = vid_id$videoId,
                                            created     = vid_id$videoPublishedAt,
                                            title       = titles$title,
                                            description = titles$description))

    # get the token for the next page
    nextPageToken <- ifelse(!is.null(vid$nextPageToken), vid$nextPageToken, NA)

    # if no more pages then done
    if (is.na(nextPageToken)) {
      break
    }
  }
  return(videos)
}

videos <- get_videos(playlist_id)
```

Then I extract from the title the first part of the title and description (the rest is just propaganda), whether the video comes from HBO or from a Web exclusive, and format the video's creation date


```r
videos <- videos %>%
  mutate(short_title = str_match(title, "^([^:]+).+")[,2],
         hbo_web     = str_match(title, ".+\\((.+)\\)$")[,2],
         short_desc  = str_match(description, "^([^\n]+).+")[,2],
         vid_created = as.Date(created)) %>%
  select(-created)
```

```
## Error in eval(expr, envir, enclos): object 'videos' not found
```


Lets take a look at the 204 videos.


```r
library(DT)
datatable(videos[, c(4, 6, 7)], rownames = FALSE,
          options = list(pageLength = 5#,
                         # autoWidth = TRUE,
                         # columnDefs = list(list(width = '200px', targets = 2))
                         )) %>% 
  formatStyle(c(1:3), `font-size` = '14px')
```

<!--html_preserve--><div id="htmlwidget-8b17f9adab1fc82fd23a" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8b17f9adab1fc82fd23a">{"x":{"filter":"none","data":[["Stupid Watergate","Dialysis","Net Neutrality Update","Net Neutrality II","Ivanka &amp; Jared","French Elections","Gerrymandering","Marijuana","Federal Budget","Dancing Zebra Footage","American Health Care Act","Dalai Lama","Obamacare","Putin","Trump vs. Truth","Last Week Tonight Season 4 Prom","Trump University","President-Elect Trump","Mercadeo Multinivel","Multilevel Marketing","Voting On Tuesday - How Is This Still A Thing?","School Segregation","Opioids","Third Parties","Guantánamo","Police Accountability","Scandals","Refugee Crisis","Birds","Charter Schools","Johnny Strong","Labor Day","Auto Lending","Olympics Opening Ceremony","Journalism","Democratic National Convention","Campaign Songs","Republican National Convention","Endorsements (Web Exclusive)","Fan Mail Vol. 2 (Web Exclusive)","Brexit Update","Doping","Independence Day (Web Exclusive)","Brexit","Retirement Plans","Debt Buyers","Primaries and Caucuses","How Is This Not A Thing? (Web Exclusive)","911","Scientific Studies","Cicadas (Web Exclusive)","Puerto Rico","Lead","Credit Reports","Congressional Fundraising","Border Wall","Conspiracies (Web Exclusive)","International Women's Day","Encryption","Special Districts","Donald Trump","Whitewashing","Abortion Laws","Voting","Season 3","Lost Graphics Vol. 2 (Web Exclusive)","Revised Resolutions (Web Exclusive)","Regifting (Web Exclusive)","Pennies","Daily Fantasy Sports","Prisoner Re-entry","Medicaid Gap","Canadian Election","North Dakota","Mental Health","Migrants and Refugees","Public Defenders","LGBT Discrimination","History Lies (Web Exclusive)","Back To School (Web Exclusive)","Televangelists","Sex Education","Washington DC Statehood","Mandatory Minimums","Food Waste","Stadiums","Transgender Rights","Leap Second","Shallow Dives (Web Exclusive)","People Prematurely Declaring The End of Obamacare","Online Harassment","Torture","Bail","FIFA II","Chickens","Lost Graphics (Web Exclusive)","Paid Family Leave","Standardized Testing","Fashion","Doomsday Video","Patents","The IRS","Edward Snowden on Passwords","HBO NOW","Government Surveillance","Red-Tailed Hawks","Municipal Violations","April Fools' Day (Web Exclusive)","The NCAA","U.S. Territories","Daylight Saving Time - How Is This Still A Thing?","Infrastructure","UK Labour Party","Elected Judges","Tobacco","Sports Illustrated Swimsuit Issue - How Is This Still a Thing?","Goodbye, RadioShack","Marketing to Doctors","Season 2","Fifty Shades #NotMyChristian Apology (Web Exclusive)","Season 2 Promo","New Year's Eve (Web Exclusive)","Turkey Pardoning (Web Exclusive)","Salmon Cannon","The Lottery","Finale Preview","Home Depot Commercial","State Legislatures and ALEC","1,000,000 YouTube Subscribers (Web Exclusive)","Sugar","Dr. Jane Goodall Interview","Translators","Supreme Court","Real Animals, Fake Paws Footage","Columbus Day - How Is This Still A Thing","Pumpkin Spice (Web Exclusive)","Civil Forfeiture","Jeff Goldblum Outtakes","Ayn Rand - How Is This Still A Thing?","Drones","Narendra Modi In New York","Roger Goodell (Extended Web Exclusive)","Miss America Pageant","Step Up, Peru","Scottish Independence","Student Debt","#GoodbyeGeckos","Cookie Monster's Ideas (Web Exclusive)","Wage Gap","John Oliver Literally Destroys Piñatas (Web Exclusive)","Ferguson, MO and Police Militarization","Fan Mail Vol. 1 (Web Exclusive)","Predatory Lending","Native Advertising","New York's Port Authority","#WeGotThoseGeckos","Nuclear Weapons","#GoGetThoseGeckos","Prison","Singapore's Gambling Problem","Wealth Gap","Warren G. Harding's Love Letters","Don't Visit Antarctica","Hobby Lobby","Uganda and Pepe Julian Onziema Pt. 1","Fireworks (Web Exclusive)","Pepe Julian Onziema Interview Pt. II (Web Exclusive)","Dr. Oz and Nutritional Supplements","Tom Wheeler Is Not A Dingo","The Washington Redskins","President Obama Visits Native American Territory","Stephen Hawking Interview","Stephen Hawking Extended Interview","FIFA and the World Cup","iTunes, Assad, and Right Said Fred","World Cup Excitement","Net Neutrality","Tony Abbott, President of the USA of Australia","Activists and Corporations","Last Week's News...We Think (Web Exclusive)","GM Ad","Right To Be Forgotten","Fareed Zakaria Interview Pt. 1","Fareed Zakaria Interview Pt. 2 (Web Exclusive)","Nintendo Gay Marriage","India Election Update","Eurovision and Crimea Coin","Dressing Up As Other Races (How Is This Still a Thing?)","Climate Change Debate","Climate Change (Abbreviated)","Critics Quote","Other Countries' Presidents - François Hollande","Death Penalty","Simon Ostrovsky Interview (Web Exclusive)","Letter of the Week -- POM Wonderful (Web Exclusive)","Nerd Prom","The Buzz","Episode Preview","Workplace of the Week - The NFL","\"Oregon Spirit\" by Lisa Loeb","Last Week Tonight with John Oliver","General Keith Alexander Extended Interview","GOP - Whatevs","GOP - Hashtag Awesomesauce"],["John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation","For-profit dialysis companies often maximize their profits at the expense of their patients. John Oliver explores why a medical clinic is nothing like a Taco Bell","John Oliver discusses the recent flood of comments posted on the FCC's website","Equal access to online information is once again under serious threat. John Oliver encourages internet commenters to voice their displeasure to the FCC by visiting www.gofccyourself.com and clicking \"express\" to file your comment","Ivanka Trump and Jared Kushner hold an incredible amount of political power. That's troubling considering their incredibly small amount of political experience","The presidential election in France could determine the political future of Europe. John Oliver visits an excessively French bistro to deliver an urgent message to voters","Lawmakers often reshape voting districts to shift the balance of political power. That's unfair to voters, even those of us with questionable judgment","Under federal law, even legal marijuana is illegal. John Oliver explains why conflicting drug laws pose serious problems","Donald Trump's federal budget plan proposes large funding cuts with largely negative consequences. John Oliver examines the troubling priorities of the new administration","Dancing zebras improve every situation, so feel free to add this footage of a zebra dancing in front of a green screen to a video of your choice. Share your creations using #JustAddZebras","The Republican health care bill could leave many Americans without affordable coverage. Last Week Tonight's catheter cowboy returns to morning cable news to explain that to Donald Trump","Tibetan Buddhists have suffered deep persecution by the Chinese government. John Oliver sits down with the Dalai Lama to discuss China, the conditions in Tibet, and horse milk","Congressional Republicans could soon vote to repeal Obamacare","Vladimir Putin is known as a ruthless leader and master manipulator. John Oliver enlists a group of singing dancers to explain that to Donald Trump","Donald Trump spreads a lot of false information thanks to his daily consumption of morning cable news. If only we could sneak some facts into the president’s media diet","Last Week Tonight, literally one of HBO’s Sunday night shows, returns 2/12 at 11PM","Trump University recently settled its lawsuits for $25 million; here's some background","Donald Trump will be the next president of the United States. How did we get to this point? And what do we do now","Las compañías de mercadeo multinivel aclaman ser negocios legítimos, pero algunas parecen ser terriblemente... piramidales. John Oliver y Jaime Camil nos demuestran como funcionan.","Multilevel marketing companies claim to be legitimate businesses, but some seem awfully…pyramid shaped. John Oliver and Jaime Camil demonstrate how they work.","Tuesday voting is highly inconvenient, so why do we still do it","Public schools are increasingly divided by race and class. John Oliver discusses the troubling trend towards school resegregation","John Oliver discusses the extent and root of the nation’s epidemic of opioid addiction","Third party candidates want to be serious contenders, so John Oliver considers them seriously as potential presidents","John Oliver examines the legal and moral issues surrounding the military prison at Guantánamo Bay","John Oliver discusses the systems in place to investigate and hold police officers accountable for misconduct","The 2016 presidential race is teeming with raisins. Sorry…scandals","Last Week Tonight covers an inappropriate analogy for the refugee crisis","Birds will soon begin migrating to warmer climates. John Oliver says good riddance","Charter schools are privately run, publicly funded, and irregularly regulated. John Oliver explores why they aren’t at all like pizzerias","John Oliver pitches a summer blockbuster comic book adaptation about the perilous adventures of superhero Johnny Strong.","Everyone knows the rule against wearing white after Labor Day. John Oliver suggests some other things we should all stop doing","Auto lenders can steer vulnerable people into crushing debt. Keegan-Michael Key and Bob Balaban help John Oliver show exactly how","With the Olympic Games now underway, John Oliver recaps the opening ceremony","The newspaper industry is suffering. That’s bad news for journalists — both real and fictional","John Oliver covers the Democratic convention and the unconventional state of our democracy","John Oliver and some of America’s favorite recording artists remind politicians not to use their songs without permission on the campaign trail","John Oliver discusses last week's unsurprisingly surprising Republican convention.","Since we’re in the middle of an election year, John Oliver makes some official endorsements","John Oliver reads his fan mail, which comes from YouTube comments instead of letters because we live in the modern world","The United Kingdom voted to leave the European Union, and it looks like it may not be an especially smooth transition","Doping scandals have cast a shadow over the Olympic Games. Until we eliminate drugs from sports, we should at least update our athlete promos","John Oliver reminds America what it lost by gaining its independence.","Britain could soon vote to leave the European Union. John Oliver enlists a barbershop quartet to propose a smarter option","Saving for retirement means navigating a potential minefield of high fees and bad advice. Billy Eichner and Kristin Chenoweth share some tips","Companies that purchase debt cheaply then collect it aggressively are shockingly easy to start. We can prove it!","Primaries and caucuses are a surprisingly undemocratic part of the democratic process. John Oliver discusses our convoluted system for choosing presidential nominees.","John Oliver covers some things that don’t — but definitely should — exist.","Emergency call centers are in desperate need of funding and new technology. Until we upgrade our 911 system, we should at least create more informative PSA's.","John Oliver discusses how and why media outlets so often report untrue or incomplete information as science","Billions of cicadas will soon emerge after spending 17 years underground. John Oliver fills them in on what's happened since 1999","Puerto Rico is suffering a massive debt crisis. Lin-Manuel Miranda joins John Oliver to call for relief","Lead poisoning is a national problem. If only lawmakers were as concerned as the puppets on Sesame Street","Credit reports play a surprisingly large role in our lives, but even more surprising is how often they contain critical mistakes. John Oliver helps credit agencies see why this is a problem.","Lawmakers have to raise money to keep their jobs, but a surprising amount of their job now consists of raising money. John Oliver sits down with Congressman Steve Israel to discuss the costs of political spending","Donald Drumpf wants to build a wall on the U.S-Mexico border. Is his plan feasible?","John Oliver wakes up the sheeple who have had the wool pulled over their eyes by the lamestream media","Connect with Last Week Tonight online..","Strong encryption poses problems for law enforcement, is weakening it worth the risks it presents? It’s…complicated.","Special districts spend more public money than all city governments combined. That's odd considering most of us don't know they exist","Our main story was about Donald Trump. We can't believe we're saying that either","With the academy awards coming up, Last Week Tonight asks: Hollywood whitewashing...how is this still a thing","Abortion is theoretically legal, but some states make it practically inaccessible","Every American deserves an equal vote. But in some states, access to voting is becoming less and less equal.","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","John Oliver shares more of his favorite graphics that never made it on the show","John Oliver helps you revise the New Year’s resolutions you’ve already failed to keep","You will receive at least one horrible gift this month. John Oliver has some tips for getting rid of it","Pennies are not even worth what they’re worth. So why do we still make them","Daily fantasy sports sites claim they are not gambling enterprises, but they seem awfully…gamblish.","Former offenders face enormous obstacles once they leave prison. John Oliver sits down with Bilal Chatman to discuss the challenges of reentering society","The election in 2016 decides our new president, but the one this year could determine whether many Americans will have healthcare","Canada is about to have a major election. John Oliver enlists Mike Myers, a beaver, and a moose to give voters some advice","North Dakota is known for being polite, but perhaps they’ve been a little too hospitable to oil companies","John Oliver explains how our national system of treating mental health works, or more often than not, how it doesn’t","Millions of migrants seeking asylum in Europe face hostility, racism, and red tape. John Oliver does one admittedly tiny thing for one of them","The Miranda warning includes the right to a public defender. It doesn’t include the fact that public defenders are highly overworked and grossly underpaid","This year’s gay marriage ruling was a milestone, but LGBT discrimination is still surprisingly legal. John Oliver explains why we need a federal anti-discrimination law","John Oliver shares some of his favorite completely made-up history facts","John Oliver gives students a crash course in everything they will learn — or not learn — in school this year","U.S. tax law allows television preachers to get away with almost anything. We know this from personal experience","Sex education varies widely between school districts, leaving many teens without comprehensive information. We made a video that covers what some schools are too embarrassed to teach","Washington DC experiences taxation without representation. It's also missing from rhyming state songs. John Oliver and a group of singing children fix one of these problems","Mandatory minimums require fixed prison sentences for certain crimes. John Oliver explains why we treat some turkeys better than most low-level offenders","Producers, sellers, and consumers waste tons of food. John Oliver discusses the shocking amount of food we don’t eat.","Cities spend massive amounts of public money on privately-owned stadiums. Cities issue tax-exempt municipal bonds that — wait, don’t fall asleep","This week’s gay rights victory was historic, but the transgender community still faces staggering challenges. John Oliver focuses on the “T” in “LGBT.","On June 30th, scientists are adding an extra second to atomic clocks. How will you spend yours","Instead of covering 1 topic in 15 minutes, John Oliver covers 15 topics in 1 minute","Five years of people prematurely declaring the end of Obamacare.","Online harassment is a major problem, but it’s rarely prosecuted. If only we’d been warned about this in the early days of the internet","The US Senate Torture Report revealed horrifying details of America's interrogation program. Helen Mirren will fill you in","John Oliver explains why America’s bail system is better for the reality tv industry than it is for the justice system","After the arrests of numerous top officials, John Oliver decided to give an update on the state of FIFA","John Oliver explains how chicken farming can be unfair, punishing, and inhumane. And not just for the chickens","John Oliver shows off some of his favorite graphics that never made it onto the show","Many American companies do not offer paid leave after the birth of a child, which means they probably shouldn’t run sappy Mother’s Day ads","American students face a ridiculous amount of testing. John Oliver explains how standardized tests impact school funding, the achievement gap, how often kids are expected to throw up","Trendy clothes are cheaper than ever. That sounds great for the people who buy them, but it's horrible for the people who make them.","CNN produced an actual doomsday video to broadcast when the world is ending and it’s incredibly dull. We've enlisted Martin Sheen to help make humanity’s final moments happier","For inventors, patents are an essential protection against theft. But when patent trolls abuse the system by stockpiling patents and threatening lawsuits, businesses are forced to shell out tons of money.","Nobody likes the IRS. But recent budget and staff cuts have made it increasingly difficult for the department to do its very important job. Don’t take our word for it. Ask Michael Bolton","John Oliver and Edward Snowden talk password security","John Oliver from Last Week Tonight offers his take on HBO NOW, the new standalone streaming service from HBO","There are very few government checks on what America’s sweeping surveillance programs are capable of doing. John Oliver sits down with Edward Snowden to discuss the NSA, the balance between privacy and security, and dick-pics","The New Hampshire legislature refused to make the red-tailed hawk the official raptor of their state...so we made it the official raptor of our show","If you have money, committing a municipal violation may pose you a minor inconvenience. If you don’t, it can ruin your life","April Fools’ Day is awful. Please stand with John Oliver and take the Last Week Tonight No-Prank Pledge","The NCAA doesn’t pay athletes because they consider them amateurs. The NCAA considers them amateurs because they don’t get paid","A set of Supreme Court decisions made over 100 years ago has left U.S. territories without meaningful representation. That’s weird, right","Last Week Tonight with John Oliver: Daylight Saving Time - How Is This Still A Thing? (HBO","America’s crumbling infrastructure: It’s not a sexy problem, but it is a scary one.","The UK's Labour Party has painted a campaign van pink in an attempt to attract women voters. We are glad they didn't keep going with that strategy","The vast majority of US judges are elected, forcing many judges to pander to the electorate and accept campaign money in order to keep their jobs. This seems slightly troubling","Thanks to tobacco industry regulations and marketing restrictions in the US, smoking rates have dropped dramatically. John Oliver explains how tobacco companies are keeping their business strong overseas","We’ve noticed that the Sports Illustrated Swimsuit Issue still exists but can’t quite figure out why","RadioShack has filed for bankruptcy. We’ve helped them create a farewell message","Pharmaceutical companies spend billions of dollars marketing drugs to doctors","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","John Oliver apologizes to Jamie Dornan for perpetuating the #NotMyChristian hashtag...sort of","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","New Year's Eve is the worst. John Oliver has some great excuses for getting out of it","Turkey pardoning is a weird tradition","There is a cannon that shoots salmon over dams.","State lotteries claim to be good for education and the general wellbeing of citizens","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Lowe’s is employing robots this holiday season","While midterm coverage is largely focused on the parts of Congress that do very little, vital (and bizarre) midterm elections are going unexamined. State legislators pass a lot of bills, and some of that efficiency is thanks to a group called ALEC that writes legislation for them. It’s as shady as it sounds","Last Week Tonight with John Oliver: 1,000,000 YouTube Subscribers (Web Exclusive","Sugar. It's in everything","For our series People Who Think Good, John Oliver sits down for a banana with Dr. Jane Goodall, one of the world's foremost experts in chimpanzees","Translators who have aided the U.S. Military in Afghanistan and Iraq are in great danger in their home countries, but red tape is making it impossible for many of them to leave. John Oliver interviews Mohammad, one translator who made it out","Cameras aren’t allowed in the Supreme Court, so most coverage of our most important cases looks like garbage","We have provided this footage for you to do your own Supreme Court reenactments. Please feel free to use it, post your videos, and tag them #RealAnimalsFakePaws so we can find them","Christopher Columbus did a lot of stuff that was way more terrible than \"sailing the ocean blue,\" but we don't learn about that","Pumpkin spice. Why","Did you know police can just take your stuff if they suspect it's involved in a crime? They can","Jeff Goldblum is amazing. Here are some outtakes of him harassing a stack of money that didn't make it into our Law and Order: Civil Forfeiture Unit segment","Ayn Rand, author of \"Atlas Shrugged\" and \"The Fountainhead,\" is still kind of a thing. How?","The United States has launched a huge number of drone strikes under President Obama.","Narendra Modi, the Prime Minster of India visited New York and did some classic New York things.","Roger Goodell spoke about the NFL’s recent controversies. And he spoke badly","The Miss America Pageant…how is this still a thing","ISIS is rapidly spreading throughout the Middle East.","Scotland is about to vote on whether to secede from the UK","John Oliver discusses student debt, which is awful, as well as for-profit colleges, who are awfully good at inflicting debt upon us","The Russian space sex geckos have died. John Oliver enlists the band A Great Big World to help him pay tribute to the sacrifice they made for science with their song “Say Something.","Cookie Monster has a few ideas to share with John Oliver","John Oliver explores America's wage gap between men and women and proposes a possible solution.","Watch John Oliver deliver an epic takedown of piñatas","In the wake of the shooting of Michael Brown in Ferguson, MO, John Oliver explores the racial inequality in treatment by police as well as the increasing militarization of America’s local police forces","John Oliver reads fan mail, but because no one sends mail anymore, it’s all from YouTube comments","Payday loans put a staggering amount of Americans in debt. They prey on the elderly and military service members. They’re awful, and nearly impossible to regulate. We’ve recruited Sarah Silverman to help spread the word about how to avoid falling into their clutches","The line between editorial content and advertising in news media is blurrier and blurrier. That's not bullshit. It's repurposed bovine waste","Locked in a dispute with Fishs Eddy, New York's Port Authority wants to regain control of its own image. John Oliver wants to help them make it happen","Last week on Last Week Tonight, John Oliver told us to tell Vladimir Putin to #GoGetThoseGeckos. This week, there's some good news...#WeGotThoseGeckos","America has over 4,800 nuclear weapons, and we don’t take terrific care of them","Russia sent some geckos into space to have sex","America's prisons are broken. Just ask John Oliver and several puppets","Singapore's anti-gambling ads had one critical flaw","John Oliver discusses America's growing wealth gap and why it may be a problem in the future","Warren G. Harding was a nasty, nasty president","Tourism in Antarctica is ruining the environment.","With the Supreme Court ruling hinging on the religious rights of Hobby Lobby, John Oliver takes a look at other ways corporations can be more like people.","John Oliver celebrates recent LGBT rights milestones in the United States before covering oppressive anti-gay laws in Uganda. (Also, the US involvement in inspiring and funding those laws.) Ugandan LGBTI rights advocate Pepe Julian Onziema sits down with John to discuss the situation in his home country","With Last Week Tonight on hiatus, John Oliver takes to the internet to cover the most important story of the past week: Fireworks","John Oliver talks in depth with Ugandan LGBTI rights activist Pepe Julian Onziema about the oppressive anti-gay legislation in Uganda as well as the western involvement in inspiring those laws","John Oliver outlines what, exactly is problematic about Dr. Oz and the nutrition supplement industry. Then he invites George R.R. Martin, Steve Buscemi, the Black and Gold Marching Elite, and some fake real housewives on the show to illustrate how to pander to an audience without hurting anyone.","FCC Chair Tom Wheeler watched Last Week Tonight's bit on net neutrality. He thought it was funny and creative. He wants us to know he's not a dingo","How is that team still called The Washington Redskins","John Oliver covers President Obama's first visit to Native American territory and subsequent mold removal","John Oliver talks to Stephen Hawking in the first installment of Last Week Tonight's new \"People Who Think Good\" series. They cover such topics as parallel universes, artificial intelligence, and Charlize Theron","John Oliver talks to Stephen Hawking in the first installment of Last Week Tonight's new \"People Who Think Good\" series. They cover such topics as parallel universes, artificial intelligence, and Charlize Theron","John Oliver's excitement for the World Cup is tempered by knowing information about FIFA, the organization that produces it. John details the problems with the upcoming tournament and the staggering allegations of corruption against FIFA","Right Said Fred (really!) appears on Last Week Tonight with John Oliver to tell Syrian president Bashar al-Assad what a dick he is. It's going to be especially disappointing to Assad, as they are one of his favorite bands","John Oliver describes his excitement for, and ambivalence towards, the upcoming World Cup","Cable companies are trying to create an unequal playing field for internet speeds, but they're doing it so boringly that most news outlets aren't covering it.","Meet Australia's President of the United States, Prime Minister Tony Abbott, the instigator of a wink-related scandal. He sometimes puts his foot in his mouth and other times chooses to say nothing at all","Activists and corporations are teaming up to fight for open internet while the FCC is trying to create two speeds of service","John Oliver delivers last week's news, predicted two weeks ago.","In light of General Motors' recall of 11 million vehicles and recently-leaked public relations memo, Last Week Tonight with John Oliver made a new, honest ad for their cars","John Oliver covers the new European law that would allow people to erase themselves from internet search engines","John Oliver and Fareed Zakaria discuss Narendra Modi's recent victory in India's record-breaking election","John Oliver and Fareed Zakaria further discuss the victory of Narendra Modi in India's recent election","John Oliver discusses Massachusetts' celebration of ten years of marriage equality","John Oliver delivers an update on the historic election in India, the largest in human history","Russian and Ukraine go head to head in the Eurovision song contest, and Vladimir Putin mints a special coin to commemorate his annexation of the Crimean peninsula. (We come up with a better coin.","Last Week Tonight with John Oliver asks","John Oliver hosts a mathematically representative climate change debate, with the help of special guest Bill Nye the Science Guy, of course","John Oliver offers some evidence to dispel the myth that climate change is a myth","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Did you know that there are other countries than the United States of America?","Can the death penalty be executed humanely?","John Oliver interviews Vice news journalist Simon Ostrovsky who was held captive in Ukraine","In response to our segment in our premiere on food labeling, POM Wonderful sent us a refrigerator full of juice and an elegantly worded letter implying what we can do with it","John Oliver offers his take on the star-studded White House Correspondents Dinner, affectionately known as, \"Nerd Prom.","Subscribe to the HBO YouTube: http://itsh.bo/10qIqsj","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc","Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc"],["2017-05-22","2017-05-15","2017-05-15","2017-05-08","2017-04-24","2017-04-17","2017-04-10","2017-04-03","2017-03-20","2017-03-20","2017-03-13","2017-03-06","2017-02-27","2017-02-20","2017-02-13","2017-01-18","2016-11-29","2016-11-14","2016-11-07","2016-11-07","2016-11-05","2016-10-31","2016-10-24","2016-10-17","2016-10-10","2016-10-03","2016-09-26","2016-09-20","2016-09-12","2016-08-22","2016-08-29","2016-09-05","2016-08-15","2016-08-08","2016-08-08","2016-08-01","2016-07-25","2016-07-25","2016-07-18","2016-07-11","2016-06-28","2016-06-27","2016-07-04","2016-06-20","2016-06-13","2016-06-06","2016-05-23","2016-05-30","2016-05-16","2016-05-09","2016-05-02","2016-04-25","2016-04-18","2016-04-11","2016-04-04","2016-03-21","2016-03-28","2016-03-15","2016-03-14","2016-03-07","2016-02-29","2016-02-23","2016-02-22","2016-02-15","2016-01-15","2016-01-25","2016-01-04","2015-12-14","2015-11-23","2015-11-16","2015-11-09","2015-11-02","2015-10-19","2015-10-12","2015-10-05","2015-09-28","2015-09-14","2015-08-24","2015-08-31","2015-09-07","2015-08-17","2015-08-10","2015-08-03","2015-07-27","2015-07-20","2015-07-13","2015-06-29","2015-06-29","2015-07-06","2015-06-29","2015-06-22","2015-06-15","2015-06-08","2015-06-01","2015-05-18","2015-05-25","2015-05-11","2015-05-04","2015-04-27","2015-04-20","2015-04-20","2015-04-13","2015-04-09","2015-04-07","2015-04-06","2015-04-02","2015-03-23","2015-03-30","2015-03-16","2015-03-09","2015-03-09","2015-03-02","2015-02-23","2015-02-23","2015-02-16","2015-02-16","2015-02-09","2015-02-09","2015-02-04","2015-01-26","2015-01-09","2014-12-29","2014-11-24","2014-11-10","2014-11-10","2014-11-03","2014-11-03","2014-11-03","2014-11-03","2014-10-27","2014-10-27","2014-10-20","2014-10-20","2014-10-20","2014-10-13","2014-10-13","2014-10-06","2014-10-06","2014-10-09","2014-09-29","2014-09-29","2014-09-22","2014-09-22","2014-09-15","2014-09-15","2014-09-08","2014-09-08","2014-09-02","2014-08-25","2014-08-25","2014-08-18","2014-09-01","2014-08-11","2014-08-04","2014-08-04","2014-08-04","2014-07-28","2014-07-28","2014-07-21","2014-07-21","2014-07-14","2014-07-14","2014-07-09","2014-06-30","2014-06-30","2014-07-07","2014-06-30","2014-06-23","2014-06-16","2014-06-16","2014-06-16","2014-06-16","2014-06-16","2014-06-09","2014-06-09","2014-06-09","2014-06-02","2014-06-02","2014-06-02","2014-05-26","2014-05-19","2014-05-19","2014-05-19","2014-05-19","2014-05-19","2014-05-19","2014-05-12","2014-05-12","2014-05-12","2014-05-12","2014-05-06","2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-04-28","2014-04-28","2014-04-28","2014-04-28","2014-04-28","2014-04-28","2014-03-21","2014-03-21"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>short_title<\/th>\n      <th>short_desc<\/th>\n      <th>vid_created<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100],"rowCallback":"function(row, data) {\nvar value=data[0]; if (value!==null) $(this.api().cell(row, 0).node()).css({'font-size':'14px'});\nvar value=data[1]; if (value!==null) $(this.api().cell(row, 1).node()).css({'font-size':'14px'});\nvar value=data[2]; if (value!==null) $(this.api().cell(row, 2).node()).css({'font-size':'14px'});\n}"}},"evals":["options.rowCallback"],"jsHooks":[]}</script><!--/html_preserve-->

<br/>
## Fetching the comments

Now I get the comments for every video. I made my own functions for the same reason as before. The function `get_1_video_comments` retrieves comments from a given `video_id`, receiving the `n` parameter as the maximum of comments we want.


```r
get_1_video_comments <- function(video_id, n = 5) {
  nextPageToken <- NULL
  comments <- {}

  repeat {
    com <- get_comment_threads(c(video_id  = video_id),
                               part        = "id, snippet",
                               page_token  = nextPageToken,
                               text_format = "plainText")

    for (i in 1:length(com$items)) {
      com_id      <- com$items[[i]]$snippet$topLevelComment$id
      com_text    <- com$items[[i]]$snippet$topLevelComment$snippet$textDisplay
      com_video   <- com$items[[i]]$snippet$topLevelComment$snippet$videoId
      com_created <- com$items[[i]]$snippet$topLevelComment$snippet$publishedAt

      comments    <- comments %>% bind_rows(tibble(video_id    = com_video,
                                                   com_id      = com_id,
                                                   com_text    = com_text,
                                                   com_created = com_created))
      if (nrow(comments) == n) {
        break
      }

      nextPageToken <- ifelse(!is.null(com$nextPageToken), com$nextPageToken, NA)
    }

    if (is.na(nextPageToken) | nrow(comments) == n) {
      break
    }
  }
  return(comments)
}
```

The function `get_comments_dani` receives a vector of `video_id`s and returns `n` comments for every video, using the previous `get_1_video_comments` function. Then I remove empty comments, join with the video information and remove videos with less than 100 comments.


```r
get_comments_dani <- function(videos, n = 10){
  comments <- pmap_df(list(videos, n), get_1_video_comments)
}

raw_yt_comments <- get_comments_dani(videos$id, n = 300)

yt_comments <- raw_yt_comments %>%
  filter(com_text != "")
  left_join(videos, by = c("video_id" = "id")) %>%
  group_by(short_title) %>%
  mutate(n = n(),
         com_created = as.Date(com_created)) %>%
  ungroup() %>%
  filter(n >= 100)
```


And looking at the first rows we can already see some of that passion I was talking about 😳


```r
kable(head(yt_comments[, c(7, 9, 3)], 5), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> short_desc </th>
   <th style="text-align:left;"> com_text </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Stupid Watergate </td>
   <td style="text-align:left;"> John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation </td>
   <td style="text-align:left;"> Hoosier is their college thingy </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Stupid Watergate </td>
   <td style="text-align:left;"> John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation </td>
   <td style="text-align:left;"> Does anyone have a link to the full penguinvideo from the TSA part? That song is stuck in my head now. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Stupid Watergate </td>
   <td style="text-align:left;"> John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation </td>
   <td style="text-align:left;"> 2 things: 
1. I'm glad I have been occupying myself with other things this past week and during this current one

2. Waters is an idiot. He's literally some kiss-ass intern that worked under Bill O'Reilly and lucked out on the fact that Bill sexually harassed some women to end up getting his own lame-ass show. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Stupid Watergate </td>
   <td style="text-align:left;"> John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation </td>
   <td style="text-align:left;"> John Oliver wouldn't know unbiased reporting if it bit him in the ass. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Stupid Watergate </td>
   <td style="text-align:left;"> John Oliver discusses the shocking magnitude and potential impact of the latest revelations surrounding the Russia investigation </td>
   <td style="text-align:left;"> Give Thumbs up on this comment if you would like to BEAT THE FUCK out of John Oliver. </td>
  </tr>
</tbody>
</table>









# Most used words and sentiment

Comments are influenced by two facts: the discussed topic (usually it is a very controversial one), and the degree of fanaticism of the commenter. I think both of these things confluenced in very passionate comments.

## Positive and Negative words in comments

In the _tidy text_ world, a [tidy dataset](http://tidytextmining.com/tidytext.html) is a table with one-token-per-row. I start by tidying the `yt_comments` dataframe, and removing the stop words (this dictionary is already included in the `tidytext` package).


```r
library(tidytext)

tidy_yt_comments <- yt_comments %>%
  tidytext::unnest_tokens(word, com_text) %>%
  anti_join(stop_words, by = "word")
```

I'm using the `bing` lexicon to evaluate the emotion in the word, that categorizes it into _positive_ and _negative_. I join the words in the `tidy_yt_comments` dataset with the sentiment on the `bing` lexicon, and then count how many times each word apperars. 

So let's find out the most used words in the comments!


```r
library(ggplot2)

tidy_yt_comments %>%  
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup() %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, nn)) %>%
  ggplot(aes(word, nn, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = NULL, x = NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

There is a lot of strong words here! And I'm pretty sure this [`trump` _positive_ word](https://www.merriam-webster.com/dictionary/trump) we are seeing is not quite the same [_Trump_ John has been talking about non stop for the last two years](https://en.wikipedia.org/wiki/Donald_Trump)... and he is not precisely using it in a positive way...  I could include this word in a `custom_stop_words` dataframe, but I'm going leave it like that for now.

Also... not sure why `funny` is in the `negative` category. I know it can be used as _weird_, but I think this happens to me because I'm not a native english speaker.

Are there more positive or negative words?


```r
tidy_yt_comments %>%
  inner_join(get_sentiments("bing"), by = "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, nn)) %>%
  ggplot(aes(sentiment, nn)) +
  geom_col(aes(fill = sentiment), show.legend = FALSE) +
  scale_fill_manual(values = c("green3", "red2")) +
  ylab(NULL) +
  xlab(NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-13-1.png" style="display: block; margin: auto;" />


## More sentiments in comments

There is a different lexicon, the `nrc` one, that classiffies the words into more categories: positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust. Let's check what we find!


```r
tidy_yt_comments  %>%
  inner_join(get_sentiments("nrc"), by = "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, nn)) %>%
  ggplot(aes(word, nn, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

Ok... a few comments here. 

* `john` is considered a word with disgust and negative sentiment... So I checked and found that [it means either a toilet or a prostitute's client](https://www.google.com.uy/search?q=john+meaning&oq=john+meaning&aqs=chrome..69i57j0l5.5413j0j4&sourceid=chrome&ie=UTF-8). Either way, I'm going to remove it including it in the `custom_stop_words` dataframe because it is a word so frequent that makes every other word disproportionate.

* `trump` again is considered a positive word and also a surprise one (no doubt about the surprise element for both the word and the character though).

* `money`: what is wrong with this word? Apparently is a very confusing one, because it is linked with positive sentiment as anticipation, joy, surprise and trust, but is also with anger. Anyway, this is a side comment because it's about the lexicon and not this analysis.


```r
custom_stop_words <- bind_rows(data_frame(word = c("john"), 
                                          lexicon = c("custom")),
                               stop_words)

yt_comments %>%
  tidytext::unnest_tokens(word, com_text) %>%
  anti_join(custom_stop_words, by = "word") %>%
  inner_join(get_sentiments("nrc"), by = "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, nn)) %>%
  ggplot(aes(word, nn, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-15-1.png" style="display: block; margin: auto;" />

What is the most present sentiment?


```r
yt_comments %>%
  tidytext::unnest_tokens(word, com_text) %>%
  anti_join(custom_stop_words, by = "word") %>%
  inner_join(get_sentiments("nrc"), by = "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(pos_neg = ifelse(sentiment %in% c("positive", "anticipation", "joy", "trust", "surprise"), 
                          "Positive", "Negative")) %>%
  ggplot(aes(reorder(sentiment, nn), nn)) +
  geom_col(aes(fill = pos_neg), show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-16-1.png" style="display: block; margin: auto;" />
According to this lexicon, there are more positive than negative words! The opposite of wht we found using the `bing` lexicon. But this one allows us to analyze other sentiments as well.


# Most used n-grams

Other interesting thing to do is find the most common _bigrams_ (pairs of words) or _n-grams_.


```r
yt_comments %>%
  tidytext::unnest_tokens(five_gram, com_text, token = "ngrams", n = 5) %>%
  count(five_gram, sort = TRUE) %>%
  top_n(10) %>%
  mutate(five_gram = reorder(five_gram, nn)) %>%
  ggplot(aes(five_gram, nn)) +
  geom_col(fill = "red", show.legend = FALSE) +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-17-1.png" style="display: block; margin: auto;" />

The _*am i the only one*_, _*i the only one who*_ and _*is it just me or*_ 5-grams shows us a lot of misanderstood people, or at least who is wondering if they are alone in the way they think. I'm going to take a peek at these comments!


```r
am_i_the_only_one <- yt_comments %>%
  tidytext::unnest_tokens(five_gram, com_text, token = "ngrams", n = 5) %>%
  filter(five_gram == "am i the only one") %>%
  select(com_id)

kable(head(yt_comments[yt_comments$com_id %in% am_i_the_only_one$com_id, c(7, 3)]), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> com_text </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Ivanka &amp; Jared </td>
   <td style="text-align:left;"> Am I the only one who doesn't find trump funny anymore? Im sure theres at least 1 more person. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Federal Budget </td>
   <td style="text-align:left;"> am i the only one who thinks steve bannon looks like matt groening? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dancing Zebra Footage </td>
   <td style="text-align:left;"> Am I the only one who noticed that the Zebra is actually perfectly recreating that Shia Lebouf motivational speech video </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dalai Lama </td>
   <td style="text-align:left;"> Am I the only one here thinking that Oliver and Lama look very much alike? </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Putin </td>
   <td style="text-align:left;"> Am I the only one who is appalled by the fact that Bill O'Reilly said that if Russian planes flew near U.S. warships (which happened all the time during the Cold War) the only option would be to &quot;shoot 'em down&quot; ...... and John Oliver took O'Reily's side? I wish that these crazy war mongers would all go have a war in Antarctica and leave the rest of the world out of it. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Putin </td>
   <td style="text-align:left;"> Am i the only one wondering who the girl group is? </td>
  </tr>
</tbody>
</table>

And a very strange 5-gram: "great great great great great"... I have to check what this is about!


```r
great_great_great_great_great <- yt_comments %>%
  tidytext::unnest_tokens(five_gram, com_text, token = "ngrams", n = 5) %>%
  filter(five_gram == "great great great great great") %>%
  select(com_id)

kable(head(yt_comments[yt_comments$com_id %in% great_great_great_great_great$com_id, c(7, 3)]), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> com_text </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Other Countries' Presidents - François Hollande </td>
   <td style="text-align:left;"> I live in France as of now and I am American and French, my mother is american and my father is French. And I find it shocking that they mocked that Francois Hollande doesn't believe in God. In France, it is very common not to believe in God. probably 90% of the people I know don't believe in God and for us it's an evidence. We find people that do believe in God, weird. Even though he is a terrible president, I do agree with him on that. I find it weird that they emphasise at the End &quot;A president who doesn't think God exists&quot; and like that's an evidence. Because up until now, there has been NO proof of God's existence. Yet people still believe it. But what's weird is that if tomorrow I said &quot;I have aliens spelling in my house&quot; you would be like &quot;WTF!&quot;. It's just someone invented one day because at the time they didn't know how life was made and why is this and why is that, so they said &quot;only god has the answer&quot; yet now we have the answers to most things yet people still believe in God. America is the country with he most people that believe in God which is crazy. Only 3% of the people in the USA don't believe in God and in France it's probably the opposite. And choosing the christian religion, honestly, that's like the worst religion you could ever choose. You guys believe in Heaven and Hell and all that shit that's 100000% fake. You teach your kids terrible things. If you have to choose your religion, just believe in God and don't follow stupid rules. Or if you REALLY want to have a religion, choose Jewish, it's the most realistic one and their rules are way more down to the ground. I feel like the Bible was written by a Jew that took Crystal Meth by accident and thought that all that he saw was true and wrote it in a book which was written in a year where everyone believed what everyone said so they published the book, it then became a religion and people are transmitting this brainwashing bullshit to their kids and making crazy God psychopaths. If God exists, which I am questioning a lot, I don't think he needs everyone to suck his balls that much, I mean, would you like it if 3-5 Billion people (deducting people that believe in God) were sucking on your balls all day in exchange for you  making effort for each and everyone to help solve your dept issues or your couple problems? I am pretty sure you would commit suicide, so if God existed once, he probably committed suicide. And a lot of christians are still mad at Jews that they killed Jesus, well, if I would be angry at a person for killing my great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great great  GrandMother, most people would laugh at me, but since you are sheep and you say what everyone else says, War is what happens. Just to be clear My family is not Jewish, They are &quot;Catholic&quot; meaning that's what they were essentially but nobody cares about religion or believes in God in this family because we all know that it's all invented. I could honestly compare God to Santa Clause because instead of him being a guy that gives you free presents, he is supposed to heal all of ur problems in exchange for prayers. You have more luck sending a letter to the president than praying to God for help and getting an answer. </td>
  </tr>
</tbody>
</table>

Just like I suspected, this is one very long concatenation of the word _*great*_. This guy is a very, _very_ enthusiastic atheist who is refering to a very old ancestor, so it doesn't count for this analysis.

_how is this still a_ and _is this still a thing_ of course ring a bell for those of us who watch the show, since it has a section called "How is this still a thing?" talking about certain traditions or things that for some reason seemed adequate at some point in time, but now are totally absurd. Like why are US Presidential Elections on Tuesday, or 

# Moving on... 

## Sentiment Analysis on comments

Similarly as what I did for every word, now I join the words in the `tidy_yt_comments` dataset with the sentiment on the `bing` lexicon, and then count how many _positive_ and _negative_ words every comment has. Then compute the `sentiment` as `positive` - `negative`, to finally join this to the `yt_comment` dataset. 


```r
library(tidyr)

yt_comment_sent <- tidy_yt_comments  %>%
  inner_join(get_sentiments("bing"), by = "word") %>% 
  count(com_id, sentiment) %>%
  spread(sentiment, nn, fill = 0) %>%
  mutate(sentiment = positive - negative) %>% 
  ungroup() %>% 
  left_join(yt_comments, by = "com_id") %>% 
  arrange(sentiment)
```

The longer the comment, the higher potential for higher sentiment. Let's take a look at the extremes. The most negative comments according to the `bing` lexicon are:


```r
kable(head(yt_comment_sent[, c(2:6, 10, 12)], 2), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> negative </th>
   <th style="text-align:right;"> positive </th>
   <th style="text-align:right;"> sentiment </th>
   <th style="text-align:left;"> video_id </th>
   <th style="text-align:left;"> com_text </th>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> short_desc </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> -77 </td>
   <td style="text-align:left;"> KUdHIatS36A </td>
   <td style="text-align:left;"> Can you blame police?

&quot;Cop Killer&quot;

Cop killer, yeah!I got my black shirt on
I got my black gloves on
I got my ski mask on
This shit's been too long
I got my twelve gauge sawed off
I got my headlights turned off
I'm 'bout to bust some shots off
I'm 'bout to dust some cops offI'm a cop killer, better you than me
Cop killer, fuck police brutality!
Cop killer, I know your family's grieving
(Fuck 'em!)
Cop killer, but tonight we get even, ha haI got my brain on hype
Tonight'll be your night
I got this long-assed knife
And your neck looks just right
My adrenaline's pumpin'
I got my stereo bumpin'
I'm 'bout to kill me somethin'
A pig stopped me for nuthin'!Cop killer, better you than me
Cop killer, fuck police brutality!
Cop killer, I know your momma's grieving
(Fuck her!)
Cop killer, but tonight we get even, yeah!Die, die, die, pig, die! Fuck the police!
Fuck the police!
Fuck the police!
Fuck the police!Fuck the police!
Fuck the police!
Fuck the police!
Fuck the police!
Yeah!Cop killer, better you than me.
I'm a COP KILLER, fuck police brutality!
Cop killer, I know your family's grieving
(Fuck 'em!)
Cop killer, but tonight we get even, ha ha ha ha, yeah!Fuck the police!
Fuck the police!
Fuck the police!
Fuck the police!Fuck the police!
Fuck the police!
Fuck the police!
Fuck the police!
Break it downFuck the police, yeah!
Fuck the police, for Darryl Gates
Fuck the police, for Rodney King
Fuck the police, for my dead homies
Fuck the police, for your freedom
Fuck the police, don't be a pussy
Fuck the police, have some muthafuckin' courage
Fuck the police, sing alongCop killer!
Cop killer!
Cop killer!
Cop killer!Cop killer! Whaddyou wanna be when you grow up?
Cop killer! Good choice
Cop killer! I'm a muthafuckin'
Cop killer!Cop killer, better you than me
Cop killer, fuck police brutality!
Cop killer, I know your momma's grieving
(Fuck her!)
Cop killer, but tonight we get even! </td>
   <td style="text-align:left;"> Ferguson, MO and Police Militarization </td>
   <td style="text-align:left;"> In the wake of the shooting of Michael Brown in Ferguson, MO, John Oliver explores the racial inequality in treatment by police as well as the increasing militarization of America’s local police forces </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> -50 </td>
   <td style="text-align:left;"> 5pdPrQFjo2o </td>
   <td style="text-align:left;"> They're crazy about Morphine being bad, as the truth is that it isn't bad at all. It's NO different than any other drug/Medicine, it must be legally used, responsibly used, and it works fine (hello 26+ years and I haven't had one measly problem with a dosage they consider high, though truthfully it is a dosage that is correct and works for my great constant Pain- hello people I'm still alive! Don't buy into the Bull and LIES about it! 
I went through Hell with Pain every single day nonstop for over ten years and denied the one and only thing that has ever eased my Pain- Morphine! I suffered beyond words, Pain would get so bad it would make me vomit from neck Pain. But they didn't care one bit about my suffering then, nor do they care about it now and that I got peanuts for it all- a company's criminal actions that I didn't even cause or have anything to do with-strangers- here in the U.S., but NOT even from the United States! 
Then my life was saved as I was losing my mind from over 10 years of non-stop Pain and nothing worked to ease the Pain, but for the one Medicine I was forbidden to use, and told LIES as to why I couldn't use it. 
Then finally a Pain Doctor was finally allowed to start treating my Pain with Morphine Medicine, as nothing else has done a dam thing for my Pain! My Pain is mostly caused by a C1-C2 fusion, but I also have other injuries and Pain from it also- a severe head injury, and also severe injuries and broken bones- to my head, face, upper body caused by an illegally drunken driver in a truck who caused a head on collision (killed my two friends 19 &amp; 20 years old and we did nothing wrong), but this Country cares more about drug addicts, than they did/do for us or the torturous life ruining Pain I've had and I still have and go through the suffering now thanks to the Maine State Government- as they obviously don't care about the people like myself or the daily suffering of torturous constant Pain I go through. 
I have also used what they consider a high dosage of Morphine for 26 years with NOT one dam problem! But now they take it from me again- to save the drug addicts! 
Well- what the heck is this all about, they ruin our lives to save the drug addicts. Help those who do wrong, and screw us who have done nothing wrong!
These people, U.S. Government and State Government are just trying to actually kill us, while raising the street sales of Afghanistan Heroin. Yeah go figure that one! 
All these other things due nothing for my Pain! These people don't care, lack empathy, and are clueless to what this has done to my existence. But nothing has been done for us, as they don't care about us! They care more about terrorists from some other country, than they do for us people with Severe Chronic Pain, heck they've taken away the one and only thing that saved my life and gave me somewhat of a life! Yeah, again- go figure! </td>
   <td style="text-align:left;"> Opioids </td>
   <td style="text-align:left;"> John Oliver discusses the extent and root of the nation’s epidemic of opioid addiction </td>
  </tr>
</tbody>
</table>

And the most positive:


```r
kable(tail(yt_comment_sent[, c(2:6, 10, 12)], 2), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> negative </th>
   <th style="text-align:right;"> positive </th>
   <th style="text-align:right;"> sentiment </th>
   <th style="text-align:left;"> video_id </th>
   <th style="text-align:left;"> com_text </th>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> short_desc </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> YQZ2UeOTO3I </td>
   <td style="text-align:left;"> I love you and your show, but hold the phone. Seattle is awesome!!! Forgive me while I go on a little diatribe about the city I love now (because I'm currently working abroad and can't wait to get home). Music, theater, art, culture, coffee, farmer's markets, the University of Washington, a great LGBT scene and dog-friendly natural beauty everywhere. One of the top ten best cities to live in the US according to Business Insider, as well as top places to live if you're vegan or maybe smoke marijuana. We're bursting with libraries and museums, from the Experience Music Project And Pacific Science Center to the Museum of Flight and Burke Natural History Museum. We have a big theater culture, as well as art film theaters, and you can catch something to broaden your horizons any day. Live music and art collectives sprawl through tiny coffee shops in every neighborhood. The zip code I live in, in south Seattle, is the most diverse in the entire country. There are so many beautiful places to walk in Seattle, stunning views of Mt. Rainier, whales right in our backyard, and 94% of Seattle residents have a park within walking distance of where they live. We do get quite a bit of rain, but we also have one of the most temperate climates in the US, so summer isn't too hot and it hardly snows in winter. As a result, plenty of animals love it too, it's even often said we have more dogs than children. Coffee, art, dogs, and expansive views of trees brightening every corner against the blue of Lake Washington and the Pacific Ocean, earning us the moniker &quot;The Emerald City&quot;. There is no place better. Come and see for yourself! Again, love you and never stop doing what you do, John Oliver!!! You are a godsend for our country right now, so glad this is the one British import we actually like. </td>
   <td style="text-align:left;"> Marketing to Doctors </td>
   <td style="text-align:left;"> Pharmaceutical companies spend billions of dollars marketing drugs to doctors </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> e0bMfS-_pjM </td>
   <td style="text-align:left;"> Dear John
My name is Joana and I am your biggest fan in the universe. I say this with confidence because by definition, I am enthusiastically devoted to you. Now I don’t own a television, I am against television all together but thankfully you’re on youtube and between one ted talk and a make up tutorial I don’t know exactly how, I came to your videos and felt in love. I say this with the utmost respect for your beautiful wife, I am sure you chose the right girl for you,  and, because you are married, I have no aspirations of a romantic experience with you.I admire you as an idol, and I wanted to take this opportunity to thank you. Thank you John for being who you are. The smartest, funniest, most insightful and proper person that I ever experienced, but also because you worked hard to become  such a star. To spread your brilliant ideas across and through your talent make the world a better place. I feel hopeful of a better world because of the multitude of people  who appreciate your show. I feel proud that a white supremacist shithead mentions you in his hate speech, as an opponent force. Did  you ever think you would be such a powerful force?
I never had an idol before. I mean, I loved Whitney Houston when I was 16 and tried to sing like her but that did not work well at all. But the moment I watched your first show I could not help but watch every single one of them over the a few months.  Then I researched about you, and you know, I am 32 years old and I  feel the impulse to collect pictures of you. Maybe not. But I am just so happy that a guy with your wonderful ideas, wonderful vision of the world, is empowered to broadcast yourself and inspire others to do the right things, to make sense of this crazy world, and do this with a sharp  sense of humor.
You are wonderful John Oliver, wonderful. I feel ridiculous to say this because I am not 15 years old and as a grown woman have a demanding job and many responsibilities, but deep inside I cultivate the dream of, someday, meet you in person and say to you, how inspired I am by you.
As I am sure it will never happen, though I will keep the more realistic expectation that this letter reaches you. And if it does and you need to keep just one single word from it, make it three: THANK YOU JOHN! Joana </td>
   <td style="text-align:left;"> Voting On Tuesday - How Is This Still A Thing? </td>
   <td style="text-align:left;"> Tuesday voting is highly inconvenient, so why do we still do it </td>
  </tr>
</tbody>
</table>

See? People get passionate about the stories on this show.

## Sentiment Analysis on episodes

Let's see what we find when grouping the comments by episode. 


```r
yt_title_sent <- yt_comment_sent %>% 
  group_by(short_title, vid_created) %>% 
  summarise(pos           = sum(positive),
            neg           = sum(negative),
            sentiment     = pos - neg) %>% 
  ungroup() %>% 
  arrange(-sentiment)
  
head(yt_title_sent, 7) %>% bind_rows(tail(yt_title_sent, 7)) %>% 
  ggplot(aes(reorder(short_title, sentiment), sentiment) ) +
  geom_col(aes(fill = sentiment > 0), show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip() +
  theme_minimal() 
```

<img src="/figure/./2017-05-26-john-oliver/unnamed-chunk-23-1.png" style="display: block; margin: auto;" />

Let's examine what are these episodes about!


```r
kable(
  head(yt_title_sent, 7) %>% 
    bind_rows(tail(yt_title_sent, 7)) %>% 
    left_join(videos, by = "short_title") %>% 
    select(short_title, short_desc, sentiment),
  format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> short_title </th>
   <th style="text-align:left;"> short_desc </th>
   <th style="text-align:right;"> sentiment </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Letter of the Week -- POM Wonderful (Web Exclusive) </td>
   <td style="text-align:left;"> In response to our segment in our premiere on food labeling, POM Wonderful sent us a refrigerator full of juice and an elegantly worded letter implying what we can do with it </td>
   <td style="text-align:right;"> 100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Real Animals, Fake Paws Footage </td>
   <td style="text-align:left;"> We have provided this footage for you to do your own Supreme Court reenactments. Please feel free to use it, post your videos, and tag them #RealAnimalsFakePaws so we can find them </td>
   <td style="text-align:right;"> 74 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Last Week's News...We Think (Web Exclusive) </td>
   <td style="text-align:left;"> John Oliver delivers last week's news, predicted two weeks ago. </td>
   <td style="text-align:right;"> 48 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dr. Jane Goodall Interview </td>
   <td style="text-align:left;"> For our series People Who Think Good, John Oliver sits down for a banana with Dr. Jane Goodall, one of the world's foremost experts in chimpanzees </td>
   <td style="text-align:right;"> 47 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fan Mail Vol. 1 (Web Exclusive) </td>
   <td style="text-align:left;"> John Oliver reads fan mail, but because no one sends mail anymore, it’s all from YouTube comments </td>
   <td style="text-align:right;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Supreme Court </td>
   <td style="text-align:left;"> Cameras aren’t allowed in the Supreme Court, so most coverage of our most important cases looks like garbage </td>
   <td style="text-align:right;"> 15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Season 2 </td>
   <td style="text-align:left;"> Subscribe to the Last Week Tonight YouTube: http://itsh.bo/1h6WGc </td>
   <td style="text-align:right;"> 14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Drones </td>
   <td style="text-align:left;"> The United States has launched a huge number of drone strikes under President Obama. </td>
   <td style="text-align:right;"> -399 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dressing Up As Other Races (How Is This Still a Thing?) </td>
   <td style="text-align:left;"> Last Week Tonight with John Oliver asks </td>
   <td style="text-align:right;"> -440 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ferguson, MO and Police Militarization </td>
   <td style="text-align:left;"> In the wake of the shooting of Michael Brown in Ferguson, MO, John Oliver explores the racial inequality in treatment by police as well as the increasing militarization of America’s local police forces </td>
   <td style="text-align:right;"> -477 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Abortion Laws </td>
   <td style="text-align:left;"> Abortion is theoretically legal, but some states make it practically inaccessible </td>
   <td style="text-align:right;"> -489 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Death Penalty </td>
   <td style="text-align:left;"> Can the death penalty be executed humanely? </td>
   <td style="text-align:right;"> -489 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Opioids </td>
   <td style="text-align:left;"> John Oliver discusses the extent and root of the nation’s epidemic of opioid addiction </td>
   <td style="text-align:right;"> -544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mental Health </td>
   <td style="text-align:left;"> John Oliver explains how our national system of treating mental health works, or more often than not, how it doesn’t </td>
   <td style="text-align:right;"> -619 </td>
  </tr>
</tbody>
</table>

# Wordcloud!

I couldn't let this opportunity go to make a wordcloud!


```r
library(wordcloud)
```

```
## Error in library(wordcloud): there is no package called 'wordcloud'
```

```r
library(viridis)
library(tm)
```

```
## Error in library(tm): there is no package called 'tm'
```

```r
words <- toString(yt_comments$com_text) %>%
  str_split(pattern = " ", simplify = TRUE)
```

```
## Error in function_list[[k]](value): could not find function "str_split"
```

```r
wordcloud <- wordcloud(words, colors = viridis::viridis_pal(end = 0.8)(10),
                       min.freq = 800, random.color = TRUE, max.words = 100,
                       scale = c(3.5,.03))
```

```
## Error in eval(expr, envir, enclos): could not find function "wordcloud"
```


