##This document details commands used for the alignments and SNP calling of hop whole genome and DArT sequences against the Cascade Dovetail reference genome 

## ----------------------0.Download reference genomes---------------------------------------------------------------------------------------

## download the cascade Dovtail reference
# wget: http://hopbase.cqls.oregonstate.edu/content/cascadeDovetail/assemblyData/dovetailCascadeFullAssemblyUnmasked.fasta.gz

### Pilgrim and 316/1/10 raw sequences were moved to project directory from /archives/2020_niabemr_general/H204SC20021075_batch1_20200313
### Pilgrim (S1) and 316/1/10 (S3) P150x2 sequences were generaged on illumina novaseq6000 platform 
##DArT sequence reads were moved to project dierectory from /archives/2021_eastmall_general/klara_hajdu_hop_dartseq/hop_dartseq

# Pilgrim and 316/1/16 data was transferred from niab hpc to cropdiversity  

#--------------------------------------------1. Removing sequencing adapters from DArT raw reads-----------------------------------------------------------------------


for Strain in 2446998 2446999 2447000 2447001 2447002 2447003 2447004 2447005 2447006 2447007 2447008 2447009 2447010 2447011 2447012 2447013 2447014 2447015 2447016 2447017 2447018 2447019 2447020 2447021 2447022 2447023 2447024 2447025 2447026 2447027 2447028 2447029 2447030 2447031 2447032 2447033 2447034 2447035 2447036 2447037 2447038 2447039 2447040 2447041 2447042 2447043 2447044 2447045 2447046 2447047 2447048 2447049 2447050 2447051 2447052 2447053 2447054 2447055 2447056 2447057 2447058 2447059 2447060 2447061 2447062 2447063 2447064 2447065 2447066 2447067 2447068 2447069 2447070 2447071 2447072 2447073 2447074 2447075 2447076 2447077 2447078 2447079 2447080 2447081 2447082 2447083 2447084 2447085 2447086 2447087 2447088 2447089 2447090 2447091 2447093 2447094 2447095 2447096 2447097 2447098 2447099 2447100 2447101 2447102 2447103 2447104 2447105 2447106 2447107 2447108 2447109 2447110 2447111 2447112 2447113 2447114 2447115 2447116 2447117 2447118 2447119 2447120 2447121 2447122 2447123 2447124 2447125 2447126 2447127 2447128 2447129 2447130 2447131 2447132 2447133 2447134 2447135 2447136 2447137 2447138 2447139 2447140 2447141 2447142 2447143 2447144 2447145 2447146 2447147 2447148 2447149 2447150 2447151 2447152 2447153 2447154 2447155 2447156 2447158 2447159 2447160 2447161 2447162 2447163 2447164 2447165 2447166 2447167 2447168 2447169 2447170 2447171 2447172 2447173 2447174 2447175 2447176 2447177 2447179 2447180 2447181 2447182 2447183 2447184 2447185 2447186 2472650 2472651 2472652 2472653 2472654 2472655 2472656 2472657 2472658 2472659 2472660 2472661 2472662 2472663 2472664 2472665 2472666 2472667 2472668 2472669 2472670 2472671 2472672 2472673 2472674 2472675 2472676 2472677 2472678 2472679 2472680 2472681 2447178; do
  for input in /home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/*.FASTQ; do
    IlluminaAdapters=/home/khajdu/files/git_repos/scripts/hop_genomics/dna_qc/illumina_full_adapters.fa
    ProgDir=/home/khajdu/git_repos/files/dna_qc
    OutDir=projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/trim 
    mkdir -p OutDir
    sbatch $ProgDir/fastq-mcf.sh $input $IlluminaAdapters $Outdir $Strain
  done
done

# S1 S3 sequences were trimmed in previous snp calling attempt

##------------------------------------------2. Estimate genome coverage of dart sequences----------------------------------------------------------------------------------


## ~20x coverage of this size genomes is sufficient for SNP calling.

for Strain in 2446998 2446999 2447000 2447001 2447002 2447003 2447004 2447005 2447006 2447007 2447008 2447009 2447010 2447011 2447012 2447013 2447014 2447015 2447016 2447017 2447018 2447019 2447020 2447021 2447022 2447023 2447024 2447025 2447026 2447027 2447028 2447029 2447030 2447031 2447032 2447033 2447034 2447035 2447036 2447037 2447038 2447039 2447040 2447041 2447042 2447043 2447044 2447045 2447046 2447047 2447048 2447049 2447050 2447051 2447052 2447053 2447054 2447055 2447056 2447057 2447058 2447059 2447060 2447061 2447062 2447063 2447064 2447065 2447066 2447067 2447068 2447069 2447070 2447071 2447072 2447073 2447074 2447075 2447076 2447077 2447078 2447079 2447080 2447081 2447082 2447083 2447084 2447085 2447086 2447087 2447088 2447089 2447090 2447091 2447093 2447094 2447095 2447096 2447097 2447098 2447099 2447100 2447101 2447102 2447103 2447104 2447105 2447106 2447107 2447108 2447109 2447110 2447111 2447112 2447113 2447114 2447115 2447116 2447117 2447118 2447119 2447120 2447121 2447122 2447123 2447124 2447125 2447126 2447127 2447128 2447129 2447130 2447131 2447132 2447133 2447134 2447135 2447136 2447137 2447138 2447139 2447140 2447141 2447142 2447143 2447144 2447145 2447146 2447147 2447148 2447149 2447150 2447151 2447152 2447153 2447154 2447155 2447156 2447158 2447159 2447160 2447161 2447162 2447163 2447164 2447165 2447166 2447167 2447168 2447169 2447170 2447171 2447172 2447173 2447174 2447175 2447176 2447177 2447179 2447180 2447181 2447182 2447183 2447184 2447185 2447186 2472650 2472651 2472652 2472653 2472654 2472655 2472656 2472657 2472658 2472659 2472660 2472661 2472662 2472663 2472664 2472665 2472666 2472667 2472668 2472669 2472670 2472671 2472672 2472673 2472674 2472675 2472676 2472677 2472678 2472679 2472680 2472681 2447178; do
  for input in /home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/trim/*trimmed.FASTQ; do
    Outdir=/home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"
    mkdir -p $Outdir
    ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/dna_qc
    sbatch $ProgDir/count_nucl_unpaired.sh $input 3000 $Outdir #Estimated genome size
  done
done

# S1 S3 genome coverages were estimated in previous snp calling attempt

##------------------------------------------3. Carryout alignment of genomes (bowtie2)-----------------------------------------------

# bowtie and gatk were run from /home/khajdu/miniconda3/envs/snp_calling

#non paired end alignments
Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in 2446998 2446999 2447000 2447001 2447002 2447003 2447004 2447005 2447006 2447007 2447008 2447009 2447010 2447011 2447012 2447013 2447014 2447015 2447016 2447017 2447018 2447019 2447020 2447021 2447022 2447023 2447024 2447025 2447026 2447027 2447028 2447029 2447030 2447031 2447032 2447033 2447034 2447035 2447036 2447037 2447038 2447039 2447040 2447041 2447042 2447043 2447044 2447045 2447046 2447047 2447048 2447049 2447050 2447051 2447052 2447053 2447054 2447055 2447056 2447057 2447058 2447059 2447060 2447061 2447062 2447063 2447064 2447065 2447066 2447067 2447068 2447069 2447070 2447071 2447072 2447073 2447074 2447075 2447076 2447077 2447078 2447079 2447080 2447081 2447082 2447083 2447084 2447085 2447086 2447087 2447088 2447089 2447090 2447091 2447093 2447094 2447095 2447096 2447097 2447098 2447099 2447100 2447101 2447102 2447103 2447104 2447105 2447106 2447107 2447108 2447109 2447110 2447111 2447112 2447113 2447114 2447115 2447116 2447117 2447118 2447119 2447120 2447121 2447122 2447123 2447124 2447125 2447126 2447127 2447128 2447129 2447130 2447131 2447132 2447133 2447134 2447135 2447136 2447137 2447138 2447139 2447140 2447141 2447142 2447143 2447144 2447145 2447146 2447147 2447148 2447149 2447150 2447151 2447152 2447153 2447154 2447155 2447156 2447158 2447159 2447160 2447161 2447162 2447163 2447164 2447165 2447166 2447167 2447168 2447169 2447170 2447171 2447172 2447173 2447174 2447175 2447176 2447177 2447179 2447180 2447181 2447182 2447183 2447184 2447185 2447186 2472650 2472651 2472652 2472653 2472654 2472655 2472656 2472657 2472658 2472659 2472660 2472661 2472662 2472663 2472664 2472665 2472666 2472667 2472668 2472669 2472670 2472671 2472672 2472673 2472674 2472675 2472676 2472677 2472678 2472679 2472680 2472681 2447178; do
  for input in /home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/trim/*trimmed.FASTQ; do
    OutDir=/home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/haplotypecall
    mkdir -p $OutDir
    ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/bowtie_19.7.sh $Reference $input $OutDir $Strain
  done
done

#paired end alignments
for StrainPath in /home/khajdu/projects/niab/hop/raw_read; do
   Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
   F_Read=$StrainPath/S1/F/*.fq
   R_Read=$StrainPath/S1/R/*.fq
   strain=$(echo $F_Read | rev | cut -f3 -d '/' | rev)
   OutDir=/home/khajdu/projects/niab/hop/S1_alignment
   mkdir -p $OutDir
   ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
   sbatch $ProgDir/run_bowtie_test.sh $Reference $F_Read $R_Read $OutDir $strain
done

for StrainPath in /home/khajdu/projects/niab/hop/raw_read; do
   Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
   F_Read=$StrainPath/S3/F/*.fq
   R_Read=$StrainPath/S3/R/*.fq
   strain=$(echo $F_Read | rev | cut -f3 -d '/' | rev)
   OutDir=/home/jconnell/projects/niab/hop/S3_alignment
   mkdir -p $OutDir
  ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
   sbatch $ProgDir/run_bowtie_test.sh $Reference $F_Read $R_Read $OutDir $strain
done



##-----------------------------------------4. Remove multimapping reads, discordant reads, optical duplicates (samtools)--------------------------------------------------- 

##and add read group and sample name to each mapped read. 
  

for Strain in S1 S3; do 
  for input in /home/khajdu/projects/niab/hop/"$Strain"_alignment/"$Strain"_genome_aligned.sam; do
    OutDir=projects/niab/khajdu/hop/raw_data/trim/"$Strain"/alignments_Dovetail/nomulti
    mkdir -p $OutDir  
    ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/pre_SNP_calling.slurm2.sh $input $Strain $OutDir
  done
done

#this worked and put things in outdir locatiocdn
for Strain in 2446998 2446999 2447000 2447001 2447002 2447003 2447004 2447005 2447006 2447007 2447008 2447009 2447010 2447011 2447012 2447013 2447014 2447015 2447016 2447017 2447018 2447019 2447020 2447021 2447022 2447023 2447024 2447025 2447026 2447027 2447028 2447029 2447030 2447031 2447032 2447033 2447034 2447035 2447036 2447037 2447038 2447039 2447040 2447041 2447042 2447043 2447044 2447045 2447046 2447047 2447048 2447049 2447050 2447051 2447052 2447053 2447054 2447055 2447056 2447057 2447058 2447059 2447060 2447061 2447062 2447063 2447064 2447065 2447066 2447067 2447068 2447069 2447070 2447071 2447072 2447073 2447074 2447075 2447076 2447077 2447078 2447079 2447080 2447081 2447082 2447083 2447084 2447085 2447086 2447087 2447088 2447089 2447090 2447091 2447093 2447094 2447095 2447096 2447097 2447098 2447099 2447100 2447101 2447102 2447103 2447104 2447105 2447106 2447107 2447108 2447109 2447110 2447111 2447112 2447113 2447114 2447115 2447116 2447117 2447118 2447119 2447120 2447121 2447122 2447123 2447124 2447125 2447126 2447127 2447128 2447129 2447130 2447131 2447132 2447133 2447134 2447135 2447136 2447137 2447138 2447139 2447140 2447141 2447142 2447143 2447144 2447145 2447146 2447147 2447148 2447149 2447150 2447151 2447152 2447153 2447154 2447155 2447156 2447158 2447159 2447160 2447161 2447162 2447163 2447164 2447165 2447166 2447167 2447168 2447169 2447170 2447171 2447172 2447173 2447174 2447175 2447176 2447177 2447179 2447180 2447181 2447182 2447183 2447184 2447185 2447186 2472650 2472651 2472652 2472653 2472654 2472655 2472656 2472657 2472658 2472659 2472660 2472661 2472662 2472663 2472664 2472665 2472666 2472667 2472668 2472669 2472670 2472671 2472672 2472673 2472674 2472675 2472676 2472677 2472678 2472679 2472680 2472681 2447178; do
  for input in /home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/alignment/"$Strain"_aligned.sam; do
    OutDir=/home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/alignment/nomulti
    mkdir -p $OutDir
    ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/pre_SNP_calling_unpaired.slurm.sh $input $Strain $OutDir
  done 
done  


#------------------------------------- 5. pre indel realingment and indel realignment for S1 and S3 only-------------------------------------------------------------------------

Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in S1 S3; do
  for input in /home/khajdu/projects/niab/khajdu/$Strain/"$Strain"_genome_aligned_nomulti_proper_sorted_nodup_rg.bam; do
    echo $Strain
    Outdir=/home/khajdu/projects/niab/khajdu/$Strain/pre_realigner_intervals
    mkdir -p $Outdir
    ProgDir=/home/khajdu/git_repos/files/
    sbatch $ProgDir/pre_indel_realignment.sh $Reference $input $Strain $Outdir
  done 
done  

Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in S1 S3; do
 for input in /home/khajdu/projects/niab/khajdu/$Strain/"$Strain"_genome_aligned_nomulti_proper_sorted_nodup_rg.bam; do
    target_intervals=/home/khajdu/projects/niab/khajdu/$Strain/pre_realigner_intervals/realigner.intervals
    echo $Strain
    Outdir=/home/khajdu/projects/niab/khajdu/$Strain/pre_realigner_intervals
    mkdir -p $Outdir
    ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/indel_realignment_v2.sh $Reference $Strain $input $target_intervals $Outdir
  done 
done  


##----------------------------------------6. Submit bam files from step 6. for SNP calling with haplotype caller in gvcf module (gatk) --------------------------------


Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in S1 S3; do
  for input in /home/khajdu/projects/niab/khajdu/"$Strain"/pre_realigner_intervals/"$Strain"_realigned.bam; do
    echo $Strain
    Outdir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/$Strain/
    mkdir -p $Outdir
    ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/haplotyp_caller_v2.sh $Reference $Strain $input $Outdir
  done 
done  

#didnt put files in outdir, manually copied them in a common folder as per step 8.
Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in 2446998 2446999 2447000 2447001 2447002 2447003 2447004 2447005 2447006 2447007 2447008 2447009 2447010 2447011 2447012 2447013 2447014 2447015 2447016 2447017 2447018 2447019 2447020 2447021 2447022 2447023 2447024 2447025 2447026 2447027 2447028 2447029 2447030 2447031 2447032 2447033 2447034 2447035 2447036 2447037 2447038 2447039 2447040 2447041 2447042 2447043 2447044 2447045 2447046 2447047 2447048 2447049 2447050 2447051 2447052 2447053 2447054 2447055 2447056 2447057 2447058 2447059 2447060 2447061 2447062 2447063 2447064 2447065 2447066 2447067 2447068 2447069 2447070 2447071 2447072 2447073 2447074 2447075 2447076 2447077 2447078 2447079 2447080 2447081 2447082 2447083 2447084 2447085 2447086 2447087 2447088 2447089 2447090 2447091 2447093 2447094 2447095 2447096 2447097 2447098 2447099 2447100 2447101 2447102 2447103 2447104 2447105 2447106 2447107 2447108 2447109 2447110 2447111 2447112 2447113 2447114 2447115 2447116 2447117 2447118 2447119 2447120 2447121 2447122 2447123 2447124 2447125 2447126 2447127 2447128 2447129 2447130 2447131 2447132 2447133 2447134 2447135 2447136 2447137 2447138 2447139 2447140 2447141 2447142 2447143 2447144 2447145 2447146 2447147 2447148 2447149 2447150 2447151 2447152 2447153 2447154 2447155 2447156 2447158 2447159 2447160 2447161 2447162 2447163 2447164 2447165 2447166 2447167 2447168 2447169 2447170 2447171 2447172 2447173 2447174 2447175 2447176 2447177 2447179 2447180 2447181 2447182 2447183 2447184 2447185 2447186 2472650 2472651 2472652 2472653 2472654 2472655 2472656 2472657 2472658 2472659 2472660 2472661 2472662 2472663 2472664 2472665 2472666 2472667 2472668 2472669 2472670 2472671 2472672 2472673 2472674 2472675 2472676 2472677 2472678 2472679 2472680 2472681 2447178; do
  for input in /home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/haplotypecall/"$Strain"_aligned_nomulti_sorted_nodup_rg.bam; do
   OutDir=/home/khajdu/projects/niab/khajdu/hop/dartseq/unpaired_reads/"$Strain"/haplotypecall
  mkdir -p $OutDir
  ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/SNP_calling
  sbatch $ProgDir/haplotyp_caller_unpaired.sh $Reference $Strain $input $Outdir
  done
done

Plate1
2447086 DH21-5921 Hop Humulus lupulus L.  PIL
2447087 DH21-5921 Hop Humulus lupulus L.  PIL
2447088 DH21-5921 Hop Humulus lupulus L.  316
2447089 DH21-5921 Hop Humulus lupulus L.  316
2447090 DH21-5921 Hop Humulus lupulus L.  CAS
2447091 DH21-5921 Hop Humulus lupulus L.  CAS

Plate2
2447181 DH21-5921 Hop Humulus lupulus L.  PIL
2447182 DH21-5921 Hop Humulus lupulus L.  PIL
2447183 DH21-5921 Hop Humulus lupulus L.  316
2447184 DH21-5921 Hop Humulus lupulus L.  316
2447185 DH21-5921 Hop Humulus lupulus L.  CAS
2447186 DH21-5921 Hop Humulus lupulus L.  CAS


#cascade 10 "chromosomes" largest to smallest
Scaffold_1531
Scaffold_1533
Scaffold_172
Scaffold_19
Scaffold_191
Scaffold_24
Scaffold_49 
Scaffold_73 
Scaffold_76
Scaffold_77

##-----------------------------------------7. copy gvcf from individual haplotype calls to shared folder -------------------------------------------------------------------

for strain in /home/khajdu/projects/niab/khajdu/khajdu_3045*/*_SNP_calls.g.vcf; do
file=$(basename $strain)
echo $file
OutDir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/S1S3_DovetailCohort/filtered_gatk
cp $strain $OutDir
done


