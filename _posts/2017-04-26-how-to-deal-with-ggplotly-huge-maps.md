---
layout: post
title:  How to deal with ggplotly huge maps
date: "2017-05-10 09:11:29 UYT"
published: true
tags: [rstats, r, plotly, ggplotly, maps, plot_geo]
description: How to produce interactive maps in R with plotly, using ggplotly and plot_geo. While ggplotly is easier to use, it produces huge HTML content. Using plot_geo instead is incredibly more efficient.
---
How I had to go from `gglotly` to `plotly::plot_geo` to reduce the size of the HTML output for posting interactive maps on my blog.

<!--more-->

This is the second one of the 3-posts-series, where I go from fetching Twitter users and preparing the data to visualizing it (If I wanted to show everything I've done in a single post, it would be almost as long as my first one! And I didn't want that 😝 ):

1. [How to fetch Twitter users with R]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}): the title is kind of self explanatory...
2. How to deal with ggplotly huge maps: this one, where I go through the details of why I chose not to use `ggplotly` and use `plot_geo` instead to generate the HTML.
3. [How to plot animated maps with gganimate]({% post_url 2017-04-24-how-to-plot-animated-maps-with-gganimate %}): again, pretty obvious subject.
 
Finally [I present my favourite visualization here]({% post_url 2017-05-10-visualizing-r-ladies-growth %}).

## Motivation

For this series I've been experimenting with interactive maps and animated ones these past few days and I finally was able to produce some fancy outputs using the `plotly` package and the `gganimate` one. You can see the whole process [in my GitHub repo](https://github.com/d4tagirl/R-Ladies-growth-maps). Everything was working perfectly on RStudio, until I wanted to share my results on my blog, and _things got complicated_. Originally I produced some interactive maps using the `plotly::ggplotly` function and it generated a 3.3 MB HTML... and *that's an issue* when you want to include it on a website 😳 . So I tried a different approach: using the `plotly::plot_geo` function I was able to produce a very similar plot, generating a way smaller HTML.

## The data

I'm using the [data produced in this previous post]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}). Let's take a look at it to see what we are dealing with.




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

