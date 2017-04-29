---
layout: post
title:  How to deal with ggplotly huge maps
date: "2017-04-24 12:11:29 UYT"
published: true
tags: [rstats, r, plotly, ggplotly, maps, plot_geo]
description: How to produce animated maps in R with plotly, using ggplotly and plot_geo. While ggplotly is easier to use, it produces huge maps (using HTML widgets). Using plot_geo instead is incredibly more efficient.
---
How I had  to go from `gglotly` to `plotly::plot_geo` to reduce the size of the HTML output for posting animated maps on my blog.

<!--more-->
I've been experimenting with animating maps these past few days and I finally was able to produce some fancy maps using the `plotly` package and the `gganimate` one ([you can see my repo here](https://github.com/d4tagirl/R-Ladies-growth-maps)). Everything was working perfectly on Rstudio, until I wanted to share some kind of tutorial on my blog, and _things got complicated_. Originally I animated some maps using the `plotly::ggplotly` function and it generated a 3.3 MB HTML widget... and *that's an issue* when you want to include it on a website 😳 . So I tried a different approach: using the `plotly::plot_geo` function I was able to produce a very similar plot, but generating a way smaller HTML widget.

# The data

I'm using the [data produced in this previous post]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}){:target="_blank"}. Let's take a look at it to see what we are dealing with.




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

<!--html_preserve--><div id="htmlwidget-fdab61b5361daed234f4" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fdab61b5361daed234f4">{"x":{"filter":"none","data":[["RLadiesSF","RLadiesLondon","RLadiesRTP","RLadiesCT","RLadiesIstanbul","RLadiesBCN","RLadiesNYC","RLadiesBoston","RLadiesLA","RLadiesMAD","RLadiesAU","RLadiesParis","RLadiesLx","RLadiesBerlin","RLadiesValencia","RLadiesNash","RLadiesColumbus","RLadiesAustin","RLadiesAmes","RLadiesDC","RLadiesLdnOnt","RLadiesBA","RLadiesDublin","RLadiesManchest","RLadiesTbilisi","RLadiesMunich","RLadiesAdelaide","RLadiesTC","RLadiesBudapest","RLadiesIzmir","RLadiesLima","RLadiesCapeTown","RLadiesRio","RLadiesSR","RLadiesMTL","RLadiesTaipei"],["San Francisco","London, England","Durham, NC","Connecticut, USA","İstanbul, Türkiye","Barcelona, Spain","New York","Boston, MA","Los Angeles, CA","Madrid, Spain","Melbourne, Victoria","Paris, France","Lisbon","Berlin, Deutschland","Valencia, España","Nashville, TN","Columbus, OH","Austin, TX","Ames, IA","Washington, DC","London, Ontario","Buenos Aires, Argentina","Dublin City, Ireland","Manchester, England","Tbilisi","Munich, Bavaria","Adelaide, South Australia","Twin Cities","Budapest, Magyarország","Izmir, Turkey","Lima, Peru","Cape Town, South Africa","Rio de Janeiro, Brazil","Santa Rosa, Argentina","Montreal","Taipei"],["2012-10-15","2016-04-20","2016-06-28","2016-11-24","2016-09-06","2016-10-11","2016-09-01","2016-09-06","2016-08-29","2016-09-03","2016-09-02","2016-09-19","2016-10-26","2016-10-03","2016-11-13","2016-09-28","2016-10-04","2016-12-15","2016-11-30","2016-12-08","2017-01-19","2017-01-05","2017-01-21","2016-10-08","2016-11-29","2017-03-21","2017-02-20","2015-04-04","2017-01-23","2016-10-19","2016-10-08","2017-03-06","2017-01-15","2017-04-06","2017-04-13","2014-11-15"],[886,1102,215,134,425,360,256,247,309,384,404,247,182,192,146,179,173,100,115,114,75,174,71,128,85,46,26,86,61,88,37,44,18,5,1,347],[1652.91666666667,369.875,300.875,151.875,230.875,195.875,235.875,230.875,238.875,233.875,234.875,217.875,180.875,203.875,162.875,208.875,202.875,130.875,145.875,137.875,95.875,109.875,93.875,198.875,146.875,34.875,63.875,751.875,91.875,187.875,198.875,49.875,99.875,18.875,11.875,891.916666666667],[-122.4194155,-0.1277583,-78.898619,-73.087749,28.9783589,2.1734035,-74.0059413,-71.0588801,-118.2436849,-3.7037902,144.9630576,2.3522219,-9.1393366,13.404954,-0.3762881,-86.7816016,-82.9987942,-97.7430608,-93.6319131,-77.0368707,-81.2452768,-58.3815591,-6.2603097,-2.2426305,44.827096,11.5819806,138.6007456,-93.2009998,19.040235,27.142826,-77.042754,18.4240553,-43.1728965,-64.2912369,-73.567256,121.5654177],[37.7749295,51.5073509,35.9940329,41.6032207,41.0082376,41.3850639,40.7127837,42.3600825,34.0522342,40.4167754,-37.8136276,48.856614,38.7222524,52.5200066,39.4699075,36.1626638,39.9611755,30.267153,42.0307812,38.9071923,42.9849233,-34.6036844,53.3498053,53.4807593,41.7151377,48.1351253,-34.9284989,44.9374831,47.497912,38.423734,-12.0463731,-33.9248685,-22.9068467,-36.620922,45.5016889,25.0329694]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>screen_name<\/th>\n      <th>location<\/th>\n      <th>created_at<\/th>\n      <th>followers<\/th>\n      <th>age_days<\/th>\n      <th>lon<\/th>\n      <th>lat<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"columnDefs":[{"className":"dt-right","targets":[3,4,5,6]}],"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<br />
I want to produce a `plotly` map where I can plot each location (`lon` and `lat`), with each point's size indicating the amount of `followers`. 