#copy S1 and S3 gvcf files from working directory

for strain in /home/khajdu/projects/niab/khajdu/hop/SNP_calling/$strain/*_SNP_calls.g.vcf; do
file=$(basename $strain)
echo $file
OutDir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/S1S3_DovetailCohort/filtered_gatk
cp $strain $OutDir
done

##reference genome with .dict and .fa should also be copied over


##-------------------------------------------------------8.  submit g.vcf files generated from haplotype caller step ----------------------------------------------------
## filter for only biallelic SNPs. 

# genotype gvcf cannot take multiple GVCF files in one command 

# this was done in two steps
#first vcf containing snps called from S1 and S3
ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/SNP_calling
sbatch $ProgDir/genotype_gvcf2.sh 

#next snps called from 200 unpaired dart sequence tags
ProgDir=/home/khajdu/files/git_repos/scripts/hop_genomics/SNP_calling
sbatch $ProgDir/genotype_gvcf2_re.sh 


#--------------------------------------------9. Hard filter variants (gatk)---------------------------------------------------------------------------------------- 

# 9.a Hard filtering variants with GATK
#quality filtering criteria "QD < 2.0 || QUAL < 30.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || SOR > 3 || ReadPosRankSum < -8.0" 


# GATK VariantFiltration on S1 S3 genotyped vcf 
# error: scaffolds must be contiguous
# picard sort 
picard=/home/khajdu/miniconda3/envs/snp_calling/share/picard-2.18.29-0/picard.jar
java -jar $picard SortVcf \
   I= S1S3_DovetailCohort_SNPs_genotype.vcf \
   O= S1S3_DovetailCohort_SNPs_genotype.vcf_sorted.vcf

# still don't work, error : FORMAT '43573' at Scaffold_1533:23196528 is not defined in the header
Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
for Strain in S1S3_DovetailCohort; do
  for vcf in  projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/"$Strain"/*_sorted.vcf; do
    Outdir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/$Strain/filtered_v1v3
    mkdir -p $Outdir
    ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
    sbatch $ProgDir/variant_hard_filter4.sh $Reference $Strain $vcf $Outdir
 done 
done 
#still don't work
## S1S3 genotyped vcf badly called, only half the file was genotyped. missing calls after Scaffold_1533:23196528 

#check if GVCF was already faulty (no calls) after this position:
bcftools query -e'QUAL="."' -f'%CHROM %POS [%GT] %ID %REF %ALT %QUAL\n' S1_SNP_calls.g.vcf > count_variant_sites_in_input_GVCFs
bcftools query -e'QUAL="."' -f'%CHROM %POS [%GT] %ID %REF %ALT %QUAL\n' S3_SNP_calls.g.vcf > count_variant_sites_in_input_GVCFs
# gvcfs are fine, same check done on DARt gvcfs.


# GATK filtering on full cohort genotype vcf

#didn't work
#Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
#vcf=projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/dovetailCascadeFullAssemblyUnmasked_SNPs_genotype_v3.vcf
#Outdir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered
#mkdir -p $Outdir
#ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
#sbatch $ProgDir/variant_hard_filter5.sh $Reference $vcf $Outdir
#this produced raw_indels and raw_snps but didn't filter

##filtering again
#Reference=/home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta
#vcf=projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered/cohort_raw_indels.vcf
#Outdir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered
#mkdir -p $Outdir
#ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
#sbatch $ProgDir/variant_hard_filter5.6.sh $Reference $vcf $Outdir


#switching to gatk4 gatk=/home/khajdu/miniconda3/envs/snp_calling/share/gatk4-4.2.6.1-1

#Reference=projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/dovetailCascadeFullAssemblyUnmasked.fasta
#vcf=projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/dovetailCascadeFullAssemblyUnmasked_SNPs_genotype_v3.vcf
#Outdir=/home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered
#mkdir -p $Outdir
#ProgDir=/home/khajdu/git_repos/files/git_repos/scripts/hop_genomics/SNP_calling
#sbatch $ProgDir/variant_hard_filter5.sh $Reference $vcf $Outdir


# truncated combined genotype vcf files! in gvcfs a lot more snps were called. prob genotypegvcf ran out of memory, need to be repeated
#both S1 gvcf and S3 gvcf have complete snp set called so dont need to go back further 

#giving up on GATK filtering...

########################################################################################

## ---------------------------------------10. Filtering with bcftools to make snpEff compatible vcf --------------------------------------------------------------------

#vcf=projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered
# conda create -n sambcfenv samtools bcftools
# ca sambcfenv  

#10.a
bcftools view -s S1, S3 cohort_raw_snps.vcf >S1S3_snps_only.vcf  #extracting info from two parents only
bcftools view -s S1, S3 cohort_raw_snps.vcf >S1S3_indels_only.vcf #extracting info from two parents only

bcftools view -Ou -s sample1,sample2 file.vcf | bcftools query -f %INFO/AC\t%INFO/AN\n

#10.b filtering using the same criteria as attempted with GATK, this was done in two steps (for no particular reason)
bcftools filter -O z -o filtered_S1S3.vcf -i '%QUAL>30' S1S3_snps_only.vcf
bcftools filter -O z -o S1S3_filtered_snps.vcf -i 'QD>3 & SOR<3 &  FS<60 & MQ>40 & ReadPosRankSum>-8 & MQRankSum>-12.5' filtered_S1S3.vcf

#S1S3 snp count:
12442348 S1S3_snps_only.vcf
2801646 S1S3_filtered_snps.



#10.c repeat 10b on full cohort
bcftools filter -O z -o filtered_cohort.vcf -i '%QUAL>30' cohort_raw_snps.vcf
bcftools filter -O z -o full_cohort_filtered_snps.vcf -i 'QD>3 & SOR<3 &  FS<60 & MQ>40 & ReadPosRankSum>-8 & MQRankSum>-12.5' filtered_cohort.vcf
vcf


#SNPs and INDELs called from S1 S3    13876239
#from which SNPs                      12506098
#from which INDELs                    1370141
  
#snps after filtering with bcftools   2812547
#indels after filtering with bcftools 36311
#SNP per base after filtering         1061.366063


#extracting separate S1 S3 snps

bcftools query -i 'TYPE="SNP"' -f '%CHROM %POS %REF %ALT GTs:[ %GT] %QUAL %QD %FS %MQ %MQRankSum %ReadPosRankSum\n' S1S3_filtered_snps.vcf > filtered_S1S3_genotypeinfo.txt

#separate filtered SNPs present in S1 and S3
awk -F' ' '$6 == "./."' filtered_S1S3_genotypeinfo.txt > S3_filtered_snps.txt
awk -F' ' '$7 == "./."' filtered_S1S3_genotypeinfo.txt > S1_filtered_snps.txt
awk -F' ' '$7 != "./." && $6 != "./."' filtered_S1S3_genotypeinfo.txt > S1S3_shared_snps.txt

Sample ,S1,S3,Total
Transitions ,1484970,1349302,2834272
Transversions ,863688,781742,1645430
Ts/Tv ,1.719,1.726,1.723

82679 S1_filtered_snps.txt
63467 S3_filtered_snps.txt
2653924 S1S3_shared_snps.txt
# square brackets[] to extract from FORMAT field, eg bcftools query -f '%CHROM %POS[\t%GT\t%PL]\n' file.bcf | head -3




##-------------------------------------------------11. Plot filtering results (R)------------------------------------------------------------------------

##setwd("C:/Users/hajdk/OneDrive/New folder/Thesis/Chapter4_Hop_genome_analysis")
##library('ggplot2')
##library('tools')
##library('tidyverse')
##library('ggpubr')
##
##
##df1<-read.table("cohort_snps_stats.tsv" , sep = '\t', header = TRUE)
##
##str(df1)
##
##df1$PASS <- df1$FILTER
##df1$PASS[df1$PASS!="PASS"] <- "FAIL"
##df1$PASS <- as.factor(df1$PASS)
#### Histogram with density plot
##geom_histogram(aes(y=..density..), alpha=0.2, bins=50)
##
##p0 <- ggplot(df1, aes(x=QD)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p0)
##ggsave("../QD_all.pdf", p0)
##
##p1 <- ggplot(df1, aes(x=QD, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="right") 
##print(p1)
##
##p2 <- ggplot(df1, aes(x=FS, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="") +
##  scale_x_continuous(trans='log10')
##print(p2)
##
##p3 <- ggplot(df1, aes(x=SOR, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p3)
##
##p4 <- ggplot(df1, aes(x=MQ, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p4)
##
##p5 <- ggplot(df1, aes(x=MQRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p5)
##
##p6 <- ggplot(df1, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p6)
##
##
##df2<-read.table("cohort_indels_stats.tsv" , sep = '\t', header = TRUE)
##
##str(df1)
##
##df2$PASS <- df2$FILTER
##df2$PASS[df2$PASS!="PASS"] <- "FAIL"
##df2$PASS <- as.factor(df1$PASS)
#### Histogram with density plot
##geom_histogram(aes(y=..density..), alpha=0.4, bins=50)
##
##p7 <- ggplot(df2, aes(x=QD, colour=PASS, fill=PASS)) +
## geom_density(alpha=.4) +
##  theme(legend.position="none")
##print(p7)
##
##p8 <- ggplot(df2, aes(x=FS, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none") +
##  scale_x_continuous(trans='log10')
##print(p8)
##
##p9 <- ggplot(df2, aes(x=ReadPosRankSum, colour=PASS, fill=PASS)) +
##  geom_density(alpha=.2) +
##  theme(legend.position="none")
##print(p9)


##--------------------------------------------12. Annotate filtered VCF file for SNP effects (snpeff)---------------------------------------------------------------------------------- 


# Install snpEff 
cd /mnt/shared/scratch/khajdu/apps
mkdir snpEff 

# Download latest version
#wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip

# Unzip file
#unzip snpEff_latest_core.zip

# update java environment and create env to run snpEff from
# conda create -n jdk11 openjdk=11
# conda activate jdk11


## Create custom SnpEff genome database

```bash
SnpEff=/mnt/shared/scratch/khajdu/apps/snpEff
nano $SnpEff/snpEff.config

## Add the following lines to the section with databases:

```
##---
## EMR Databases
##----
## H. lupulus cascade genome #non specific, needs to be recognisable relative to the organims/genome
## cascadeDovetail.genome : hop_ref2022 #name before .genome is the prefix snpEff uses for the downstream steps, needs to be consistent
## H. lupulus cascade genome
## cascadeDovetailTM.genome : hop_ref2022 Maker and Transdecoder merged annotationss
```

##Collect input files


# formatting gff3 files for snpEff database building step

#home/khajdu/projects/niab/khajdu/hop/gene_prediction/cascadeDovetail/*.gff3 # makerGenes.gff3 and transcripts.fasta.transdecoder.genomeCentric.gff3 contain the full set of annotations

#1. remove bad lines from maker gene model file (anything that wasn't predicted with maker as these confuse snpEff database building)
cd projects/niab/khajdu/hop/gene_predictions/cascadeDovetail
more makerGenes.gff3 | grep '##gff-version 3\|maker' > makerGenes.gff

#2. copy gff files to snpeff folder and merge annotations: 
# from projects/niab/khajdu/hop/gene_predictions/cascadeDovetail
cp makerGenes.gff transcripts.fasta.transdecoder.genomeCentric.gff3 /mnt/shared/scratch/khajdu/apps/snpEff/data
cd /mnt/shared/scratch/khajdu/apps/snpEff/data
conda activate agat #first copy agat env from /mnt/shared/jconnell/apps/miniconda3/envs to /home/khajdu/miniconda3/envs
agat_sp_merge_annotations.pl --gff makerGenes --gff transcripts.fasta.transdecoder.genomeCentric.gff3 --out combinedDovetailTM.gff3

#3. run snpEff build
conda activate jdk11 
Reference=$(ls /home/khajdu/projects/niab/hop/genome/dovetailCascadeFullAssemblyUnmasked.fasta)
Gff3=$(ls /mnt/shared/scratch/snpEff/data/combinedDovetailTM.gff3) #
SnpEff=/mnt/shared/scratch/khajdu/apps/snpEff
snpeffdir=/mnt/shared/scratch/khajdu/apps/snpEff/data/cascadeDovetailTM #this is the correct filepath snpEff will recognise
mkdir -p $snpeffdir
cp $Reference $snpeffdir/sequences.fa #this is the correct naming snpEff will recognise
cp $Gff3 $snpeffdir/genes.gff #this is the correct naming snpEff will recognise
cd $SnpEff
java -Xmx4g -jar snpEff.jar build -gff3 -v cascadeDovetailTM -noCheckCds -noCheckProtein

#4.Annotate VCF files (S1S3 only first)
CurDir=/mnt/shared/scratch/khajdu/apps/snpEff
cd $CurDir
for a in $(ls /home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered/*_filtered_snps.vcf); do # full_cohort_filtered_snps.vcf with 200 DArt and 2 parent files, S1S3_filtered_snps.vcf with only two parents 
    echo $a
    filename=$(basename "$a")
    Prefix=${filename%.vcf}
    OutDir=$(ls -d /home/khajdu/projects/niab/khajdu/hop/SNP_calling/haplotype_calls_v3/cohort_filtered/snpeffTM)
    #mkdir -p $Outdir
    SnpEff=/mnt/shared/scratch/khajdu/apps/snpEff
    java -Xmx4g -jar $SnpEff/snpEff.jar -v -ud 0 cascadeDovetailTM $a > $OutDir/"$Prefix"_annotated.vcf
    mv snpEff_genes.txt $OutDir/snpEff_genes_"$Prefix".txt
    mv snpEff_summary.html $OutDir/snpEff_summary_"$Prefix".html
done


#submitted scripts below from the directory where files are located: /projects/hop/SNP_calling/haplotype_calls/cohort 
  ```bash 
    SnpEff=/mnt/shared/scratch/khajdu/apps/snpEff
    file=
    prefix=${basename "$file"}
    #mv cohort_filtered_snps* $OutDir/.
    #-
    #Create subsamples of SNPs containing those in a given category
    #-
    #genic (includes 5', 3' UTRs)
    java -jar $SnpEff/SnpSift.jar filter "(ANN[*].EFFECT has 'missense_variant') || (ANN[*].EFFECT has 'nonsense_variant') || (ANN[*].EFFECT has 'synonymous_variant') || (ANN[*].EFFECT has 'intron_variant') || (ANN[*].EFFECT has '5_prime_UTR_variant') || (ANN[*].EFFECT has '3_prime_UTR_variant')" S1S3_filtered_snps_annotated.vcf > S1S3_dovetail_filtered_snps_genic.vcf
    #coding
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant') || (ANN[0].EFFECT has 'synonymous_variant')" S1S3_filtered_snps_annotated.vcf > S1S3_dovetail_filtered_snps_coding.vcf
    #non-synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'missense_variant') || (ANN[0].EFFECT has 'nonsense_variant')" S1S3_filtered_snps_annotated.vcf > S1S3_dovetail_filtered_snps_nonsyn.vcf
    #synonymous
    java -jar $SnpEff/SnpSift.jar filter "(ANN[0].EFFECT has 'synonymous_variant')" S1S3_filtered_snps_annotated.vcf > S1S3_dovetail_filtered_snps_syn.vcf
    #Four-fold degenrate sites (output file suffix: 4fd)
   ```


grep -v '#' | wc -l S1S3_filtered_snps_annotated.vcf

#extract genic snps from snpeff annotated vcf
more S1S3_filtered_snps_annotated.vcf | grep -v '#' | grep "PASS" | cut -f 1,2,8,10,11 | sed 's/|/\t/g' | cut -f 1,2,4,5,7 | grep -v "intergenic\|stream" > cohort_filtered_snps_annotated_no_intergenic 


#manipulate snpeff vcf:

# grep -v "" takes every line that start with " 
# wc -l counts  
# cut -f will take whole columns from a file , numbers to define which ones
# cut -f 1 | sort | uniq | wc -l  take a column and removes duplicates
# sed 's/|/\t/g' will put things in separate columns that had a pipe (|) between them. after they are separated, information can be extracted
# https://www.youtube.com/watch?v=-rmreyRAbkE very good snpeff interpretation and manipulation video
#want to extract information on where the snp is , impact level, what gene is in 
# venny (bioinfogp.cnb.csic.es) makes vennn diagrams for comparing snps in different genomes

##Pipeline complete 


    




