# Quiz

November 30,
Attached files include:

- graphical outputs of the FASTQC package (to have a summary of data and to make sure of having a correct sequencing data)

- a short descripion of the graphs in the PDF file


December 2,
- while the majority of reads are properly mapped to the human genome, they are poorly mapped to the mouse genome. I'm assuming that reads are from a human individual.
- I aligned bliss and restseq data to the human reference genome (hg19)
- Then I used Integrated Genome Browser (IGB) to visualize bam files of bliss and restseq.
- Visualized data show that bliss is a very low-coverage sequencing data of the whole genome, in which reads are almost uniformly distributed along human chromosomes. 
- In restseq, as I had envisaged before, sequencing machine has targeted some special regions of the genome for sequencing and a few reads are potentially generated from other genomic regions.
- However, in restseq, a higher number of reads are generated from those targeted regions, compared to the average genome-wide sequencing coverage in bliss.
- To call those regions with Double Strand Breaks (DSBs), I'm in the process of analyzing bam files. 
- To call these variants, I have to know the expected potential abnormalities in the reads, after mapping them to the reference genome.
- My speculation is that observing more indels is expected, in the vicinity of DSBs.  


- IGB plot is attached.
- Codes which I have used to generate the bam files, are in the attached text file


December 5,
Information are extracted from the BAM files, using the following samtools commands,

samtools view  restseq_data_hg_sorted.bam |perl -lane 'print "$F[1]\t$F[2]\t$F[3]\t$F[4]\t$F[5]\t$F[6]\t$F[7]\t$F[8]"' > restseq_data_hg_sorted.hits


samtools view  bliss_data_hg_sorted.bam |perl -lane 'print "$F[1]\t$F[2]\t$F[3]\t$F[4]\t$F[5]\t$F[6]\t$F[7]\t$F[8]"' > bliss_data_hg_sorted.hits


Information in the restseq_data_hg_sorted.hits and bliss_data_hg_sorted.hits files are consequently summarized using codes, written in R. Please see restseq.R and bliss.R codes.

In restseq data:
I have written a code in R to extract information from the restseq file (R code is uploaded on GitHub, please see restseq.R). In each genomic position, this code calculates the total read counts and also the number of reads with indels, mapped to that position.  

In bliss data:
I have written a code in R to extract information from the bliss file. Since in the bliss data we have the whole-genome sequencing data and many reads are mapped to locations which are close to each other, to have a better visualization of data I have summarized information in genomic segments of length  10 kb (R code is uploaded on GitHub, please see bliss.R).  This code calculates the total read counts and also the number of reads with indels, mapped to genomic segments with length 10 kb. 

More results are given in Comparisions.pdf
