# Hapmap_to_Linkage
R program containing functions that convert hapmap formatted marker files into linkage formatted marker files (marker file + marker info file) to use with Haploview for marker tagging and LD analysis.

Functions accept hapmap files with single letter IUPAC code (e.g. AC = M, AA = A. etc.) and are to be used with inbred lines/species only. They would need to be modified for use with lines/species with high levels of heterozygosity by accepting double letter code. These functions are also suited for unrelated lines. If individuals are related and pedigree information is available, it could be included.
