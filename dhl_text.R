# text analysis

library(knitr)
library(tidyverse)
library(textdata)
library(gutenbergr)

## 2.1 The Sentiments dataset
library(tidytext)
library(wordcloud)
library(RColorBrewer)
pal2 <- brewer.pal(3, "Dark2")
get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

## --------------------------------------------------------------
library(dplyr)
library(stringr)

## build a Wordcloud from the reviews of boston airbnb listings
wordfreq_bos=tibble(bos_review$comments) %>%
  rename(comments=`bos_review$comments`) %>%
  unnest_tokens(word, comments) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
wordcloud(wordfreq_bos$word, freq = wordfreq_bos$n, scale=c(2, 0.5), max.words = 100,
          rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))

## build a Wordcloud from the reviews of new york airbnb listings
wordfreq_ny=tibble(ny_review$comments) %>%
  rename(comments=`ny_review$comments`) %>%
  unnest_tokens(word, comments) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
wordcloud(wordfreq_ny$word, freq = wordfreq_ny$n, scale=c(2, 0.5), max.words = 100,
          rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))

## build a Wordcloud from the reviews of los angeles airbnb listings
wordfreq_la=tibble(la_review$comments) %>%
  rename(comments=`la_review$comments`) %>%
  unnest_tokens(word, comments) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
wordcloud(wordfreq_la$word, freq = wordfreq_la$n, scale=c(2, 0.5), max.words = 100,
          rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))

## build a Wordcloud from the reviews of hawaii airbnb listings
wordfreq_hawa=tibble(hawa_review$comments) %>%
  rename(comments=`hawa_review$comments`) %>%
  unnest_tokens(word, comments) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
wordcloud(wordfreq_hawa$word, freq = wordfreq_hawa$n, scale=c(2, 0.5), max.words = 100,
          rot.per = 0.25, colors = pal2, random.order=FALSE, vfont=c("serif", "plain"))

