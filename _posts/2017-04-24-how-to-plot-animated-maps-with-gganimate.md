---
layout: post
title:  How to plot animated maps with gganimate
date: "2017-04-24 12:11:29 UYT"
published: true
tags: [rstats, r, gganimate, maps, gif]
description: How to plot an animated map using `gganimate`, and produce a .gif file to share it!
---
Here I show how to plot an animated map using `gganimate`, and produce a .gif file to share it!

<!--more-->

As I mentioned in previous posts, I recently [came across this article](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/), and I knew I had to produce a similar map for the [R-Ladies' chapters](http://rladies.org/). I insist that the purple color did its magic with me. So my idea was to plot all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it.

The first part of this project was to get all the R-Ladies chapters' Twitter users, and that is [what I did in this previous post]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}){:target="_blank"}. Then I plotted them in a map using `ggplot2` and animated the map using the `plotly` package. Despite `plotly::ggplotly` apparently being the easier way, I discovered that it is not the way to go if you want to publish it on a website, as [I examine in this article]({% post_url 2017-04-24-maps-in-plotly-ggplotly-s-huge-maps-or-plot-geo %}){:target="_blank"}. It produces an extremely large HTML, so you should rather use `plotly::plot_geo` instead. 

Now I want to plot a similar map, but animating it using `gganimate`, so I can export it to a .gif file I can easily share. Fun!

# The data

Let's take a look at the data from my last blog post:




```r
library(DT)

datatable(rladies, rownames = FALSE,
          options = list(pageLength = 5))
```

<!--html_preserve--><div id="htmlwidget-fc0e086ea12c4aab3773" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fc0e086ea12c4aab3773">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesLondon","RLadiesRTP","RLadiesCT","RLadiesIstanbul","RLadiesBCN","RLadiesNYC","RLadiesBoston","RLadiesLA","RLadiesMAD","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesValencia","RLadiesNash","RLadiesColumbus","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesLdnOnt","RLadiesBA","RLadiesDublin","RLadiesManchest","RLadiesTbilisi","RLadiesMunich","RLadiesAdelaide","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadiesSR","RLadiesMTL","RLadiesTaipei","RLadiesWarsaw"],["San Francisco","London, England","Durham, NC","Connecticut, USA","İstanbul, Türkiye","Barcelona, Spain","New York","Boston, MA","Los Angeles, CA","Madrid, Spain","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Valencia, España","Nashville, TN","Columbus, OH","Austin, TX","Ames, IA","Washington, DC","London, Ontario","Buenos Aires, Argentina","Dublin City, Ireland","Manchester, England","Tbilisi","Munich, Bavaria","Adelaide, South Australia","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","Santa Rosa, Argentina","Montreal","Taipei","Warsaw"],["2012-10-15","2016-04-20","2016-06-28","2016-11-24","2016-09-06","2016-10-11","2016-09-01","2016-09-06","2016-08-29","2016-09-03","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-11-13","2016-09-28","2016-10-04","2016-12-15","2016-11-30","2016-12-08","2017-01-19","2017-01-05","2017-01-21","2016-10-08","2016-11-29","2017-03-21","2017-02-20","2015-04-04","2017-01-23","2016-10-19","2016-10-08","2017-03-06","2017-01-15","2017-04-06","2017-04-13","2014-11-15","2016-11-15"],[886,1102,215,134,425,360,256,247,309,384,404,247,182,192,146,179,173,100,115,114,75,174,71,128,85,46,26,86,61,88,37,44,18,5,1,347,80],[1652.91666666667,369.875,300.875,151.875,230.875,195.875,235.875,230.875,238.875,233.875,234.875,217.875,180.875,203.875,162.875,208.875,202.875,130.875,145.875,137.875,95.875,109.875,93.875,198.875,146.875,34.875,63.875,751.875,91.875,187.875,198.875,49.875,99.875,18.875,11.875,891.916666666667,160.875],[-122.4194155,-0.1277583,-78.898619,-73.087749,28.9783589,2.1734035,-74.0059413,-71.0588801,-118.2436849,-3.7037902,144.9630576,2.3522219,-9.1393366,13.404954,-0.3762881,-86.7816016,-82.9987942,-97.7430608,-93.6319131,-77.0368707,-81.2452768,-58.3815591,-6.2603097,-2.2426305,44.827096,11.5819806,138.6007456,-93.2009998,19.040235,27.142826,-77.042754,18.4240553,-43.1728965,-64.2912369,-73.567256,121.5654177,21.0122287],[37.7749295,51.5073509,35.9940329,41.6032207,41.0082376,41.3850639,40.7127837,42.3600825,34.0522342,40.4167754,-37.8136276,48.856614,38.7222524,52.5200066,39.4699075,36.1626638,39.9611755,30.267153,42.0307812,38.9071923,42.9849233,-34.6036844,53.3498053,53.4807593,41.7151377,48.1351253,-34.9284989,44.9374831,47.497912,38.423734,-12.0463731,-33.9248685,-22.9068467,-36.620922,45.5016889,25.0329694,52.2296756]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n      <th>lon<\/th>\n      <th>lat<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":[3,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

# Plot the map using ggplot2

<br />
I want to produce a map where I can plot each chapter according to its location, with the point's size indicating the amount of Twitter followers. 

I use the `maps` package to get the world map, using the `ggplot2` and `theme_map` ones for plotting it nicely. 


```r
library(ggplot2)
library(maps)
library(ggthemes)

world <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map() 
```

<img src="/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Now I plot the chapters. I chose the purple color, obviously!


```r
map <- world +
  geom_point(aes(x = lon, y = lat,
                 size = followers),
             data = rladies, 
             colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8), 
                        breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')
```

<img src="/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

With the `range` parameter I control the scale of the points' size.


# Animate the map using gganimate!

Now the only thing left is to animate the map! The core thing here is I want every chapter appearing in the order it was created, to somehow tell a story with the map. Lets start by animating `map`, the `ggplot` object we just created. I have to make a few changes for `gganimate` to work:

- for  `gganimate` to work it needs a `frame` aesthetic: I'll use the `created_at` variable. You set this as a new aesthetic in the `ggplot` and it is ignored by it, but it passes to the `gganimate`;
- I also added the `cumulative = TRUE`, so once the chapter appears on the map, it remains.


```r
# 
# # esta anda pero me deja cada frame separado. supuestamente se arregla poniendo fig.show = 'animate'. pruebo en la que viene!
# library(gganimate)
# 
# map <- ggplot() +
#   borders('world', colour = 'gray80', fill = 'gray80') +
#   theme_map() +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location),
#                  size = followers,
#                  frame = created_at,
#                  cumulative = TRUE),
#              data = rladies, colour = 'purple', alpha = .5) +
#   scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) +
#   labs(size = 'Followers')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map, interval = .3)
```







