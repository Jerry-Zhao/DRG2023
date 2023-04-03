#! /usr/local/perl -w

open(INA,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_male_Rep1_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INB,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_male_Rep2_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INC,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_male_Rep3_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(IND,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_male_Rep4_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INE,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_male_Rep5_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(INF,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_female_Rep1_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(ING,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_female_Rep2_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INH,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_female_Rep3_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INI,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_female_Rep4_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");
open(INJ,"RNAseq/count/AbdelLab_NeuronKCL_RNAseq_female_Rep5_exonic_gene_Jerry.txt")||die("Can't open INA:$!\n");

open(OUT,">RNAseq/Merged_AbdelLab_NeuronKCL_RNAseq_male_female_exonic_gene_Jerry.xls")||die("Can't write OUT:$!\n");

while(<INA>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$male1{$1}=$2;}else{print"error1\t$_\n";}}
while(<INB>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$male2{$1}=$2;}else{print"error2\t$_\n";}}
while(<INC>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$male3{$1}=$2;}else{print"error3\t$_\n";}}
while(<IND>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$male4{$1}=$2;}else{print"error4\t$_\n";}}
while(<INE>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$male5{$1}=$2;}else{print"error5\t$_\n";}}

while(<INF>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$female1{$1}=$2;}else{print"error7\t$_\n";}}
while(<ING>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$female2{$1}=$2;}else{print"error8\t$_\n";}}
while(<INH>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$female3{$1}=$2;}else{print"error9\t$_\n";}}
while(<INI>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$female4{$1}=$2;}else{print"error10\t$_\n";}}
while(<INJ>){chomp;if(/^(ENSMUSG\d+)\_[\w\.\-\(\)]+\t(\d+)$/){$female5{$1}=$2;}else{print"error11\t$_\n";}}

print OUT "\tMale_rep1\tMale_rep2\tMale_rep3\tMale_rep4\tMale_rep5\t";
print OUT "Female_rep1\tFemale_rep2\tFemale_rep3\tFemale_rep4\tFemale_rep5\n";

my $a1=0;
foreach (keys %male1)
{
 $a1++;
 print OUT "$_\t";
 print OUT "$male1{$_}\t$male2{$_}\t$male3{$_}\t$male4{$_}\t$male5{$_}\t";
 print OUT "$female1{$_}\t$female2{$_}\t$female3{$_}\t$female4{$_}\t$female5{$_}\n";
}

print "total-genes: $a1\n";

close OUT;


