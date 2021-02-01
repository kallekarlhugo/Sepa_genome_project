#generate assembly stats
# run with bash 03.stats.sh assembly.fasta
/data/programs/bbmap/stats.sh $1 > ${1%fasta}stats
