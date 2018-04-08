---
layout: post
title:  tf-idf de todas las sesiones parlamentarias analizadas
date: "2017-05-30 02:11:29 UYT"
published: true
tags: [skip_index]
---

<!--more-->
<br />




## Diputados:


```r
library(dplyr)
library(tidytext)

sesion_diputados_words <- diputados %>%
  unnest_tokens(word, pdf) %>%
  count(fecha, sesion, fecha_sesion, word, sort = TRUE) %>%
  ungroup()

diputados_words <- sesion_diputados_words %>% 
  group_by(fecha_sesion) %>% 
  summarize(total = sum(n))

sesion_diputados_tfidf <- left_join(sesion_diputados_words, diputados_words) %>%
  bind_tf_idf(word, fecha_sesion, n) 

for (i in unique(sesion_diputados_tfidf$fecha_sesion)){
  sesion_diputados_tfidf %>%
    filter(fecha_sesion == i) %>%
    arrange(desc(tf_idf)) %>%
    mutate(word = factor(word, levels = rev(unique(word)))) %>%
    top_n(15, tf_idf) %>%
    knitr::kable(format = "html") %>%
    print(kableExtra::kable_styling(full_width = F))
  cat("\n")
}
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> aditivo </td>
   <td style="text-align:right;"> 233 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0010526 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0017102 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> ejecutora </td>
   <td style="text-align:right;"> 245 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0011068 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0016398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> 1.1 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0005557 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0014337 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> viernes </td>
   <td style="text-align:right;"> 381 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0017212 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0014154 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> 001 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0004427 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0009934 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> 461 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0002801 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009793 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> 000 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0003524 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0009092 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> pesos </td>
   <td style="text-align:right;"> 201 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0009080 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0008815 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 968 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0043730 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0007973 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> creditos </td>
   <td style="text-align:right;"> 162 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0007318 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0007105 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> sustituyese </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0006325 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0006948 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> escalafon </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0003795 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0006799 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> ferroviario </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0003117 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006578 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> reasignase </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0001807 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006318 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-04 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-08-04_31 </td>
   <td style="text-align:left;"> 441 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 221358 </td>
   <td style="text-align:right;"> 0.0001672 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005844 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> cls </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0005709 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0023918 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> 18.566 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0006329 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0022131 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> investigar </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0012907 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0014780 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> empleadores </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0007384 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0013935 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> tripartito </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0004964 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0013917 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> num </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0003103 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009590 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> piquete </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0002234 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009359 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0002296 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008028 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> negociacion </td>
   <td style="text-align:right;"> 191 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0011852 </td>
   <td style="text-align:right;"> 0.6632942 </td>
   <td style="text-align:right;"> 0.0007861 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> oit </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0004158 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0006755 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> bergara </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0002358 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006610 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> bipartita </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0001551 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006499 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> sanabria </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0002296 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006436 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> saldos </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0003351 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0006323 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-28 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-03-28_6 </td>
   <td style="text-align:left;"> ilicitudes </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 161153 </td>
   <td style="text-align:right;"> 0.0001800 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006292 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> francas </td>
   <td style="text-align:right;"> 326 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0026736 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0050453 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> 15.921 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0011728 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0026314 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> voluntariado </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0008447 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0015135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> desarrolladores </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0003363 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0014088 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> franca </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0007299 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0011318 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> zonas </td>
   <td style="text-align:right;"> 507 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0041580 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0010721 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> 1987 </td>
   <td style="text-align:right;"> 133 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0010908 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0010589 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 533 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0043713 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0009589 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> 303 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0003363 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0008676 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> dormitorio </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0002706 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008366 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> transaccion </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0005167 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0007322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> desarrollador </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0001968 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006882 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> usuario </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0005905 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0006762 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> localizadas </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0001722 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006022 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-11-14_52 </td>
   <td style="text-align:left;"> mercaderias </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 121933 </td>
   <td style="text-align:right;"> 0.0003609 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0005863 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> interpelante </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005476 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0019147 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> penarol </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0018746 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> rapinas </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0008425 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0017778 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> amsterdam </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0003791 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0011719 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> homicidios </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0008425 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0011428 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> entradas </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005406 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0011408 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> estadio </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0006038 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0010293 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> bonomi </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0006880 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0010194 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> clasico </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005336 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0009560 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> bravas </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0003019 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009331 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> policia </td>
   <td style="text-align:right;"> 293 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0020570 </td>
   <td style="text-align:right;"> 0.4519851 </td>
   <td style="text-align:right;"> 0.0009298 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> hinchas </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0002527 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008837 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> interpelacion </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005968 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0008095 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> tribuna </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005827 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0007904 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-15 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-02-15_3 </td>
   <td style="text-align:left;"> barras </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 142437 </td>
   <td style="text-align:right;"> 0.0005055 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0007838 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> basada </td>
   <td style="text-align:right;"> 322 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0026487 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0016801 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 757 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0062269 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0016055 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 198 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0016287 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0011289 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> desalojos </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0003702 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0009551 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> genero </td>
   <td style="text-align:right;"> 514 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0042280 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0007709 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> adquisitiva </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0002468 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007628 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> art </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0006581 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0007536 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> discapacidad </td>
   <td style="text-align:right;"> 136 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0011187 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0007096 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> agresora </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0002056 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> sabalero </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0002221 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006226 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> prescripcion </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0005018 </td>
   <td style="text-align:right;"> 1.1939225 </td>
   <td style="text-align:right;"> 0.0005991 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> victima </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0009048 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0005739 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> 272 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0003373 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0005229 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> asentamientos </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0004771 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0005029 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 2017-12-12_58 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 121570 </td>
   <td style="text-align:right;"> 0.0006087 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0005006 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> lavado </td>
   <td style="text-align:right;"> 271 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0022178 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0019017 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> activos </td>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0024060 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0013283 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> terrorismo </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0013912 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0010513 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> delictivas </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0005974 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0010184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> decomiso </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0003601 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0009291 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> gafi </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0002701 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008348 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> envios </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0001719 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> obligados </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0009493 </td>
   <td style="text-align:right;"> 0.7239188 </td>
   <td style="text-align:right;"> 0.0006872 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> delito </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0011212 </td>
   <td style="text-align:right;"> 0.6061358 </td>
   <td style="text-align:right;"> 0.0006796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> clientes </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0004419 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0006548 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> diligencia </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0005401 </td>
   <td style="text-align:right;"> 1.1939225 </td>
   <td style="text-align:right;"> 0.0006449 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> sujetos </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0008757 </td>
   <td style="text-align:right;"> 0.7239188 </td>
   <td style="text-align:right;"> 0.0006339 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> cliente </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0003683 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0006278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> delitos </td>
   <td style="text-align:right;"> 154 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0012603 </td>
   <td style="text-align:right;"> 0.4519851 </td>
   <td style="text-align:right;"> 0.0005696 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-12-20_1 </td>
   <td style="text-align:left;"> postal </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 122193 </td>
   <td style="text-align:right;"> 0.0002537 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0005692 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> venezuela </td>
   <td style="text-align:right;"> 679 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0057031 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0044966 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> canciller </td>
   <td style="text-align:right;"> 162 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0013607 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0022107 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> maduro </td>
   <td style="text-align:right;"> 141 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0011843 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0021220 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> chavez </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0004200 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0012981 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> unasur </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0005459 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0012250 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> venezolana </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0005711 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0010234 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> venezolano </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0006971 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0009456 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> revocatorio </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0002856 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008827 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> cancilleria </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0005795 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0008213 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> oea </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0006131 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0007966 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> venezolanos </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0004536 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0007732 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> interpelante </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0002184 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0007636 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> bolivariana </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0005795 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0007217 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> referendum </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0003696 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0006974 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2017-05-10_14 </td>
   <td style="text-align:left;"> leopoldo </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 119059 </td>
   <td style="text-align:right;"> 0.0002352 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006593 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> afap </td>
   <td style="text-align:right;"> 193 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0018648 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0035190 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> cincuentones </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0011111 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0022139 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> mixto </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0006860 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0016450 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> desafiliacion </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0005121 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0013213 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> fideicomiso </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0005991 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0010212 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> 16.713 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0006087 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0009439 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> pesce </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0002899 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008960 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> viviana </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0002899 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008960 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> jubilacion </td>
   <td style="text-align:right;"> 101 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0009759 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0008368 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> previsional </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0004251 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0007617 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 621 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0060002 </td>
   <td style="text-align:right;"> 0.1121173 </td>
   <td style="text-align:right;"> 0.0006727 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> ahorro </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0008213 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0006475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> jubilarse </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0003188 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0006353 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> jueves </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0015459 </td>
   <td style="text-align:right;"> 0.3610133 </td>
   <td style="text-align:right;"> 0.0005581 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-14 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 2017-12-14_60 </td>
   <td style="text-align:left;"> 1995 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 103497 </td>
   <td style="text-align:right;"> 0.0008696 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0005516 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> rendicion </td>
   <td style="text-align:right;"> 285 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0025801 </td>
   <td style="text-align:right;"> 0.4284546 </td>
   <td style="text-align:right;"> 0.0011054 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> deficit </td>
   <td style="text-align:right;"> 129 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0011678 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0010879 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> us </td>
   <td style="text-align:right;"> 257 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0023266 </td>
   <td style="text-align:right;"> 0.4054651 </td>
   <td style="text-align:right;"> 0.0009434 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> deuda </td>
   <td style="text-align:right;"> 132 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0011950 </td>
   <td style="text-align:right;"> 0.6632942 </td>
   <td style="text-align:right;"> 0.0007926 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 458 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0041462 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0007559 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> bruto </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0004708 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0007299 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> gasto </td>
   <td style="text-align:right;"> 173 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0015661 </td>
   <td style="text-align:right;"> 0.4519851 </td>
   <td style="text-align:right;"> 0.0007079 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> crecimiento </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0013670 </td>
   <td style="text-align:right;"> 0.4284546 </td>
   <td style="text-align:right;"> 0.0005857 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> fiscal </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0010682 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0005620 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> cuentas </td>
   <td style="text-align:right;"> 339 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0030689 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0005595 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> pbi </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0004164 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0005411 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> proyecciones </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0001901 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0004559 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> presupuestal </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0006880 </td>
   <td style="text-align:right;"> 0.6061358 </td>
   <td style="text-align:right;"> 0.0004170 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> endeudamiento </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0003169 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0004117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-02_29 </td>
   <td style="text-align:left;"> neta </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 110462 </td>
   <td style="text-align:right;"> 0.0001358 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0003807 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> 461 </td>
   <td style="text-align:right;"> 112 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0010891 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0038079 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> aditivo </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0011571 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0018800 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> 733 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0003890 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010904 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 568 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0055231 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0010070 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> escalafon </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0005154 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0009234 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> vapor </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0003112 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007461 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> 460 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0002431 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006815 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> onfi </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0001848 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> ejecutora </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0004278 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0006339 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> inconstitucional </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0004862 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0006054 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> ayudante </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0002334 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0006022 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> jueves </td>
   <td style="text-align:right;"> 168 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0016336 </td>
   <td style="text-align:right;"> 0.3610133 </td>
   <td style="text-align:right;"> 0.0005898 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> comisario </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0002236 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0005771 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> sentencia </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0006029 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0005616 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-03 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-03_30 </td>
   <td style="text-align:left;"> judiciales </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 102840 </td>
   <td style="text-align:right;"> 0.0006612 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0005213 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> riego </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0010713 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0018263 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> audiencia </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0011035 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0014337 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> 17.823 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0005249 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0010459 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> sustituyese </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0009106 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0010004 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> emprendedores </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0004928 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0009819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> imputado </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0005357 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0009598 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> acusacion </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0005785 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0008970 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> emprendedor </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0003857 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0008139 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> emprendedora </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0002571 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007948 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> 19.293 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0005785 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0007847 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> cpp </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0002678 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007508 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> privativas </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0002357 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007285 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> formalizacion </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0003214 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006782 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> trombosis </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0001607 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006733 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-10-17_47 </td>
   <td style="text-align:left;"> sentencia </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 93343 </td>
   <td style="text-align:right;"> 0.0007178 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0006687 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 573 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0063191 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0016292 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> basada </td>
   <td style="text-align:right;"> 178 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0019630 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0012451 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> ideologia </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0007279 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0009457 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0016652 </td>
   <td style="text-align:right;"> 0.4760827 </td>
   <td style="text-align:right;"> 0.0007928 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0011359 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0007873 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> genero </td>
   <td style="text-align:right;"> 378 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0041686 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0007600 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> lobby </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0001985 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> ceramicos </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0002206 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006818 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> varones </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0004191 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0006498 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0007720 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0006348 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 492 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0054258 </td>
   <td style="text-align:right;"> 0.1121173 </td>
   <td style="text-align:right;"> 0.0006083 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> victima </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0008933 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0005666 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> ninas </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0007830 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0004967 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> haro </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0004411 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0004650 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 2017-12-13_59 </td>
   <td style="text-align:left;"> olmos </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 90678 </td>
   <td style="text-align:right;"> 0.0002316 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0004614 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> laicidad </td>
   <td style="text-align:right;"> 255 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0031318 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0042481 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> religiosa </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0013387 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0020758 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> religioso </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0007369 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0013906 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> laicismo </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0003193 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0011165 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> religion </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0008966 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0008704 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> iglesia </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0004667 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0007582 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> laica </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0003070 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007362 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> laico </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0003439 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0007257 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> gabino </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0002088 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006454 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> mevir </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0007737 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0006363 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 486 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0059688 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0005689 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> religiones </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0002825 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0005331 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> templos </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0001719 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005315 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> cultos </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0002211 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0004960 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-10-03_41 </td>
   <td style="text-align:left;"> jutep </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 81423 </td>
   <td style="text-align:right;"> 0.0002333 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0004649 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> clemente </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0008437 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0018930 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> sucursales </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0010864 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0013528 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> estable </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0010170 </td>
   <td style="text-align:right;"> 1.1939225 </td>
   <td style="text-align:right;"> 0.0012143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> sas </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0005316 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0011219 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 413 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0047732 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0010471 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> cierres </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0003005 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0007753 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> banco </td>
   <td style="text-align:right;"> 398 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0045998 </td>
   <td style="text-align:right;"> 0.1643031 </td>
   <td style="text-align:right;"> 0.0007558 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> clientes </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0004854 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0007192 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> reestructura </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0006125 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0007014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> constitutivo </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0003120 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006585 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> biologicas </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0003120 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0005591 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> emprendedor </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0002543 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0005365 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> elinger </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0001849 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0005184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> ssf </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0001156 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-11-15_53 </td>
   <td style="text-align:left;"> inversores </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 86525 </td>
   <td style="text-align:right;"> 0.0002658 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0004763 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> fracking </td>
   <td style="text-align:right;"> 152 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0020131 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0056434 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> fractura </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0011257 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0026994 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> moratoria </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0009006 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0020207 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> hidraulica </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0009536 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0020122 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> http </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0009933 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0019791 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> shale </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0003443 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0014427 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> gas </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0011920 </td>
   <td style="text-align:right;"> 1.1939225 </td>
   <td style="text-align:right;"> 0.0014231 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> hidrocarburos </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0008211 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0013341 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> banchero </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0004238 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0011881 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> convencionales </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0006225 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0011746 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> acuifero </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0002781 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009725 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> and </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0003046 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009416 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> prohibicion </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0010595 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0009085 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> petroleo </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0005298 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0009031 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-12-05_54 </td>
   <td style="text-align:left;"> cnect </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 75506 </td>
   <td style="text-align:right;"> 0.0002516 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008798 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> mental </td>
   <td style="text-align:right;"> 391 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0053957 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0056879 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> hospitalizacion </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0014628 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0051146 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> trastorno </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0015042 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0028385 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> involuntaria </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0004140 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0014475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> asilares </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0003174 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0013298 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> monovalentes </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0002484 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0010407 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> mentales </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0005382 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0010156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 359 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0049541 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0009032 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> trastornos </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0004416 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0007912 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> hospitalizaciones </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0002208 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0007720 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> acrux </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0002484 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007678 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> asistencial </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0004002 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0007170 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> citricola </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0002760 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0007121 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> dispositivos </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0005520 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0006873 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-08-08_32 </td>
   <td style="text-align:left;"> interdisciplinarios </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 72465 </td>
   <td style="text-align:right;"> 0.0002070 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006398 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> clientes </td>
   <td style="text-align:right;"> 188 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0022984 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0034053 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> sucursales </td>
   <td style="text-align:right;"> 166 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0020294 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0025271 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> banco </td>
   <td style="text-align:right;"> 701 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0085701 </td>
   <td style="text-align:right;"> 0.1643031 </td>
   <td style="text-align:right;"> 0.0014081 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> sucursal </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0011247 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0012357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> reestructura </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0009536 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0010920 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> lunes </td>
   <td style="text-align:right;"> 134 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0016382 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0009044 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> presencial </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0003056 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0007886 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> bancario </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0005012 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0007772 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> brou </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0011003 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0007627 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> credito </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0009903 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0007483 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> gerente </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0005135 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0006965 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> cliente </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0004034 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0006878 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> rosca </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0001589 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006659 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> cierres </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0002567 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0006624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-11 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2017-12-11_57 </td>
   <td style="text-align:left;"> cajero </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 81796 </td>
   <td style="text-align:right;"> 0.0004523 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0006410 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> contadora </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0015672 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0040438 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> delegada </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0010448 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0023443 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> intendenta </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0004969 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0017375 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> ceibal </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0009684 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0012058 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> 303 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0004460 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0011507 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> charrua </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0004077 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0009148 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> reestructura </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0007135 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0008171 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> tribunal </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0027394 </td>
   <td style="text-align:right;"> 0.2978344 </td>
   <td style="text-align:right;"> 0.0008159 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> zelmar </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0003568 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0007529 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> recurso </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0013506 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0007456 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> contador </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0007900 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0007359 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> ediles </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0008409 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0007211 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> bergara </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0002548 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> cumparsita </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0002931 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0006575 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-16_16 </td>
   <td style="text-align:left;"> anuencia </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 78483 </td>
   <td style="text-align:right;"> 0.0001784 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005514 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> defuncion </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0005024 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0012962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 454 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0061641 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0007965 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> diferendo </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0003530 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0007034 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> salarial </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0005159 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0005009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> anp </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0002444 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0004612 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> jueces </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0005159 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0004612 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> alimenticia </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0001765 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0004554 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> autopsia </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0001222 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0004273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> contencioso </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0004209 </td>
   <td style="text-align:right;"> 1.0116009 </td>
   <td style="text-align:right;"> 0.0004258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> 733 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0001494 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0004187 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> magistrados </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0002987 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0004052 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> 19.310 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0000950 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0003982 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> extraviadas </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0000950 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0003982 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> holocausto </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0001629 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0003907 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-07_2 </td>
   <td style="text-align:left;"> inconstitucional </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 73652 </td>
   <td style="text-align:right;"> 0.0003123 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0003889 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> femicidio </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0009499 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0014730 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> homicidio </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0008278 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0010755 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> voluntariado </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0003935 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0007051 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> bernal </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001628 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006823 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> nasazzi </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001628 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006823 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> egeda </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001900 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0013299 </td>
   <td style="text-align:right;"> 0.4760827 </td>
   <td style="text-align:right;"> 0.0006331 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> iroldi </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001493 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006254 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> espionaje </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001764 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006168 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> obdulio </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001764 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006168 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> agravante </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0003393 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0005261 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> meviur </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001493 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005219 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 147 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0019948 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0005143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> exdirectores </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001221 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-12 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-09-12_39 </td>
   <td style="text-align:left;"> desafiliarse </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 73690 </td>
   <td style="text-align:right;"> 0.0001357 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0004745 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> materna </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0008838 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0017609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> lactancia </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0006337 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0014218 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> lactantes </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0004002 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0013993 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> migraciones </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0003002 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0008415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> traccion </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002668 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008247 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> totoral </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002835 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007947 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> taborda </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002668 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007480 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> elvira </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002835 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0007315 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> biberon </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0001668 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006986 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> leche </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0005336 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0006933 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 408 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0068036 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0006485 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> equinos </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002835 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0006361 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> tunez </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0001501 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006288 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> etiquetas </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0002001 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> monedas </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59968 </td>
   <td style="text-align:right;"> 0.0004669 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0006067 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> desafuero </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0007086 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0016991 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 341 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0047378 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0010393 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> envidrio </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0003196 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009878 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> alcoholicas </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0003335 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007996 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> fueros </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0004585 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0007109 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> bebidas </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0004307 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0006998 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> gualeguaychu </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0002223 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006871 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> 18.407 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0003335 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0006644 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> botnia </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0001945 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006013 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> ecuestre </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0001667 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005830 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> expendedores </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0001389 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005821 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> slf </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0001389 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005821 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> afe </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0005141 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0005648 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> locomotora </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0001528 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005344 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-11-07_50 </td>
   <td style="text-align:left;"> fondes </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 71974 </td>
   <td style="text-align:right;"> 0.0002779 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0005244 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> transfronterizo </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0005145 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0017988 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> narcotrafico </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0012778 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0017333 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> sustancias </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0006970 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0010327 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> aduaneros </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0005145 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0009708 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> aduaneras </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0004315 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0009105 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> penas </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0006472 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0008409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> aduanera </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0004813 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0007819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> aceptarla </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0003651 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0007274 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> 14.294 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0002987 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007163 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> crimen </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0008630 </td>
   <td style="text-align:right;"> 0.6632942 </td>
   <td style="text-align:right;"> 0.0005724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> podre </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0003651 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0005409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> marihuana </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0002157 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0005173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> mutua </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0005145 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0004994 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> almacenare </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0001162 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004867 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> baps </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0001162 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004867 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-04_24 </td>
   <td style="text-align:left;"> poseyere </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 60258 </td>
   <td style="text-align:right;"> 0.0001162 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004867 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 459 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0079203 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0017374 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> olegario </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0004832 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0011586 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> armada </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0012769 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0010501 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> villalba </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0006385 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0009900 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> sucursales </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0007075 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0008810 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> serrana </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0003279 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0008459 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> fractura </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0003451 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0008275 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> corso </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0002588 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007256 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> hidraulica </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0003279 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006918 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> hidrocarburos </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0003969 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0006448 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> campbell </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0001726 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006033 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> bicentenario </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0002416 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0005420 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> mar </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0005522 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0005144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> mariscala </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0001208 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005061 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-11-01_49 </td>
   <td style="text-align:left;"> convencionales </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 57952 </td>
   <td style="text-align:right;"> 0.0002588 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0004884 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> abril </td>
   <td style="text-align:right;"> 437 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0078210 </td>
   <td style="text-align:right;"> 0.1121173 </td>
   <td style="text-align:right;"> 0.0008769 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> rodo </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0004832 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0007851 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> venezuela </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0008949 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0007056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> atyr </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0001074 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004499 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0006443 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0004466 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> aparicio </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0007159 </td>
   <td style="text-align:right;"> 0.5787368 </td>
   <td style="text-align:right;"> 0.0004143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> desistimiento </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0004295 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0004001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> 3er </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0001969 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0003922 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> exitos </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0002506 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0003885 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> fueros </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0002506 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0003885 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> onfi </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0001074 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0003755 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> alonso </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0006801 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0003755 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> totalitarismos </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0000895 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0003749 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> balparda </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0002864 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0003721 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-04_7 </td>
   <td style="text-align:left;"> contables </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 55875 </td>
   <td style="text-align:right;"> 0.0002148 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0003661 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> riego </td>
   <td style="text-align:right;"> 241 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0044446 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0075769 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> zelmar </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0019549 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0041252 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> 16.858 </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0010512 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0023587 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> michelini </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0012541 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0020375 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> hidraulicas </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0005533 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0019345 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> agrarias </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0008852 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0012544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> sar </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0004057 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0009104 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> suelos </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0004057 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0009104 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> multipredial </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0002582 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009028 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> aar </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0002398 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008383 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> agua </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0029508 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0007608 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> 1997 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0009037 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0007125 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> canon </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0003504 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0006278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> represas </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0002213 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006204 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-10-11_46 </td>
   <td style="text-align:left;"> parcelas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 54223 </td>
   <td style="text-align:right;"> 0.0002582 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006191 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> lesa </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0006984 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0010830 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> fiscalia </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0011999 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0010289 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> caducidad </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0004477 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0009448 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> zoologico </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0002686 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009393 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> crimenes </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0007164 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0008920 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> sexos </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0004656 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0007938 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> paridad </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0004119 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0007022 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> terra </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0005194 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0006748 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0012536 </td>
   <td style="text-align:right;"> 0.4760827 </td>
   <td style="text-align:right;"> 0.0005968 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> electivos </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0003224 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0005776 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> 18.476 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0001791 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005536 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 308 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0055160 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0005257 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> equitativa </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0003582 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0004858 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> arquitecto </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0002686 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0004165 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-10-18_48 </td>
   <td style="text-align:left;"> humanidad </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 55838 </td>
   <td style="text-align:right;"> 0.0007164 </td>
   <td style="text-align:right;"> 0.5787368 </td>
   <td style="text-align:right;"> 0.0004146 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> osta </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0007144 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0012801 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> venezuela </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0012937 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0010200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> racismo </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0007723 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0010035 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> racial </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0007144 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0007849 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> afrogama </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001738 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007281 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> asociativas </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0002510 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006019 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> sucive </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001545 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> orsi </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001738 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005372 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> intolerancia </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0005213 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0004857 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> afrodescendientes </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0002703 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0004844 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> conexas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0002703 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0004608 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> afrodescendiente </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001931 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0004332 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> linaje </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001545 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0004330 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0006179 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0004283 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-12_26 </td>
   <td style="text-align:left;"> lamonaca </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 51790 </td>
   <td style="text-align:right;"> 0.0001738 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0004167 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> fgdpl </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0006481 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0027151 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> productores </td>
   <td style="text-align:right;"> 234 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0033699 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0018604 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 222 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0031971 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0016819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> agro </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0009073 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0016256 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> gasoil </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0007777 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0015494 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> lecheros </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0007201 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0015195 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> leche </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0010369 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0013472 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> us </td>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0030818 </td>
   <td style="text-align:right;"> 0.4054651 </td>
   <td style="text-align:right;"> 0.0012496 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> autoconvocados </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0003312 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0010238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> agropecuario </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0007345 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0009543 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> lechero </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0004032 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0008034 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> dolar </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0004032 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0007609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> precio </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0011377 </td>
   <td style="text-align:right;"> 0.6632942 </td>
   <td style="text-align:right;"> 0.0007546 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> deudas </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0005904 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0007352 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2018-02-08_3 </td>
   <td style="text-align:left;"> precios </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 69439 </td>
   <td style="text-align:right;"> 0.0009649 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0007291 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> tapie </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0007871 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0018874 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> pineyro </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0005903 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0009154 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> aebu </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0005029 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0009010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> israel </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0005466 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0008476 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> zaragoza </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0002405 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007434 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> rioja </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0001749 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007328 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> gimenez </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0002405 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006742 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0009402 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0006517 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> ceibal </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0005029 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0006262 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> abad </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0002405 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0006206 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> aparicio </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0010058 </td>
   <td style="text-align:right;"> 0.5787368 </td>
   <td style="text-align:right;"> 0.0005821 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> fueros </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0003717 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0005763 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> tranqueras </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0003061 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0005485 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> alonso </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0009620 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0005311 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> fros </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0002624 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0005228 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-09_13 </td>
   <td style="text-align:left;"> pimentel </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 45737 </td>
   <td style="text-align:right;"> 0.0002624 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0005228 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> gotuzzo </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0005808 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0017952 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> salvamento </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0005808 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0016281 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> aereas </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0006924 </td>
   <td style="text-align:right;"> 1.992430 </td>
   <td style="text-align:right;"> 0.0013796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> hederson </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0006031 </td>
   <td style="text-align:right;"> 2.243745 </td>
   <td style="text-align:right;"> 0.0013532 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> tdah </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0003127 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0013102 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> septiembre </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0008488 </td>
   <td style="text-align:right;"> 1.481604 </td>
   <td style="text-align:right;"> 0.0012576 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> cardozo </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0005137 </td>
   <td style="text-align:right;"> 2.110213 </td>
   <td style="text-align:right;"> 0.0010841 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> covisunca </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0002457 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0010294 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> 249 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0004467 </td>
   <td style="text-align:right;"> 1.992430 </td>
   <td style="text-align:right;"> 0.0008901 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> gomez </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0006478 </td>
   <td style="text-align:right;"> 1.245216 </td>
   <td style="text-align:right;"> 0.0008066 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> aeronaves </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0003797 </td>
   <td style="text-align:right;"> 2.110213 </td>
   <td style="text-align:right;"> 0.0008013 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> 252 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0004244 </td>
   <td style="text-align:right;"> 1.887070 </td>
   <td style="text-align:right;"> 0.0008009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> autoctona </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0002457 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0007595 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> aeronauticas </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0002904 </td>
   <td style="text-align:right;"> 2.580217 </td>
   <td style="text-align:right;"> 0.0007492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-05 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-09-05_36 </td>
   <td style="text-align:left;"> aereo </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 44769 </td>
   <td style="text-align:right;"> 0.0005137 </td>
   <td style="text-align:right;"> 1.417066 </td>
   <td style="text-align:right;"> 0.0007280 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> condicional </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0011219 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0026902 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> decimetros </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0006648 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0023246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> cuadrados </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0013297 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0020618 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> pirez </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0003740 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010484 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> 9.847 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002493 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0010445 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> penados </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002285 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009575 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> vigilancia </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0010596 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0009471 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> fraccion </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0004986 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0008934 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> perros </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0006441 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0008736 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> 10.329 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002493 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> 12.872 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002493 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> 17.854 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002493 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> 30.045 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002493 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> caucion </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0002078 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0008705 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-04 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-10-04_42 </td>
   <td style="text-align:left;"> animales </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 48132 </td>
   <td style="text-align:right;"> 0.0009765 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0008373 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> companera </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0018034 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0014219 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> coroneles </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002342 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009813 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> gnls </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002576 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> batallon </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0003279 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0008460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> cannabis </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0003982 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0006788 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> cumparsita </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002811 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0006306 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> marihuana </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002576 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006178 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> paracaidismo </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0001405 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005888 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> paracaidista </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0001405 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005888 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> siif </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0001405 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005888 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> 15.688 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002108 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0005439 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> soja </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002811 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0005304 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> infanteria </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0001874 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0005253 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> alumbrado </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0002576 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0004616 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-02_11 </td>
   <td style="text-align:left;"> pirez </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 42697 </td>
   <td style="text-align:right;"> 0.0001639 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0004596 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> cti </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0008327 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0017573 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 281 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0055714 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0010158 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> asse </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0040051 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0008786 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> auditorias </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0006345 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0008606 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> preinvestigadora </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0003569 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0008558 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> investigadora </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0017051 </td>
   <td style="text-align:right;"> 0.5007753 </td>
   <td style="text-align:right;"> 0.0008539 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> fonasa </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0007336 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0008059 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> irregularidades </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0010508 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0007941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> traslados </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0007931 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0007699 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> ejecutoras </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0004957 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0007686 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> semco </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0001784 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007476 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> investigar </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0006345 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0007265 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> auditoria </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0007336 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0006557 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> tomografo </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0001784 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006239 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-08-09_33 </td>
   <td style="text-align:left;"> hospital </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 50436 </td>
   <td style="text-align:right;"> 0.0023594 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0006083 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> 018 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0022592 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0058293 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 278 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0064088 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0033716 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> oximetria </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0002075 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0008693 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> congenitas </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0002766 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008551 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> pulso </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0002766 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008551 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 280 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0064549 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0008340 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> companera </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0009913 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0007816 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> gusto </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0020748 </td>
   <td style="text-align:right;"> 0.3610133 </td>
   <td style="text-align:right;"> 0.0007490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> haro </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0006916 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0007291 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> anomalias </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0001844 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006448 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> voto </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0028125 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0006170 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> insulina </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0002305 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0005948 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> 19.446 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0002075 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0005816 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> cardiacas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0001383 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005795 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-03-06_2 </td>
   <td style="text-align:left;"> fronteriza </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 43378 </td>
   <td style="text-align:right;"> 0.0001844 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005701 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> cufre </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0005702 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0013672 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> intolerancia </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0013736 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0012796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> candombe </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0005443 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0012212 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> cgiar </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0002333 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009773 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> consorcio </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0004665 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0009295 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> aerolineas </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0002073 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0008687 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> convencion </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0018920 </td>
   <td style="text-align:right;"> 0.4054651 </td>
   <td style="text-align:right;"> 0.0007671 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 250 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0064794 </td>
   <td style="text-align:right;"> 0.1121173 </td>
   <td style="text-align:right;"> 0.0007264 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> discriminacion </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0020734 </td>
   <td style="text-align:right;"> 0.3395071 </td>
   <td style="text-align:right;"> 0.0007039 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> preambulo </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0004406 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0006832 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> sociocultural </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0002333 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006539 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> honduras </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0003628 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0006501 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> ag </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0002073 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> vuelos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0001814 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005608 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2017-12-06_56 </td>
   <td style="text-align:left;"> pabellon </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 38584 </td>
   <td style="text-align:right;"> 0.0002333 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0005593 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> retenciones </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0008305 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0019916 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> intangible </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0009255 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0019529 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> cooperativas </td>
   <td style="text-align:right;"> 131 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0031086 </td>
   <td style="text-align:right;"> 0.6061358 </td>
   <td style="text-align:right;"> 0.0018842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> creditos </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0016374 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0015895 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> cooperativo </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0010204 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0015822 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> vinos </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0005458 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0015300 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> credito </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0019696 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0014883 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> jutep </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0007119 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0014184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> 17.829 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0005221 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0013470 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> vitivinicola </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0004746 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0012246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 216 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0051256 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0009345 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> nomina </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0010204 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0008391 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> denunciante </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0004983 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0008096 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> 19.340 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0002610 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008069 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-16 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-08-16_35 </td>
   <td style="text-align:left;"> vitivinicultura </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 42141 </td>
   <td style="text-align:right;"> 0.0002610 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007318 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> lutero </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0011427 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0035323 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> dieste </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0009869 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0017683 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> biblia </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0006233 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0017474 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> asean </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0004415 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0015438 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> aeronaves </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0007272 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0015345 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 244 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0063370 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0013901 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> aerea </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0014284 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0013307 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> indonesia </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0005454 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0012237 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> latu </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0004675 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0012062 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> eladio </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0005973 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0011272 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> iglesia </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0005454 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0008861 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> escrituras </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0002857 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008831 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> tanque </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0003636 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0008719 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> vuelo </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0005454 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0008457 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-11-08_51 </td>
   <td style="text-align:left;"> bebidas </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 38504 </td>
   <td style="text-align:right;"> 0.0005194 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0008439 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> septiembre </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0020667 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0030621 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> femicidio </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0008510 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0013196 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> purificacion </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0005106 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0013175 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> provincias </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0005835 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0013093 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> garufa </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0003404 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0011902 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> provincia </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0007051 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0009564 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> britanica </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0003404 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0009543 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> bretana </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0005106 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0008296 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> ingleses </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0003161 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007579 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> 1817 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0002918 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0007528 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> unido </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0005835 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0006682 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0012887 </td>
   <td style="text-align:right;"> 0.4760827 </td>
   <td style="text-align:right;"> 0.0006135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> corso </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0002188 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0006135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> beraza </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0001702 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005951 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> bowles </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0001702 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005951 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-09-06_38 </td>
   <td style="text-align:left;"> majestad </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 41128 </td>
   <td style="text-align:right;"> 0.0001702 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005951 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> oleicola </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0005540 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0023209 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> animal </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0018130 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0016889 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> compte </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0004281 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0011045 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> enriqueta </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0004281 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0011045 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> rique </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0004281 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0011045 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> dorado </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0003022 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009340 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> rabia </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0003022 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0009340 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> hemocentro </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0003777 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0009057 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> jardin </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0009317 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0009044 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> animales </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0010072 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0008636 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> tenencia </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0010827 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0007505 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> delta </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0003022 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007245 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> tigre </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0003022 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007245 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> aceite </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0002770 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006642 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-13_20 </td>
   <td style="text-align:left;"> oliva </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 39714 </td>
   <td style="text-align:right;"> 0.0002770 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006642 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> admision </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0024288 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0035985 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> espectaculo </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0010994 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0019698 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> espectaculos </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0021476 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0019195 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> organizador </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0005880 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0014100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> organizadores </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0005880 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0014100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> deportivos </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0010227 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0010780 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> auf </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0004091 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0010555 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> futbol </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0011760 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0009273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> deporte </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0015595 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0008205 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> recintos </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0003068 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> cardiologico </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0002557 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007167 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> deudor </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0003068 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0006884 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> guatemala </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0004346 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0006439 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> rae </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0001534 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006427 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> estadios </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0002557 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0005736 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-04-18_10 </td>
   <td style="text-align:left;"> imae </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 39114 </td>
   <td style="text-align:right;"> 0.0002557 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0005736 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> guernica </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0026532 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0092768 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> bombardeo </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0015800 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0055244 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> vasco </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0008347 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0025801 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> azerbaiyan </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0006856 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0019221 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> bombas </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0007155 </td>
   <td style="text-align:right;"> 2.397895 </td>
   <td style="text-align:right;"> 0.0017156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> vascos </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0006558 </td>
   <td style="text-align:right;"> 2.580217 </td>
   <td style="text-align:right;"> 0.0016922 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> moskovics </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0005366 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0016586 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> vasca </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0003577 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0012508 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> roble </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0002981 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0012490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> graciable </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0005664 </td>
   <td style="text-align:right;"> 2.110213 </td>
   <td style="text-align:right;"> 0.0011952 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> legion </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0003279 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0011466 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> condor </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0002981 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0010423 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> picasso </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0003279 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0010136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> incendiarias </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0002385 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0009992 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> vizcaya </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 33545 </td>
   <td style="text-align:right;"> 0.0002385 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0009992 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> benavente </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0006232 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0026109 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> herederos </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0004451 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0012479 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> aviacion </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0006825 </td>
   <td style="text-align:right;"> 1.791759 </td>
   <td style="text-align:right;"> 0.0012229 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> enmienda </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0009793 </td>
   <td style="text-align:right;"> 1.098612 </td>
   <td style="text-align:right;"> 0.0010759 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> lausarot </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0004451 </td>
   <td style="text-align:right;"> 2.397895 </td>
   <td style="text-align:right;"> 0.0010674 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> 18.865 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0003264 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0010090 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> cordel </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0002968 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0009173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> uniones </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0003264 </td>
   <td style="text-align:right;"> 2.580217 </td>
   <td style="text-align:right;"> 0.0008423 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> causante </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0003264 </td>
   <td style="text-align:right;"> 2.397895 </td>
   <td style="text-align:right;"> 0.0007827 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> mozos </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0002968 </td>
   <td style="text-align:right;"> 2.580217 </td>
   <td style="text-align:right;"> 0.0007657 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> audem </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0001781 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0007460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> cooparte </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0001781 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0007460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> 419 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0002374 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0007338 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> artistas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0004155 </td>
   <td style="text-align:right;"> 1.550597 </td>
   <td style="text-align:right;"> 0.0006442 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-10-10_44 </td>
   <td style="text-align:left;"> sucesorio </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 33698 </td>
   <td style="text-align:right;"> 0.0002077 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0006421 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> lalo </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0011940 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0050026 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> aguirre </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0022064 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0039533 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> admision </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0006489 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0009615 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> vichadero </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0003894 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0008736 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> exdiputado </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0003115 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0008037 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> supiste </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0001817 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007613 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> paz </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0026476 </td>
   <td style="text-align:right;"> 0.2776317 </td>
   <td style="text-align:right;"> 0.0007351 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> organizadores </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0002855 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0006847 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> shell </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0002077 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006419 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> abejas </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0001817 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006353 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> espectaculos </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0007008 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0006264 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> mpp </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0003115 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0005878 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> laborable </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0001298 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005438 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> lumpen </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0001298 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005438 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-09-13_40 </td>
   <td style="text-align:left;"> etica </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 38525 </td>
   <td style="text-align:right;"> 0.0007528 </td>
   <td style="text-align:right;"> 0.6632942 </td>
   <td style="text-align:right;"> 0.0004993 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> companera </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0022595 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0017815 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 312 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0095264 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0012309 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> socialista </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0009160 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0011901 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> locucion </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001527 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006396 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0008549 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0005926 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> 22ª </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001832 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005663 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> expoactiva </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001832 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005663 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> obesidad </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0002443 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0005481 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> contribuyente </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0003969 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0005157 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> 19.446 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001832 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0005136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> concurrira </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0002137 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0005125 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> aparicio </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0008855 </td>
   <td style="text-align:right;"> 0.5787368 </td>
   <td style="text-align:right;"> 0.0005125 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> dunas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001221 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> escrituracion </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001221 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> malta </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001221 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005117 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-14_4 </td>
   <td style="text-align:left;"> medanos </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 32751 </td>
   <td style="text-align:right;"> 0.0001221 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005117 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> turco </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0018099 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0055945 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> admision </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0024813 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0036763 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> espectaculo </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0018391 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0032952 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> organizadores </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0007590 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0018200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> espectaculos </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0019267 </td>
   <td style="text-align:right;"> 0.8938179 </td>
   <td style="text-align:right;"> 0.0017221 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> quiroga </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0004671 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0013094 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> organizador </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0004671 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0011200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> aborto </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0004087 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0009800 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> gomez </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0007006 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0008724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> permanencia </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0012553 </td>
   <td style="text-align:right;"> 0.6343067 </td>
   <td style="text-align:right;"> 0.0007962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> museos </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0003211 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> espectadores </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0003795 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0007561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> pescadores </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0002627 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007365 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> colecciones </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0001752 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007338 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-05_8 </td>
   <td style="text-align:left;"> reproducciones </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 34256 </td>
   <td style="text-align:right;"> 0.0001752 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007338 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 267 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0104837 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0055154 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> 018 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0016099 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0041538 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> febrero </td>
   <td style="text-align:right;"> 271 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0106408 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0019400 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> zoologico </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0002749 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009610 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> receso </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0003534 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0007929 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> 017 </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0045547 </td>
   <td style="text-align:right;"> 0.1643031 </td>
   <td style="text-align:right;"> 0.0007484 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> decomisos </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001963 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0006865 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> declino </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0007068 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0006584 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> curatela </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001963 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0006068 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> valentin </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0005577 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> decomisados </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001963 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0005066 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> vertedero </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001963 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0005066 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> 19.574 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001178 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004935 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> casarino </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0001178 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004935 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2018-02-07_2 </td>
   <td style="text-align:left;"> empleador </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 25468 </td>
   <td style="text-align:right;"> 0.0003534 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0004793 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> gularte </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0005098 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0015758 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> aceptarla </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0007477 </td>
   <td style="text-align:right;"> 1.992430 </td>
   <td style="text-align:right;"> 0.0014897 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> podre </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0007477 </td>
   <td style="text-align:right;"> 1.481604 </td>
   <td style="text-align:right;"> 0.0011078 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> fumador </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002719 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0009507 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> musulmana </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002719 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0007622 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> laicidad </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0005438 </td>
   <td style="text-align:right;"> 1.356441 </td>
   <td style="text-align:right;"> 0.0007376 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> fumadores </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002039 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0007130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> plastica </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002039 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0007130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> vedete </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0001699 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0007119 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> durand </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002379 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0006669 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> trans </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0005778 </td>
   <td style="text-align:right;"> 1.145132 </td>
   <td style="text-align:right;"> 0.0006616 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> martha </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0003738 </td>
   <td style="text-align:right;"> 1.704748 </td>
   <td style="text-align:right;"> 0.0006373 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> interpuesta </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0002039 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0006303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> luna </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0003059 </td>
   <td style="text-align:right;"> 1.992430 </td>
   <td style="text-align:right;"> 0.0006094 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-05_25 </td>
   <td style="text-align:left;"> acusaron </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 29424 </td>
   <td style="text-align:right;"> 0.0001699 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0005942 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0044733 </td>
   <td style="text-align:right;"> 0.4760827 </td>
   <td style="text-align:right;"> 0.0021297 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> varones </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0006578 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0010200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 136 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0035787 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0009227 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> mujeres </td>
   <td style="text-align:right;"> 344 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0090519 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0008627 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> nosotras </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0003684 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0008266 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> femenina </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0005000 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0007407 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0008420 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0006925 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> igualdad </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0022367 </td>
   <td style="text-align:right;"> 0.2978344 </td>
   <td style="text-align:right;"> 0.0006662 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> trabajadoras </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0006052 </td>
   <td style="text-align:right;"> 1.0986123 </td>
   <td style="text-align:right;"> 0.0006649 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0044733 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0005780 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> matrimonio </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0003421 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0005304 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> insulina </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001842 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0004753 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> abuelas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001053 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> falls </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001053 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> fundamentalismos </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001053 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> glicemia </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001053 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-08_3 </td>
   <td style="text-align:left;"> seneca </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 38003 </td>
   <td style="text-align:right;"> 0.0001053 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0004410 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> falco </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0018064 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0035992 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> liber </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0017342 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0021594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> panama </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0015535 </td>
   <td style="text-align:right;"> 0.7239188 </td>
   <td style="text-align:right;"> 0.0011246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> lara </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0002890 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008934 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> cometas </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0001806 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0007568 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> poeta </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0005058 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0007168 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0009393 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0006511 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> camila </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0006142 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0006474 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> camilas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0001445 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006055 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> aparicio </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0009755 </td>
   <td style="text-align:right;"> 0.5787368 </td>
   <td style="text-align:right;"> 0.0005645 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> estudiantil </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0004335 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0005399 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> parlatino </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0007587 </td>
   <td style="text-align:right;"> 0.6931472 </td>
   <td style="text-align:right;"> 0.0005259 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> alonso </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0009393 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0005186 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> literarios </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0001445 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005053 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> padrastro </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0001445 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005053 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-03_12 </td>
   <td style="text-align:left;"> resabios </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 27679 </td>
   <td style="text-align:right;"> 0.0001445 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005053 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0046005 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0024203 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> saliente </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0007862 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0022039 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> exitos </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0007279 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0011287 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> vicepresidentes </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0004368 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0008242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> elogios </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0003494 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0007840 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> voto </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0033776 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0007409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> fundar </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0017179 </td>
   <td style="text-align:right;"> 0.4054651 </td>
   <td style="text-align:right;"> 0.0006966 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> ecuanime </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0003203 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006759 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> ecuanimidad </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0003494 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0006594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> jueves </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0015723 </td>
   <td style="text-align:right;"> 0.3610133 </td>
   <td style="text-align:right;"> 0.0005676 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 146 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0042511 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0005493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> felicitar </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0006115 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0005243 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> cualidades </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0003494 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0005177 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> equipo </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0013394 </td>
   <td style="text-align:right;"> 0.3829923 </td>
   <td style="text-align:right;"> 0.0005130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-01_1 </td>
   <td style="text-align:left;"> felicitaciones </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 34344 </td>
   <td style="text-align:right;"> 0.0003203 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0004966 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> bell </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0005810 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0020313 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> buoy </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0005810 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0020313 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> fusileros </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0012432 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 199 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0088931 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0011491 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> buceo </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0011275 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> salvamento </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0011275 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> anv </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004916 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0011030 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> inacoop </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004469 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0010716 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> embarcado </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0010378 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> helicoptero </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0009644 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> emprendimientos </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0009832 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0009544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> navales </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004469 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0008904 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> plana </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004022 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0008014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> compras </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0007597 </td>
   <td style="text-align:right;"> 1.0116009 </td>
   <td style="text-align:right;"> 0.0007685 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-15_5 </td>
   <td style="text-align:left;"> buque </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 22377 </td>
   <td style="text-align:right;"> 0.0004469 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0007618 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> bancarizacion </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0007210 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0011180 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> 19.210 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0007610 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0010784 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> credito </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0013619 </td>
   <td style="text-align:right;"> 0.7556675 </td>
   <td style="text-align:right;"> 0.0010291 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> debito </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0006008 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0010242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> tarjeta </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0009613 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0010134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> lluberas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0002403 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0010069 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> bancos </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0011215 </td>
   <td style="text-align:right;"> 0.8223589 </td>
   <td style="text-align:right;"> 0.0009223 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> antartico </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0003605 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0008644 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> 2021 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0004005 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0008452 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> albert </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0002403 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0008403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> 19.478 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0003605 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0008088 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0078907 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0007521 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> bancarizado </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0002403 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007429 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> reabrir </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0002003 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0007003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-28 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-06-28_23 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 24966 </td>
   <td style="text-align:right;"> 0.0062084 </td>
   <td style="text-align:right;"> 0.1121173 </td>
   <td style="text-align:right;"> 0.0006961 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> 16.698 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0011079 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0034246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 193 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0106913 </td>
   <td style="text-align:right;"> 0.1823216 </td>
   <td style="text-align:right;"> 0.0019493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> designante </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0004986 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0017432 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> negare </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0003324 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0013925 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> haro </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0012741 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0013431 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> mineral </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0002770 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0009685 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> negaren </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0002216 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009284 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> amianto </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0002770 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0008561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> prefabricadas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0002216 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0007748 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> investigadoras </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0003878 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0007317 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> provocadas </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0001662 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0005811 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> baranzano </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0003324 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0005666 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> graffigna </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0003324 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0005666 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> curbelo </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0003324 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0005154 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-01 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-01_28 </td>
   <td style="text-align:left;"> 2050 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18052 </td>
   <td style="text-align:right;"> 0.0001662 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0005137 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> raras </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0026157 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0049359 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> fermedades </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0006154 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0025785 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> incentivado </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0004103 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0012683 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> rara </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0005642 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0011905 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> enfermedades </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0021028 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0011609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> afucar </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0002564 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0010744 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> lunes </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0018976 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0010476 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> musulmana </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0003590 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> discapacitadas </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0004103 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0009206 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> aditivos </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0005129 </td>
   <td style="text-align:right;"> 1.7917595 </td>
   <td style="text-align:right;"> 0.0009189 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> vacantes </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0005642 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0008748 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> academias </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0002564 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0007927 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> paliativos </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0003077 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0007379 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> 701 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0001539 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> ayui </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0001539 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> eliminase </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0001539 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-24 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-07-24_27 </td>
   <td style="text-align:left;"> enfermeda </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 19498 </td>
   <td style="text-align:right;"> 0.0001539 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0006446 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> saliente </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0007522 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0021087 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> tus </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0004906 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0009257 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> fundar </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0022566 </td>
   <td style="text-align:right;"> 0.4054651 </td>
   <td style="text-align:right;"> 0.0009150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> exitos </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0005887 </td>
   <td style="text-align:right;"> 1.5505974 </td>
   <td style="text-align:right;"> 0.0009128 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> companero </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0034994 </td>
   <td style="text-align:right;"> 0.2578291 </td>
   <td style="text-align:right;"> 0.0009022 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> voto </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0035321 </td>
   <td style="text-align:right;"> 0.2193628 </td>
   <td style="text-align:right;"> 0.0007748 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> ecuanimidad </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0003925 </td>
   <td style="text-align:right;"> 1.8870696 </td>
   <td style="text-align:right;"> 0.0007406 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> felicito </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0007849 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0007312 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> dotes </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0002943 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0006604 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> legislaturas </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0003270 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0005575 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> hincha </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0002289 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0005490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> negociador </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0001308 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0005481 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> cualidades </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0003270 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0004845 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> saludo </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0009157 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0004818 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-01 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-01_1 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 114 </td>
   <td style="text-align:right;"> 30577 </td>
   <td style="text-align:right;"> 0.0037283 </td>
   <td style="text-align:right;"> 0.1292117 </td>
   <td style="text-align:right;"> 0.0004817 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> che </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0069135 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0193809 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> guevara </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0020629 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0053227 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> fidel </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0009478 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0026571 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> revolucionario </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0012823 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0017394 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> revolucionarios </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0005575 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0015630 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> bolivia </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0010593 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0015011 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> socialismo </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0005575 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0013369 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> cuba </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0007806 </td>
   <td style="text-align:right;"> 1.4816045 </td>
   <td style="text-align:right;"> 0.0011565 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> quijano </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0003345 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0010340 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> arbenz </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0002230 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0009344 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> imperialismo </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0005575 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0009058 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> cubanos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0003903 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0008236 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> declino </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0008363 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0007791 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 142 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0079170 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0007546 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-10-10_43 </td>
   <td style="text-align:left;"> revolucionaria </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 17936 </td>
   <td style="text-align:right;"> 0.0003345 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0007506 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> geoparques </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0014422 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0060424 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> gambogi </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0007554 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0031650 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> geoparque </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0006868 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0028773 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> grutas </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0004807 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0020141 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> unesco </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0013049 </td>
   <td style="text-align:right;"> 1.481604 </td>
   <td style="text-align:right;"> 0.0019333 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> dieste </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0010301 </td>
   <td style="text-align:right;"> 1.791759 </td>
   <td style="text-align:right;"> 0.0018458 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> residuos </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0012362 </td>
   <td style="text-align:right;"> 1.481604 </td>
   <td style="text-align:right;"> 0.0018315 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> circular </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0012362 </td>
   <td style="text-align:right;"> 1.193922 </td>
   <td style="text-align:right;"> 0.0014759 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> reutilizacion </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0004121 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0014408 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> reciclaje </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0004807 </td>
   <td style="text-align:right;"> 2.803360 </td>
   <td style="text-align:right;"> 0.0013477 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> 19.210 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0008928 </td>
   <td style="text-align:right;"> 1.417066 </td>
   <td style="text-align:right;"> 0.0012652 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> geologico </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0003434 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0012006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> lezica </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0003434 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0012006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> coetc </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0002747 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0011509 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-22 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-06-22_22 </td>
   <td style="text-align:left;"> recicladas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 14561 </td>
   <td style="text-align:right;"> 0.0002747 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0011509 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> huelga </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0023405 </td>
   <td style="text-align:right;"> 1.2452158 </td>
   <td style="text-align:right;"> 0.0029145 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> golpe </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0031025 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0026603 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> resistencia </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0028848 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0024736 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> 19.211 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0005987 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0020935 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> obrera </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0005443 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0012213 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> rusch </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0002722 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0011402 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> 1973 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0010342 </td>
   <td style="text-align:right;"> 0.9707789 </td>
   <td style="text-align:right;"> 0.0010040 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> cnt </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0011430 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0009801 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> fabricas </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0005443 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0008843 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> dictadura </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0021772 </td>
   <td style="text-align:right;"> 0.3610133 </td>
   <td style="text-align:right;"> 0.0007860 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> teja </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0002722 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007629 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> vestigios </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0002722 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0007629 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> madrugada </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0003810 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0007591 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> michelini </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0004354 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0007075 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-13_21 </td>
   <td style="text-align:left;"> anonimos </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 18372 </td>
   <td style="text-align:right;"> 0.0003266 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0006892 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> leones </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0064635 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0154989 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> clubes </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0032318 </td>
   <td style="text-align:right;"> 1.1939225 </td>
   <td style="text-align:right;"> 0.0038585 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> leonismo </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0007387 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0025828 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> jones </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0005540 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0023211 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> club </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0026777 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0021113 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> melvin </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0004617 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0019343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> paulo </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0004617 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0019343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> sao </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0004617 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0019343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> cabt </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0015474 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> toxinicas </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0015474 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> farc </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0012914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> zaragoza </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0011417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> chicago </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0004617 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0011071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> gimenez </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010354 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> universalidad </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10830 </td>
   <td style="text-align:right;"> 0.0003693 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010354 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> branco </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0039016 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0077737 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> paranhos </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0019055 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0066624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> baron </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0014518 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0044875 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> zeballos </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0012703 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0044416 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> yaguaron </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0005444 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0019036 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> ultimatum </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0004537 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0019008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> brasil </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0053534 </td>
   <td style="text-align:right;"> 0.2978344 </td>
   <td style="text-align:right;"> 0.0015944 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> emperador </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0004537 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0015863 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> guayana </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0003629 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0015206 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> merin </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0005444 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0014047 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> acre </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0004537 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0014023 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> liverpool </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0003629 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0012690 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> canciller </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0007259 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0011794 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> cyssa </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0002722 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0011405 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-18_9 </td>
   <td style="text-align:left;"> junior </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 11021 </td>
   <td style="text-align:right;"> 0.0002722 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0011405 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> palestino </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0054605 </td>
   <td style="text-align:right;"> 2.580217 </td>
   <td style="text-align:right;"> 0.0140892 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> palestina </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0057755 </td>
   <td style="text-align:right;"> 2.397895 </td>
   <td style="text-align:right;"> 0.0138490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> palestinos </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0027302 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0084393 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> israel </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0026252 </td>
   <td style="text-align:right;"> 1.550597 </td>
   <td style="text-align:right;"> 0.0040707 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> abbas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0006301 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0026397 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> jerusalen </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0010501 </td>
   <td style="text-align:right;"> 2.110213 </td>
   <td style="text-align:right;"> 0.0022159 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> inalienables </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0006301 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0019475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> israeli </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0006301 </td>
   <td style="text-align:right;"> 3.091042 </td>
   <td style="text-align:right;"> 0.0019475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> israelies </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0005250 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0018358 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> abdel </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0004200 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0017598 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> cisjordania </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0004200 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0017598 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> gaza </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0004200 </td>
   <td style="text-align:right;"> 3.496508 </td>
   <td style="text-align:right;"> 0.0014687 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> 181 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0007351 </td>
   <td style="text-align:right;"> 1.887070 </td>
   <td style="text-align:right;"> 0.0013871 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> balfour </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0003150 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0013199 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> oslo </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0003150 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0013199 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-12-06_55 </td>
   <td style="text-align:left;"> palestinas </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9523 </td>
   <td style="text-align:right;"> 0.0003150 </td>
   <td style="text-align:right;"> 4.189655 </td>
   <td style="text-align:right;"> 0.0013199 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> licandro </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0081400 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0284617 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0062144 </td>
   <td style="text-align:right;"> 0.5260931 </td>
   <td style="text-align:right;"> 0.0032694 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> victor </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0026258 </td>
   <td style="text-align:right;"> 1.0541605 </td>
   <td style="text-align:right;"> 0.0027680 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> bayley </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0005252 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0022003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> aa </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0004376 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0015302 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> ff </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0004376 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0015302 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> zufriategui </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0004376 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0015302 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> 138º </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0003501 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0014668 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> autocritico </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0003501 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0014668 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> militares </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0018381 </td>
   <td style="text-align:right;"> 0.7239188 </td>
   <td style="text-align:right;"> 0.0013306 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> ejercitos </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0003501 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0012242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> seregni </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0007002 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0011937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> armadas </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0014004 </td>
   <td style="text-align:right;"> 0.7884574 </td>
   <td style="text-align:right;"> 0.0011042 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> notaba </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0002626 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0011001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-14 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2018-03-14_5 </td>
   <td style="text-align:left;"> enfrentaron </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11425 </td>
   <td style="text-align:right;"> 0.0004376 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0010494 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> provincia </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0016955 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0022999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> provincias </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0009689 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0021739 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> 1817 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0007267 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0018749 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> instrucciones </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0010900 </td>
   <td style="text-align:right;"> 1.4170660 </td>
   <td style="text-align:right;"> 0.0015446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0139276 </td>
   <td style="text-align:right;"> 0.0953102 </td>
   <td style="text-align:right;"> 0.0013274 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> orientales </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0009689 </td>
   <td style="text-align:right;"> 1.3564414 </td>
   <td style="text-align:right;"> 0.0013142 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> 1956 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0006055 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0012778 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> burgos </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0011231 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> dimitrioff </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0011231 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> lust </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0011231 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> empoderamiento </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0004844 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0010870 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> liberal </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0006055 </td>
   <td style="text-align:right;"> 1.7047481 </td>
   <td style="text-align:right;"> 0.0010323 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> irma </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> milesi </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> virreinato </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-13 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-13_19 </td>
   <td style="text-align:left;"> zavalkin </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 8257 </td>
   <td style="text-align:right;"> 0.0003633 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0010185 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> metalurgico </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0019461 </td>
   <td style="text-align:right;"> 2.8033604 </td>
   <td style="text-align:right;"> 0.0054555 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> cuesta </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0060235 </td>
   <td style="text-align:right;"> 0.5520686 </td>
   <td style="text-align:right;"> 0.0033254 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> comunista </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0027801 </td>
   <td style="text-align:right;"> 1.1451323 </td>
   <td style="text-align:right;"> 0.0031836 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> obrero </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0023167 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0030101 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> obrera </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0012047 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0027031 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> mazzarovich </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0005560 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0023295 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> sindicato </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0021314 </td>
   <td style="text-align:right;"> 1.0116009 </td>
   <td style="text-align:right;"> 0.0021561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> pietrarroia </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0004633 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0019413 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> cnt </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0021314 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0018276 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> sindicalista </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0007414 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0017777 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> sindical </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0020387 </td>
   <td style="text-align:right;"> 0.8574502 </td>
   <td style="text-align:right;"> 0.0017481 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> cofundador </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0004633 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0016201 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> soefapa </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0003707 </td>
   <td style="text-align:right;"> 4.1896547 </td>
   <td style="text-align:right;"> 0.0015530 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> metalurgicos </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0004633 </td>
   <td style="text-align:right;"> 3.0910425 </td>
   <td style="text-align:right;"> 0.0014322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-06 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-09-06_37 </td>
   <td style="text-align:left;"> castillo </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10791 </td>
   <td style="text-align:right;"> 0.0005560 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0011733 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> desnutricion </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0018141 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0043501 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> alimentacion </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0046051 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0042899 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> hambre </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0044655 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0041599 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> obesidad </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0015350 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0034442 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> malnutricion </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0012559 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0032406 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> alimentos </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0032096 </td>
   <td style="text-align:right;"> 0.9315582 </td>
   <td style="text-align:right;"> 0.0029899 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> fao </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0012559 </td>
   <td style="text-align:right;"> 2.2437446 </td>
   <td style="text-align:right;"> 0.0028180 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> alimentario </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0006977 </td>
   <td style="text-align:right;"> 3.4965076 </td>
   <td style="text-align:right;"> 0.0024397 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> semillas </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0013955 </td>
   <td style="text-align:right;"> 1.6247054 </td>
   <td style="text-align:right;"> 0.0022672 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> alimentaria </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0015350 </td>
   <td style="text-align:right;"> 1.2992830 </td>
   <td style="text-align:right;"> 0.0019944 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> nutricion </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0009768 </td>
   <td style="text-align:right;"> 1.9924302 </td>
   <td style="text-align:right;"> 0.0019463 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> nutrientes </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0006977 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0018003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> frentes </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0006977 </td>
   <td style="text-align:right;"> 2.1102132 </td>
   <td style="text-align:right;"> 0.0014724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> agricultores </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0005582 </td>
   <td style="text-align:right;"> 2.5802168 </td>
   <td style="text-align:right;"> 0.0014403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-10-11_45 </td>
   <td style="text-align:left;"> sobrepeso </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 7166 </td>
   <td style="text-align:right;"> 0.0005582 </td>
   <td style="text-align:right;"> 2.3978953 </td>
   <td style="text-align:right;"> 0.0013385 </td>
  </tr>
</tbody>
</table>



## Senadores


```r
sesion_senadores_words <- senadores %>%
  unnest_tokens(word, pdf) %>%
  count(fecha, sesion, fecha_sesion, word, sort = TRUE) %>%
  ungroup()

