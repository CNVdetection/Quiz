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
- In restseq, as I had envisaged before, sequencing machine has targeted some special regions of the genome for sequencing and no reads are generated from other genomic regions.
- However, in restseq, a higher number of reads are generated from those targeted regions, compared to the average genome-wide sequencing coverage in bliss.
- To call those regions with Double Strand Breaks (DSBs), I'm in the process of analyzing bam files. 
- To call these variants, I have to know the expected potential abnormalities in the reads, after mapping them to the reference genome.
- My gesture is that observing more indels is expected, in the vicinity of DSBs.  


- IGB plot is attached.
- Codes which I have used to generate the bam files, are in the attached text file