<!--html_preserve--><div id="htmlwidget-30e8f69b95ef0161f5e4" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-30e8f69b95ef0161f5e4">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesNYC","RLadiesIstanbul","RLadiesBCN","RLadiesColumbus","RLadiesBoston","RLadiesLA","RLadiesLondon","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesRTP","RLadiesCT","RLadiesValencia","RLadiesNash","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesBA","RLadiesLdnOnt","RLadiesManchest","RLadiesDublin","RLadiesLima","RLadiesTbilisi","RLadiesAdelaide","RLadiesMunich","RLadiesSR","RLadiesMAD","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesCapeTown","RLadiesRio","RLadiesMTL","RLadiesSeattle","RLadiesTaipei","RLadiesWarsaw"],["San Francisco","New York","İstanbul, Türkiye","Barcelona, Spain","Columbus, OH","Boston, MA","Los Angeles, CA","London, England","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Durham, NC","Connecticut, USA","Valencia, España","Nashville, TN","Austin, TX","Ames, IA","Washington, DC","Buenos Aires, Argentina","London, Ontario","Manchester, England","Dublin City, Ireland","Lima, Peru","Tbilisi","Adelaide, South Australia","Munich, Bavaria","Santa Rosa, Argentina","Madrid, Spain","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Cape Town, South Africa","Rio de Janeiro, Brazil","Montreal","Seattle","Taipei","Warsaw"],["2012-10-15","2016-09-01","2016-09-06","2016-10-11","2016-10-04","2016-09-06","2016-08-29","2016-04-20","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-06-28","2016-11-24","2016-11-13","2016-09-28","2016-12-15","2016-11-30","2016-12-08","2017-01-05","2017-01-19","2016-10-08","2017-01-21","2016-10-08","2016-11-29","2017-02-20","2017-03-21","2017-04-06","2016-09-03","2015-04-04","2017-01-23","2016-10-19","2017-03-06","2017-01-15","2017-04-13","2017-05-06","2014-11-15","2016-11-15"],[916,309,436,377,179,259,320,1154,415,253,199,202,220,141,151,182,113,130,128,217,92,137,84,54,100,58,58,33,473,86,73,88,54,32,1,0,347,80],[1672.91666666667,255.875,250.875,215.875,222.875,250.875,258.875,389.875,254.875,237.875,200.875,223.875,320.875,171.875,182.875,228.875,150.875,165.875,157.875,129.875,115.875,218.875,113.875,218.875,166.875,83.875,54.875,38.875,253.875,771.875,111.875,207.875,69.875,119.875,31.875,8.875,911.916666666667,180.875],[-122.4194155,-74.0059413,28.9783589,2.1734035,-82.9987942,-71.0588801,-118.2436849,-0.1277583,144.9630576,2.3522219,-9.1393366,13.404954,-78.898619,-73.087749,-0.3762881,-86.7816016,-97.7430608,-93.6319131,-77.0368707,-58.3815591,-81.2452768,-2.2426305,-6.2603097,-77.042754,44.827096,138.6007456,11.5819806,-64.2912369,-3.7037902,-93.2009998,19.040235,27.142826,18.4240553,-43.1728965,-73.567256,-122.3320708,121.5654177,21.0122287],[37.7749295,40.7127837,41.0082376,41.3850639,39.9611755,42.3600825,34.0522342,51.5073509,-37.8136276,48.856614,38.7222524,52.5200066,35.9940329,41.6032207,39.4699075,36.1626638,30.267153,42.0307812,38.9071923,-34.6036844,42.9849233,53.4807593,53.3498053,-12.0463731,41.7151377,-34.9284989,48.1351253,-36.620922,40.4167754,44.9374831,47.497912,38.423734,-33.9248685,-22.9068467,45.5016889,47.6062095,25.0329694,52.2296756]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n      <th>lon<\/th>\n      <th>lat<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":[3,4,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br />
This dataframe is about R-Ladies' chapters' Twitter accounts. I want to produce a `plotly` map where I can plot each chapter according to its location (`lon` and `lat`), with each point's size indicating its number of `followers`. 

## Using ggplotly

The first thing I did was generate the map using `ggplot2`, because `plotly` integrates easily with it with the `ggplotly` function. And I'm so comfortable using the `tidyverse`, that it was the natural thing for me to do! 

`ggplotly` translates the `ggplot2` object into a `plotly` one, displaying the aesthetic mappings in the tooltip. As I wanted to include other variables in it, I added the extra (and _unofficial_) `text` aesthetic for `ggplotly` to include them. As `ggplot2` doesn't have a `text` aesthetic it ignores it, but `ggplotly` recognizes it and displays it in the tooltip.

The greatest thing about the `text` aesthetic is that you can include more than one variable outside the `ggplot` aesthetics to display, as shown below.


```r
library(ggplot2)
library(maps)
library(ggthemes)

world <- ggplot() +
  borders("world", colour = "gray85", fill = "gray80") +
  theme_map()

map <- world +
  geom_point(aes(x = lon, y = lat,
                 text = paste('city: ', location,
                              '<br /> created : ', created_at),
                 size = followers),
             data = rladies, colour = 'purple', alpha = .5) +
  scale_size_continuous(range = c(1, 8), breaks = c(250, 500, 750, 1000)) +
  labs(size = 'Followers')
```

<img src="/figure/source/how-to-deal-with-ggplotly-huge-maps/2017-04-26-how-to-deal-with-ggplotly-huge-maps/static_map-1.png" style="display: block; margin: auto;" />

This is the static map that I'm animating using `ggplotly`, with the following code:


```r
library(plotly)

ggplotly(map, tooltip = c('text', 'size'))
```

