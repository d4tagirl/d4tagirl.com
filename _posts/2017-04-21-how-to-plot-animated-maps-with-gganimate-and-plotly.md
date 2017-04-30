---
layout: post
title:  Visualizing R-Ladies's growth! 
date: "2017-04-20 12:11:29 UYT"
published: false
tags: [rstats, r, gganimate, plotly]
description: How to plot animated maps in R, with gganimate and plotly.
---
Here I show how to plot the Twitter users' data retrieved in my previous post in different animated maps, using `gganimate` and `plotly`.

<!--more-->

As I mentioned in my previous post, I recently [came across this article](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/), and I knew I had to produce a similar map for the [R-Ladies' chapters](http://rladies.org/). I insist that the purple color did its magic with me. So my idea was to plot all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it.

The first part of this project was to get all the R-Ladies chapters' Twitter users, and that is [what I did in my previous post]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}){:target="_blank"}. Now I have to plot the maps and animate them. Fun!

# Using Plotly

Let's take a look at the data from my last blog post:




```r
library(knitr)

kable(head(rladies), format = "html")
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:left;"> location </th>
   <th style="text-align:left;"> created_at </th>
   <th style="text-align:right;"> followers </th>
   <th style="text-align:left;"> age_days </th>
   <th style="text-align:right;"> lon </th>
   <th style="text-align:right;"> lat </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RLadiesSF </td>
   <td style="text-align:left;"> San Francisco </td>
   <td style="text-align:left;"> 2012-10-15 </td>
   <td style="text-align:right;"> 886 </td>
   <td style="text-align:left;"> 1652.917 days </td>
   <td style="text-align:right;"> -122.4194155 </td>
   <td style="text-align:right;"> 37.77493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesLondon </td>
   <td style="text-align:left;"> London, England </td>
   <td style="text-align:left;"> 2016-04-20 </td>
   <td style="text-align:right;"> 1102 </td>
   <td style="text-align:left;"> 369.875 days </td>
   <td style="text-align:right;"> -0.1277583 </td>
   <td style="text-align:right;"> 51.50735 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesRTP </td>
   <td style="text-align:left;"> Durham, NC </td>
   <td style="text-align:left;"> 2016-06-28 </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:left;"> 300.875 days </td>
   <td style="text-align:right;"> -78.8986190 </td>
   <td style="text-align:right;"> 35.99403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesCT </td>
   <td style="text-align:left;"> Connecticut, USA </td>
   <td style="text-align:left;"> 2016-11-24 </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:left;"> 151.875 days </td>
   <td style="text-align:right;"> -73.0877490 </td>
   <td style="text-align:right;"> 41.60322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesIstanbul </td>
   <td style="text-align:left;"> İstanbul, Türkiye </td>
   <td style="text-align:left;"> 2016-09-06 </td>
   <td style="text-align:right;"> 425 </td>
   <td style="text-align:left;"> 230.875 days </td>
   <td style="text-align:right;"> 28.9783589 </td>
   <td style="text-align:right;"> 41.00824 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RLadiesBCN </td>
   <td style="text-align:left;"> Barcelona, Spain </td>
   <td style="text-align:left;"> 2016-10-11 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:left;"> 195.875 days </td>
   <td style="text-align:right;"> 2.1734035 </td>
   <td style="text-align:right;"> 41.38506 </td>
  </tr>
</tbody>
</table>

I want to produce a map where I can plot each chapter according to its location, with the point's size indicating the amount of Twitter followers. I'm chosing `plotly` now because I love its interactivity, and you can select what you want to see when you hover over the points.

I use the `maps` package to get the world map, using `ggplot2` and `theme_map` for plotting it nicely. 


```r
library(ggplot2)
library(maps)
library(ggthemes)

world <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map() 
```

<img src="/figure/source/how-to-plot-animated-maps-with-gganimate-and-plotly/2017-04-21-how-to-plot-animated-maps-with-gganimate-and-plotly/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Now I plot the chapters. I chose the purple color, obviously!


```r
map <- world +
  geom_point(aes(x = lon, y = lat,
                 size = followers),
             data = rladies, colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')
```

<img src="/figure/source/how-to-plot-animated-maps-with-gganimate-and-plotly/2017-04-21-how-to-plot-animated-maps-with-gganimate-and-plotly/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

The only thing left is to animate it with `plotly`, and this is really easy!!


```r
library(plotly)

# ggplotly(map, tooltip = c('size'))
```

Now if you hover over the map you can see how many folowers each chapter have. I use the `tooltip` parameter to specify the aesthetics I want `ggplotly` to display in the label when hovering over each point in the map.

But what if you want to see more information about every chapter? There is a very simple way to do this. You only need to add an additional aesthetic parameter to the `ggplot`, and it will pass it to `ggplotly`.


```r
map <- world +
  geom_point(aes(x = lon, y = lat, 
                 text = paste('city: ', location, "<br />",
                  'followers: ', followers),
                 size = followers,
                 creation = created_at),
             data = rladies, colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')

# ggplotly(map, tooltip = c('text', 'size', 'creation')) 
```

Here I add two new parameters to the aesthetics: the first one is `text`, that allowes me to customize output using `paste()`, and the second one that I invented is `creation`, and it is passed just like that to the tooltip. I couldn't find a way to do the same I did with `text`, with a different parameter... The creators even call it _"the unofficial "text" aesthetic"_, so I don't know if there actually you can do that woth a different parameter.


```r
library(ggplot2)
library(plotly)

g <- list(
  showframe = FALSE,
  coastlinecolor = toRGB("grey"),
  showland = TRUE,
  landcolor = toRGB("grey"),
  showcountries = TRUE,
  countrycolor = toRGB("white"),
  countrywidth = 0.2,
  projection = list(type = 'Mercator')
)

p <- plot_geo(rladies,
              marker = list(color = "#B23AEE",
                            opacity = 0.5,
                            line = list(color = "#7A378B",
                                        width = 1.5))) %>%
  add_markers(
    x = ~lon,
    y = ~lat,
    sizes = c(1, 400),
    size = ~followers,
    hoverinfo = "text",
    text = ~paste('city: ', rladies$location, "<br />",
                  'followers: ', rladies$followers)
  ) %>%
  layout(
    geo = g
  )

p
```

<!--html_preserve--><div id="34541cbdee4" style="width:910px;height:520px;" class="plotly html-widget"></div>
<script type="application/json" data-for="34541cbdee4">{"x":{"visdat":{"3451756353":["function () ","plotlyVisDat"]},"cur_data":"3451756353","attrs":{"3451756353":{"marker":{"color":"#B23AEE","opacity":0.5,"line":{"color":"#7A378B","width":1.5}},"alpha":1,"sizes":[1,400],"x":{},"y":{},"type":"scatter","mode":"markers","size":{},"hoverinfo":"text","text":{}}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"mapType":"geo","geo":{"domain":{"x":[0,1],"y":[0,1]},"showframe":false,"coastlinecolor":"rgba(190,190,190,1)","showland":true,"landcolor":"rgba(190,190,190,1)","showcountries":true,"countrycolor":"rgba(255,255,255,1)","countrywidth":0.2,"projection":{"type":"Mercator"}},"dragmode":"zoom","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":[{"name":"Collaborate","icon":{"width":1000,"ascent":500,"descent":-50,"path":"M487 375c7-10 9-23 5-36l-79-259c-3-12-11-23-22-31-11-8-22-12-35-12l-263 0c-15 0-29 5-43 15-13 10-23 23-28 37-5 13-5 25-1 37 0 0 0 3 1 7 1 5 1 8 1 11 0 2 0 4-1 6 0 3-1 5-1 6 1 2 2 4 3 6 1 2 2 4 4 6 2 3 4 5 5 7 5 7 9 16 13 26 4 10 7 19 9 26 0 2 0 5 0 9-1 4-1 6 0 8 0 2 2 5 4 8 3 3 5 5 5 7 4 6 8 15 12 26 4 11 7 19 7 26 1 1 0 4 0 9-1 4-1 7 0 8 1 2 3 5 6 8 4 4 6 6 6 7 4 5 8 13 13 24 4 11 7 20 7 28 1 1 0 4 0 7-1 3-1 6-1 7 0 2 1 4 3 6 1 1 3 4 5 6 2 3 3 5 5 6 1 2 3 5 4 9 2 3 3 7 5 10 1 3 2 6 4 10 2 4 4 7 6 9 2 3 4 5 7 7 3 2 7 3 11 3 3 0 8 0 13-1l0-1c7 2 12 2 14 2l218 0c14 0 25-5 32-16 8-10 10-23 6-37l-79-259c-7-22-13-37-20-43-7-7-19-10-37-10l-248 0c-5 0-9-2-11-5-2-3-2-7 0-12 4-13 18-20 41-20l264 0c5 0 10 2 16 5 5 3 8 6 10 11l85 282c2 5 2 10 2 17 7-3 13-7 17-13z m-304 0c-1-3-1-5 0-7 1-1 3-2 6-2l174 0c2 0 4 1 7 2 2 2 4 4 5 7l6 18c0 3 0 5-1 7-1 1-3 2-6 2l-173 0c-3 0-5-1-8-2-2-2-4-4-4-7z m-24-73c-1-3-1-5 0-7 2-2 3-2 6-2l174 0c2 0 5 0 7 2 3 2 4 4 5 7l6 18c1 2 0 5-1 6-1 2-3 3-5 3l-174 0c-3 0-5-1-7-3-3-1-4-4-5-6z"},"click":"function(gd) { \n        // is this being viewed in RStudio?\n        if (location.search == '?viewer_pane=1') {\n          alert('To learn about plotly for collaboration, visit:\\n https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html');\n        } else {\n          window.open('https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html', '_blank');\n        }\n      }"}],"modeBarButtonsToRemove":["sendDataToCloud"]},"data":[{"marker":{"size":[321.722070844687,400,78.5531335149864,49.1989100817439,154.656675749319,131.100817438692,93.4114441416894,90.149863760218,112.618528610354,139.798365122616,147.046321525886,90.149863760218,66.5940054495913,70.2179836512262,53.5476839237057,65.5068119891008,63.3324250681199,36.8773841961853,42.3133514986376,41.9509536784741,27.8174386920981,63.6948228882834,26.3678474114441,47.0245231607629,31.441416893733,17.3079019073569,10.0599455040872,31.8038147138965,22.7438692098093,32.5286103542234,14.0463215258856,16.58310626703,7.16076294277929,2.44959128065395,1,126.389645776567,29.6294277929155],"sizemode":"area","fillcolor":"rgba(31,119,180,1)","color":"#B23AEE","opacity":0.5,"line":{"color":"#7A378B","width":1.5}},"type":"scattergeo","mode":"markers","hoverinfo":"text","text":["city:  San Francisco <br /> followers:  886","city:  London, England <br /> followers:  1102","city:  Durham, NC <br /> followers:  215","city:  Connecticut, USA <br /> followers:  134","city:  İstanbul, Türkiye <br /> followers:  425","city:  Barcelona, Spain <br /> followers:  360","city:  New York <br /> followers:  256","city:  Boston, MA <br /> followers:  247","city:  Los Angeles, CA <br /> followers:  309","city:  Madrid, Spain <br /> followers:  384","city:  Melbourne, Victoria <br /> followers:  404","city:  Paris, France <br /> followers:  247","city:  Lisbon <br /> followers:  182","city:  Berlin, Deutschland <br /> followers:  192","city:  Valencia, España <br /> followers:  146","city:  Nashville, TN <br /> followers:  179","city:  Columbus, OH <br /> followers:  173","city:  Austin, TX <br /> followers:  100","city:  Ames, IA <br /> followers:  115","city:  Washington, DC <br /> followers:  114","city:  London, Ontario <br /> followers:  75","city:  Buenos Aires, Argentina <br /> followers:  174","city:  Dublin City, Ireland <br /> followers:  71","city:  Manchester, England <br /> followers:  128","city:  Tbilisi <br /> followers:  85","city:  Munich, Bavaria <br /> followers:  46","city:  Adelaide, South Australia <br /> followers:  26","city:  Twin Cities <br /> followers:  86","city:  Budapest, Magyarország <br /> followers:  61","city:  Izmir, Turkey <br /> followers:  88","city:  Lima, Peru <br /> followers:  37","city:  Cape Town, South Africa <br /> followers:  44","city:  Rio de Janeiro, Brazil <br /> followers:  18","city:  Santa Rosa, Argentina <br /> followers:  5","city:  Montreal <br /> followers:  1","city:  Taipei <br /> followers:  347","city:  Warsaw <br /> followers:  80"],"geo":"geo","lat":[37.7749295,51.5073509,35.9940329,41.6032207,41.0082376,41.3850639,40.7127837,42.3600825,34.0522342,40.4167754,-37.8136276,48.856614,38.7222524,52.5200066,39.4699075,36.1626638,39.9611755,30.267153,42.0307812,38.9071923,42.9849233,-34.6036844,53.3498053,53.4807593,41.7151377,48.1351253,-34.9284989,44.9374831,47.497912,38.423734,-12.0463731,-33.9248685,-22.9068467,-36.620922,45.5016889,25.0329694,52.2296756],"lon":[-122.4194155,-0.1277583,-78.898619,-73.087749,28.9783589,2.1734035,-74.0059413,-71.0588801,-118.2436849,-3.7037902,144.9630576,2.3522219,-9.1393366,13.404954,-0.3762881,-86.7816016,-82.9987942,-97.7430608,-93.6319131,-77.0368707,-81.2452768,-58.3815591,-6.2603097,-2.2426305,44.827096,11.5819806,138.6007456,-93.2009998,19.040235,27.142826,-77.042754,18.4240553,-43.1728965,-64.2912369,-73.567256,121.5654177,21.0122287],"frame":null}],"highlight":{"on":"plotly_selected","off":"plotly_relayout","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"ctGroups":[]},"base_url":"https://plot.ly"},"evals":["config.modeBarButtonsToAdd.0.click"],"jsHooks":{"render":[{"code":"function(el, x) { var ctConfig = crosstalk.var('plotlyCrosstalkOpts').set({\"on\":\"plotly_selected\",\"off\":\"plotly_relayout\",\"persistent\":false,\"dynamic\":false,\"selectize\":false,\"opacityDim\":0.2,\"selected\":{\"opacity\":1}}); }","data":null}]}}</script><!--/html_preserve-->


```r
# #··············
# # gganimate 
# 
# map <- ggplot(world.cities, package = 'maps') +
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
# library(gganimate)
# 
# # animation::ani.options(ani.width = 1000, ani.height = 600)
# # # gganimate(map, interval = .3)
# # gganimate(map, interval = .3, filename = 'rladies.gif')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map, interval = .3, filename = 'rladies.gif')
# 
# #··············
# # gganimate, adding one transparent geom_point frame at the beggining
# 
# # init point to show empty map in the beggining
# ghost_point <- rladies %>%
#   add_row(
#     created_at = format(as.Date('2012-09-01'), format = '%Y-%m-%d'),
#     followers = 0,
#     lon = 0,
#     lat = 0,
#     .before = 1) %>% 
#   slice(1)
# 
# map_ghost <- map + 
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location), #print init point
#                  size = followers,
#                  frame = created_at,
#                  cumulative = TRUE),
#              data = ghost_point, colour = 'blue', alpha = 0) + 
#   labs(size = 'Followers')
# 
# # animation::ani.options(ani.width = 1000, ani.height = 600)
# # # gganimate(map_ghost, interval = .3)
# # gganimate(map_ghost, interval = .3, filename = 'rladies_ghost.gif')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map_ghost, interval = .3, filename = 'rladies_ghost.gif')
# 
# #··············
# # gganimate - with intermediate points!
# 
# library(tibble)
# 
# dates <- as_tibble(seq(as.Date(min(rladies$created_at)), 
#                        as.Date('2017-04-25'), 
#                        by = 'days')) %>% 
#   filter(day(value) %in% c(1, 5, 10, 15, 20, 25))
# 
# rladies_frames <- rladies %>% 
#   nest(-screen_name) %>% 
#   expand(screen_name, date = dates$value) %>%
#   right_join(rladies, by = 'screen_name') %>% 
#   filter(date > created_at) %>% 
#   mutate(date = format(date, format = '%Y-%m-%d'),
#          age_total = as.numeric(age_days, units = 'days'),
#          age_at_date = as.numeric(difftime(date, created_at, unit = 'days'), units = 'days'),
#          est_followers = ((followers - 1) / age_total) * age_at_date)
# 
# # modify init point to show empty map in the beggining
# 
# ghost_point <-  ghost_point %>% 
#   mutate(date = format(created_at, format = '%Y-%m-%d'),
#          est_followers = 0)
# 
# map_frames <- ggplot(world.cities, package = 'maps') +
#   borders('world', colour = 'gray80', fill = 'gray80') +
#   theme_map() +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location),
#                  size = est_followers,
#                  frame = date),
#              data = rladies_frames, colour = 'purple', alpha = .5) +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location), #print init point
#                  size = est_followers,
#                  frame = date),
#              data = ghost_point, colour = 'blue', alpha = 0) +
#   scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) + 
#   labs(size = 'Followers')
#              
# # animation::ani.options(ani.width = 1000, ani.height = 600)
# # # gganimate(map_frames, interval = .2)
# # gganimate(map_frames, interval = .2, filename = 'rladies_frames.gif')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map_frames, interval = .2, filename = 'rladies_frames.gif')
# 
# #··············
# # gganimate - with intermediate points - leaving some frames before London creation out
# 
# rladies_less_frames <- rladies_frames %>% 
#   filter((day(date) == 1 & month(date) %% 6 == 0) |
#            date >= rladies$created_at[rladies$screen_name == 'RLadiesLondon'])
# 
# map_less_frames <- ggplot(world.cities, package = 'maps') +
#   borders('world', colour = 'gray80', fill = 'gray80') +
#   theme_map() +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location),
#                  size = est_followers,
#                  frame = date),
#              data = rladies_less_frames, colour = 'purple', alpha = .5) + 
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location), #print init point
#                  size = est_followers,
#                  frame = date),
#              data = ghost_point, colour = 'blue', alpha = 0) +
#   scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) + 
#   labs(size = 'Followers')
# 
# # animation::ani.options(ani.width = 1000, ani.height = 600)
# # # gganimate(map_less_frames, interval = .2)
# # gganimate(map_less_frames, interval = .2, filename = 'rladies_less_frames.gif')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map_less_frames, interval = .2, filename = 'rladies_less_frames.gif')
# 
# #··············
# # gganimate -  leaving some frames before London creation out - faster!
# 
# dates <- as_tibble(seq(min(rladies$created_at), 
#                        as.POSIXlt('2017-04-25'), 
#                        by = 'days')) %>% 
#   filter(day(value) %in% c(1, 10, 20))
# 
# rladies_frames <- rladies %>% 
#   nest(-screen_name) %>% 
#   expand(screen_name, date = dates$value) %>%
#   right_join(rladies, by = 'screen_name') %>% 
#   filter(date > created_at) %>% 
#   mutate(date = format(date, format = '%Y-%m-%d'),
#          age_total = as.numeric(age_days, units = 'days'),
#          age_at_date = as.numeric(difftime(date, created_at, unit = 'days'), units = 'days'),
#          est_followers = ((followers - 1) / age_total) * age_at_date)
# 
# rladies_faster <- rladies_frames %>% 
#   filter((day(date) == 1 & month(date) %% 6 == 0) |
#            date >= rladies$created_at[rladies$screen_name == 'RLadiesLondon'])
# 
# map_faster <- ggplot(world.cities, package = 'maps') +
#   borders('world', colour = 'gray80', fill = 'gray80') +
#   theme_map() +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location),
#                  size = est_followers,
#                  frame = date),
#              data = rladies_faster, colour = 'purple', alpha = .5) +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location), #print init point
#                  size = est_followers,
#                  frame = date),
#              data = ghost_point, colour = 'blue', alpha = 0) +
#   scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) + 
#   labs(size = 'Followers')
# 
# # animation::ani.options(ani.width = 1000, ani.height = 600)
# # # gganimate(map_less_frames_fast, interval = .2)
# # gganimate(map_less_frames_fast, interval = .2, filename = 'rladies_less_frames_fast.gif')
# 
# animation::ani.options(ani.width = 750, ani.height = 450)
# gganimate(map_faster, interval = .2, filename = 'rladies_faster.gif')
#   


# save.image('RLadies_twitter_growth.RData')
```
