#! /uar/local/perl -w

open(INA,"Protein/Total_protein_list.txt")||die("Can't open INA:$!\n");
open(OUT,">Protein/Protein_list_at_least_4_samples.xls")||die("Can't write OUT: $!\n");

my $d1=$d2=$e1=$e2=$e3=0;

print OUT "ID\tMale1\tMale2\tMale3\tMale4\tMale5\tFemale1\tFemale2\tFemale3\tFemale4\tFemale5\tSamples\n";

while(<INA>)
{
 chomp;
 if(/^(\w+)\t(.*)\t(.*)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)$/)
 {
  $id="$1_$3_$2";

  $male=$female=0; 
  if($4 > 0) {$male++;}
  if($5 > 0) {$male++;}
  if($6 > 0) {$male++;}
  if($7 > 0) {$male++;}
  if($8 > 0) {$male++;}

  if($9 > 0) {$female++;}
  if($10 > 0) {$female++;}
  if($11 > 0) {$female++;}
  if($12 > 0) {$female++;}
  if($13 > 0) {$female++;}

  if($male==0){$a1++;}
  if($male==1){$a2++;}
  if($male==2){$a3++;}
  if($male==3){$a4++;}
  if($male==4){$a5++;}
  if($male==5){$a6++;}

  if($female==0){$b1++;}
  if($female==1){$b2++;}
  if($female==2){$b3++;}
  if($female==3){$b4++;}
  if($female==4){$b5++;}
  if($female==5){$b6++;}

  if(($male==5) and ($female==5)){$c1++;}
  if(($male>=4) and ($female>=4)){$c2++;}
  if(($male>=4) or  ($female>=4)){$c3++;}
 
  if(($male>=4) and ($female==0)){$d1++;} #print "$_\n";}
  if(($male==0) and ($female>=4)){$d2++;}

  $sample=$male+$female; 
  if(($male==0) and ($female>=4)){print OUT "$id\t$4\t$5\t$6\t$7\t$8\t$9\t$10\t$11\t$12\t$13\t$sample\n";$e1++;} ## Female only
  if(($male>=4) and ($female==0)){print OUT "$id\t$4\t$5\t$6\t$7\t$8\t$9\t$10\t$11\t$12\t$13\t$sample\n";$e2++;} ## Male only
  if(($male+$female)>=8){print OUT "$id\t$4\t$5\t$6\t$7\t$8\t$9\t$10\t$11\t$12\t$13\t$sample\n";$e3++;} ## Both male and female

 }
 else{print "error1\t$_\n";}
}


print "Male: 0-sample: $a1\t1-sample: $a2\t2-sample: $a3\t3-sample: $a4\t4-sample: $a5\t5-sample: $a6\n";
print "Female: 0-sample: $b1\t1-sample: $b2\t2-sample: $b3\t3-sample: $b4\t4-sample: $b5\t5-sample: $b6\n";

print "Male-Female-5-samples: $c1\tMale-and-Female-at-least-4-samples: $c2\tMale-or-Female-at-least-4-samples: $c3\n";
print "Male-at-least-4-samples-Female0: $d1\tMale0-Female-at-least-4-samples: $d2\n";

print "(Male==0) and (Female>=4): $e1\t(Male>=4) and (Female==0): $e2\t(Male+Female)>=8: $e3\n";

close INA; close OUT;


