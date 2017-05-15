---
layout: post
title:  How to plot animated maps with gganimate
date: "2017-05-10 10:11:29 UYT"
published: true
tags: [rstats, r, gganimate, maps, gif]
description: How to plot an animated map using the gganimate package, and produce a .gif file to share it!
---
Here I show how to plot an animated map using the `gganimate` package, and produce a .gif file to share it!

<!--more-->

This is the third one of the 3-posts-series, where I go from fetching Twitter users and preparing the data to visualizing it (If I wanted to show everything I've done in a single post, it would be almost as long as my first one! And I didn't want that 😝 ):

1. [How to fetch Twitter users with R]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}): the title is kind of self explanatory...
2. [How to deal with ggplotly huge maps]({% post_url 2017-04-26-how-to-deal-with-ggplotly-huge-maps %}): where I go through the details of why I chose not to use `ggplotly` and use `plot_geo` instead to generate the HTML.
3. How to plot animated maps with gganimate: this one. Again, pretty obvious subject.
 
Finally [I present my favourite visualization here]({% post_url 2017-05-10-visualizing-r-ladies-growth %}).

<br />
## The data

Let's take a look at the R-Ladies' chapters' Twitter accounts dataframe, `rladies`, I produced in the first post of this series:




```r
library(readr)
library(dplyr)

url_csv <- 'https://raw.githubusercontent.com/d4tagirl/R-Ladies-growth-maps/master/rladies.csv'
rladies <- read_csv(url(url_csv)) %>% 
  select(-1)

library(DT)

datatable(rladies, rownames = FALSE,
          options = list(pageLength = 5))
```

<!--html_preserve--><div id="htmlwidget-a6ebdc1ab3a810539338" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a6ebdc1ab3a810539338">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesNYC","RLadiesIstanbul","RLadiesBCN","RLadiesColumbus","RLadiesBoston","RLadiesLA","RLadiesLondon","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesRTP","RLadiesCT","RLadiesValencia","RLadiesNash","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesBA","RLadiesLdnOnt","RLadiesManchest","RLadiesDublin","RLadiesLima","RLadiesTbilisi","RLadiesAdelaide","RLadiesMunich","RLadiesSR","RLadiesMAD","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesCapeTown","RLadiesRio","RLadiesMTL","RLadiesSeattle","RLadiesTaipei","RLadiesWarsaw"],["San Francisco","New York","İstanbul, Türkiye","Barcelona, Spain","Columbus, OH","Boston, MA","Los Angeles, CA","London, England","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Durham, NC","Connecticut, USA","Valencia, España","Nashville, TN","Austin, TX","Ames, IA","Washington, DC","Buenos Aires, Argentina","London, Ontario","Manchester, England","Dublin City, Ireland","Lima, Peru","Tbilisi","Adelaide, South Australia","Munich, Bavaria","Santa Rosa, Argentina","Madrid, Spain","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Cape Town, South Africa","Rio de Janeiro, Brazil","Montreal","Seattle","Taipei","Warsaw"],["2012-10-15","2016-09-01","2016-09-06","2016-10-11","2016-10-04","2016-09-06","2016-08-29","2016-04-20","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-06-28","2016-11-24","2016-11-13","2016-09-28","2016-12-15","2016-11-30","2016-12-08","2017-01-05","2017-01-19","2016-10-08","2017-01-21","2016-10-08","2016-11-29","2017-02-20","2017-03-21","2017-04-06","2016-09-03","2015-04-04","2017-01-23","2016-10-19","2017-03-06","2017-01-15","2017-04-13","2017-05-06","2014-11-15","2016-11-15"],[916,309,436,377,179,259,320,1154,415,253,199,202,220,141,151,182,113,130,128,217,92,137,84,54,100,58,58,33,473,86,73,88,54,32,1,0,347,80],[1672.91666666667,255.875,250.875,215.875,222.875,250.875,258.875,389.875,254.875,237.875,200.875,223.875,320.875,171.875,182.875,228.875,150.875,165.875,157.875,129.875,115.875,218.875,113.875,218.875,166.875,83.875,54.875,38.875,253.875,771.875,111.875,207.875,69.875,119.875,31.875,8.875,911.916666666667,180.875],[-122.4194155,-74.0059413,28.9783589,2.1734035,-82.9987942,-71.0588801,-118.2436849,-0.1277583,144.9630576,2.3522219,-9.1393366,13.404954,-78.898619,-73.087749,-0.3762881,-86.7816016,-97.7430608,-93.6319131,-77.0368707,-58.3815591,-81.2452768,-2.2426305,-6.2603097,-77.042754,44.827096,138.6007456,11.5819806,-64.2912369,-3.7037902,-93.2009998,19.040235,27.142826,18.4240553,-43.1728965,-73.567256,-122.3320708,121.5654177,21.0122287],[37.7749295,40.7127837,41.0082376,41.3850639,39.9611755,42.3600825,34.0522342,51.5073509,-37.8136276,48.856614,38.7222524,52.5200066,35.9940329,41.6032207,39.4699075,36.1626638,30.267153,42.0307812,38.9071923,-34.6036844,42.9849233,53.4807593,53.3498053,-12.0463731,41.7151377,-34.9284989,48.1351253,-36.620922,40.4167754,44.9374831,47.497912,38.423734,-33.9248685,-22.9068467,45.5016889,47.6062095,25.0329694,52.2296756]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n      <th>lon<\/th>\n      <th>lat<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":[3,4,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br />
## Plotting the map using ggplot2

