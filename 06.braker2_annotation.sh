# run with bash 05.braker2_annotation.sh
mkdir annotation && cd annotation
mkdir assemblies
basepath=$(pwd)/
mkdir proteins && cd proteins
wget https://v100.orthodb.org/download/odb10_arthropoda_fasta.tar.gz
tar xvf odb10_arthropoda_fasta.tar.gz
cat arthropoda/Rawdata/* > odb10_arthropoda_proteins.fa
proteins=$(pwd)/odb10_arthropoda_proteins.fa
cd ../assemblies
ln -s <PATH TO ASSEMBLUES> # edit this to make links to your assemblies.
genomepath=$(pwd)/
cd ..


#set paths
cp -r /data/programs/Augustus_v3.3.3/config/ $(pwd)/augustus_config
export AUGUSTUS_CONFIG_PATH=$(pwd)/augustus_config
# now set paths to the other tools
export PATH=/data/programs/BRAKER2_v2.1.5/scripts//:$PATH
export AUGUSTUS_BIN_PATH=/data/programs/Augustus_v3.3.3/bin
export AUGUSTUS_SCRIPTS_PATH=/data/programs/Augustus_v3.3.3/scripts
export DIAMOND_PATH=/data/programs/diamond_v0.9.24/
export GENEMARK_PATH=/data/programs/gmes_linux_64.4.61_lic/
export BAMTOOLS_PATH=/data/programs/bamtools-2.5.1/bin/
export PROTHINT_PATH=/data/programs/ProtHint/bin/
export ALIGNMENT_TOOL_PATH=/data/programs/gth-1.7.0-Linux_x86_64-64bit/bin
export SAMTOOLS_PATH=/data/programs/samtools-1.10/
export MAKEHUB_PATH=/data/programs/MakeHub/

# RUN
cd $basepath && mkdir prot && cd prot
prot=$(pwd)
# Bpas
genome=Bpas_polish_masked.fasta.softmasked.fa
cd $prot && mkdir ${genome%.fa} && cd ${genome%.fa}
braker.pl --species=${genome%.fa}_prot --genome=genome.fa --prot_seq=$proteins --cores=40 --gff3 --softmasking
#Blap
genome=Blap_polish_masked.fasta.softmasked.fa
cd $prot && mkdir ${genome%.fa} && cd ${genome%.fa}
braker.pl --species=${genome%.fa}_prot --genome=genome.fa --prot_seq=$proteins --cores=40 --gff3 --softmasking
Bhor
genome=Bhor_polish_masked.fasta.softmasked.fa
cd $prot && mkdir ${genome%.fa} && cd ${genome%.fa}
braker.pl --species=${genome%.fa}_prot --genome=genome.fa --prot_seq=$proteins --cores=40 --gff3 --softmasking
Papollo
genome=Papollo_polish_masked.fasta.softmasked.fa
cd $prot && mkdir ${genome%.fa} && cd ${genome%.fa}
braker.pl --species=${genome%.fa}_prot --genome=genome.fa --prot_seq=$proteins --cores=40 --gff3 --softmasking
