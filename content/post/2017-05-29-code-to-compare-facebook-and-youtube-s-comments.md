---
title: Code to compare Facebook and Youtube's comments
date: '2017-05-30T02:11:29'
tags:
  - skip_index
url: /2017/05/code-to-compare-facebook-and-youtube-s-comments
hidden: true
rstats_feed: false
---

<br />


# Working with Facebook comments

## Cleaning and tidying the data

Here I replicate the work done on Youtube comments.


```r
fb_comments <- fb_comments %>% 
  filter(com_text != "") %>%
  left_join(videos_fb, by = c("post_id_fb" = "id")) %>% 
  group_by(short_title) %>% 
  mutate(n = n(),
         com_created = as.Date(com_created)) %>% 
  ungroup() %>% 
  filter(n >= 100) %>% 
  select(short_title, video_id = ids, post_id_fb, com_text, com_id, com_created)

tidy_fb_comments <- fb_comments %>%
  tidytext::unnest_tokens(word, com_text) %>%
  anti_join(stop_words, by = "word") 
```



# Plot the most positive and most negative words

Once I have a tidy dataframe, I plot the most positive and most negative words on Facebook to compare them in the original article with the Youtube ones.


```r
fb_pos_neg_words <- tidy_fb_comments %>%  
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup() %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(values = c("red2", "green3")) +
  facet_wrap(~sentiment, scales = "free_y") +
  ylim(0, 2500) +
  xlab(NULL) +
  ylab(NULL) +
  coord_flip() +
  theme_minimal()
```

<img src="/post/code-to-compare-facebook-and-youtube-s-comments/2017-05-29-code-to-compare-facebook-and-youtube-s-comments/unnamed-chunk-5-1.png" style="margin: auto;" />

# Sentiment by comment and by video

As I did for the Youtube videos, I calculate the sentiment for every comment and then for every video.


```r
fb_comment_sent <- tidy_fb_comments  %>%
  inner_join(get_sentiments("bing"), by = "word") %>% 
  count(com_id, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>% 
  ungroup() %>% 
  left_join(fb_comments, by = "com_id")

fb_title_sent <- fb_comment_sent %>% 
  group_by(short_title) %>% 
  summarise(pos        = sum(positive),
            neg        = sum(negative),
            sent_mean  = mean(sentiment),
            sentiment  = pos - neg) %>% 
  ungroup() %>% 
  arrange(-sentiment)
```

# Joining Facebook and Youtube comments

I join the Youtube and Facebook's sentiment by video tables to compare comments. I have to filter the videos present in both platforms to make a fair comparison.




```r
comments_by_title <- yt_title_sent %>% 
  inner_join(fb_title_sent, by = c("short_title" = "short_title")) %>% 
  select(vid_created, 
         short_title, 
         mean_sent_yt = sent_mean.x,
         mean_sent_fb = sent_mean.y) %>% 
  ungroup() %>% 
  mutate(diff = mean_sent_fb - mean_sent_yt,
         short_title = reorder(short_title, -diff)) %>% 
  arrange(desc(diff))
```

And now I can plot the sentiment for every video on each platforms, ordered by published date.  
  

```r
library(plotly)
ggplotly(comments_by_title %>%
  
  ggplot(aes(x = reorder(short_title, vid_created), 
             text = paste(short_title, "<br />",  vid_created))) +
  geom_line(aes(y = mean_sent_fb, group = 1), color = "blue") +
  geom_line(aes(y = mean_sent_yt, group = 1), color = "red") +
  geom_hline(yintercept = 0) +
  xlab(NULL) +
  ylab(NULL) +
  theme_minimal() +
  theme(axis.text.x = element_blank()),
tooltip = "text")
```