The goal is to produce a map where each chapter is plotted according to its location, with the point's size indicating the amount of Twitter followers. 

I use the `maps` package to get the world map, using the `ggplot2::ggplot` and `ggthemes::theme_map` functions for plotting it nicely. Then I plot the chapters choosing the purple color, obviously!


```r
library(ggplot2)
library(maps)
library(ggthemes)

world <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map() 

map <- world +
  geom_point(aes(x = lon, y = lat, size = followers),
             data = rladies, 
             colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8), 
                        breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')
```

<img src="/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/static_chapters_map-1.png" style="display: block; margin: auto;" />

The `range` parameter is what controls the scale of the points' size.
<br />
## Animating the map using gganimate

Now let's animate the map! The core thing here is that I want every chapter appearing following the creation timeline, to somehow tell a story with the map. Lets start by animating `map`: the `ggplot` object I just created. I have to make a few changes for `gganimate` to work:

- `gganimate` requires a `frame` aesthetic: I'll use the `created_at` variable. You set this as a new aesthetic in `ggplot` which is ignored by it (as shown in the warning messages), but `gganimate` recognizes and uses it;

- I also add the `cumulative = TRUE`, an additional aesthetic  (same comment about `ggplot` ignoring it), so once the chapter appears on the map, it keeps showing in all the following frames.

Following [my good friend Bruno](https://www.linkedin.com/in/bruno-chiesa-gispert-b1a6b942)'s suggestion, I add an empty frame at the beginning so that the first frame you see is just the empty map. I generate a dataframe with the same structure than the original one, with some random data, except for the `created_at` field that should be filled with a date prior to the first chapter creation for it to appear at the beginning.

And I add some empty frames at the end as well, to be able to see the final composition of chapters for a bit longer.


```r
library(tibble)
library(lubridate)

ghost_points_ini <- tibble(
  created_at = as.Date('2011-09-01'),
  followers = 0, lon = 0, lat = 0)

ghost_points_fin <- tibble(
  created_at = seq(as.Date('2017-05-16'),
                   as.Date('2017-05-30'),
                   by = 'days'),
  followers = 0, lon = 0, lat = 0)
```

Then I add an extra layer to the `ggplot`: the second `geom_point`, with the `alpha` parameter set to `0` so the point will not show in the plot.


```r
map <- world +
  geom_point(aes(x = lon, y = lat, size = followers, 
                 frame = created_at,
                 cumulative = TRUE),
             data = rladies, colour = 'purple', alpha = .5) +
  geom_point(aes(x = lon, y = lat, size = followers, # this is the init transparent frame
                 frame = created_at,
                 cumulative = TRUE),
             data = ghost_points_ini, alpha = 0) +
  geom_point(aes(x = lon, y = lat, size = followers, # this is the final transparent frames
                 frame = created_at,
                 cumulative = TRUE),
             data = ghost_points_fin, alpha = 0) +
  scale_size_continuous(range = c(1, 8), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers') 

library(gganimate)
ani.options(interval = 0.2)
gganimate(map)
```

![ani_map](/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/ani_map.gif)

This animation is so cool! It shows how R-Ladies is spreading all over the globe, giving also some idea of how it is growing: where in the world the chapters concentrates and how it accelerated its growing significantly in the last year or so!
<br />
## Customizing the animation

Now it's when I start to get a little obsessed about some details... You can always improve things, right? 😉
<br />
### Adding additional frames

This idea actually came from my husband, who suggested that each point could start small when the chapter is founded and reach its full size today. How cool would that be?! 

I only have each chapter once in the `rladies` dataframe, with the creation date and the amount of followers. To create new frames for the `gganimate`, I have to replicate each chapter with an intermediate number of followers (I assume linear growth) for each intermediate date. I do that by creating a dataframe of dates from the first R-Ladies' chapter was created until today (to make this analysis reproducible I assume today is 2017-05-15), and keep only the dates 1, 10 and 20 of each month (I could keep all dates but It would not improve the animation's quality much and it would generate a heavier animation).


```r
dates <- as_tibble(seq(floor_date(as.Date(min(rladies$created_at)), 
                                  unit = "month"),
                       as.Date('2017-05-15'),
                       by = 'days')) %>%
  filter(day(value) %in% c(1, 10, 20))
```

