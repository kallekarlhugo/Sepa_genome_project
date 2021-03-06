# Assembly pipeline for sepa pollinator genome project
Feb1 2021

## input data
each species was sequenced using Nanopore data as well as using Illumina data
The nanopore data was used for genome assembly as well as polishing while Illumina short read data was exclusively used for final genome polishing.

# 01 Draft assembly
## Bumble bees
For the Bumble bee genomes, each species was assembled using the Nextdenovo assembler assuming an expected genome size of 250Mb

The configuration file as well as the command to run it can be find in the code repository.

## Parnassius apollo butterfly
For the Parnassius buttefly we used Shasta v0.7.
Due to the low, ~40X, coverage we modified the recomended settings for nanopore data (Nanopore_sept2020) by reducing the minimum overlap to 7kb increasing the hashiteration count to 15. You can find the exact configuration file in the code directory as well as the script used to start the assembly.

# 02 Long read polishing
each assembly was polished with one iteration using Pepper polish v0.1
Long reads used to assemble the genome was first alinged to the draft assembly using minimap2, sorted with sambamba and then polished with pepper. The script used to do this can be found under pepper.sh

# 03 Genome evalation
We evaluated the assembly quality by looking at the number and size of the generated contigs as well as BUSCO for a measure of gene completeness, both before and after polishing.

The script used to do this can be found in stats.sh and busco.sh
The one difference between the bumblebees and the butterfly was to set the relevant busco database prior to running busco.

# 04 Short read polishing
TBD

# 05 repeat masking
We used RED repeat masker and the redmask.sh script to mask each assembly of repetitive elements prior to annotation.

# 06 annotation
We used Braker2 and the protein only pipeline using the arthropod protein dataset prom OrthoDB to train the the model and predict genes.
