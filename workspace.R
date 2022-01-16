library(tercen)
library(dplyr, warn.conflicts = FALSE)
source("R/ALICE.R")

# t=0
# http://localhost:5402/admin/w/4268ffd55d3487c8c40b156b3f00969f/ds/abca350c-5105-406e-8515-019f4abbdf2e
# t=15
# http://localhost:5402/admin/w/4268ffd55d3487c8c40b156b3f00969f/ds/b4edd608-fb17-4075-8e6f-c2ff34a39495

options("tercen.workflowId" = "4268ffd55d3487c8c40b156b3f00969f")
options("tercen.stepId"     = "b4edd608-fb17-4075-8e6f-c2ff34a39495")

getOption("tercen.workflowId")
getOption("tercen.stepId")

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
