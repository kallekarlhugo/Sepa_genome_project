#run with ./01.shasta.sh reads.fastq
# output will be in the ShastaRun directory
PATH=/mnt/griffin/kaltun/software:$PATH
shasta-Linux-0.7.0 --input $1 --config shasta_nanopore_sept2020_7kreducedmarkers.com
