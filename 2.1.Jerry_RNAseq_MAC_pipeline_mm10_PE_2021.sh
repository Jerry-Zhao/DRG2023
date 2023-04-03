### Analyzing the RNASeq data
printf "\n!!!!!!! \nHi Jerry, a new journey of paired-end RNA-seq analysis has began.\n!!!!!!!\n\n"

infile=(AbdelLab_NeuronKCL_RNAseq_female_rep1 AbdelLab_NeuronKCL_RNAseq_female_rep2 AbdelLab_NeuronKCL_RNAseq_female_rep3 AbdelLab_NeuronKCL_RNAseq_female_rep4 AbdelLab_NeuronKCL_RNAseq_female_rep5 AbdelLab_NeuronKCL_RNAseq_male_rep1 AbdelLab_NeuronKCL_RNAseq_male_rep2 AbdelLab_NeuronKCL_RNAseq_male_rep3 AbdelLab_NeuronKCL_RNAseq_male_rep4 AbdelLab_NeuronKCL_RNAseq_male_rep5)

for inputname in "${infile[@]}"
do
    cd "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/FASTQ"
    #### Step 1: mapping use STAR
    echo "\n\n\n\nWorking on sample ${inputname}  \n\n"
    printf "\n\n\n  Step 1 of 3: STAR mapping \n\n"
  
    mkdir "tmp1" ## map the temp directory for mapping
    mv "${inputname}_1.fastq" "tmp1" ## move FASTQ to the folder
    mv "${inputname}_2.fastq" "tmp1" ## move FASTQ to the folder
    cd "tmp1"

    STAR --genomeDir "/Users/jerry/Analysis/Genome/STAR/mm10" --readFilesIn "${inputname}_1.fastq" "${inputname}_2.fastq" --runThreadN 40 --outFilterMultimapNmax 1 --outFilterMismatchNmax 3 --outFilterScoreMinOverLread 0.25 --outFilterMatchNminOverLread 0.25

    samtools view -f 0x2 "Aligned.out.sam" -o "${inputname}_pair.sam" ## remove singletons
    samtools view -H "Aligned.out.sam" -o "header.sam"  ## SAM headers 
    cat "header.sam" "${inputname}_pair.sam" > "${inputname}.sam" 
    mv "Log.final.out" "${inputname}.Log" ## rename the mapping statistics file
    head -n 50 "${inputname}.Log" ## the mapping statistics

    mv "${inputname}.sam" "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/BAM"
    mv "${inputname}_1.fastq" ".."
    mv "${inputname}_2.fastq" ".."
#    rm "${inputname}_1.fastq"
#    rm "${inputname}_2.fastq"
    mv "${inputname}.Log" "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/Statistics"

    cd ".."
    rm -rf "tmp1"
#    gzip "${inputname}_1.fastq"
#    gzip "${inputname}_2.fastq"
 


    #### Step 2: split the SAM file by chromosome 
    printf "\n\n\nStep 2 of 3: split sam by chromosome \n\n"
    cd "/Users/jerry/Analysis/Split"
    gawk -v tag=${inputname} 'NR>26 { print > tag".sam.chr"$3}' "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/BAM/${inputname}.sam"



    #### Step 3: Generate bam and BigWig file from sam file
    printf "\n\n\nStep 3 of 3: generate bam and BigWig from SAM file \n\n"
    cd "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/BAM"
    # sam to bam
    samtools view -bS "${inputname}.sam" -o  "${inputname}_raw.bam" ## convert sam to bam
    samtools sort "${inputname}_raw.bam" -o "${inputname}.bam"      ## sort ba
    samtools index "${inputname}.bam"                               ## index bam
    rm "${inputname}_raw.bam"                                       ## remove unsorted bam

    # bam to BigWig
    lines=`expr $(wc -l < "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/BAM/${inputname}.sam"| tr -d " ") - 25` ## uniquely mapped reads
    bw_value=`expr $lines / 2000000` ### The normalized bw y-axes will be uniquely mapped read-pairs (Million)

    ## stranded
#    bamCoverage -b "${inputname}.bam" --filterRNAstrand forward --binSize 1 -p 14 -o "${inputname}_plus_${bw_value}.bw" 
#    bamCoverage -b "${inputname}.bam" --filterRNAstrand reverse --binSize 1 -p 14 -o "${inputname}_minus_${bw_value}.bw"
#    mv "${inputname}_plus_${bw_value}.bw" "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/Tracks" 
#    mv "${inputname}_minus_${bw_value}.bw" "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/Tracks"

    ## non-stranded
    bamCoverage -b "${inputname}.bam" --binSize 1 -p 40 -o "${inputname}_${bw_value}.bw"
    mv "${inputname}_${bw_value}.bw" "/Users/jerry/Analysis/Project/AbdelLab/Gender/RNAseq/Tracks"
 
#    rm "${inputname}.sam"
done

