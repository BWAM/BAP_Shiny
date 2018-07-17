example.df <- read.csv("www/example.csv", stringsAsFactors = FALSE)
example.df <- BAP::data_prep(example.df)
print(example.df)
