---
layout: post
title:  How to plot animated maps with gganimate and plotly
date: "2017-04-20 12:11:29 UYT"
published: true
tags: [rstats, r, gganimate, plotly]
description: How to plot animated maps in R, with gganimate and plotly.
---
Here I show how to plot the Twitter users' data retrieved in my previous post in different animated maps, using `gganimate` and `plotly`.

<!--more-->

As I was telling in my previous post, recently [I came across this article](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/), and I knew I had to make a similar map for the [R-Ladies' chapters](http://rladies.org/). I insist that the purple color did its magic with me. So my idea was to plot all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it.

The first part of this project was to get all the R-Ladies chapters' Twitter users, and that is [what I did in my previous post]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}){:target="_blank"}. Now I have to plot the maps and animating them. Fun!

# Using Plotly

I'm using the data from my last blog post. Let's take a look at it:




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

So my idea is produce a map where I can plot each chapter, with the size indicating the amount of Twitter followers. I'm chosing `plotly` now because I love its interactivity, and I can select what I want to see in the label.



```r
# library('maps')
# library('ggthemes')
# 
# # load('RLadies_growing.Rdata')
# 
# #··················
# # plotly
# 
# library('plotly')
# 
# map <- ggplot(world.cities, package = 'maps') +
#   borders('world', colour = 'gray80', fill = 'gray80') +
#   theme_map() +
#   geom_point(aes(x = lon, y = lat, text = paste('city: ', location),
#                  size = followers,
#                  frame = created_at),
#              data = rladies, colour = 'purple', alpha = .5) +
#   scale_size_continuous(range = c(1, 10), breaks = c(250, 500, 750, 1000)) + 
#   labs(size = 'Followers')
# 
# ggplotly(map, tooltip = c('text', 'size', 'frame'))
# 
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
