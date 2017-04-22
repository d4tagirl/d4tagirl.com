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

Recently [I came across this post](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/), and I knew I had to make a similar map for the [R-Ladies' chapters](http://rladies.org/) (probably the purple color had plenty to do with that!). So my idea was to map all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it. 

If I wanted to show everything I've done in a single post, it would be almost as long as my first one! And I didn't want that :P So I decided to make 2 _tutorial-like_ posts: one for the data preparation (this very one), and the second one about making the maps and animating them. And finally other post where I don't go into too much detail about everything.

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
library(knitr)

kable(head(users[, c(2:5)]), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> description </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> R-Ladies Global </td>
   <td style="text-align:left;"> RLadiesGlobal </td>
   <td style="text-align:left;"> The World </td>
   <td style="text-align:left;"> Promoting Gender Diversity in the #rstats community via meetups, mentorship &amp; global collaboration! 30+ groups worldwide: US|Europe|Oceania|LatAm|Asia #RLadies </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R-Ladies SF </td>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> R-Ladies is the first group dedicated to women and R. It was founded in Oct 2012 to promote knowledge, support and inclusivity. #rstats #RLadies </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R-Ladies London </td>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> The first R programming meetup for Minority Genders in the UK! Promoting Diversity &amp; Inclusivity in STEM/Data Science
london@rladies.org 
#RLadiesLondon #rstats </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R-Ladies RTP </td>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R-Ladies Connecticut </td>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> Promoting &amp; connecting women (and self-identified) interested in R programming throughout Connecticut! </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Alice Data </td>
   <td style="text-align:left;"> alice_data </td>
   <td style="text-align:left;"> London </td>
   <td style="text-align:left;"> Data Scientist @BritishMuseum | Trained in quantbio+conservation loves R, science, improv | Proud Introvert #quiet | @RLadiesGlobal co-founder #RLadies🌍 </td>
  </tr>
</tbody>
</table>

This is great! It retrieves the user if it matches the user's _description_ as well as _name_ and _screen name_ (handle), with 36 variables regarding the user. I'm only showing the ones I'm going to use, but there is a lot of extra information there.

# Cleaning the data

First I make sure I don't have any duplicates, and then I keep only the handles that comply with the stipulated format, using a regular expression. I filter out 3 additional handles: _'RLadies'_, whose _name_ is _'Royal Ladies'_, that I assume has something to do with royalty by the crown on their picture. _'RLadies\_LF'_ is a Japanese account that translated as follows on _Google Translator_: _'Rakuten Ichiba fashion delivery'_. And finally _'RLadiesGlobal'_ because it is not a chapter, so I don't want to map it. 

I also select the variables I will use, and correct the missing values on _location_ that I'll need to geocode the chapters. 

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
                         ifelse(screen_name == 'RLadiesMTL', 'Montreal', location))) %>%
  select(screen_name, location, created_at, followers = followers_count)

kable(head(rladies), format = "html")         
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 2012-10-15 04:18:09 </td>
   <td style="text-align:right;"> 886 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 2016-04-20 00:52:06 </td>
   <td style="text-align:right;"> 1102 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 2016-06-28 00:15:29 </td>
   <td style="text-align:right;"> 215 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 2016-11-24 14:21:03 </td>
   <td style="text-align:right;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 2016-09-06 11:18:43 </td>
   <td style="text-align:right;"> 425 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 2016-10-11 21:06:18 </td>
   <td style="text-align:right;"> 360 </td>
  </tr>
</tbody>
</table>

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
    created_at = as.Date('2014-11-15'),
    followers = 347)