Then I generate a new dataframe with every chapter appearing once for every intermediate date, from its creation date until today. I assume the number of followers increasing linearly. (If you are familiar with `tidiverse` maybe you [prefer to skip the next part](#skipping) where I explain how I join these tables).


```r
library(tidyr)

rladies_frames <- rladies %>%
  select(screen_name) %>%
  expand(screen_name, date = dates$value) %>%
  right_join(rladies, by = 'screen_name') %>%
  filter(date > created_at) %>%
  mutate(age_total = as.numeric(age_days, units = 'days'),
         age_at_date = as.numeric(difftime(date, created_at, unit = 'days'), 
                                  units = 'days'),
         est_followers = ((followers - 1) / age_total) * age_at_date)
```

Step-by-step what I do is take the original `rladies` dataframe and select the `screen_name` column. With the `tidyr::expand` I create one row for every `screen_name`-`date` combination (Cartesian product). The `right_join` completes the rest of the information for every chapter, and then I keep only the dates for every chapter that are greater than its creation date (I don't want to have frames for a chapter previous to its foundation!). At last I add some variables useful to estimate the amount of followers (`est_followers`), assuming the amount of followers increases linearly.

<a id="skipping"> </a>


```r
ghost_points_ini <-  ghost_points_ini %>%
  mutate(date = created_at,
         est_followers = 0)

ghost_points_fin <-  ghost_points_fin %>%
  expand(date = created_at, rladies) %>%
  select(date, est_followers = followers, lon, lat)

map_frames <- world +
  geom_point(aes(x = lon, y = lat, size = est_followers, 
                 frame = date),
             data = rladies_frames, colour = 'purple', alpha = .5) +
  geom_point(aes(x = lon, y = lat, size = est_followers,
                 frame = date),
             data = ghost_points_ini, alpha = 0) +
  geom_point(aes(x = lon, y = lat, size = est_followers,
                 frame = date),
             data = ghost_points_fin, colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')

ani.options(interval = .05)
gganimate(map_frames)
```

![ani_map_frames](/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/ani_map_frames.gif)

This is a very accurate map in terms of the timeline: it shows how long it took for every chapter to be founded and how R-Ladies proliferated in the past year or so. 

But... (I told you I got kind of obsessed!) it takes too long from the creation of the first chapters until it started to get traction and the last part of the animation is really fast in comparison. So let's take care of that 😉
<br />
### Removing some frames from the beginning

The foundation of the London chapter was kind of a turning point: after that R-Ladies started to spread much faster. So I decided to keep all frames after that date, but remove several frames from before, keeping only the first day of the month, every 6 months. 


```r
rladies_less_frames <- rladies_frames %>%
  filter((day(date) == 1 & month(date) %% 6 == 0) |
           date >= rladies$created_at[rladies$screen_name == 'RLadiesLondon'])

map_less_frames <- world +
  geom_point(aes(x = lon, y = lat, size = est_followers, 
                 frame = date),
             data = rladies_less_frames, colour = 'purple', alpha = .5) +
  geom_point(aes(x = lon, y = lat, size = est_followers, 
                 frame = date),
             data = ghost_points_ini, alpha = 0) +
  geom_point(aes(x = lon, y = lat, size = est_followers, 
                 frame = date),
             data = ghost_points_fin, colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')

ani.options(interval = .15)
gganimate(map_less_frames)
```

![ani_map_less_frames](/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/ani_map_less_frames.gif)

This reduces a lot the amount of frames, at the cost of making the story less accurate in terms of time scale. But it is a nicer animation! My favorite actually 😊
<br />
## Creating the .gif

The only thing left is to save the animation to a file, in this case I choose a `.gif`, but you can also choose to save it as .mp4, .swf or .html (each of them requiring specific drivers, [check the documentation here](https://github.com/dgrtwo/gganimate))


```r
gganimate(map_less_frames, interval = .2, filename = 'rladies.gif')
```

I wanted a .gif file to share it on Twitter, Slack and other social media, so I could post something like this:

<blockquote class="twitter-tweet tw-align-center" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/hashtag/RLadies?src=hash">#RLadies</a> is growing! A sneak peek to my next blog post ;) <a href="https://twitter.com/hashtag/gganimate?src=hash">#gganimate</a> <a href="https://twitter.com/hashtag/rstats?src=hash">#rstats</a> <a href="https://t.co/rIJ02WzRTx">pic.twitter.com/rIJ02WzRTx</a></p>&mdash; Daniela Vázquez (@d4tagirl) <a href="https://twitter.com/d4tagirl/status/853003269953789952">April 14, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<br />
It was a pretty popular Tweet, so you should try! 

That's it! 

You can check out [the code in my GitHub repo](https://github.com/d4tagirl/R-Ladies-growth-maps). Please leave your comments if you have any, or [mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616). Thanks 😉