senadores_words <- sesion_senadores_words %>% 
  group_by(fecha_sesion) %>% 
  summarize(total = sum(n))

sesion_senadores_tfidf <- left_join(sesion_senadores_words, senadores_words) %>%
  bind_tf_idf(word, fecha_sesion, n) 

for (i in unique(sesion_senadores_tfidf$fecha_sesion)){
  sesion_senadores_tfidf %>%
    filter(fecha_sesion == i) %>%
    arrange(desc(tf_idf)) %>%
    mutate(word = factor(word, levels = rev(unique(word)))) %>%
    top_n(15, tf_idf) %>%
    knitr::kable(format = "html") %>%
    print(kableExtra::kable_styling(full_width = F))
  cat("\n")
}
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 236 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0023114 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0018068 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> 000.000 </td>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0022037 </td>
   <td style="text-align:right;"> 0.7102416 </td>
   <td style="text-align:right;"> 0.0015651 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> gasto </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0012243 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0013244 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 433 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0042408 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0012440 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> deficit </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0008619 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0012398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> rendicion </td>
   <td style="text-align:right;"> 172 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0016846 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0009788 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> impuestos </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0008619 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0009324 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> tasa </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0008521 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0009218 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> erratas </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0002155 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0008786 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> consular </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0003820 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0008731 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> astori </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0004211 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0008415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> cuentas </td>
   <td style="text-align:right;"> 213 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0020861 </td>
   <td style="text-align:right;"> 0.3886580 </td>
   <td style="text-align:right;"> 0.0008108 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:right;"> 631 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0061800 </td>
   <td style="text-align:right;"> 0.1262937 </td>
   <td style="text-align:right;"> 0.0007805 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> pbi </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0003036 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0006472 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> inumet </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0001469 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0005990 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-18 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 2017-09-18_32 </td>
   <td style="text-align:left;"> scavarelli </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 102103 </td>
   <td style="text-align:right;"> 0.0001469 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0005990 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> matricula </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0007925 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0023607 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> egreso </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0008931 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0022043 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> educativos </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0015346 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0020026 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> educativa </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0013711 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0017892 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> educativo </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0017359 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0017124 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> anep </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0010692 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0016173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> ministra </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0013334 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0015108 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> docentes </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0012831 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0013880 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> codicen </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0007547 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0013396 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> pisa </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0004780 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0012864 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> estudiantes </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0011573 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0011955 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> netto </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0003522 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0011920 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> curricular </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0004780 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0011798 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> centros </td>
   <td style="text-align:right;"> 131 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0016478 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0011145 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-26 </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 2017-04-26_9 </td>
   <td style="text-align:left;"> promejora </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 79498 </td>
   <td style="text-align:right;"> 0.0002642 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010771 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 289 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0051611 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0026951 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 505 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0090185 </td>
   <td style="text-align:right;"> 0.2708750 </td>
   <td style="text-align:right;"> 0.0024429 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> mujeres </td>
   <td style="text-align:right;"> 236 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0042146 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0022008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> basada </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0012144 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0013137 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 243 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0043396 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0012730 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0016965 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0012645 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0006965 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0010019 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> penas </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0005000 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0009402 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0006786 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0009294 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> sustitutivo </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0006429 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0009248 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> victima </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0006072 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0009184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> ninas </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0005893 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0008071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> directrices </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0003215 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0006852 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> genero </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0020894 </td>
   <td style="text-align:right;"> 0.3163373 </td>
   <td style="text-align:right;"> 0.0006610 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-15 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2017-11-15_42 </td>
   <td style="text-align:left;"> adolescentes </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 55996 </td>
   <td style="text-align:right;"> 0.0005179 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0005868 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> upm </td>
   <td style="text-align:right;"> 266 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0041978 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0063496 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> inversion </td>
   <td style="text-align:right;"> 157 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0024777 </td>
   <td style="text-align:right;"> 0.8194409 </td>
   <td style="text-align:right;"> 0.0020303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> ppp </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0006313 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0018805 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> viaducto </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0004103 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016731 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> celulosa </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0008680 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0016321 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> contrato </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0020200 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0015790 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> biomasa </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0003314 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013513 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> planta </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0016570 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0012953 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0015781 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0012336 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> ferrocarril </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0004103 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012223 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> ferroviario </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0004419 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0011892 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> ferrea </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0003472 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0011750 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> franca </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0005681 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0011352 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> pregunta </td>
   <td style="text-align:right;"> 101 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0015939 </td>
   <td style="text-align:right;"> 0.6118015 </td>
   <td style="text-align:right;"> 0.0009752 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-28 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 2017-11-28_44 </td>
   <td style="text-align:left;"> toros </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 63366 </td>
   <td style="text-align:right;"> 0.0004103 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0009379 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 825 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0231131 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0134294 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> lavado </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0022973 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0024852 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> gafi </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0005323 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0021705 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> 14294 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0005323 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0018015 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> capitulo </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0019331 </td>
   <td style="text-align:right;"> 0.8586616 </td>
   <td style="text-align:right;"> 0.0016599 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> activos </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0018491 </td>
   <td style="text-align:right;"> 0.8586616 </td>
   <td style="text-align:right;"> 0.0015877 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> contadores </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0005883 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0015834 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> terrorismo </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0010926 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0014963 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> colegio </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0008405 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0013386 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> delito </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0012327 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0012734 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> penas </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0005603 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0010536 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> compilacion </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0002802 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0009482 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> delitos </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0011767 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0009198 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> 18494 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0003082 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009180 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-09 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 2017-08-09_29 </td>
   <td style="text-align:left;"> confeccion </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 35694 </td>
   <td style="text-align:right;"> 0.0003082 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009180 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> publicidad </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0015962 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0021860 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> campanas </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0014011 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0021193 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> electorales </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0010109 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0017943 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> donaciones </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0007804 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0014673 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 273 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0048418 </td>
   <td style="text-align:right;"> 0.2708750 </td>
   <td style="text-align:right;"> 0.0013115 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> electoral </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0024475 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0012781 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> candidatos </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0006562 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0010451 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> financiamiento </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0010996 </td>
   <td style="text-align:right;"> 0.9420432 </td>
   <td style="text-align:right;"> 0.0010359 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> listas </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0005853 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0009321 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> television </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0007272 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0008633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> coriun </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0001951 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0007955 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> donar </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0002660 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0007925 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> canales </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0003547 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0007561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> elecciones </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0006562 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0006779 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-01 </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 2017-11-01_38 </td>
   <td style="text-align:left;"> financiacion </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 56384 </td>
   <td style="text-align:right;"> 0.0007804 </td>
   <td style="text-align:right;"> 0.8586616 </td>
   <td style="text-align:right;"> 0.0006701 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> delito </td>
   <td style="text-align:right;"> 215 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0034408 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0035544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> corrupcion </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0016324 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0027418 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> abuso </td>
   <td style="text-align:right;"> 168 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0026886 </td>
   <td style="text-align:right;"> 0.8994836 </td>
   <td style="text-align:right;"> 0.0024184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> derogacion </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0011042 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0022064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> 162 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0013283 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0015769 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> aller </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0004321 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0014624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> funciones </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0020805 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0014071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> arbitrario </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0005281 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0013034 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 259 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0041449 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0012159 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> derogar </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0006401 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0011362 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> cohecho </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0002721 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011093 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> penal </td>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0034248 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0010046 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> delitos </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0012643 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0009883 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> catedras </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0003841 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0008779 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-07 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2017-06-07_18 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 62486 </td>
   <td style="text-align:right;"> 0.0019844 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0008215 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> afap </td>
   <td style="text-align:right;"> 144 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0026242 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0078173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> cincuentones </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0009112 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0022489 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> mixto </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0007472 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0022258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> 16713 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0007107 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0019127 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> rentabilidad </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0006925 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0014761 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> prevision </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0016401 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0012821 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> astori </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0005832 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0011652 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> clientelismo </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0003827 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0010299 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> jubilacion </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0006925 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0009961 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> murro </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0004009 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0009895 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> jubilaciones </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0005103 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0009594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> bps </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0005649 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0008997 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0011299 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0008832 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> 000.000 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0012028 </td>
   <td style="text-align:right;"> 0.7102416 </td>
   <td style="text-align:right;"> 0.0008542 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-20 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 2017-12-20_51 </td>
   <td style="text-align:left;"> previsional </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 54874 </td>
   <td style="text-align:right;"> 0.0002734 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0008143 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> moratoria </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0008878 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0026447 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> fracking </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0011456 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0026185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 438 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0125440 </td>
   <td style="text-align:right;"> 0.1655144 </td>
   <td style="text-align:right;"> 0.0020762 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> nocturno </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0006873 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0016964 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> extradicion </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0008019 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0016023 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> acuifero </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0005155 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0015357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:right;"> 424 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0121431 </td>
   <td style="text-align:right;"> 0.0885534 </td>
   <td style="text-align:right;"> 0.0010753 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> passa </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0003150 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010662 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> petroleo </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0007160 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0010299 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> ribeiro </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0003437 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0010238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> convencionales </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0004582 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0009768 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> electrica </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0004869 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0008642 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> hidrocarburos </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0004296 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0008584 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> prohibicion </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0006873 </td>
   <td style="text-align:right;"> 1.2443241 </td>
   <td style="text-align:right;"> 0.0008553 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-19 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 2017-12-19_50 </td>
   <td style="text-align:left;"> g </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 34917 </td>
   <td style="text-align:right;"> 0.0003723 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0008510 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 541 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0173804 </td>
   <td style="text-align:right;"> 0.1857171 </td>
   <td style="text-align:right;"> 0.0032278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> cayota </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0006104 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0020658 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> greiver </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0004819 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0016309 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> israel </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0008032 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0014256 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> 266.6 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0003213 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> embajador </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0012851 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0012677 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> benavides </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0002891 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011790 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> juez </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0011566 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0011409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> audiencia </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0005140 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0010957 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> reanimacion </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0002570 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010480 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> sustituye </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0011566 </td>
   <td style="text-align:right;"> 0.8994836 </td>
   <td style="text-align:right;"> 0.0010403 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> acusatorio </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0003534 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0008722 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> bosco </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0002570 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0008698 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> mario </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0005783 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0007919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> 259.1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0001928 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0007860 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-03 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 2017-10-03_33 </td>
   <td style="text-align:left;"> homologadores </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 31127 </td>
   <td style="text-align:right;"> 0.0001928 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0007860 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> armadas </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0040354 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0039809 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> impuesto </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0024572 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0027842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> caja </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0023174 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0026258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> retiros </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0012785 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0025547 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> retirados </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0005594 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0022808 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> fuerzas </td>
   <td style="text-align:right;"> 206 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0041153 </td>
   <td style="text-align:right;"> 0.4940185 </td>
   <td style="text-align:right;"> 0.0020330 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> jubilaciones </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0010788 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0020284 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> pensiones </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0014384 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0019698 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> deficit </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0012586 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0018104 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> militares </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0018978 </td>
   <td style="text-align:right;"> 0.8586616 </td>
   <td style="text-align:right;"> 0.0016296 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> iass </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0004595 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0013687 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> militar </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0023373 </td>
   <td style="text-align:right;"> 0.5511769 </td>
   <td style="text-align:right;"> 0.0012883 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> soldados </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0006193 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0011645 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> previsional </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0003796 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0011307 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-29 </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2017-11-29_45 </td>
   <td style="text-align:left;"> retiro </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 50057 </td>
   <td style="text-align:right;"> 0.0007991 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0010943 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> productores </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0027451 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0028357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> lechero </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0010145 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0027302 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> gasoil </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0013526 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0025434 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> endeudamiento </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0011537 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0023053 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> leche </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0016311 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0021285 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0025461 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0019903 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> lecheros </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0007360 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0016823 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> agro </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0007161 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0016369 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 111 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0022080 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0014210 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> precios </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0009150 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0013841 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> competitividad </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0007758 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0013770 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> 000.000 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0018102 </td>
   <td style="text-align:right;"> 0.7102416 </td>
   <td style="text-align:right;"> 0.0012856 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> lecheria </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0006564 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0012343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> inale </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0004973 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0012274 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-07 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2018-02-07_55 </td>
   <td style="text-align:left;"> tributan </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 50272 </td>
   <td style="text-align:right;"> 0.0003581 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0012118 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> mujeres </td>
   <td style="text-align:right;"> 346 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0074811 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0039065 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> cuota </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0019892 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0023615 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> suplencias </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0005189 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0021159 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0024432 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0018210 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> paridad </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0008216 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0017514 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> listas </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0010378 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0016529 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 176 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0038054 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0013850 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> minimalista </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0003243 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013224 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> cuotas </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0008649 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0012441 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> hombres </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0020973 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0012186 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> circunscripciones </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0002162 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0008816 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> electivos </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0002595 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0007729 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> igualdad </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0010378 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0006679 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> parlatino </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0002595 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0006404 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-15 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 2017-03-15_4 </td>
   <td style="text-align:left;"> avance </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 46250 </td>
   <td style="text-align:right;"> 0.0009297 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0006288 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 428 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0143788 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0083545 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> 18308 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0010415 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0031024 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> directrices </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0012766 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0027213 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> cancela </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0006719 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0022740 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> intendentes </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0015118 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0019728 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> mutua </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0012430 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0017023 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> aduanera </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0007391 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0014768 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> departamentales </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0017470 </td>
   <td style="text-align:right;"> 0.8194409 </td>
   <td style="text-align:right;"> 0.0014315 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> aduaneros </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0006047 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0013822 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> congreso </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0012094 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0013704 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> dinot </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0003360 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013699 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> sostenible </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0008735 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0010370 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> corea </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0003695 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0009121 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> aduaneras </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0003360 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0009041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-08 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 2017-08-08_28 </td>
   <td style="text-align:left;"> ordenamiento </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 29766 </td>
   <td style="text-align:right;"> 0.0025868 </td>
   <td style="text-align:right;"> 0.3398678 </td>
   <td style="text-align:right;"> 0.0008792 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> riego </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0015934 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0025377 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> centros </td>
   <td style="text-align:right;"> 142 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0037092 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0025087 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> agua </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0022725 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0016938 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> patologias </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0007053 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0016121 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> imae </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0004179 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012450 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> patologia </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0003135 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> regar </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0002873 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0009724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> prevalencia </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0003657 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0009026 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> medicina </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0006008 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0008642 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> aguas </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0006269 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0008181 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> ecologico </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0002351 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0007956 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> lobos </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0002351 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0007956 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> asistencial </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0002612 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0007781 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> centro </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0015934 </td>
   <td style="text-align:right;"> 0.4666195 </td>
   <td style="text-align:right;"> 0.0007435 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-18 </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 2017-10-18_37 </td>
   <td style="text-align:left;"> productividad </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 38283 </td>
   <td style="text-align:right;"> 0.0003657 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0007307 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> victimas </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0024381 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0026375 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> explotacion </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0019890 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0023612 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> trafico </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0016361 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0022406 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 217 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0069614 </td>
   <td style="text-align:right;"> 0.2708750 </td>
   <td style="text-align:right;"> 0.0018857 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0011228 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0016151 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> esclavo </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0004491 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0015200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> esclavitud </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0006416 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0013677 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 127 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0040742 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0011951 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> ninas </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0008662 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0011862 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> combate </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0007378 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0010614 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> forzado </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0002566 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010465 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> reparacion </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0003850 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0008799 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> victima </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0005774 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0008734 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> prostitucion </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0002566 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0008686 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-14 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 2017-11-14_41 </td>
   <td style="text-align:left;"> delito </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 31172 </td>
   <td style="text-align:right;"> 0.0008341 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0008616 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> mevir </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0035100 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0065999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> gallinal </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0016360 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0040379 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 171 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0050866 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0029554 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> insalubre </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0008626 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0025697 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> colonizacion </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0012196 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0018447 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> 11029 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0007139 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0017620 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> espectaculos </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0005949 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0016011 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> vanerio </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0005354 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0015950 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> campos </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0012196 </td>
   <td style="text-align:right;"> 1.2443241 </td>
   <td style="text-align:right;"> 0.0015176 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> rancherios </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0003570 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014555 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> rural </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0024987 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0014518 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> erradicacion </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0005949 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0013599 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> hectareas </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0008031 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0013490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> coneat </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0004759 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0012809 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> colonizador </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0002677 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010916 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-02 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 2017-08-02_27 </td>
   <td style="text-align:left;"> producidas </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 33618 </td>
   <td style="text-align:right;"> 0.0002677 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010916 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> mln </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0011433 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0046620 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> vica </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0009923 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0040462 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> font </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0007766 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0031666 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> urruzola </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0009923 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0029560 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> investigadora </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0014669 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0027582 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> tupamaros </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0009276 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0024964 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> fiscala </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0007982 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0023777 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> tocan </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0006687 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0022633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> investigar </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0010355 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0020690 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> libro </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0018768 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0020303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> zabalza </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0004746 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0019352 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> bandas </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0006256 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0018636 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> llorente </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0004530 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0018472 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0034084 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0014110 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-21 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2017-06-21_20 </td>
   <td style="text-align:left;"> mpp </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 46356 </td>
   <td style="text-align:right;"> 0.0004530 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0013495 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> bolsas </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0036275 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0077324 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> plasticas </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0019843 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0053401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> pluna </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0020153 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0035770 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> plastico </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0005891 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0019937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0077820 </td>
   <td style="text-align:right;"> 0.1655144 </td>
   <td style="text-align:right;"> 0.0012880 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> remate </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0004341 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0010713 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> bolsa </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0007441 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0010704 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> autonomo </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0006201 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0010415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> residuos </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0004341 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0009922 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> medioambiente </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0006511 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0009848 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> ente </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0008991 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0009727 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> plastica </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0002790 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0009444 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0011471 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0008967 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> biodegradables </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0001860 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0007585 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-06 </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 2017-12-06_47 </td>
   <td style="text-align:left;"> varig </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 32254 </td>
   <td style="text-align:right;"> 0.0001860 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0007585 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> palestina </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0015098 </td>
   <td style="text-align:right;"> 2.285778 </td>
   <td style="text-align:right;"> 0.0034510 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> dieste </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0017204 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0032350 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> terra </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0013693 </td>
   <td style="text-align:right;"> 1.998096 </td>
   <td style="text-align:right;"> 0.0027361 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> palestino </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0008076 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0024056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> subsidio </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0012289 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0023107 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> eladio </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0011938 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0022447 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> palestinos </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0005969 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0020201 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> israel </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0010182 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0018073 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> noviembre </td>
   <td style="text-align:right;"> 177 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0062147 </td>
   <td style="text-align:right;"> 0.270875 </td>
   <td style="text-align:right;"> 0.0016834 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> gregorio </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0007724 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0016466 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> rocanova </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0005969 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0016064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> 13728 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0007022 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0014969 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> arquitecto </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0007724 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0013711 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> lucio </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0006320 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0013472 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-22 </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 2017-11-22_43 </td>
   <td style="text-align:left;"> aladi </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 28481 </td>
   <td style="text-align:right;"> 0.0004916 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0012132 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> riego </td>
   <td style="text-align:right;"> 245 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0077032 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0122683 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> agua </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0049049 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0036558 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> agrarias </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0009118 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0022504 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> 16858 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0007546 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0020308 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> hidraulicas </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0004087 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016667 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> agrario </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0007232 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0016530 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> productividad </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0007232 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0014449 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> multipredial </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0004087 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013833 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> agropecuaria </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0005974 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0012734 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> asociaciones </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0006288 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0012565 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> gravamen </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0004087 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012176 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> hectareas </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0006917 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0011618 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> asociativos </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0002830 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011538 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> agricola </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0007232 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0011517 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-05 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 2017-07-05_23 </td>
   <td style="text-align:left;"> produccion </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 31805 </td>
   <td style="text-align:right;"> 0.0021695 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0011329 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> disenadores </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004038 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0016466 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> discapacidad </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0010279 </td>
   <td style="text-align:right;"> 1.512588 </td>
   <td style="text-align:right;"> 0.0015548 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> lanas </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0003671 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0014969 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> tapie </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0005140 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0013832 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> vuelos </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0005140 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0013832 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> pineyro </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004405 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0013123 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> interparlamentaria </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0008076 </td>
   <td style="text-align:right;"> 1.592631 </td>
   <td style="text-align:right;"> 0.0012863 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> medicamentos </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004772 </td>
   <td style="text-align:right;"> 2.285778 </td>
   <td style="text-align:right;"> 0.0010909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> evaristo </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004038 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0010868 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> visual </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004038 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0010868 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> vareliana </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0003304 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0009842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> farmaco </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0002203 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0008981 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> moweek </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0002203 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0008981 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> ramon </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004772 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0008974 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-11 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2017-07-11_24 </td>
   <td style="text-align:left;"> mattos </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 27240 </td>
   <td style="text-align:right;"> 0.0004038 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0008608 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> publicidad </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0015431 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0021133 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> suprema </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0025433 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0017201 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> canales </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0007144 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0015229 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> corte </td>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0046008 </td>
   <td style="text-align:right;"> 0.3163373 </td>
   <td style="text-align:right;"> 0.0014554 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> inconstitucional </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0009430 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0014264 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> electoral </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0027148 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0014176 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> gratuita </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0007430 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0013970 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> elector </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0004572 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0013620 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> propaganda </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0006573 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0013133 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> canal </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0006858 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0012896 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> campanas </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0007430 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0011238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> electorales </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0006287 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0011159 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> television </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0009144 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0010856 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> votos </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0010002 </td>
   <td style="text-align:right;"> 0.8194409 </td>
   <td style="text-align:right;"> 0.0008196 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-07 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2017-11-07_39 </td>
   <td style="text-align:left;"> inconstitucionalidad </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 34994 </td>
   <td style="text-align:right;"> 0.0005715 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0007827 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> agosto </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0103275 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0060006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> terminal </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0014401 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0019722 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> japon </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0010286 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0018258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> ferrer </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0005349 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0018103 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> ninez </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0008641 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0014513 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> adolescencia </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0007818 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0013131 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> concesionario </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0004115 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012257 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> mena </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0004526 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0012181 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> cipreses </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0002880 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011744 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> concesion </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0006172 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0009335 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> empresario </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0005349 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0008519 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> padrones </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0006172 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0008452 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> fluviomaritima </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0003703 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0007894 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> adolescentes </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0006583 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0007460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-08-23 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2017-08-23_30 </td>
   <td style="text-align:left;"> maua </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 24304 </td>
   <td style="text-align:right;"> 0.0003703 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0007399 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0076120 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0031512 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> provincias </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0024888 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> bandera </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0024136 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0023810 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> ilicitamente </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0006498 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0021992 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> exportados </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0006498 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0019357 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> posgrado </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0019097 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> maglio </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0004641 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0018926 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> artigas </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0045486 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0018830 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> restitucion </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0006962 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0018737 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> izamiento </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0004177 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017033 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> cumparsita </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0006034 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0016239 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> transferidos </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0006034 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0016239 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0049199 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0014433 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> lausarot </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0005106 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0013740 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-06 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2017-06-06_17 </td>
   <td style="text-align:left;"> guayabos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 21545 </td>
   <td style="text-align:right;"> 0.0003249 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013248 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> subsidio </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0033788 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0063531 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> vicepresidente </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0023651 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0023332 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> renuncia </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0019522 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0023176 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> quintos </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0004130 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016839 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> sandin </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0004130 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013976 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0040921 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0012004 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 167 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0062695 </td>
   <td style="text-align:right;"> 0.1857171 </td>
   <td style="text-align:right;"> 0.0011643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> legislador </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0012389 </td>
   <td style="text-align:right;"> 0.8994836 </td>
   <td style="text-align:right;"> 0.0011144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> bentancour </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0003003 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010164 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> tusso </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0003003 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010164 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> suarez </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0006382 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0010164 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> exvicepresidente </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0003754 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0010103 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> aceitunas </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0003379 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0010065 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> nodale </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0003379 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0010065 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-10 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 2017-10-10_34 </td>
   <td style="text-align:left;"> justino </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 26637 </td>
   <td style="text-align:right;"> 0.0002253 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0009185 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> femicidio </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0016018 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0026905 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> mujeres </td>
   <td style="text-align:right;"> 111 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0039512 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0020633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0039156 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0020447 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> penas </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0008543 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0016064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> dominacion </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0005339 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0015906 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> kelland </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0003916 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013252 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> mata </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0005339 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0012205 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> sexual </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0008187 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0011777 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> masculinidad </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0002848 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011612 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> feminicidio </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0004627 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0011421 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0014950 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0011143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0007475 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0010237 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> abril </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0033816 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0009920 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> expareja </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0002848 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0009638 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-18 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 2017-04-18_8 </td>
   <td style="text-align:left;"> delito </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 28093 </td>
   <td style="text-align:right;"> 0.0009255 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0009561 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> sitios </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0027872 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0075010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> sienra </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0012053 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0040791 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> memoria </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0051601 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0040336 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> wilson </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0032015 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0036276 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> susana </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0025612 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0027707 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> exilio </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0010546 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0021072 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> dictadura </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0020716 </td>
   <td style="text-align:right;"> 0.8994836 </td>
   <td style="text-align:right;"> 0.0018633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> victimas </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0012053 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0013039 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> violaciones </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0007533 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0012653 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> 1973 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0006780 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0010797 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> reparacion </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0004520 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0010331 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> memo </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0003013 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010198 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0012806 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0009545 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> presos </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0005650 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0008998 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-05 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 2017-12-05_46 </td>
   <td style="text-align:left;"> sapelli </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 26550 </td>
   <td style="text-align:right;"> 0.0003013 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0008976 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> acv </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0013229 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0044773 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> palestina </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0014993 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0034271 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> cuba </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0012788 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0022699 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> scarpa </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0006615 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0022386 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> cassinelli </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0007497 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0022332 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> sahara </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0004851 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0019779 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> embajador </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0015434 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0015226 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> neurocirugia </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0004410 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0014924 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> lorier </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0016757 </td>
   <td style="text-align:right;"> 0.8586616 </td>
   <td style="text-align:right;"> 0.0014389 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> saharaui </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0003528 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014385 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> certificado </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0007056 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0014098 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> sandro </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0003087 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012587 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> agronomo </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0003528 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0011939 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> defuncion </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0004851 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0011088 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-12 </td>
   <td style="text-align:left;"> 48 </td>
   <td style="text-align:left;"> 2017-12-12_48 </td>
   <td style="text-align:left;"> occidental </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 22677 </td>
   <td style="text-align:right;"> 0.0004410 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0010884 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> nicolich </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0018011 </td>
   <td style="text-align:right;"> 2.285778 </td>
   <td style="text-align:right;"> 0.0041168 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> seregni </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0022629 </td>
   <td style="text-align:right;"> 1.512588 </td>
   <td style="text-align:right;"> 0.0034228 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> unificacion </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0011083 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0023626 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> aeroparque </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0007851 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0023387 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> municipio </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0016163 </td>
   <td style="text-align:right;"> 1.369487 </td>
   <td style="text-align:right;"> 0.0022135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> sindical </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0017549 </td>
   <td style="text-align:right;"> 0.986495 </td>
   <td style="text-align:right;"> 0.0017312 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> liber </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0014778 </td>
   <td style="text-align:right;"> 1.133099 </td>
   <td style="text-align:right;"> 0.0016745 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> charrua </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0005080 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0013671 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> tato </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0003233 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0013181 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> congreso </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0011083 </td>
   <td style="text-align:right;"> 1.133099 </td>
   <td style="text-align:right;"> 0.0012559 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> monedas </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0010622 </td>
   <td style="text-align:right;"> 1.081805 </td>
   <td style="text-align:right;"> 0.0011490 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> vidart </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0002771 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0011298 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> sgarbi </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0003694 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0011006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> fagundez </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0003233 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0010941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-02 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 2017-05-02_10 </td>
   <td style="text-align:left;"> cnt </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 21654 </td>
   <td style="text-align:right;"> 0.0007389 </td>
   <td style="text-align:right;"> 1.304949 </td>
   <td style="text-align:right;"> 0.0009642 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> francas </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0058381 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0116651 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> franca </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0025880 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0051711 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0125188 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0045564 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> zonas </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0070418 </td>
   <td style="text-align:right;"> 0.4940185 </td>
   <td style="text-align:right;"> 0.0034788 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> audiovisuales </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0009028 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0026894 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> desarrolladores </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0006621 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0022406 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> 15921 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0007222 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0016509 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> dgi </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0008426 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0015844 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> tematicas </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0006621 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0014112 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> florida </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0010232 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0013352 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> aditivo </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0007222 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0012819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> usuarios </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0009630 </td>
   <td style="text-align:right;"> 1.2443241 </td>
   <td style="text-align:right;"> 0.0011983 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> azar </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0004213 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0011338 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> juegos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0004213 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0010398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> entretenimiento </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0003611 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0009719 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-21 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 2017-03-21_5 </td>
   <td style="text-align:left;"> esparcimiento </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16615 </td>
   <td style="text-align:right;"> 0.0003611 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0009719 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> mujeres </td>
   <td style="text-align:right;"> 229 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0092094 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0048090 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0040216 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0029974 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> paramos </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0006434 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0017317 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> nosotras </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0007239 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0014464 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> violencia </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0027347 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0014280 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0036194 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0013173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> embarazo </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0005228 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0011950 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> igualdad </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0017695 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0011388 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> movilizacion </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0004826 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0011031 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> domestica </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0007239 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0009913 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> hombres </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0016086 </td>
   <td style="text-align:right;"> 0.5810299 </td>
   <td style="text-align:right;"> 0.0009347 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> muje </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0003217 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0007354 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> muertas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0002413 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0007188 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> luchamos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0002815 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0006948 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-08 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 2017-03-08_2 </td>
   <td style="text-align:left;"> varones </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 24866 </td>
   <td style="text-align:right;"> 0.0003619 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0006806 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0030392 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0023757 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> 000.000 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0028872 </td>
   <td style="text-align:right;"> 0.7102416 </td>
   <td style="text-align:right;"> 0.0020506 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> transaccion </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0008738 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0019972 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> ministros </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0020894 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0016333 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> colectivos </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0012537 </td>
   <td style="text-align:right;"> 1.2443241 </td>
   <td style="text-align:right;"> 0.0015600 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> advertencias </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0004559 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0015429 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> enganchados </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0003419 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> enganche </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0003419 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0013941 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> judicial </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0022034 </td>
   <td style="text-align:right;"> 0.6118015 </td>
   <td style="text-align:right;"> 0.0013480 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0017475 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0013025 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> magistrados </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0006838 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0011486 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> presidenta </td>
   <td style="text-align:right;"> 96 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0036470 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0010698 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> inconstitucional </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0006838 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0010343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> advertido </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0004939 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0009868 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-08 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 2017-02-08_55 </td>
   <td style="text-align:left;"> suprema </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 26323 </td>
   <td style="text-align:right;"> 0.0014436 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0009764 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> sobrevivientes </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0009241 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0027530 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> paez </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0006161 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0025122 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> andes </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0008856 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0021858 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> rugby </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0006161 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0020851 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> terminal </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0012707 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0017402 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> tragedia </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0011937 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0016347 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> alud </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0003851 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0015701 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> mena </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0005776 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0015544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> montana </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0005006 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0014912 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> cordillera </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0003466 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014131 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> parrado </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0003466 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014131 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> milagro </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0005006 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0013472 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> nieve </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0003080 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012561 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> usd </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0014247 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0011137 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> epopeya </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0002310 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0009421 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-11-08 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 2017-11-08_40 </td>
   <td style="text-align:left;"> mariposa </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 25970 </td>
   <td style="text-align:right;"> 0.0002310 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0009421 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 257 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0210483 </td>
   <td style="text-align:right;"> 0.1857171 </td>
   <td style="text-align:right;"> 0.0039090 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> aeronaves </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0011466 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0034156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> toscas </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0007371 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0030056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> ofelia </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0008190 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0024397 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> caraguata </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0007371 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0021958 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> patetta </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0006552 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0019518 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> ejercicios </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0011466 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0019259 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> combinados </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0006552 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0017633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> estatutos </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0004914 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0016631 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> cooperativas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0011466 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0014963 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> suroeste </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0004095 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013859 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> tanque </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0005733 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0013104 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> certificados </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0006552 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0013092 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> vuelo </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0007371 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0013083 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-11 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2017-10-11_35 </td>
   <td style="text-align:left;"> municipio </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12210 </td>
   <td style="text-align:right;"> 0.0009009 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0012338 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> falco </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0017742 </td>
   <td style="text-align:right;"> 2.285778 </td>
   <td style="text-align:right;"> 0.0040555 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> lactancia </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0010138 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0030202 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> 18596 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0006590 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0022303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> fiscalia </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0020784 </td>
   <td style="text-align:right;"> 1.033015 </td>
   <td style="text-align:right;"> 0.0021470 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> lara </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0004562 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0018603 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> liber </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0016221 </td>
   <td style="text-align:right;"> 1.133099 </td>
   <td style="text-align:right;"> 0.0018380 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> lesa </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0010645 </td>
   <td style="text-align:right;"> 1.592631 </td>
   <td style="text-align:right;"> 0.0016954 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> materna </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0007604 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0016208 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> especializada </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0008618 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0016204 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> 1973 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0010138 </td>
   <td style="text-align:right;"> 1.592631 </td>
   <td style="text-align:right;"> 0.0016147 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> palestinos </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0004562 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0015441 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> poesia </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0005576 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0013762 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> prisioneros </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0004562 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0013591 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> estudiantes </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0012673 </td>
   <td style="text-align:right;"> 1.033015 </td>
   <td style="text-align:right;"> 0.0013091 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-17 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2017-05-17_16 </td>
   <td style="text-align:left;"> acosta </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 19727 </td>
   <td style="text-align:right;"> 0.0004055 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0012081 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> sanguinetti </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0030310 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0045847 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0084869 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0035134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> indonesia </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0009699 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0023939 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> embajadora </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0006668 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0017946 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> malasia </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004850 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0016413 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> bauzan </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004243 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0014362 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> nury </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004243 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0014362 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> asiatico </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004850 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0013052 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> perros </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004850 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0013052 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> sudeste </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0003637 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0010835 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> plenipotenciaria </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0003031 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> cw </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0002425 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0009887 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> myra </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0002425 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0009887 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> elsa </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0004243 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0009700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-14 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2017-06-14_19 </td>
   <td style="text-align:left;"> melo </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 16496 </td>
   <td style="text-align:right;"> 0.0006062 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0009655 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> chuy </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0013569 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0040420 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> ibicuy </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0007753 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0023097 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> rocha </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0029075 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0021671 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> aeronave </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0007753 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0020866 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> patrullera </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0004846 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0019759 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> julio </td>
   <td style="text-align:right;"> 221 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0214189 </td>
   <td style="text-align:right;"> 0.0885534 </td>
   <td style="text-align:right;"> 0.0018967 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> acrux </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0006784 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0018258 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> rou </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0009692 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0016279 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> comero </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0003877 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0015807 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> combinado </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0006784 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0015507 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> km </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0007753 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0015492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> c1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0004846 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0014436 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> mentor </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0004846 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0014436 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> lancha </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0005815 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0014352 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-26 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 2017-07-26_26 </td>
   <td style="text-align:left;"> aereas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10318 </td>
   <td style="text-align:right;"> 0.0005815 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0012396 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> biassini </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0014912 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0040133 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> solari </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0014912 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0040133 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> loedel </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0009418 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0031876 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> benito </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0011773 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0029057 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> octubre </td>
   <td style="text-align:right;"> 194 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0152264 </td>
   <td style="text-align:right;"> 0.1857171 </td>
   <td style="text-align:right;"> 0.0028278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> helenica </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0007064 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0023907 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> citricultura </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0007064 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0021043 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> rita </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0009418 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0020077 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> cincunegui </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0007064 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0019010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> bogliaccini </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0005494 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0018594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> citrus </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0005494 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0018594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> imposicion </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0010203 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0016250 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> llambi </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0004709 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0015938 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> embajador </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0014128 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0013937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> 902 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0003139 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012801 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-10-17 </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 2017-10-17_36 </td>
   <td style="text-align:left;"> 903 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 12741 </td>
   <td style="text-align:right;"> 0.0003139 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012801 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> haiti </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0033477 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0066891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> paz </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0052346 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0035404 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> minustah </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0010348 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0035020 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> armadas </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0029825 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0029423 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> misiones </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0032260 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0025218 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> contingentes </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0007304 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0024720 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> unidas </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0032869 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0022230 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> fuerzas </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0038956 </td>
   <td style="text-align:right;"> 0.4940185 </td>
   <td style="text-align:right;"> 0.0019245 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> naciones </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0034086 </td>
   <td style="text-align:right;"> 0.5511769 </td>
   <td style="text-align:right;"> 0.0018787 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> soldados </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0009739 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0018312 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> teniente </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0007304 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0015570 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> aerotecnico </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003652 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> martirene </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003652 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> montiel </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003652 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> haitiana </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003043 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> haitiano </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003043 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> pastor </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003043 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012410 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-16 </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 2017-05-16_15 </td>
   <td style="text-align:left;"> yiyi </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16429 </td>
   <td style="text-align:right;"> 0.0003043 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0012410 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> antartico </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0022417 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0066780 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> emergencias </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0012723 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0037902 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> homenaje </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0037564 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0019616 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> ambientales </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0010906 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0018318 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> protocolo </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0017570 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0018151 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> emanada </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0005453 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0014675 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> invitaciones </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0005453 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0014675 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> haiti </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0007271 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0014527 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> firmas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0008482 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0013509 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> jueves </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0011512 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0012453 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> reconsideracion </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0003635 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0012303 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> armadas </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0010906 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0010759 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> mayo </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0084823 </td>
   <td style="text-align:right;"> 0.1262937 </td>
   <td style="text-align:right;"> 0.0010713 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> tratado </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0022417 </td>
   <td style="text-align:right;"> 0.4666195 </td>
   <td style="text-align:right;"> 0.0010460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-09 </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2017-05-09_12 </td>
   <td style="text-align:left;"> minustah </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 16505 </td>
   <td style="text-align:right;"> 0.0003029 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010253 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> niko </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0029281 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0099100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> roslik </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0021023 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0056577 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> schvarz </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0013515 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0055106 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> abril </td>
   <td style="text-align:right;"> 162 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0121631 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0035680 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> olegario </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0008259 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0024603 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> semanario </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0009010 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0024247 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> serrana </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0007508 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0022366 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> vladimir </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0008259 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0020384 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> autopsia </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0004505 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0018369 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> jaque </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0005256 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0017787 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> policlinica </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0007508 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0017162 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> bichkov </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0005256 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0015656 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> maestro </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0014265 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0015432 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> faro </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0004505 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0015246 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-04 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 2017-04-04_6 </td>
   <td style="text-align:left;"> paloma </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 13319 </td>
   <td style="text-align:right;"> 0.0006757 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0013502 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> solidaridad </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0023766 </td>
   <td style="text-align:right;"> 0.7102416 </td>
   <td style="text-align:right;"> 0.0016880 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> correspondencia </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0010007 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0015136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> crespo </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0005003 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0014905 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> becas </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0006880 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0014665 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> universitarias </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0005629 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0013893 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> km </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0006880 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0013746 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> armada </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0012509 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0013532 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> ramal </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0005003 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0013465 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> receptoras </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0004378 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0013042 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> 28.700 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0003753 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0012700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> admitira </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0005003 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0012349 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> 15739 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0003127 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010583 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> bpc </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0003127 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0010583 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> profesionales </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0013759 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0010255 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-21 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 2017-12-21_52 </td>
   <td style="text-align:left;"> aportantes </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 15989 </td>
   <td style="text-align:right;"> 0.0002502 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010201 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> asse </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0057335 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0086724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> sica </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0014029 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0041790 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> novia </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0010369 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0027906 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> marlene </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0007929 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0026836 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> escribano </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0010369 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0023701 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0031717 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0020411 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> venias </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0012809 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0019374 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> hospital </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0021348 </td>
   <td style="text-align:right;"> 0.8994836 </td>
   <td style="text-align:right;"> 0.0019202 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> directores </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0017078 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0018475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> vocal </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0006709 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0018057 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> clinicas </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0006709 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0016559 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> irregularidades </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0006099 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0016415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> directorio </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0019518 </td>
   <td style="text-align:right;"> 0.8194409 </td>
   <td style="text-align:right;"> 0.0015994 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> hospitales </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0007319 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0013763 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-27 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 2018-02-27_57 </td>
   <td style="text-align:left;"> doctora </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 16395 </td>
   <td style="text-align:right;"> 0.0012199 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0012602 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> perimetro </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0008982 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0036624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> junio </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0066139 </td>
   <td style="text-align:right;"> 0.4139758 </td>
   <td style="text-align:right;"> 0.0027380 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> muniz </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0008982 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0022168 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> elvira </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0008165 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0021975 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> taborda </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0007349 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0021891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> 2021 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0006532 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0017580 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> totoral </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0005716 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0017027 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> cajeros </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0004083 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016647 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> cuidaran </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0004083 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016647 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> electronicos </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0006532 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0014931 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> 19478 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0004899 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0014594 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> maestra </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0008982 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0012920 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> vigencia </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0032661 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0011887 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> prorroga </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0021230 </td>
   <td style="text-align:right;"> 0.5511769 </td>
   <td style="text-align:right;"> 0.0011701 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-06-29 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 2017-06-29_21 </td>
   <td style="text-align:left;"> entrada </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 12247 </td>
   <td style="text-align:right;"> 0.0024496 </td>
   <td style="text-align:right;"> 0.4666195 </td>
   <td style="text-align:right;"> 0.0011430 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0044994 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0028956 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> policar </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0008059 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0027273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> asse </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0015446 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0023363 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> betty </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0006044 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0020455 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> marcos </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0063125 </td>
   <td style="text-align:right;"> 0.3163373 </td>
   <td style="text-align:right;"> 0.0019969 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> kozlowsky </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0005372 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0018182 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> gaucho </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0004701 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0015909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> dialogo </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0020146 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0015016 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> suertes </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0004029 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013637 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> esther </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0005372 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0013260 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> renuncia </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0010745 </td>
   <td style="text-align:right;"> 1.1871657 </td>
   <td style="text-align:right;"> 0.0012756 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> febrero </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0047008 </td>
   <td style="text-align:right;"> 0.2488960 </td>
   <td style="text-align:right;"> 0.0011700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> oradores </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0008059 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0011592 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> saramago </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0003358 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0011364 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-21 </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 2018-02-21_56 </td>
   <td style="text-align:left;"> juntos </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 14891 </td>
   <td style="text-align:right;"> 0.0010745 </td>
   <td style="text-align:right;"> 0.9420432 </td>
   <td style="text-align:right;"> 0.0010122 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> diabetes </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0011931 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0040378 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> banchero </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0016269 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0040153 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> bellon </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0013015 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0038771 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> marrapodi </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0009761 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0029078 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> carmelo </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0010846 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0021671 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> noain </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0008677 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0021415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> alemania </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0016269 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0021230 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> gabriel </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0010846 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0019251 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> utec </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0008677 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0018496 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> julio </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0163774 </td>
   <td style="text-align:right;"> 0.0885534 </td>
   <td style="text-align:right;"> 0.0014503 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> embajador </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0014100 </td>
   <td style="text-align:right;"> 0.9864950 </td>
   <td style="text-align:right;"> 0.0013909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> carreras </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0006508 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0013003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> alimentacion </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0008677 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0012481 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> profesor </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0018438 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0012470 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-12 </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2017-07-12_25 </td>
   <td style="text-align:left;"> escolar </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9220 </td>
   <td style="text-align:right;"> 0.0006508 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0012236 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> leonidas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0011888 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0040232 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> larrosa </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0013586 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0036563 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> batalla </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0024624 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0032133 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> velazquez </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0009340 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0031611 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> hugo </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0026322 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0029826 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0045003 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0028962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> arrarte </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0008491 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0028737 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> corbo </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0008491 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0022852 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> marta </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0007642 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0022765 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> liceo </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0036512 </td>
   <td style="text-align:right;"> 0.5221894 </td>
   <td style="text-align:right;"> 0.0019066 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0050098 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0018234 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> matrimonio </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0008491 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0018100 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> borbonet </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0005944 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0017706 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> fabris </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0005944 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0017706 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-03-06 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2018-03-06_1 </td>
   <td style="text-align:left;"> meneghetti </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11777 </td>
   <td style="text-align:right;"> 0.0005944 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0017706 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> vespertina </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0014562 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0049283 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> matutina </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0007943 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0026882 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> 17829 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0006619 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0019718 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> ausentarse </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0007943 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0019604 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> retenciones </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0006619 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0016336 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> 867 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0003971 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0016194 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> gerardo </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0006619 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0015130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> letrados </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0006619 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0012446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> faltaron </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0018533 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0011927 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> iturralde </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0007943 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0011426 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> 14762 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> 881 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> 885 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> administrados </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> bettina </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> grisel </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> guruchaga </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> josefina </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> lavie </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> ortopedia </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> sampayo </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> senali </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> stopingi </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-09-13 </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 2017-09-13_31 </td>
   <td style="text-align:left;"> traumatologia </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7554 </td>
   <td style="text-align:right;"> 0.0002648 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0010796 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> berton </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0012376 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0050465 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> bartol </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0009520 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0038819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> samuel </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0010472 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0035442 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> carpetas </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0019992 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0033580 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> rodo </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0011424 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0028196 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0065689 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0023909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> sacramento </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0007616 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0022688 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> armco </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0004760 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0019409 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> lecheria </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0006664 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0012531 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> archivar </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0005712 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0012176 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> n.os </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0015232 </td>
   <td style="text-align:right;"> 0.7817006 </td>
   <td style="text-align:right;"> 0.0011907 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> archivo </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0008568 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0011734 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> voto </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0079970 </td>
   <td style="text-align:right;"> 0.1457118 </td>
   <td style="text-align:right;"> 0.0011653 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> secado </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0002856 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0011646 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-14 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 2017-03-14_3 </td>
   <td style="text-align:left;"> carol </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 10504 </td>
   <td style="text-align:right;"> 0.0018088 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0011641 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> messere </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0011736 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0039719 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> ferraro </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0008535 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0028886 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> teresita </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0009602 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0025841 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> canada </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0016003 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0024207 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> jueza </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0008535 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0022970 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> apelaciones </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0012803 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0022724 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> alicia </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0009602 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0019186 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> alvarez </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0010669 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0018937 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> estremecieron </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0004268 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> iglesias </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0004268 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012713 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> suprema </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0018137 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0012267 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> tribunal </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0017070 </td>
   <td style="text-align:right;"> 0.6763401 </td>
   <td style="text-align:right;"> 0.0011545 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> letrada </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0005334 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0011371 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> ricardo </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0008535 </td>
   <td style="text-align:right;"> 1.3049487 </td>
   <td style="text-align:right;"> 0.0011138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-07-04 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2017-07-04_22 </td>
   <td style="text-align:left;"> doctora </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9373 </td>
   <td style="text-align:right;"> 0.0010669 </td>
   <td style="text-align:right;"> 1.0330150 </td>
   <td style="text-align:right;"> 0.0011021 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> cooperativista </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0013960 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0041587 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> cooperativistas </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0006980 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0028462 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> socio </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0014833 </td>
   <td style="text-align:right;"> 1.679642 </td>
   <td style="text-align:right;"> 0.0024914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> extraordinarios </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0013088 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0024609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> usuario </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0016578 </td>
   <td style="text-align:right;"> 1.304949 </td>
   <td style="text-align:right;"> 0.0021633 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> neutralidad </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0006108 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0020671 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> cooperativa </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0015705 </td>
   <td style="text-align:right;"> 1.244324 </td>
   <td style="text-align:right;"> 0.0019543 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> sutel </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0005235 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0017718 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> cooperativas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0012215 </td>
   <td style="text-align:right;"> 1.304949 </td>
   <td style="text-align:right;"> 0.0015940 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> dormitorio </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0003490 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0014231 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> 13728 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0006108 </td>
   <td style="text-align:right;"> 2.131627 </td>
   <td style="text-align:right;"> 0.0013019 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> lustemberg </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0006980 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0012390 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> cuadrados </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0006108 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0011484 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> red </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0008725 </td>
   <td style="text-align:right;"> 1.244324 </td>
   <td style="text-align:right;"> 0.0010857 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-13 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 2017-12-13_49 </td>
   <td style="text-align:left;"> privatizacion </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11461 </td>
   <td style="text-align:right;"> 0.0005235 </td>
   <td style="text-align:right;"> 1.880313 </td>
   <td style="text-align:right;"> 0.0009844 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> imae </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0011247 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0033505 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> rata </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0007157 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0029185 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> marzo </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0048057 </td>
   <td style="text-align:right;"> 0.3639654 </td>
   <td style="text-align:right;"> 0.0017491 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> ministra </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0015337 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0017379 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> franco </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0008180 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0016344 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> carpetas </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0009202 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0015457 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> interpelacion </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0009202 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0015457 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> cardiologico </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0004090 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0013842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> camioneta </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0004090 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0012184 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> escritas </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0007157 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0010826 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> anep </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0006135 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0009280 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> 696 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0003067 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> contumaz </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0003067 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> escalera </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0003067 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-03-07 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2017-03-07_1 </td>
   <td style="text-align:left;"> primarios </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9780 </td>
   <td style="text-align:right;"> 0.0003067 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0009138 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> fragata </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0037599 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0112005 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> capitan </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0038992 </td>
   <td style="text-align:right;"> 1.998096 </td>
   <td style="text-align:right;"> 0.0077909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> navio </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0020888 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0056216 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> capitanes </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0018103 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0048720 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> antiguedad </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0025066 </td>
   <td style="text-align:right;"> 1.679642 </td>
   <td style="text-align:right;"> 0.0042102 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> tenientes </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0015318 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0037807 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> colotta </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0028278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> cp </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 3.384390 </td>
   <td style="text-align:right;"> 0.0028278 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> coroneles </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0013926 </td>
   <td style="text-align:right;"> 1.998096 </td>
   <td style="text-align:right;"> 0.0027825 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> rutas </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0019496 </td>
   <td style="text-align:right;"> 1.304949 </td>
   <td style="text-align:right;"> 0.0025441 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> prefectura </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0024890 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> ascensos </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0013926 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0024717 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> ascenso </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0018103 </td>
   <td style="text-align:right;"> 1.187166 </td>
   <td style="text-align:right;"> 0.0021492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> amarillo </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0006963 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0020742 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-10 </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 2017-05-10_13 </td>
   <td style="text-align:left;"> pino </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 7181 </td>
   <td style="text-align:right;"> 0.0008355 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0020622 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> femicidio </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0033927 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0056985 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> cultivadores </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0031583 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> arroz </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0016964 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0028493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> desprecio </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0026167 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> menosprecio </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0026167 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> mortalidad </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0012723 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0025421 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> moskovics </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0009542 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0023551 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> homicidio </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0012723 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0022582 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> cadena </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 1.7749524 </td>
   <td style="text-align:right;"> 0.0018818 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> feminicidio </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0007422 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0018317 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> homicidios </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0008482 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0018080 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> abril </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0059372 </td>
   <td style="text-align:right;"> 0.2933478 </td>
   <td style="text-align:right;"> 0.0017417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> mujer </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0023325 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0017385 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> transportistas </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0006361 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0017120 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-04-05 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 2017-04-05_7 </td>
   <td style="text-align:left;"> victima </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 9432 </td>
   <td style="text-align:right;"> 0.0010602 </td>
   <td style="text-align:right;"> 1.5125881 </td>
   <td style="text-align:right;"> 0.0016037 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> universitarios </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0021944 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0034948 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> cofloral </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0007837 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0031956 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> minuta </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0026646 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0028826 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> caja </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0025078 </td>
   <td style="text-align:right;"> 1.1330985 </td>
   <td style="text-align:right;"> 0.0028416 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> prematuros </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0007837 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0026523 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> unipersonal </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0007837 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0026523 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> floricultores </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0006270 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0025564 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> paternidad </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0012539 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0025054 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> profesionales </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0032915 </td>
   <td style="text-align:right;"> 0.7453329 </td>
   <td style="text-align:right;"> 0.0024533 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> envie </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0010972 </td>
   <td style="text-align:right;"> 1.9980959 </td>
   <td style="text-align:right;"> 0.0021923 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> mayo </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0172414 </td>
   <td style="text-align:right;"> 0.1262937 </td>
   <td style="text-align:right;"> 0.0021775 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> 19161 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0009404 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0021496 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> maternidad </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0012539 </td>
   <td style="text-align:right;"> 1.5926308 </td>
   <td style="text-align:right;"> 0.0019970 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> prematuro </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0004702 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0019173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-05-03 </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 2017-05-03_11 </td>
   <td style="text-align:left;"> puerperio </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 6380 </td>
   <td style="text-align:right;"> 0.0006270 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0018677 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> postal </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0012682 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0037780 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> tributos </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0014796 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0031540 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> tasas </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0014796 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0027821 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> prototipado </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0006341 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0025856 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> 18910 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0008455 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0025186 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> diciembre </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0133164 </td>
   <td style="text-align:right;"> 0.1655144 </td>
   <td style="text-align:right;"> 0.0022041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> robotica </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0006341 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0021461 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> beneficiarios </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0014796 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0021284 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> tambores </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0008455 </td>
   <td style="text-align:right;"> 2.4680995 </td>
   <td style="text-align:right;"> 0.0020867 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> exoneracion </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0010569 </td>
   <td style="text-align:right;"> 1.8803129 </td>
   <td style="text-align:right;"> 0.0019872 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> importaciones </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0008455 </td>
   <td style="text-align:right;"> 2.2857780 </td>
   <td style="text-align:right;"> 0.0019326 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> cupos </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0006341 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0018890 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> series </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0006341 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0018890 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> electronica </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0008455 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0018023 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> 995 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0004227 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> 996 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0004227 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> 997 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0004227 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> neficiarios </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0004227 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017238 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-12-27 </td>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> 2017-12-27_53 </td>
   <td style="text-align:left;"> ursec </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4731 </td>
   <td style="text-align:right;"> 0.0004227 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0017238 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> km </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0023781 </td>
   <td style="text-align:right;"> 1.998096 </td>
   <td style="text-align:right;"> 0.0047517 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> ausentarse </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0017836 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0044021 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> hamburgo </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0011891 </td>
   <td style="text-align:right;"> 2.978925 </td>
   <td style="text-align:right;"> 0.0035421 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> bomberos </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0011891 </td>
   <td style="text-align:right;"> 2.691243 </td>
   <td style="text-align:right;"> 0.0032001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> federal </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0017836 </td>
   <td style="text-align:right;"> 1.679642 </td>
   <td style="text-align:right;"> 0.0029958 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> 23,400 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> 26,900 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> 40,300 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> etiopia </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> habana </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> toscanini </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> upaep </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0005945 </td>
   <td style="text-align:right;"> 4.077537 </td>
   <td style="text-align:right;"> 0.0024242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> helsinki </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0008918 </td>
   <td style="text-align:right;"> 2.468100 </td>
   <td style="text-align:right;"> 0.0022010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> finlandia </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0011891 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0021105 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2017-02-02 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2017-02-02_54 </td>
   <td style="text-align:left;"> moscu </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3364 </td>
   <td style="text-align:right;"> 0.0011891 </td>
   <td style="text-align:right;"> 1.774952 </td>
   <td style="text-align:right;"> 0.0021105 </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> fecha </th>
   <th style="text-align:left;"> sesion </th>
   <th style="text-align:left;"> fecha_sesion </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total </th>
   <th style="text-align:right;"> tf </th>
   <th style="text-align:right;"> idf </th>
   <th style="text-align:right;"> tf_idf </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0058540 </td>
   <td style="text-align:right;"> 0.6435502 </td>
   <td style="text-align:right;"> 0.0037673 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> gluten </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0028082 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> 330 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0017218 </td>
   <td style="text-align:right;"> 1.3694872 </td>
   <td style="text-align:right;"> 0.0023579 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> operativas </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 3.3843903 </td>
   <td style="text-align:right;"> 0.0023308 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> aristimuno </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0013774 </td>
   <td style="text-align:right;"> 1.6796422 </td>
   <td style="text-align:right;"> 0.0023136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> turquia </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 2.9789252 </td>
   <td style="text-align:right;"> 0.0020516 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> celebrada </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0018535 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> reducirlo </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 2.6912431 </td>
   <td style="text-align:right;"> 0.0018535 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> febrero </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0072314 </td>
   <td style="text-align:right;"> 0.2488960 </td>
   <td style="text-align:right;"> 0.0017999 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> receso </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0013774 </td>
   <td style="text-align:right;"> 1.2443241 </td>
   <td style="text-align:right;"> 0.0017139 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> minuta </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0013774 </td>
   <td style="text-align:right;"> 1.0818052 </td>
   <td style="text-align:right;"> 0.0014901 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> 338 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0010331 </td>
   <td style="text-align:right;"> 1.4384801 </td>
   <td style="text-align:right;"> 0.0014860 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> multilateral </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0006887 </td>
   <td style="text-align:right;"> 2.1316273 </td>
   <td style="text-align:right;"> 0.0014681 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> 19637 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> bleas </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> celiaca </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> fomin </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> ifer </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> inzaurralde </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> mortan </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2018-02-06 </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2018-02-06_54 </td>
   <td style="text-align:left;"> promulgaciones </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2904 </td>
   <td style="text-align:right;"> 0.0003444 </td>
   <td style="text-align:right;"> 4.0775374 </td>
   <td style="text-align:right;"> 0.0014041 </td>
  </tr>
</tbody>
</table>