<!--html_preserve--><div id="htmlwidget-b93cb1caa427cac94be0" style="width:840px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-b93cb1caa427cac94be0">{"x":{"data":[{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38],"y":[0.0927835051546392,-0.574712643678161,-0.84,0.122448979591837,-0.51063829787234,0.123595505617978,0.0425531914893617,0.407624633431085,-0.47008547008547,0.285714285714286,0.288288288288288,0.08,-0.8,0.0909090909090909,0.166666666666667,0,-0.108108108108108,0.170731707317073,-0.341085271317829,-0.137724550898204,-0.697674418604651,-0.89010989010989,-0.484210526315789,0.162790697674419,0.108108108108108,0.173611111111111,-0.125984251968504,-0.216216216216216,0.241379310344828,-0.784722222222222,-0.24,-0.198757763975155,0.13953488372093,-0.561338289962825,-0.336,0.262295081967213,0.358490566037736,-0.0427807486631016],"text":["\"Oregon Spirit\" by Lisa Loeb <br /> 2014-04-28","Death Penalty <br /> 2014-05-05","Dressing Up As Other Races (How Is This Still a Thing?) <br /> 2014-05-12","Net Neutrality <br /> 2014-06-02","Tony Abbott, President of the USA of Australia <br /> 2014-06-02","FIFA and the World Cup <br /> 2014-06-09","Tom Wheeler Is Not A Dingo <br /> 2014-06-16","Dr. Oz and Nutritional Supplements <br /> 2014-06-23","Hobby Lobby <br /> 2014-06-30","Fireworks (Web Exclusive) <br /> 2014-07-07","Wealth Gap <br /> 2014-07-14","Prison <br /> 2014-07-21","Nuclear Weapons <br /> 2014-07-28","Columbus Day - How Is This Still A Thing <br /> 2014-10-13","Pumpkin Spice (Web Exclusive) <br /> 2014-10-13","Turkey Pardoning (Web Exclusive) <br /> 2014-11-24","Season 2 Promo <br /> 2015-01-09","Fifty Shades #NotMyChristian Apology (Web Exclusive) <br /> 2015-01-26","Daylight Saving Time - How Is This Still A Thing? <br /> 2015-03-09","The NCAA <br /> 2015-03-16","April Fools' Day (Web Exclusive) <br /> 2015-03-30","Torture <br /> 2015-06-15","Transgender Rights <br /> 2015-06-29","Shallow Dives (Web Exclusive) <br /> 2015-07-06","Sex Education <br /> 2015-08-10","Televangelists <br /> 2015-08-17","History Lies (Web Exclusive) <br /> 2015-08-31","Back To School (Web Exclusive) <br /> 2015-09-07","Regifting (Web Exclusive) <br /> 2015-12-14","Voting <br /> 2016-02-15","Whitewashing <br /> 2016-02-23","Border Wall <br /> 2016-03-21","Retirement Plans <br /> 2016-06-13","President-Elect Trump <br /> 2016-11-14","Trump University <br /> 2016-11-29","Last Week Tonight Season 4 Prom <br /> 2017-01-18","Dancing Zebra Footage <br /> 2017-03-20","French Elections <br /> 2017-04-17"],"key":null,"type":"scatter","mode":"lines","name":"","line":{"width":1.88976377952756,"color":"rgba(0,0,255,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38],"y":[-1,-2.17410714285714,-1.91739130434783,-0.3,-0.424731182795699,-0.767295597484277,-0.333333333333333,-0.592964824120603,-0.69,-0.0974025974025974,-0.688995215311005,-1.45933014354067,-0.804123711340206,-1.19512195121951,-0.146739130434783,-1.05347593582888,0.0191082802547771,-0.573170731707317,-0.752525252525252,-0.49738219895288,-0.988372093023256,-1.40579710144928,-1.18604651162791,-0.361842105263158,-0.668421052631579,-1.18324607329843,-0.596153846153846,-0.927777777777778,-0.329479768786127,-1.27555555555556,-1.01075268817204,-0.82122905027933,-0.414772727272727,-0.788990825688073,-0.410891089108911,-0.375722543352601,-0.577235772357724,-0.401129943502825],"text":["\"Oregon Spirit\" by Lisa Loeb <br /> 2014-04-28","Death Penalty <br /> 2014-05-05","Dressing Up As Other Races (How Is This Still a Thing?) <br /> 2014-05-12","Net Neutrality <br /> 2014-06-02","Tony Abbott, President of the USA of Australia <br /> 2014-06-02","FIFA and the World Cup <br /> 2014-06-09","Tom Wheeler Is Not A Dingo <br /> 2014-06-16","Dr. Oz and Nutritional Supplements <br /> 2014-06-23","Hobby Lobby <br /> 2014-06-30","Fireworks (Web Exclusive) <br /> 2014-07-07","Wealth Gap <br /> 2014-07-14","Prison <br /> 2014-07-21","Nuclear Weapons <br /> 2014-07-28","Columbus Day - How Is This Still A Thing <br /> 2014-10-13","Pumpkin Spice (Web Exclusive) <br /> 2014-10-13","Turkey Pardoning (Web Exclusive) <br /> 2014-11-24","Season 2 Promo <br /> 2015-01-09","Fifty Shades #NotMyChristian Apology (Web Exclusive) <br /> 2015-01-26","Daylight Saving Time - How Is This Still A Thing? <br /> 2015-03-09","The NCAA <br /> 2015-03-16","April Fools' Day (Web Exclusive) <br /> 2015-03-30","Torture <br /> 2015-06-15","Transgender Rights <br /> 2015-06-29","Shallow Dives (Web Exclusive) <br /> 2015-07-06","Sex Education <br /> 2015-08-10","Televangelists <br /> 2015-08-17","History Lies (Web Exclusive) <br /> 2015-08-31","Back To School (Web Exclusive) <br /> 2015-09-07","Regifting (Web Exclusive) <br /> 2015-12-14","Voting <br /> 2016-02-15","Whitewashing <br /> 2016-02-23","Border Wall <br /> 2016-03-21","Retirement Plans <br /> 2016-06-13","President-Elect Trump <br /> 2016-11-14","Trump University <br /> 2016-11-29","Last Week Tonight Season 4 Prom <br /> 2017-01-18","Dancing Zebra Footage <br /> 2017-03-20","French Elections <br /> 2017-04-17"],"key":null,"type":"scatter","mode":"lines","name":"","line":{"width":1.88976377952756,"color":"rgba(255,0,0,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text"},{"x":[0.4,38.6],"y":[0,0],"text":"","key":null,"type":"scatter","mode":"lines","name":"","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text"}],"layout":{"margin":{"t":28.7853881278539,"r":7.30593607305936,"b":16.4383561643836,"l":34.337899543379},"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"type":"linear","autorange":false,"tickmode":"array","range":[0.4,38.6],"ticktext":["\"Oregon Spirit\" by Lisa Loeb","Death Penalty","Dressing Up As Other Races (How Is This Still a Thing?)","Net Neutrality","Tony Abbott, President of the USA of Australia","FIFA and the World Cup","Tom Wheeler Is Not A Dingo","Dr. Oz and Nutritional Supplements","Hobby Lobby","Fireworks (Web Exclusive)","Wealth Gap","Prison","Nuclear Weapons","Columbus Day - How Is This Still A Thing","Pumpkin Spice (Web Exclusive)","Turkey Pardoning (Web Exclusive)","Season 2 Promo","Fifty Shades #NotMyChristian Apology (Web Exclusive)","Daylight Saving Time - How Is This Still A Thing?","The NCAA","April Fools' Day (Web Exclusive)","Torture","Transgender Rights","Shallow Dives (Web Exclusive)","Sex Education","Televangelists","History Lies (Web Exclusive)","Back To School (Web Exclusive)","Regifting (Web Exclusive)","Voting","Whitewashing","Border Wall","Retirement Plans","President-Elect Trump","Trump University","Last Week Tonight Season 4 Prom","Dancing Zebra Footage","French Elections"],"tickvals":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38],"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":false,"tickfont":{"color":null,"family":null,"size":0},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":"","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"type":"linear","autorange":false,"tickmode":"array","range":[-2.30319373167155,0.536711222245496],"ticktext":["-2.0","-1.5","-1.0","-0.5","0.0","0.5"],"tickvals":[-2,-1.5,-1,-0.5,0,0.5],"ticks":"","tickcolor":null,"ticklen":3.65296803652968,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":"","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":null,"bordercolor":null,"borderwidth":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToAdd":[{"name":"Collaborate","icon":{"width":1000,"ascent":500,"descent":-50,"path":"M487 375c7-10 9-23 5-36l-79-259c-3-12-11-23-22-31-11-8-22-12-35-12l-263 0c-15 0-29 5-43 15-13 10-23 23-28 37-5 13-5 25-1 37 0 0 0 3 1 7 1 5 1 8 1 11 0 2 0 4-1 6 0 3-1 5-1 6 1 2 2 4 3 6 1 2 2 4 4 6 2 3 4 5 5 7 5 7 9 16 13 26 4 10 7 19 9 26 0 2 0 5 0 9-1 4-1 6 0 8 0 2 2 5 4 8 3 3 5 5 5 7 4 6 8 15 12 26 4 11 7 19 7 26 1 1 0 4 0 9-1 4-1 7 0 8 1 2 3 5 6 8 4 4 6 6 6 7 4 5 8 13 13 24 4 11 7 20 7 28 1 1 0 4 0 7-1 3-1 6-1 7 0 2 1 4 3 6 1 1 3 4 5 6 2 3 3 5 5 6 1 2 3 5 4 9 2 3 3 7 5 10 1 3 2 6 4 10 2 4 4 7 6 9 2 3 4 5 7 7 3 2 7 3 11 3 3 0 8 0 13-1l0-1c7 2 12 2 14 2l218 0c14 0 25-5 32-16 8-10 10-23 6-37l-79-259c-7-22-13-37-20-43-7-7-19-10-37-10l-248 0c-5 0-9-2-11-5-2-3-2-7 0-12 4-13 18-20 41-20l264 0c5 0 10 2 16 5 5 3 8 6 10 11l85 282c2 5 2 10 2 17 7-3 13-7 17-13z m-304 0c-1-3-1-5 0-7 1-1 3-2 6-2l174 0c2 0 4 1 7 2 2 2 4 4 5 7l6 18c0 3 0 5-1 7-1 1-3 2-6 2l-173 0c-3 0-5-1-8-2-2-2-4-4-4-7z m-24-73c-1-3-1-5 0-7 2-2 3-2 6-2l174 0c2 0 5 0 7 2 3 2 4 4 5 7l6 18c1 2 0 5-1 6-1 2-3 3-5 3l-174 0c-3 0-5-1-7-3-3-1-4-4-5-6z"},"click":"function(gd) { \n        // is this being viewed in RStudio?\n        if (location.search == '?viewer_pane=1') {\n          alert('To learn about plotly for collaboration, visit:\\n https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html');\n        } else {\n          window.open('https://cpsievert.github.io/plotly_book/plot-ly-for-collaboration.html', '_blank');\n        }\n      }"}],"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly"},"evals":["config.modeBarButtonsToAdd.0.click"],"jsHooks":[]}</script><!--/html_preserve-->

