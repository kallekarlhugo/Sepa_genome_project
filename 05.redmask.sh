# run with bash ./05.redmask.sh assembly.fasta
PATH=$PATH:/data/programs/RED/redUnix64
python /data/programs/RED/redmask-master/redmask.py -i $1 -o ${1%fasta}_mask
