#!/usr/bin/env perl

use strict;
use warnings;
use Text::CSV qw(csv);

my $pk = 'ISO3CODE';

die "Usage: file... >mongo/model.py\n" if !@ARGV;

my @tables;
for my $file (@ARGV) {
  my $data = csv(in => $file, encoding => "UTF-8");
  my $top_row = $data->[0];
  (my $name = $file) =~ s#.*/(.*?)\.csv$#$1#;
  $name = simplify($name, 'csv_');
  my $string = "class $name(db.Model):\n";
  my @cols = "ISO3CODE = db.Column(db.String(3))"; # not PK as nullable
  shift @$top_row; # ISO3CODE dealt with above
  push @cols, map simplify($_, 'y')." = db.Column(db.String(1000))", @$top_row;
  push @tables, $string . join '', map "    $_\n", @cols;
}
print join "\n\n", @tables;

sub simplify {
  my ($text, $prefix) = @_;
  $text =~ s#[^A-Za-z0-9]+#_#g;
  $text =~ /^\d/ ? $prefix.$text : $text;
}
