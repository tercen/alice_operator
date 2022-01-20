library(tercen)
library(dplyr, warn.conflicts = FALSE)
source("R/ALICE.R")

# t=0
# http://localhost:5402/admin/w/4268ffd55d3487c8c40b156b3f00969f/ds/abca350c-5105-406e-8515-019f4abbdf2e
# t=15
# http://localhost:5402/admin/w/4268ffd55d3487c8c40b156b3f00969f/ds/b4edd608-fb17-4075-8e6f-c2ff34a39495

options("tercen.workflowId" = "4268ffd55d3487c8c40b156b3f00969f")
options("tercen.stepId"     = "94d8f51a-ddc3-4c18-ba77-5e40ca55cd81")

getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx = tercenCtx()

if (as.character(ctx$op.value('rankVar')) != "NULL") {
  rankVar <- as.character(ctx$op.value('rankVar'))
} else {
  stop("rankVar not supplied")
}

if (as.character(ctx$op.value('readCount')) != "NULL") {
  readCount <- as.character(ctx$op.value('readCount'))
} else {
  stop("readCount not supplied")
}

if (as.character(ctx$op.value('readProportion')) != "NULL") {
  readProportion <- as.character(ctx$op.value('readProportion'))
} else {
  stop("readProportion not supplied")
}

if (as.character(ctx$op.value('nucleotideSeq')) != "NULL") {
  nucleotideSeq <- as.character(ctx$op.value('nucleotideSeq'))
} else {
  stop("nucleotideSeq not supplied")
}

if (as.character(ctx$op.value('aminoacidSeq')) != "NULL") {
  aminoacidSeq <- as.character(ctx$op.value('aminoacidSeq'))
} else {
  stop("aminoacidSeq not supplied")
}

if (as.character(ctx$op.value('bestVGene')) != "NULL") {
  bestVGene <- as.character(ctx$op.value('bestVGene'))
} else {
  stop("bestVGene not supplied")
}

if (as.character(ctx$op.value('bestJGene')) != "NULL") {
  bestJGene <- as.character(ctx$op.value('bestJGene'))
} else {
  stop("bestJGene not supplied")
}

tableId <- ctx$rselect()[[1]]
df <- ctx$client$tableSchemaService$select(tableId)
df <- as.data.frame(as_tibble(df))

# rename column names
names(df)[names(df) == rankVar] <- 'Rank'
names(df)[names(df) == readCount] <- 'Read.count'
names(df)[names(df) == rankVar] <- 'Read.proportion'
names(df)[names(df) == nucleotideSeq] <- 'CDR3.nucleotide.sequence'
names(df)[names(df) == aminoacidSeq] <- 'CDR3.amino.acid.sequence'
names(df)[names(df) == bestVGene] <- 'bestVGene'
names(df)[names(df) == bestJGene] <- 'bestJGene'

df %>%
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
  mutate(.tlbIdx = tableId) %>%
  mutate(.ci = rep_len(0, nrow(.))) %>%
  ctx$addNamespace() %>%
  ctx$save()