If you want to see this map [you can check it here]({% post_url 2017-04-24-huge-ggplotly-map %}){:target="_blank"}, but it will take a while! It is a 3.3 MB page!

It's a pretty nice map, but it takes forever to load the HTML! And that is why I checked how the `plotly` people make this kind of plots from scratch, and I gave it a try.

It is actually pretty easy! The only thing that was not that straightforward for me was finding the chart references for customizing the maps (probably because I was doing a bad job at searching for them 😳 ), so [here is the link](https://plot.ly/r/reference/), and for the layout in particular [here it is this other link](https://plot.ly/r/reference/#layout-geo/) just in case you encounter the same difficulties as I did.


```r
g <- list(showframe = FALSE,
          coastlinecolor = toRGB("white"),
          showland = TRUE,
          landcolor = toRGB("gray80"),
          showcountries = TRUE,
          countrycolor = toRGB("white"),
          countrywidth = 0.2,
          projection = list(type = 'Mercator'))

plot_geo(rladies,
         marker = list(color = toRGB("purple"),
                       opacity = 0.5,
                       line = list(color = toRGB("purple"),
                                   width = 1.5))) %>%
  add_markers(x = ~lon,
              y = ~lat,
              sizes = c(1, 450),
              size = ~followers,
              hoverinfo = "text",
              text = ~paste('city: ', location,
                            '<br /> created: ', created_at,
                            '<br /> followers: ', followers)) %>%
  layout(geo = g)
```

<!--html_preserve--><div id="eff669b792e" style="width:910px;height:520px;" class="plotly html-widget"></div>
<script type="application/json" data-for="eff669b792e">{"x":{"visdat":{"eff1d74e9b5":["function () ","plotlyVisDat"]},"cur_data":"eff1d74e9b5","attrs":{"eff1d74e9b5":{"marker":{"color":"rgba(160,32,240,1)","opacity":0.5,"line":{"color":"rgba(160,32,240,1)","width":1.5}},"alpha":1,"sizes":[1,450],"x":{},"y":{},"type":"scatter","mode":"markers","size":{},"hoverinfo":"text","text":{}}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"mapType":"geo","geo":{"domain":{"x":[0,1],"y":[0,1]},"showframe":false,"coastlinecolor":"rgba(255,255,255,1)","showland":true,"landcolor":"rgba(204,204,204,1)","showcountries":true,"countrycolor":"rgba(255,255,255,1)","countrywidth":0.2,"projection":{"type":"Mercator"}},"dragmode":"zoom","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":[{"name":"Collaborate","icon":{"width":1000,"ascent":500,"descent":-50,"path":"M487 375c7-10 9-23 5-36l-79-259c-3-12-11-23-22-31-11-8-22-12-35-12l-263 0c-15 0-29 5-43 15-13 10-23 23-28 37-5 13-5 25-1 37 0 0 0 3 1 7 1 5 1 8 1 11 0 2 0 4-1 6 0 3-1 5-1 6 1 2 2 4 3 6 1 2 2 4 4 6 2 3 4 5 5 7 5 7 9 16 13 26 4 10 7 19 9 26 0 2 0 5 0 9-1 4-1 6 0 8 0 2 2 5 4 8 3 3 5 5 5 7 4 6 8 15 12 26 4 11 7 19 7 26 1 1 0 4 0 9-1 4-1 7 0 8 1 2 3 5 6 8 4 4 6 6 6 7 4 5 8 13 13 24 4 11 7 20 7 28 1 1 0 4 0 7-1 3-1 6-1 7 0 2 1 4 3 6 1 1 3 4 5 6 2 3 3 5 5 6 1 2 3 5 4 9 2 3 3 7 5 10 1 3 2 6 4 10 2 4 4 7 6 9 2 3 4 5 7 7 3 2 7 3 11 3 3 0 8 0 13-1l0-1c7 2 12 2 14 2l218 0c14 0 25-5 32-16 8-10 10-23 6-37l-79-259c-7-22-13-37-20-43-7-7-19-10-37-10l-248 0c-5 0-9-2-11-5-2-3-2-7 0-12 4-13 18-20 41-20l264 0c5 0 10 2 16 5 5 3 8 6 10 11l85 282c2 5 2 10 2 17 7-3 13-7 17-13z m-304 0c-1-3-1-5 0-7 1-1 3-2 6-2l174 0c2 0 4 1 7 2 2 2 4 4 5 7l6 18c0 3 0 5-1 7-1 1-3 2-6 2l-173 0c-3 0-5-1-8-2-2-2-4-4-4-7z m-24-73c-1-3-1-5 0-7 2-2 3-2 6-2l174 0c2 0 5 0 7 2 3 2 4 4 5 7l6 18c1 2 0 5-1 6-1 2-3 3-5 3l-174 0c-3 0-5-1-7-3-3-1-4-4-5-6z"},"click":"function(gd) { \n        // is this being viewed in RStudio?\n        if (location.search == '?viewer_pane=1') {\n          alert('To learn about plotly for collaboration, visit:\\n https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html');\n        } else {\n          window.open('https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html', '_blank');\n        }\n      }"}],"modeBarButtonsToRemove":["sendDataToCloud"]},"data":[{"marker":{"size":[357.398613518198,121.226169844021,170.639514731369,147.683708838822,70.6455805892548,101.772097053726,125.506065857886,450,162.468804159445,99.4376083188908,78.4272097053726,79.5944540727903,86.5979202772964,55.8604852686308,59.7512998266898,71.8128249566724,44.9662045060659,51.580589254766,50.8024263431542,85.4306759098787,36.7954939341421,54.3041594454073,33.682842287695,22.0103986135182,39.9081455805893,23.5667244367418,23.5667244367418,13.8396880415945,185.035528596187,34.4610051993068,29.4029462738302,35.2391681109185,22.0103986135182,13.4506065857886,1.38908145580589,1,136.011265164645,32.1265164644714],"sizemode":"area","fillcolor":"rgba(31,119,180,1)","color":"rgba(160,32,240,1)","opacity":0.5,"line":{"color":"rgba(160,32,240,1)","width":1.5}},"type":"scattergeo","mode":"markers","hoverinfo":"text","text":["city:  San Francisco <br /> created:  2012-10-15 <br /> followers:  916","city:  New York <br /> created:  2016-09-01 <br /> followers:  309","city:  İstanbul, Türkiye <br /> created:  2016-09-06 <br /> followers:  436","city:  Barcelona, Spain <br /> created:  2016-10-11 <br /> followers:  377","city:  Columbus, OH <br /> created:  2016-10-04 <br /> followers:  179","city:  Boston, MA <br /> created:  2016-09-06 <br /> followers:  259","city:  Los Angeles, CA <br /> created:  2016-08-29 <br /> followers:  320","city:  London, England <br /> created:  2016-04-20 <br /> followers:  1154","city:  Melbourne, Victoria <br /> created:  2016-09-02 <br /> followers:  415","city:  Paris, France <br /> created:  2016-09-19 <br /> followers:  253","city:  Lisbon <br /> created:  2016-10-26 <br /> followers:  199","city:  Berlin, Deutschland <br /> created:  2016-10-03 <br /> followers:  202","city:  Durham, NC <br /> created:  2016-06-28 <br /> followers:  220","city:  Connecticut, USA <br /> created:  2016-11-24 <br /> followers:  141","city:  Valencia, España <br /> created:  2016-11-13 <br /> followers:  151","city:  Nashville, TN <br /> created:  2016-09-28 <br /> followers:  182","city:  Austin, TX <br /> created:  2016-12-15 <br /> followers:  113","city:  Ames, IA <br /> created:  2016-11-30 <br /> followers:  130","city:  Washington, DC <br /> created:  2016-12-08 <br /> followers:  128","city:  Buenos Aires, Argentina <br /> created:  2017-01-05 <br /> followers:  217","city:  London, Ontario <br /> created:  2017-01-19 <br /> followers:  92","city:  Manchester, England <br /> created:  2016-10-08 <br /> followers:  137","city:  Dublin City, Ireland <br /> created:  2017-01-21 <br /> followers:  84","city:  Lima, Peru <br /> created:  2016-10-08 <br /> followers:  54","city:  Tbilisi <br /> created:  2016-11-29 <br /> followers:  100","city:  Adelaide, South Australia <br /> created:  2017-02-20 <br /> followers:  58","city:  Munich, Bavaria <br /> created:  2017-03-21 <br /> followers:  58","city:  Santa Rosa, Argentina <br /> created:  2017-04-06 <br /> followers:  33","city:  Madrid, Spain <br /> created:  2016-09-03 <br /> followers:  473","city:  Twin Cities <br /> created:  2015-04-04 <br /> followers:  86","city:  Budapest, Magyarország <br /> created:  2017-01-23 <br /> followers:  73","city:  Izmir, Turkey <br /> created:  2016-10-19 <br /> followers:  88","city:  Cape Town, South Africa <br /> created:  2017-03-06 <br /> followers:  54","city:  Rio de Janeiro, Brazil <br /> created:  2017-01-15 <br /> followers:  32","city:  Montreal <br /> created:  2017-04-13 <br /> followers:  1","city:  Seattle <br /> created:  2017-05-06 <br /> followers:  0","city:  Taipei <br /> created:  2014-11-15 <br /> followers:  347","city:  Warsaw <br /> created:  2016-11-15 <br /> followers:  80"],"geo":"geo","lat":[37.7749295,40.7127837,41.0082376,41.3850639,39.9611755,42.3600825,34.0522342,51.5073509,-37.8136276,48.856614,38.7222524,52.5200066,35.9940329,41.6032207,39.4699075,36.1626638,30.267153,42.0307812,38.9071923,-34.6036844,42.9849233,53.4807593,53.3498053,-12.0463731,41.7151377,-34.9284989,48.1351253,-36.620922,40.4167754,44.9374831,47.497912,38.423734,-33.9248685,-22.9068467,45.5016889,47.6062095,25.0329694,52.2296756],"lon":[-122.4194155,-74.0059413,28.9783589,2.1734035,-82.9987942,-71.0588801,-118.2436849,-0.1277583,144.9630576,2.3522219,-9.1393366,13.404954,-78.898619,-73.087749,-0.3762881,-86.7816016,-97.7430608,-93.6319131,-77.0368707,-58.3815591,-81.2452768,-2.2426305,-6.2603097,-77.042754,44.827096,138.6007456,11.5819806,-64.2912369,-3.7037902,-93.2009998,19.040235,27.142826,18.4240553,-43.1728965,-73.567256,-122.3320708,121.5654177,21.0122287],"frame":null}],"highlight":{"on":"plotly_selected","off":"plotly_relayout","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"ctGroups":[]},"base_url":"https://plot.ly"},"evals":["config.modeBarButtonsToAdd.0.click"],"jsHooks":{"render":[{"code":"function(el, x) { var ctConfig = crosstalk.var('plotlyCrosstalkOpts').set({\"on\":\"plotly_selected\",\"off\":\"plotly_relayout\",\"persistent\":false,\"dynamic\":false,\"selectize\":false,\"opacityDim\":0.2,\"selected\":{\"opacity\":1}}); }","data":null}]}}</script><!--/html_preserve-->

This code produces a 16.2 KB HTML, so there I had a 99.5% reduction 🎉

If you had a different experience, please let me know! You can comment below or [mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616). 

If you enjoyed this article, check out [the next one of the series here!]({% post_url 2017-04-24-how-to-plot-animated-maps-with-gganimate %}) or [the code in my GitHub repo](https://github.com/d4tagirl/R-Ladies-growth-maps). Thank you for reading 😉
