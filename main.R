library(tercen)
library(dplyr, warn.conflicts = FALSE)
source("R/ALICE.R")

ctx = tercenCtx()

ctx %>%
  select() %>%
  data.table() %>%
  list %>%
  ALICE_pipeline(
    DTlist = .,
    folder = "_rawdata",
    cores = 1,
    iter = 10,
    nrec = 5e5
  ) %>%
  as.data.frame() %>%
  ctx$addNamespace() %>%
  ctx$save()
