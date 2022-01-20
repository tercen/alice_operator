library(tercen)
library(dplyr, warn.conflicts = FALSE)
source("R/ALICE.R")

ctx = tercenCtx()

if (as.character(ctx$op.value('rankVar')) != "NULL") {
  rankVar <- as.character(ctx$op.value('rankVar'))
} else {
  stop("rankVar not supplied")
}

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
