# Hapmap_to_Linkage
R program containing functions that convert hapmap formatted marker files into linkage formatted marker files (data file + locus information file) to use with Haploview for marker tagging and LD analysis.

Functions accept hapmap files with single letter IUPAC code (e.g. AC = M, AA = A, etc.) and are to be used with inbred lines/species only. They would need to be modified for use with lines/species with high levels of heterozygosity by accepting double letter code. These functions are also suited specifically for unrelated lines. If individuals are related and pedigree information is available, it could be included.

An example hapmap file called "Example_Hapmap.hmp.txt" is included to test the program and example output files are included that open with Haploview (tested with Version 4.2).
