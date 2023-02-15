ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") # Creating a vector of the names of the 3 gene sequences to be loaded from NCBI GenBank

library(rentrez)  # Loading the 'rentrez' package for interacting with GenBank

Bburg <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") # Passing unique identifiers (ncbi_ids) through NCBI database to obtain corresponding sequences
# db: the name of the database to use
# id: the sequence records to obtain
# rettype: the format of the data (in this case, FASTA file)

Sequences <- strsplit(Bburg, split="\n\n") # Splitting the Bburg data into the three separate sequences
Sequences <- unlist(Sequences) # Making this a data frame

header <- gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences) # Separating the header
seq <- gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences) # Separating the sequence data
Sequences <- data.frame(Name=header,Sequence=seq) # Rejoining this to make a data frame

Sequences$Sequence <- gsub("\n", "", Sequences$Sequence) # Removing the newline characters from the Sequence column from the Sequences data frame

write.csv(Sequences, "Sequences.csv", row.names=FALSE) # Writing this dataset to a CSV file
