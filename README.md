# Alice R operator

##### Description

The `Alice R operator` applies the ALICE algorithm to TCR sequences. The ALICE algorithm 
operates on a dataset of n unique nucleotide TCR sequences (clonotypes) with a 
given VJ combination. The procedure is then applied to all VJ combinations present in the data. Unique nucleotide sequences have corresponding amino acid sequences. 
The goal is to find outlying sequences that have an abnormal number of nucleotide 
variants in the data that differ by at most one amino acid.

More information can be found in the original [paper](https://www.biorxiv.org/content/10.1101/375162v1). 

##### Usage

Input projection|.
---|---
`column`        | string, nucleotide sequences of TCR genes
`colors`        | numbers, the Read.count and Read.proportion variables
`labels`        | string, containing gene information including the amino acid
sequences, the best VGenes and best J Genes.

Input parameters|.
---|---
`input_var`        | will be supported soon

Output relations|.
---|---
`output_var`        | output relation
`Operator view`        | view of the Shiny application

##### Details

The algortihm operates on a dataset of n unique nucleotide TCR sequences (clonotypes) 
with a given VJ combination. The procedure is then applied to all VJ combinations present in the data. Unique nucleotide sequences have corresponding amino acid sequences. 
The goal is to find outlying sequences that have an abnormal number
of nucleotide variants in the data that differ by at most one amino acid.  
  
For each amino acid sequence σ, under the null hypothesis we expect the number 
of neighbours d to be Poisson distributed The sum is over all possible similar 
variants σ 0 of σ. Here, similarity σ 0 ∼ σ is defined by having at most one 
amino acid mismatch, but other measures could be used instead. Pgen(σ0) is
the probability to generate a given amino acid sequence σ 0 by V(D)J recombination, 
and Q a rescaling factor accounting for thymic selection which eliminates a 
fraction 1/Q of generated sequences. Its value was set to Q = 9.41 as the 
average over all VJ combinations reported.

##### Screenshots
![Example of application](/static/screenshot.PNG?raw=true "Example of application")

##### See Also

[template_shiny_operator](https://github.com/tercen/template_shiny_operator)
, [original ALICE implementation](https://github.com/pogorely/ALICE), 
[paper](https://www.biorxiv.org/content/10.1101/375162v1)

