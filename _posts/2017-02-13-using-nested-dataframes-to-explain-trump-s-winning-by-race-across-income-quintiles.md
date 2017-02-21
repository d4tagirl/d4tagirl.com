---
layout: post
title:  Nested dataframes to explain Trump's winning by race, across regions
date: "2017-02-13 11:20:16 UYT"
published: true
tags: [rstats, r, nested dataframes, nest, tidyr, purrr, broom, map, logistic regression]
description: Continuing my analysis on the Election Results by county, here I use nested dataframes to estimate different linear models explaining Trump's victory by race for each income quintile.
---
Continuing my analysis on the Election Results by county, here I use nested dataframes to estimate different logistic regression models explaining Trump's victory by race for each region. 

<!--more-->
It's been a while since I learned about nested dataframes to estimate different models across different groups of observations. Actually it was when I took David Robinson's Datacamp course: [Exploratory Data Analysis in R: Case Study](https://www.datacamp.com/courses/exploratory-data-analysis-in-r-case-study) and I found it really useful! The other day I was listening to the [31st episode of the Not So Standard Deviations](https://soundcloud.com/nssd-podcast/episode-31-the-word-youre-looking-for-is-magical) when Hilary started talking about nested dataframes and how it could be not completely straightforward for everyone to appreciate how useful this could be. That's when it hit me: I had to write about this!  

# The data

Continuing with the same dataframe from [my post about the analysis of counties characteristics that made Trump the winner of the US 2017 Election]({% post_url 2017-01-23-what-demographics-voted-for-trump %}) {:target="_blank"} now I examine it by region.

For that I load the data first.




```r
load("trump-rpart.Rdata")
```

# Quantile Analysis

To analyze how the results were different across some characteristics' quintiles, I define a function using `partial` from `purrr` package. Why? *Because I just leant it!* To calculate quintiles I use the same parameter one and again for the `ntile` function (`n = 5`) to find the quintiles. (This idea came from [this very popular Tweet](https://twitter.com/vsbuffalo/status/829756941501034496) that has been around this past few days).


```r
library(dplyr)
library(ggplot2)
library(purrr)

nt <- partial(ntile, n = 5)

votes <- votes %>%
  mutate(white_alone_q    = nt(white_alone),
         white_q          = nt(white),
         black_q          = nt(black),
         hisp_latin_q     = nt(hisp_latin),
         edu_batch_q      = nt(edu_batchelors),
         urban_q          = nt(housing_units_multistruct),
         income_q         = nt(income))
```

Once I have that, I define a function `group_quintiles` which input is a dataframe that has already has a column name `q` (the column with the quintiles) and groups by it and calculates a the portion of counties that voted for Trump for each quintile. I use it for every characteristic I'm interested in.


```r
group_quitiles <- function(x){
  x %>% 
  group_by(q) %>% 
  summarize(mean_Trump = mean(pref_cand_T == 1))
}

black_quintiles <- votes %>% 
  mutate(q = black_q) %>%
  group_quitiles()

white_alone_quintiles <- votes %>% 
  mutate(q = white_alone_q) %>% 
  group_quitiles()

white_quintiles <- votes %>% 
  mutate(q = white_q) %>% 
  group_quitiles()

hisp_latin_quintiles <- votes %>% 
  mutate(q = hisp_latin_q) %>% 
  group_quitiles()  

edu_batch_quintiles <- votes %>% 
  mutate(q = edu_batch_q) %>% 
  group_quitiles()

urban_quintiles <- votes %>% 
  mutate(q = urban_q) %>% 
  group_quitiles()

income_quintiles <- votes %>% 
  mutate(q = income_q) %>%
  group_quitiles() 

library(knitr)
knitr::kable(black_quintiles, align = 'l')
```



|q  |mean_Trump |
|:--|:----------|
|1  |0.9518459  |
|2  |0.8697749  |
|3  |0.8924559  |
|4  |0.8327974  |
|5  |0.6688103  |

I thought it would be more visual to see these results in a plot, so I define this other function that takes a dataframe as an input, and returns a plot. I did that so I didn't have to write for every characteristic the same (long!) code again and again. So lets plot!


```r
plot_quintiles <- function(x){
  x %>% 
  ggplot(aes(x = q, y = mean_Trump)) + 
  geom_point() + 
  ylim(0, 1) +
  labs(title = deparse(substitute(x))) +
  theme_bw() +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
        plot.title = element_text(size = 12),
        axis.line = element_line(colour = "grey"), legend.position = "bottom", 
        panel.border = element_blank()) +
  geom_segment(aes(x = q, y = -Inf, 
                   xend = q, yend = mean_Trump),
               size = 0.2)
}

library(gridExtra)
library(grid)

grid.arrange(plot_quintiles(white_alone_quintiles), plot_quintiles(white_quintiles), 
             plot_quintiles(black_quintiles),       plot_quintiles(hisp_latin_quintiles), 
             plot_quintiles(edu_batch_quintiles),   plot_quintiles(urban_quintiles),
             plot_quintiles(income_quintiles), 
             nrow = 4,
             top = textGrob("% of counties that voted for Trump, among characteristics' quintiles", 
                            gp = gpar(fontsize = 15)))
```

<img src="/figure/source/using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles/2017-02-13-using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

Results imply that the lower the `white` and `white_alone` quintile, the lesser those counties voted for Trump (especially the lowest quintile!). The opposite happens with `black` and `hisp_latin`, and also with what I called `urban`, which is the amount of housing units in multi-unit structures (you can [check the meaning of this variables in my previous post]({% post_url 2017-01-23-what-demographics-voted-for-trump %}) {:target="_blank"}). With `edu_batch` and `income` we can se a inverted "U": the lowest and highest quintiles are the counties that had less proportion of votes for Trump. For the `income`, this is where you see this *middle class* support that Trump had.

# Nested dataframes

Now let's have some fun with Nested Dataframes! As I want to analyze the difference by region, I load the `datasets` package that has all states and regions, and joined it to the `votes`dataframe I'm working with.


```r
library(datasets)
regions <- tibble(state.region, state.abb)

votes <- votes %>% 
  inner_join(regions, 
             by = c("state_abbr" = "state.abb"))

# study race and % votes for each candidates by_region
by_region <- votes %>% 
  group_by(state.region) %>% 
  summarise(mean_white       = mean(white),
            mean_white_alone = mean(white_alone),
            mean_black       = mean(black),
            mean_hisp_latin  = mean(hisp_latin),
            mean_edu_batch   = mean(edu_batchelors),
            mean_hisp_latin  = mean(hisp_latin),
            mean_urban       = mean(housing_units_multistruct),
            mean_income      = mean(income),
            mean_trump       = mean(Trump),
            mean_clinton     = mean(Clinton))

knitr::kable(by_region)
```



|state.region  | mean_white| mean_white_alone| mean_black| mean_hisp_latin| mean_edu_batch| mean_urban| mean_income| mean_trump| mean_clinton|
|:-------------|----------:|----------------:|----------:|---------------:|--------------:|----------:|-----------:|----------:|------------:|
|Northeast     |   89.26544|         84.08295|   5.770968|        6.488018|       26.88341|   22.28618|    28517.61|  0.5157132|    0.4364073|
|South         |   78.59944|         69.31337|  17.051443|       10.298804|       17.72836|   10.66481|    21844.81|  0.6540622|    0.3153637|
|North Central |   92.53602|         88.70701|   2.606540|        4.403602|       19.52550|   11.99137|    24367.44|  0.6614149|    0.2856526|
|West          |   88.60311|         72.73110|   1.583014|       17.837321|       23.35383|   13.63756|    24763.42|  0.5754544|    0.3387524|

We can see some differences in characteristics across the regions, but lets check what happens if we fit a logistic regression (because my response variable is binary) to each region and see if we discover some differences between them!

### `Trump ~ white_alone` model by region

First I do it using `white_alone` as an explanatory variable. I use the `nest` function of the `tidyr` package, to make a dataframe that contains a list column made of dataframes! As I used `nest(-state_region)` it has one column with the `state_region` and the other is the list column with a dataframe for every `state_region`. Then I use the `purr::map` function to fit a model to each dataframe in the list column mentioned before. Finaly I use the `broom::tidy` function to retrieve the tidy results of my models and filtered only the slopes. As I prefer the Odds Ratio rather then the coefficients for interpretation, I calculate them also. 


```r
library(tidyr)
library(purrr)
library(broom)

by_region_white_alone <- votes %>% 
  nest(-state.region) %>% 
  mutate(models = map(data, ~ glm(pref_cand_T ~ white_alone, ., 
                                  family = "binomial"))) %>% 
  unnest(map(models, tidy)) %>% 
  filter(term == "white_alone") %>%
  mutate(OR = exp(estimate))

knitr::kable(by_region_white_alone)
```



|state.region  |term        |  estimate| std.error| statistic| p.value|       OR|
|:-------------|:-----------|---------:|---------:|---------:|-------:|--------:|
|South         |white_alone | 0.1215167| 0.0077964| 15.586229|       0| 1.129208|
|West          |white_alone | 0.0482535| 0.0060178|  8.018514|       0| 1.049437|
|Northeast     |white_alone | 0.0897197| 0.0157405|  5.699923|       0| 1.093868|
|North Central |white_alone | 0.0803994| 0.0085641|  9.387916|       0| 1.083720|

This means that for a one-unit increase in `white_alone` population in the South region, we would expect to see about 13% increase in the odds of voting for Trump. For the West region, the expected increase would be 5%. 

This is the kind of analysis you can perform using nested dataframes, pretty amazing, ha?

### `Trump ~ black` model by region

I do the same using `black` to explain Trump percentage of votes in counties.


```r
by_region_black <- votes %>% 
  nest(-state.region) %>% 
  mutate(models = map(data, ~ glm(pref_cand_T ~ black, ., 
                                  family = "binomial"))) %>% 
  unnest(map(models, tidy)) %>% 
  filter(term == "black") %>%
  mutate(OR = exp(estimate))

knitr::kable(by_region_black)
```



|state.region  |term  |   estimate| std.error|  statistic| p.value|        OR|
|:-------------|:-----|----------:|---------:|----------:|-------:|---------:|
|South         |black | -0.0843630| 0.0052221| -16.155115|   0e+00| 0.9190976|
|West          |black | -0.3424013| 0.0627653|  -5.455264|   0e+00| 0.7100632|
|Northeast     |black | -0.1735466| 0.0334918|  -5.181762|   2e-07| 0.8406780|
|North Central |black | -0.1929370| 0.0210642|  -9.159458|   0e+00| 0.8245339|

In this case for a one-unit increase in `black` population in the South region, we would expect to see about 8% reduction in the odds of voting for Trump. For the West region, the expected decrease would be 29%. 

We can see this in a plot also (I loooove plots!), where the blue dots represent `black` population and the red ones represent `white_alone` population.


```r
ggplot() +
  geom_point(data = by_region_black, aes(x = reorder(state.region, OR), y = OR), color = "blue") +
  geom_point(data = by_region_white_alone, aes(x = reorder(state.region, OR), y = OR), color = "red") +
  geom_hline(yintercept = 1) +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.line = element_line(colour = "grey"), legend.position = "bottom", 
        panel.grid.major = element_blank(), panel.border = element_blank())
```

<img src="/figure/source/using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles/2017-02-13-using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

And that is it! This is my humble contribution to show how useful nested dataframes can be when you want to estimate different models for different groups!

The R Markdown I used to generate this post is [available here](https://github.com/d4tagirl/d4tagirl.com/blob/master/_source/using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles/2017-02-13-using-nested-dataframes-to-explain-trump-s-winning-by-race-across-income-quintiles.Rmd).


Thank you for making it until here! Please comment if you have suggestions or you find that I could do something  better ;) You can also [mention me on Twitter if you prefer!](https://twitter.com/intent/tweet?user_id=114258616)
