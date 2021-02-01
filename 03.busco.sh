# run with ./03.busco.sh assembly.fasta assembly_busco

export BUSCO_CONFIG_FILE=/data/programs/busco-4.1.2/config/config.ini
# set suitable taxa for database
database=lepidoptera_odb10
input=$1
output=$2
python3 /data/programs/busco-4.1.2/bin/busco -m genome -i $input -o $output -l $database -c 30 --long
