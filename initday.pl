#!/usr/bin/perl

use warnings;
use strict;

my $template_file = "template.pl";

my $day = (localtime)[3];

my $dir = $day . "des";
mkdir $dir;
system("cp $template_file $dir/1part.pl");
