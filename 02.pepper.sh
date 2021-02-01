# run with 02.pepper.sh draft_assembly.fa reads.fastq
PATH=$PATH:/mnt/griffin/kaltun/software/minimap2:/mnt/griffin/kaltun/software/

ont_reads=$2
assembly=$1

#align raw reads to draft
minimap2 -t 60 -Lax map-ont \
    $assembly  \
    $ont_reads | samtools view -Sbh -o ${ont_reads%.fastq}_v_${assembly%.fasta}.bam

#sort bamfile
sambamba sort -t 30 ${ont_reads%.fastq}_v_${assembly%.fasta}.bam

#generate images, call variants and polish
pepper polish \
--bam ${ont_reads%.fastq}_v_${assembly%.fasta}.sorted.bam \
--fasta $assembly \
--model_path /mnt/griffin/kaltun/pepper_models/pepper_r941_guppy344_human.pkl \
--output_file ./${1%.fasta}_pepper.fasta \
--threads 60 \
--batch_size 128
