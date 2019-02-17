#!/usr/bin/env Rscript

#__________________________________
# Author: Allison Haaning                                                                                    
# Date: 12/7/15                                                                         
# The following functions take in HapMap formatted data frame and return linkage formatted data frames (Linkage format - data file and locus information file).  
#__________________________________

# The following function reads in a HapMap formatted file and returns a linkage format data file ####

Convert_Linkage_Format <- function(HapMap_data_frame){
  #Transposes the data frame 
  Linkage_format <- t(HapMap_data_frame)
  
  #Removes the first 11 rows of the Hapmap file, which contains info that is not included in a linkage format file:
  Linkage_format <- Linkage_format[12:nrow(Linkage_format),]
  
  #Creates new columns that must be included in the linkage format file. 
  #Unrelated Pedigree contains pedigree information for individuals. If all individuals are unrelated, they should just 
  #be numbered 1-n (number of individuals). If individuals are related and pedigree information is available, this 
  #column should be changed to describe the specific individuals in the HapMap file.
  Unrelated_Pedigree <- 1:nrow(Linkage_format)
  #Alphanumeric ID that was included in the initial HapMap file.
  ID <- rownames(Linkage_format)
  #If father is unknown, use 0. If pedigree info is available, don't use 0 here.
  Father <- rep.int(0,nrow(Linkage_format))
  #If mother is unknown, use 0. If pedigree info is available, don't use 0 here.
  Mother <- rep.int(0,nrow(Linkage_format))
  #2 encodes female. Most plants are hermaphroditic, so choosing either sex is fine. They should all be the same though.
  Sex <- rep.int(2,nrow(Linkage_format))
  #0 encodes unknown affection status.
  Affection_status <- rep.int(0,nrow(Linkage_format))
  
  #Combines the extra columns generated above in a new matrix
  Extra_columns <- cbind(Unrelated_Pedigree,ID,Father,Mother,Sex,Affection_status)
  
  #Takes each column containing SNP genotype info and copies it. For each SNP genotype, the file should include two
  #nucleotides.
  Linkage_format <- Linkage_format[,rep(1:ncol(Linkage_format),each=2)]
  
  #Combines the Extra_columns matrix generated above and the Linkage_format matrix.
  Linkage_format <- cbind(Extra_columns,Linkage_format)
  
  #Final step for formatting the matrix. The linkage format file can only contain values A, T, G, C, or 0. Anything that 
  #is not A, T, G, or C is changed to 0. N below is for missing data, and the other letters (N,R,Y,S,W,K,and M) are 
  #heterozygous calls. For inbred species, these heterozygous calls are imputed to 0 (missing data).
  Linkage_format[Linkage_format == "N"] <- 0
  Linkage_format[Linkage_format == "R"] <- 0
  Linkage_format[Linkage_format == "Y"] <- 0
  Linkage_format[Linkage_format == "S"] <- 0
  Linkage_format[Linkage_format == "W"] <- 0
  Linkage_format[Linkage_format == "K"] <- 0
  Linkage_format[Linkage_format == "M"] <- 0
  
  return(Linkage_format)
}

# The following function reads in a HapMap formatted file and returns the locus information ####

Create_Marker_Info <- function(HapMap_data_frame){
  HapMap_data_frame <- t(HapMap_data_frame)
  Marker_Name <- HapMap_data_frame[1,]
  Marker_Pos <- HapMap_data_frame[4,]
  Marker_info <- data.frame(cbind(Marker_Name,Marker_Pos))
  Marker_info$Marker_Name <- as.character(Marker_info$Marker_Name)
  Marker_info$Marker_Pos <- as.numeric(as.character(Marker_info$Marker_Pos))
  return(Marker_info)
}

#Sets working directory
setwd(".")

#Reads in a HapMap formatted file and creates a data frame:
HapMap_format <- read.table("Example_Hapmap.hmp.txt", header=TRUE, sep="\t",comment.char="",check.names = FALSE)

#Runs function to create dataframes 
Linkage_Format <- Convert_Linkage_Format(HapMap_format)
Marker_info <- Create_Marker_Info(HapMap_format)

#Writes dataframes to files which can be opened in Haploview (Linkage format - data file and locus information file)
write.table(Linkage_Format, file="linkage_format.txt",sep=" ",row.names=FALSE,col.names=FALSE)
write.table(Marker_info, file="marker_info.txt",sep="\t",row.name=FALSE,col.names=FALSE)