```

As my ultimate goal is to map the chapters, I need to obtain the latitude and longitude for each one of them. The `ggmap` package really comes in handy for this kind of task. It interacts with _Google Maps_ to retrieve latitude and longitude, and I don't even have to worry about getting the location into a specific format, because it is so good at interpreting it! 

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

kable(head(rladies), format = "html")   
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
   <th style="text-align:left;"> longlat </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 1350274689 </td>
   <td style="text-align:right;"> 886 </td>
   <td style="text-align:left;"> -122.41942, 37.77493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 1461113526 </td>
   <td style="text-align:right;"> 1102 </td>
   <td style="text-align:left;"> -0.1277583, 51.5073509 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 1467072929 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:left;"> -78.89862, 35.99403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 1479997263 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:left;"> -73.08775, 41.60322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 1473160723 </td>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:left;"> 28.97836, 41.00824 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 1476219978 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:left;"> 2.173404, 41.385064 </td>
  </tr>
</tbody>
</table>



```r
rladies <- rladies %>% 
  unnest() 

kable(head(rladies), format = "html")         
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
   <th style="text-align:right;"> lon </th>
   <th style="text-align:right;"> lat </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 2012-10-15 04:18:09 </td>
   <td style="text-align:right;"> 886 </td>
   <td style="text-align:right;"> -122.4194155 </td>
   <td style="text-align:right;"> 37.77493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 2016-04-20 00:52:06 </td>
   <td style="text-align:right;"> 1102 </td>
   <td style="text-align:right;"> -0.1277583 </td>
   <td style="text-align:right;"> 51.50735 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 2016-06-28 00:15:29 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> -78.8986190 </td>
   <td style="text-align:right;"> 35.99403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 2016-11-24 14:21:03 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:right;"> -73.0877490 </td>
   <td style="text-align:right;"> 41.60322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 2016-09-06 11:18:43 </td>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:right;"> 28.9783589 </td>
   <td style="text-align:right;"> 41.00824 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 2016-10-11 21:06:18 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 2.1734035 </td>
   <td style="text-align:right;"> 41.38506 </td>
  </tr>
</tbody>
</table>

A few more minor changes and my dataframe will be ready! 

I format the date variable `created_at` as `%Y-%m-%d` (just because seeing the hours, minutes and seconds annoys me!) and generate the age in days (for reproducibility, I set a fixed date to compare it with).


```r
rladies <- rladies %>% 
  mutate(created_at = format(as.Date(created_at), format = '%Y-%m-%d'),
         age_days = difftime(as.Date('2017-4-25'), created_at, unit = 'days'))

kable(head(rladies), format = "html") 
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
   <th style="text-align:right;"> lon </th>
   <th style="text-align:right;"> lat </th>
   <th style="text-align:left;"> age_days </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 2012-10-15 </td>
   <td style="text-align:right;"> 886 </td>
   <td style="text-align:right;"> -122.4194155 </td>
   <td style="text-align:right;"> 37.77493 </td>
   <td style="text-align:left;"> 1652.917 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 2016-04-20 </td>
   <td style="text-align:right;"> 1102 </td>
   <td style="text-align:right;"> -0.1277583 </td>
   <td style="text-align:right;"> 51.50735 </td>
   <td style="text-align:left;"> 369.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 2016-06-28 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> -78.8986190 </td>
   <td style="text-align:right;"> 35.99403 </td>
   <td style="text-align:left;"> 300.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 2016-11-24 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:right;"> -73.0877490 </td>
   <td style="text-align:right;"> 41.60322 </td>
   <td style="text-align:left;"> 151.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 2016-09-06 </td>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:right;"> 28.9783589 </td>
   <td style="text-align:right;"> 41.00824 </td>
   <td style="text-align:left;"> 230.875 days </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 2016-10-11 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 2.1734035 </td>
   <td style="text-align:right;"> 41.38506 </td>
   <td style="text-align:left;"> 195.875 days </td>
  </tr>
</tbody>
</table>

That's it!

Now the dataframe is ready for me to use it for visualizing these Twitter users on the map (considering their sizes and dates of creation), and make some animations! If you are interested, [you can check how I do it here]() {:target="_blank"}

Thank you for reading! Please leave your comments below or [Mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616) :)