# Using ggplotly

The first thing I did was generate the map using `ggplot2`, because `plotly` integrates easily with it via the `ggplotly` function. And I'm so comfortable using the `tidyverse`, that it was the natural thing for me to do! 

`ggplotly` translates the `ggplot2` object into a `plotly` one, displaying the aesthetic mappings in the tooltip. As I wanted to include other variables in it, I added the extra (and _unofficial_) `text` aesthetic for `ggplotly` to include them. Despite `ggplot2` doesn't have a `text` aesthetic, `ggplotly` recognizes it and display it in the tooltip.


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

<img src="/figure/source/how-to-deal-with-ggplotly-huge-maps/2017-04-26-how-to-deal-with-ggplotly-huge-maps/unnamed-chunk-2-1.png" style="display: block; margin: auto;" />

Then I animated it using `ggplotly`, with the following code:


```r
library(plotly)

ggplotly(map, tooltip = c('text', 'size'))
```

If you want to see the animation, [you can check it here]({% post_url 2017-04-24-huge-ggplotly-map %}){:target="_blank"}, but it will take a while! It is a 3.3 MB page!

It pretty nice animation, but it takes for ever to load the HTML! And that is why I checked how the `plotly` people make this kind of animations from scratch, and I gave it a try.

It is actually not that difficult either! The only thing that was not that straightforward for me was finding the chart references for customizing the maps (probably because I was doing a bad job at searching for them 😳 ), so [here is the link](https://plot.ly/r/reference/), and for the layout in particular [here it is this other link](https://plot.ly/r/reference/#layout-geo/) just in case you encounter the same difficulties as I did.


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

<!--html_preserve--><div id="162c6129153a" style="width:910px;height:520px;" class="plotly html-widget"></div>
<script type="application/json" data-for="162c6129153a">{"x":{"visdat":{"162c54081ef7":["function () ","plotlyVisDat"]},"cur_data":"162c54081ef7","attrs":{"162c54081ef7":{"marker":{"color":"rgba(160,32,240,1)","opacity":0.5,"line":{"color":"rgba(160,32,240,1)","width":1.5}},"alpha":1,"sizes":[1,450],"x":{},"y":{},"type":"scatter","mode":"markers","size":{},"hoverinfo":"text","text":{}}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"mapType":"geo","geo":{"domain":{"x":[0,1],"y":[0,1]},"showframe":false,"coastlinecolor":"rgba(255,255,255,1)","showland":true,"landcolor":"rgba(204,204,204,1)","showcountries":true,"countrycolor":"rgba(255,255,255,1)","countrywidth":0.2,"projection":{"type":"Mercator"}},"dragmode":"zoom","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":[{"name":"Collaborate","icon":{"width":1000,"ascent":500,"descent":-50,"path":"M487 375c7-10 9-23 5-36l-79-259c-3-12-11-23-22-31-11-8-22-12-35-12l-263 0c-15 0-29 5-43 15-13 10-23 23-28 37-5 13-5 25-1 37 0 0 0 3 1 7 1 5 1 8 1 11 0 2 0 4-1 6 0 3-1 5-1 6 1 2 2 4 3 6 1 2 2 4 4 6 2 3 4 5 5 7 5 7 9 16 13 26 4 10 7 19 9 26 0 2 0 5 0 9-1 4-1 6 0 8 0 2 2 5 4 8 3 3 5 5 5 7 4 6 8 15 12 26 4 11 7 19 7 26 1 1 0 4 0 9-1 4-1 7 0 8 1 2 3 5 6 8 4 4 6 6 6 7 4 5 8 13 13 24 4 11 7 20 7 28 1 1 0 4 0 7-1 3-1 6-1 7 0 2 1 4 3 6 1 1 3 4 5 6 2 3 3 5 5 6 1 2 3 5 4 9 2 3 3 7 5 10 1 3 2 6 4 10 2 4 4 7 6 9 2 3 4 5 7 7 3 2 7 3 11 3 3 0 8 0 13-1l0-1c7 2 12 2 14 2l218 0c14 0 25-5 32-16 8-10 10-23 6-37l-79-259c-7-22-13-37-20-43-7-7-19-10-37-10l-248 0c-5 0-9-2-11-5-2-3-2-7 0-12 4-13 18-20 41-20l264 0c5 0 10 2 16 5 5 3 8 6 10 11l85 282c2 5 2 10 2 17 7-3 13-7 17-13z m-304 0c-1-3-1-5 0-7 1-1 3-2 6-2l174 0c2 0 4 1 7 2 2 2 4 4 5 7l6 18c0 3 0 5-1 7-1 1-3 2-6 2l-173 0c-3 0-5-1-8-2-2-2-4-4-4-7z m-24-73c-1-3-1-5 0-7 2-2 3-2 6-2l174 0c2 0 5 0 7 2 3 2 4 4 5 7l6 18c1 2 0 5-1 6-1 2-3 3-5 3l-174 0c-3 0-5-1-7-3-3-1-4-4-5-6z"},"click":"function(gd) { \n        // is this being viewed in RStudio?\n        if (location.search == '?viewer_pane=1') {\n          alert('To learn about plotly for collaboration, visit:\\n https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html');\n        } else {\n          window.open('https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html', '_blank');\n        }\n      }"}],"modeBarButtonsToRemove":["sendDataToCloud"]},"data":[{"marker":{"size":[361.91280653951,450,88.2715712988193,55.2388737511353,173.911898274296,147.404178019982,104.991825613079,101.321525885559,126.605812897366,157.191643960036,165.347865576748,101.321525885559,74.8138056312443,78.8919164396004,60.1326067211626,73.5903723887375,71.1435059037239,41.3732970027248,47.4904632152589,47.0826521344233,31.1780199818347,71.5513169845595,29.5467756584923,52.7920072661217,35.2561307901907,19.3514986376022,11.1952770208901,35.6639418710263,25.4686648501362,36.4795640326975,15.6811989100817,18.535876475931,7.93278837420527,2.63124432334242,1,142.102633969119],"sizemode":"area","fillcolor":"rgba(31,119,180,1)","color":"rgba(160,32,240,1)","opacity":0.5,"line":{"color":"rgba(160,32,240,1)","width":1.5}},"type":"scattergeo","mode":"markers","hoverinfo":"text","text":["city:  San Francisco <br /> created:  2012-10-15 <br /> followers:  886","city:  London, England <br /> created:  2016-04-20 <br /> followers:  1102","city:  Durham, NC <br /> created:  2016-06-28 <br /> followers:  215","city:  Connecticut, USA <br /> created:  2016-11-24 <br /> followers:  134","city:  İstanbul, Türkiye <br /> created:  2016-09-06 <br /> followers:  425","city:  Barcelona, Spain <br /> created:  2016-10-11 <br /> followers:  360","city:  New York <br /> created:  2016-09-01 <br /> followers:  256","city:  Boston, MA <br /> created:  2016-09-06 <br /> followers:  247","city:  Los Angeles, CA <br /> created:  2016-08-29 <br /> followers:  309","city:  Madrid, Spain <br /> created:  2016-09-03 <br /> followers:  384","city:  Melbourne, Victoria <br /> created:  2016-09-02 <br /> followers:  404","city:  Paris, France <br /> created:  2016-09-19 <br /> followers:  247","city:  Lisbon <br /> created:  2016-10-26 <br /> followers:  182","city:  Berlin, Deutschland <br /> created:  2016-10-03 <br /> followers:  192","city:  Valencia, España <br /> created:  2016-11-13 <br /> followers:  146","city:  Nashville, TN <br /> created:  2016-09-28 <br /> followers:  179","city:  Columbus, OH <br /> created:  2016-10-04 <br /> followers:  173","city:  Austin, TX <br /> created:  2016-12-15 <br /> followers:  100","city:  Ames, IA <br /> created:  2016-11-30 <br /> followers:  115","city:  Washington, DC <br /> created:  2016-12-08 <br /> followers:  114","city:  London, Ontario <br /> created:  2017-01-19 <br /> followers:  75","city:  Buenos Aires, Argentina <br /> created:  2017-01-05 <br /> followers:  174","city:  Dublin City, Ireland <br /> created:  2017-01-21 <br /> followers:  71","city:  Manchester, England <br /> created:  2016-10-08 <br /> followers:  128","city:  Tbilisi <br /> created:  2016-11-29 <br /> followers:  85","city:  Munich, Bavaria <br /> created:  2017-03-21 <br /> followers:  46","city:  Adelaide, South Australia <br /> created:  2017-02-20 <br /> followers:  26","city:  Twin Cities <br /> created:  2015-04-04 <br /> followers:  86","city:  Budapest, Magyarország <br /> created:  2017-01-23 <br /> followers:  61","city:  Izmir, Turkey <br /> created:  2016-10-19 <br /> followers:  88","city:  Lima, Peru <br /> created:  2016-10-08 <br /> followers:  37","city:  Cape Town, South Africa <br /> created:  2017-03-06 <br /> followers:  44","city:  Rio de Janeiro, Brazil <br /> created:  2017-01-15 <br /> followers:  18","city:  Santa Rosa, Argentina <br /> created:  2017-04-06 <br /> followers:  5","city:  Montreal <br /> created:  2017-04-13 <br /> followers:  1","city:  Taipei <br /> created:  2014-11-15 <br /> followers:  347"],"geo":"geo","lat":[37.7749295,51.5073509,35.9940329,41.6032207,41.0082376,41.3850639,40.7127837,42.3600825,34.0522342,40.4167754,-37.8136276,48.856614,38.7222524,52.5200066,39.4699075,36.1626638,39.9611755,30.267153,42.0307812,38.9071923,42.9849233,-34.6036844,53.3498053,53.4807593,41.7151377,48.1351253,-34.9284989,44.9374831,47.497912,38.423734,-12.0463731,-33.9248685,-22.9068467,-36.620922,45.5016889,25.0329694],"lon":[-122.4194155,-0.1277583,-78.898619,-73.087749,28.9783589,2.1734035,-74.0059413,-71.0588801,-118.2436849,-3.7037902,144.9630576,2.3522219,-9.1393366,13.404954,-0.3762881,-86.7816016,-82.9987942,-97.7430608,-93.6319131,-77.0368707,-81.2452768,-58.3815591,-6.2603097,-2.2426305,44.827096,11.5819806,138.6007456,-93.2009998,19.040235,27.142826,-77.042754,18.4240553,-43.1728965,-64.2912369,-73.567256,121.5654177],"frame":null}],"highlight":{"on":"plotly_selected","off":"plotly_relayout","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"ctGroups":[]},"base_url":"https://plot.ly"},"evals":["config.modeBarButtonsToAdd.0.click"],"jsHooks":{"render":[{"code":"function(el, x) { var ctConfig = crosstalk.var('plotlyCrosstalkOpts').set({\"on\":\"plotly_selected\",\"off\":\"plotly_relayout\",\"persistent\":false,\"dynamic\":false,\"selectize\":false,\"opacityDim\":0.2,\"selected\":{\"opacity\":1}}); }","data":null}]}}</script><!--/html_preserve-->

This code produces a 16.2 KB HTML, so there I had a 99.5% reduction 🎉

If you had a different experience, please let me know! You can comment below or [mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616). Thanks 😉 !
