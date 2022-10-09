
#Script to create circos plots. 
#1.) First create txt files for genomes and concatenate#circos steps

# creating karyotype file from dovetailCascadeFullAssemblyUnmasked.fasta python_create_circos_file2.py cascadeDovetail_genome.txt

#2.) Create synteny links between genomes using satsuma synteny 

#3.) Create circos config file used for building ideogram.  


#1.) Create a .txt file with contig lengths of the genomes to be aligned. 
#.txt file for genome 1 
 

Genome1=/home/khajdu/projects/niab/khajdu/hop/cascadeDovetail/dovetailCascadeFullAssemblyUnmasked.fasta
OutDir=/home/khajdu/projects/niab/khajdu/hop/Circos 
mkdir -p $OutDir
ProgDir=/home/khajdu/files/git_repos/scripts/Dotplot_analysis/circos
$ProgDir/python_create_circos_file2.py --genome $Genome1 --contig_prefix "cascade" > $OutDir/cascadeDovetail_genome.txt

#3.) Edit contig prefix to match step 1, this is required as contig prefix must remain uniform.

Synteny_file=/home/khajdu/projects/niab/khajdu/hop/Circos/s1s3_snps.txt            #Synteny file location and file name here  
OutDir=/home/khajdu/projects/niab/khajdu/hop/Circos/editedforcircos.chained.out    #Outfile location and file name here 
pre1=cascade  #change to your contig prefix
ProgDir=/home/khajdu/files/git_repos/scripts/Dotplot_analysis/circos
$ProgDir/Python_edit_contig_names.py --synteny $Synteny_file --contig_prefix_1 $pre1 --outfile $OutDir


#3.) Run circos
# Circos relies on a configuration file which has other branching files involved in the ideogram configuration.
# The 2D plot must link to satsuma_summary_chained_out file from previous step 


Conf=/home/khajdu/git_repos/circos/run_circos3.sh
OutDir=/home/khajdu/projects/niab/khajdu/hop/Circos
ProgDir=/home/khajdu/files/git_repos/scripts/Dotplot_analysis/circos
sbatch $ProgDir/circos.sh $Conf $OutDir



Conf=/home/khajdu/git_repos/circos/rampcircos.sh
OutDir=/home/khajdu/projects/niab/khajdu/hop/Circos
ProgDir=/home/khajdu/files/git_repos/scripts/Dotplot_analysis/circos
sbatch $ProgDir/circos.sh $Conf $OutDir



#creating histogram tracks with sliding windows
awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%1000);}' s1variant_hq.vcf | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+1000,$1);}' > S1_1000bp_window.vcf



# below setup was used for thesis figures
awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' s1variant_hq.vcf | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+1000,$1);}' > S15000000bp_window.vcf
awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' dart_cohort_filtered_snps_annotated.vcf | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+1000,$1);}' > newDArT5000000bp_window.vcf
awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' original_dart_snp_pos.txt | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+1000,$1);}' > oldDArT5000000bp_window.vcf


awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' s1variant_hq.vcf | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+5000000,$1);}' > S15Mbp_window.vcf
awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' s3variant_hq.vcf | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+5000000,$1);}' > S35Mbp_window.vcf


awk '/^#/ {next} {printf("%s\t%d\n",$1,$2-$2%5000000);}' cascade_res_genes2.txt | sort | uniq -c | awk '{printf("%s\t%s\t%d\t%s\n",$2,$3,$3+5000000,$1);}' > res5Mbp.txt


#awk '{ getline v < "S3_1000bp_window.vcf"; split( v, a ); print $1, $2, $3, $4, "0", "0", a[4]}' S1_1000bp_window.vcf > S1S3_1000bp_window.tsv
this merges the two snp position files
Scaffold_86 212000 213000 6 0 0 6
Scaffold_86 217000 218000 3 0 0 3
Scaffold_86 218000 219000 1 0 0 1
Scaffold_86 274000 275000 1 0 0 1
Scaffold_86 275000 276000 8 0 0 8
Scaffold_86 276000 277000 6 0 0 6
Scaffold_86 277000 278000 5 0 0 5
Scaffold_86 278000 279000 10 0 0 10
Scaffold_86 284000 285000 5 0 0 5
Scaffold_86 331000 332000 4 0 0 4
Scaffold_877 25000 26000 1 0 0 1

