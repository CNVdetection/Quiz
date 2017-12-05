#This code is used to extract information, from bliss data. This code aggregates information (total number of reads and read with indels)
#in genomic segments of length 10000 bp.
mydata = read.table("D:/bliss_data_hg_sorted.hits")

MID=mydata[,5]
L=length(MID);
indels <- matrix(c(rep(0,1000000*3)), ncol=3, nrow=1000000,byrow=T)

for (i in 1:L){
     CIGAR  =toString(MID[i])
     CIGAR_L=nchar(CIGAR)
     V <- unlist(strsplit(CIGAR, "[M I D]"))
     j <- 1
     index <-1
     while (j <= CIGAR_L){
                  if (substr(CIGAR,j,j)=="M"){
                      indels[i,1] <- indels[i,1]+as.numeric(V[index])
                      index <- index +1
                  }else if(substr(CIGAR,j,j)=="I"){
                      indels[i,2] <- indels[i,2]+as.numeric(V[index])
                      index <- index +1             
                  }else if(substr(CIGAR,j,j)=="D"){
                      indels[i,3] <- indels[i,3]+as.numeric(V[index])
                      index <- index +1    
                  }
                  j <- j+1
     }
 
}

removed_duplicated_pos <- matrix()
indels_sum_at_each_position <- matrix()
number_of_indels <- indels[1,2]+indels[1,3] 
reads_with_indels <- matrix()
if ((indels[1,2]+indels[1,3])>0){
     rwi <- 1
}else{
     rwi <- 0
}
s=1
number_of_mapped_reads <- matrix()
number_of_read <- 1

i=1 # this is the index of reference read
j=1
while ((i<=L)&&(j<=L)){
     chromo           <- mydata[i,2]
     mapping_position <- mydata[i,3]
     if ((j<=L)&&(chromo==mydata[j+1,2])&&((mydata[j+1,3]-mapping_position)<10000)){
         number_of_indels <- number_of_indels + (indels[j+1,2]+indels[j+1,3]);
         if ((indels[j+1,2]+indels[j+1,3])>0){
              rwi <- rwi + 1;
         }
         number_of_read <- number_of_read +1;
         j=j+1
     }else{
            if (s==1){
                removed_duplicated_pos[1] = mydata[i,1]
                removed_duplicated_pos[2] = as.character(mydata[i,2])
                removed_duplicated_pos[3] = mydata[i,3]
                removed_duplicated_pos[4] = mydata[i,4]
                indels_sum_at_each_position[1] = number_of_indels
                number_of_mapped_reads[1] = number_of_read
                reads_with_indels[1] = rwi
                s=2
             }
             else{
                removed_duplicated_pos=rbind(removed_duplicated_pos,c(mydata[i,1],as.character(mydata[i,2]),mydata[i,3],mydata[i,4]))
                indels_sum_at_each_position = rbind(indels_sum_at_each_position,number_of_indels)
                reads_with_indels = rbind(reads_with_indels,rwi)
                number_of_mapped_reads = rbind(number_of_mapped_reads,number_of_read) 
             }
             number_of_indels <- indels[j+1,2]+indels[j+1,3]
             if ((indels[j+1,2]+indels[j+1,3])>0){
                  rwi <- 1
             }else{
                  rwi <- 0
             }
             number_of_read <- 1
             j=j+1
             i=j
     }
}
ALL=cbind(removed_duplicated_pos,number_of_mapped_reads,reads_with_indels,indels_sum_at_each_position)
write.table(ALL,"D:\\allbliss.txt",sep = "\t",col.names = FALSE,row.names = FALSE)