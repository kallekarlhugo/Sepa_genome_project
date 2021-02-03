# align
# https://mummer4.github.io/manual/manual.html
# list reference genome first, then query genome
# Prefix=nucmer_aln_Pnap_v_Pmac000.1polish

cd /mnt/griffin/chrwhe/SEPA/apollo_alignment
mkdir synteny
cd synteny

# genomes
ln -s /mnt/griffin/kaltun/sepa/frozen_genomes/Parnassius_apollo_shasta7k_pepper.fasta .
# Papilio bianor genome
# ftp://parrot.genomics.cn/gigadb/pub/10.5524/100001_101000/100653/
wget ftp://parrot.genomics.cn/gigadb/pub/10.5524/100001_101000/100653/Pb_Hic.fasta.tar.gz
tar -zxvf Pb_Hic.fasta.tar.gz
/data/programs/scripts/AsmQC Pb_Hic.fasta
-------------------------------
    AssemblyQC Result
-------------------------------
Contigs Generated :        1,710
Maximum Contig Length : 18,214,045
Minimum Contig Length :    1,000
Average Contig Length : 246,505.7 ± 1,693,537.4
Median Contig Length :  24,205.5
Total Contigs Length :  421,524,737
Total Number of Non-ATGC Characters :    290,008
Percentage of Non-ATGC Characters :        0.069
Contigs >= 100 bp :        1,710
Contigs >= 200 bp :        1,710
Contigs >= 500 bp :        1,710
Contigs >= 1 Kbp :         1,710
Contigs >= 10 Kbp :        1,170
Contigs >= 1 Mbp :            31
N50 value :     13,120,256
Generated using /mnt/griffin/chrwhe/SEPA/apollo_alignment/Pb_Hic.fasta

/data/programs/scripts/AsmQC Parnassius_apollo_shasta7k_pepper.fasta
-------------------------------
    AssemblyQC Result
-------------------------------
Contigs Generated :        3,002
Maximum Contig Length : 33,620,021
Minimum Contig Length :      126
Average Contig Length : 477,679.6 ± 1,906,520.7
Median Contig Length :  93,535.5
Total Contigs Length :  1,433,994,289
Total Number of Non-ATGC Characters :          0
Percentage of Non-ATGC Characters :        0.000
Contigs >= 100 bp :        3,002
Contigs >= 200 bp :        2,988
Contigs >= 500 bp :        2,907
Contigs >= 1 Kbp :         2,819
Contigs >= 10 Kbp :        2,171
Contigs >= 1 Mbp :           242
N50 value :     6,772,465
Generated using /mnt/griffin/chrwhe/SEPA/apollo_alignment/Parnassius_apollo_shasta7k_pepper.fasta


# generating contig list
Query=Parnassius_apollo_shasta7k_pepper.fasta
Reference=Pb_Hic.fasta

grep '>' $Query | sed 's/>//' > Papo_contigs.txt
grep '>' $Reference | sed 's/>//' > Pbin_contigs.txt

# checking headers to make sure they are different
head -2 *txt
==> Papo_contigs.txt <==
Contig_0
Contig_1

==> Pbin_contigs.txt <==
HiC_scaffold_1
HiC_scaffold_2


Prefix=nucmer_aln_Pbin_v_Papo
/data/programs/mummer-4.0.0beta2/nucmer --mum -c 100 -t 5 -p $Prefix $Reference $Query

# Options (default value in (), *required):
#      --mum                                Use anchor matches that are unique in both the reference and query (false)
#      --maxmatch                           Use all anchor matches regardless of their uniqueness (false)
#  -b, --breaklen=uint32                    Set the distance an alignment extension will attempt to extend poor scoring regions before giving up (200)
#  -c, --mincluster=uint32                  Sets the minimum length of a cluster of matches (65)
#  -D, --diagdiff=uint32                    Set the maximum diagonal difference between two adjacent anchors in a cluster (5)
#  -d, --diagfactor=double                  Set the maximum diagonal difference between two adjacent anchors in a cluster as a differential fraction of the gap length (0.12)
#      --noextend                           Do not perform cluster extension step (false)
#  -f, --forward                            Use only the forward strand of the Query sequences (false)
#  -g, --maxgap=uint32                      Set the maximum gap between two adjacent matches in a cluster (90)
#  -l, --minmatch=uint32                    Set the minimum length of a single exact match (20)
#  -L, --minalign=uint32                    Minimum length of an alignment, after clustering and extension (0)
#      --nooptimize                         No alignment score optimization, i.e. if an alignment extension reaches the end of a sequence, it will not backtrack to optimize the alignment score and instead terminate the alignment at the end of the sequence (false)
#  -r, --reverse                            Use only the reverse complement of the Query sequences (false)
#      --nosimplify                         Don't simplify alignments by removing shadowed clusters. Use this option when aligning a sequence to itself to look for repeats (false)
#  -p, --prefix=PREFIX                      Write output to PREFIX.delta (out)
#      --delta=PATH                         Output delta file to PATH (instead of PREFIX.delta)
#      --sam-short=PATH                     Output SAM file to PATH, short format
#      --sam-long=PATH                      Output SAM file to PATH, long format
#      --save=PREFIX                        Save suffix array to files starting with PREFIX
#      --load=PREFIX                        Load suffix array from file starting with PREFIX
#      --batch=BASES                        Proceed by batch of chunks of BASES from the reference
#  -t, --threads=NUM                        Use NUM threads (# of cores)
#  -U, --usage                              Usage
#  -h, --help                               This message
#      --full-help                          Detailed help
#  -V, --version                            Version

