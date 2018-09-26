---
layout: post
title:  Visualizing R-Ladies' growth! 
date: "2017-05-15 09:11:29 UYT"
published: true
tags: [rstats, r, rladies, visualization]
description: gganimate animation about R-Ladies' growth.
---
My favourite visualization about R-Ladies growth, using `gganimate` to produce this .gif file.

![](/figure/source/visualizing-r-ladies-growth/2017-05-10-visualizing-r-ladies-growth/rladies_chiquitito.gif)

<!--more-->

I recently came across [an article](http://spatial.ly/2017/03/mapping-5000-years-of-city-growth/) in which they map 5,000 years of city growth in a beautiful animation, and I knew I had to make a similar map for the [R-Ladies' chapters](https://rladies.org/) (probably the purple color they use had plenty to do with that 💜 ). So my idea was to map all the R-Ladies' chapters according to their size, and that's when I thought of using their Twitter followers as a way to estimate it, since it's the most extended social media we use (except for some chapters).

I decided to make 3 posts to go through the details of what I've done (especially for future me!):

1. [How to fetch Twitter users with R]({% post_url 2017-04-20-how-to-fetch-twitter-users-with-r %}): the title is kind of self explanatory...
2. [How to deal with ggplotly huge maps]({% post_url 2017-04-26-how-to-deal-with-ggplotly-huge-maps %}): where I go through the details of why I chose not to use `ggplotly` and use `plot_geo` instead to generate the HTML.
3. [How to plot animated maps with gganimate]({% post_url 2017-04-24-how-to-plot-animated-maps-with-gganimate %}): again, pretty obvious subject.

This is the visualization I liked the most, so I wanted to share it here...


![](/figure/source/how-to-plot-animated-maps-with-gganimate/2017-04-24-how-to-plot-animated-maps-with-gganimate/ani_map_less_frames.gif)

... as I did on Twitter, Slack and other social media 💜

<blockquote class="twitter-tweet tw-align-center" data-lang="en"><p lang="en" dir="ltr">New <a href="https://twitter.com/hashtag/rstats?src=hash">#rstats</a> post! Visualizing <a href="https://twitter.com/hashtag/RLadies?src=hash">#RLadies</a> growth 💜 Step-by-step from Twitter users to <a href="https://twitter.com/hashtag/plotly?src=hash">#plotly</a> and <a href="https://twitter.com/hashtag/gganimate?src=hash">#gganimate</a> <a href="https://t.co/Jgi82Xb4X0">https://t.co/Jgi82Xb4X0</a> <a href="https://t.co/5qkxQwJKQF">pic.twitter.com/5qkxQwJKQF</a></p>&mdash; Daniela Vázquez (@d4tagirl) <a href="https://twitter.com/d4tagirl/status/864207469911957504">May 15, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<br />
It was a pretty popular Tweet, you should try!

Please leave your comments if you have any, or [mention me on Twitter](https://twitter.com/intent/tweet?user_id=114258616). Thanks 😉


