# Quiz

November 30,
Attached files include:

- graphical outputs of the FASTQC package (to have a summary of data and to make sure of having a correct sequencing data)

- a short descripion of the graphs in the PDF file


December 2,

# I have downloaded Build 37 (hg19) of the human chromosome fasta files using following commands:
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz

# unzip and concatenate chromosome and contig fasta files
tar zvfx chromFa.tar.gz
cat *.fa > hg19.fa
rm chr*.fa

# create reference index for the human genome
bwa index -p hg19bwaidx -a bwtsw hg19.fa

# align reads to the human reference genome, using BWA package
bwa aln -t 4 hg19bwaidx bliss_data.fastq > bliss_data.bwa
bwa samse hg19bwaidx bliss_data.bwa bliss_data.fastq > bliss_data.sam

# samtools for converting sam to bam
samtools view -bT hg19.fa bliss_data_hg.sam  > bliss_data_hg.bam


# I also downloaded fasta files of the mouse reference genome from the following web site
http://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/

# unzip and concatenate chromosome and contig fasta files
gzip -d *.fa.gz
cat *.fa > mg.fa
rm chr*.fa

# create reference index for the mouse genome
bwa index -p mgbwaidx -a bwtsw mg.fa

# align reads to the human reference genome, using BWA package
bwa aln -t 4 mgbwaidx bliss_data.fastq > bliss_data.bwa
bwa samse mgbwaidx bliss_data.bwa bliss_data.fastq > bliss_data.sam

# samtools for converting sam to bam
samtools view -bT mg.fa bliss_data_mg.sam  > bliss_data_mg.bam


# I used the following samtools command to determin the percentage of the reads which are properly mapped to the human genome
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools flagstat bliss_data_hg.bam
1000000 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 duplicates
891378 + 0 mapped (89.14%:-nan%)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (-nan%:-nan%)
0 + 0 with itself and mate mapped
0 + 0 singletons (-nan%:-nan%)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)


# I used the following samtools command to determin the percentage of the reads which are properly mapped to the mouse genome
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools flagstat bliss_data_mg.bam
1000000 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 duplicates
8733 + 0 mapped (0.87%:-nan%)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (-nan%:-nan%)
0 + 0 with itself and mate mapped
0 + 0 singletons (-nan%:-nan%)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

# As shown above, while the majority of reads are propoerly mapped to the human genome, they are poorly mapped to the mouse genome.
# I'm assuming that reads are from a human individual.
# I also alined restseq data to the human genome (hg19), using the following commands
bwa aln -t 4 hg19bwaidx restseq_data.fastq > restseq_data_hg.bwa
bwa samse hg19bwaidx restseq_data_hg.bwa restseq_data.fastq > restseq_data_hg.sam

# converting sam to bam
samtools view -bT hg19.fa restseq_data_hg.sam  > restseq_data_hg.bam

# I used the following samtools command to determin the percentage of the reads which are properly mapped to the human genome
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools flagstat restseq_data_hg.bam
1000000 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 duplicates
846933 + 0 mapped (84.69%:-nan%)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (-nan%:-nan%)
0 + 0 with itself and mate mapped
0 + 0 singletons (-nan%:-nan%)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

# bam files are consequently sorted and indexed 
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools sort bliss_data_hg.bam  bliss_data_hg_sorted
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools sort restseq_data_hg.bam restseq_data_hg_sorted

amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools index bliss_data_hg_sorted.bam
amir@amir-N551JQ:~/Desktop/samtools-0.1.8$ samtools index restseq_data_hg_sorted.bam