/data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.delta > $Prefix.coords
# clean up output
head $Prefix.coords

    [S1]     [E1]  |     [S2]     [E2]  |  [LEN 1]  [LEN 2]  |  [% IDY]  |  [LEN R]  [LEN Q]  |  [COV R]  [COV Q]  | [TAGS]
===============================================================================================================================
   79295    80653  |   971226   972545  |     1359     1320  |    93.91  |  9469303  1812034  |     0.01     0.07  | HiC_scaffold_1     Contig_209
   79295    80653  |  2415860  2414544  |     1359     1317  |    94.42  |  9469303  5427019  |     0.01     0.02  | HiC_scaffold_1     Contig_265
   79296    80435  | 33264060 33265165  |     1140     1106  |    94.48  |  9469303 33620021  |     0.01     0.00  | HiC_scaffold_1     Contig_20
   79297    80653  |  3594457  3595779  |     1357     1323  |    94.48  |  9469303  5305764  |     0.01     0.02  | HiC_scaffold_1     Contig_48
  199512   200379  |   587643   586785  |      868      859  |    94.96  |  9469303  7679593  |     0.01     0.01  | HiC_scaffold_1     Contig_61

cat $Prefix.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS="\t"} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' | head | column -t

cat $Prefix.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' > $Prefix.filt.coords


#### alternative alignment method allows for filtering before plotting, produces tsv-style output
# /data/programs/mummer-4.0.0beta2/delta-filter -h
#
# USAGE: /data/programs/mummer-4.0.0beta2/.libs/delta-filter  [options]  <deltafile>
#
# -1            1-to-1 alignment allowing for rearrangements
#               (intersection of -r and -q alignments)
# -g            1-to-1 global alignment not allowing rearrangements
# -h            Display help information
# -i float      Set the minimum alignment identity [0, 100], default 0
# -l int        Set the minimum alignment length, default 0
# -m            Many-to-many alignment allowing for rearrangements
#               (union of -r and -q alignments)
# -q            Maps each position of each query to its best hit in
#               the reference, allowing for reference overlaps
# -r            Maps each position of each reference to its best hit
#               in the query, allowing for query overlaps
# -u float      Set the minimum alignment uniqueness, i.e. percent of
#               the alignment matching to unique reference AND query
#               sequence [0, 100], default 0
# -o float      Set the maximum alignment overlap for -r and -q options
#               as a percent of the alignment length [0, 100], default 100
#
#   Reads a delta alignment file from either nucmer or promer and
# filters the alignments based on the command-line switches, leaving
# only the desired alignments which are output to stdout in the same
# delta format as the input. For multiple switches, order of operations
# is as follows: -i -l -u -q -r -g -m -1. If an alignment is excluded
# by a preceding operation, it will be ignored by the succeeding

/data/programs/mummer-4.0.0beta2/delta-filter -q -r -1 $Prefix.delta > $Prefix.qr1_filter.delta
/data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.qr1_filter.delta > $Prefix.qr1_filter.coords
more $Prefix.qr1_filter.coords

# get output for circle plot
cat $Prefix.qr1_filter.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' > $Prefix.qr1_filter.reformat.coords

# /data/programs/mummer-4.0.0beta2/delta-filter -q -r -1 -u 80 $Prefix.delta > $Prefix.qr1_u80_filter.delta
# /data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.qr1_u80_filter.delta > $Prefix.qr1_u80_filter.coords
# cat $Prefix.qr1_u80_filter.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' > $Prefix.qr1_u80_filter.reformat.coords


######### promer via Kalle
for promer:

Reference=P_P_bianor.fasta

Query=Papollo_shasta7k_rename.fasta

/data/programs/mummer-4.0.0beta2/promer -p $Prefix.2 $Reference $Query

/data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.2.delta > $Prefix.2.coords

cat $Prefix.2.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$14,$15,$22,$23}' > $Prefix.2.filt.coords

and then in R I used the script that you and rachel use, filtering out

ref contigs below 50Kb
query_contigs below 2Mb
percentage mapping 70%
overlap length 1Kb

I tried a range of settings for it to not crash circulize when plotting.

For nucmer I ran the following
/data/programs/mummer-4.0.0beta2/nucmer --mum -c 100 -t 20 -p $Prefix $Reference $Query
/data/programs/mummer-4.0.0beta2/show-coords -r -c -l $Prefix.delta > $Prefix.coords
cat $Prefix.coords | sed 1,5d | tr -s ' ' | awk 'BEGIN {FS=" "; OFS=","} {;print $1,$2,$4,$5,$7,$8,$10,$12,$13,$18,$19}' > $Prefix.filt.coords

and also tried a range of filters and cutoffs in R.

Finally,
I also tried to map the Shasta asm agains my NextDenovo assembly, to double check how the assemblies differed and if there was something inherent in my query genome that caused the issue.
I ran the same nucmer script as above, but increased the filters to 95% and 10Kb overlap, which produced the plot that I shared 2 days ago in the chat. Basically showing that most of the contigs produced by both assembler are similar, with a scatter of overlaps and disagreaments.
