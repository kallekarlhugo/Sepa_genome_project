# manually edit the config file to contain the estimated genome size
# run with ./01.nd.sh reads.fastq
PATH=/mnt/griffin/kaltun/software/NextDenovo/bin:$PATH
$1 > input.fofn
python3 /mnt/griffin/kaltun/software/NextDenovo/nextDenovo nextdenovo_run.cfg
