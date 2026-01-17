#!/usr/bin/perl
use strict;
use warnings;
my $filename = '../input';
open(my $fh, '<', $filename) or die "Could not open file '$filename': $!";
my %hash;
while (my $line = <$fh>) {
    chomp($line); 
    $line =~ /(\w+) .* (lose|gain) (\d+) .* (\w+)/;
    $hash{$1}{$4} = ($2 eq "lose") ? -$3 : $3; 
}
close($fh);
my @all_person = keys %hash;
my $first = shift @all_person;
my $ans = -999999;
solve($first, \@all_person, 0);
print $ans;

sub solve {
    my ($cur_person, $remaining_person_ref, $sum) = @_;
    my @remaining = @{$remaining_person_ref};
    if (scalar(@remaining) == 0){
        my $final_score = $hash{$cur_person}{$first} + $hash{$first}{$cur_person};
        my $score = $sum + $final_score; 
        if ($score > $ans) {
            $ans = $score;
        }
        return; 
    }

    for my $i (0 .. $#remaining) {
        my $next_person = $remaining[$i];
        my @new_remaining = @remaining;
        splice(@new_remaining, $i, 1);
        my $pair_score =  $hash{$cur_person}{$next_person} + $hash{$next_person}{$cur_person};
        solve($next_person, \@new_remaining, $sum + $pair_score);
    }
}

