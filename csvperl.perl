#!/usr/bin/perl

# dump the arguments into variables
my $file = @ARGV[0];
my $add_header = @ARGV[1];
# check we have the required args to run the script without errors
unless ($file)
{
    system("clear");
    print '-' x75 . "\n";
    print "Usage:\n";
    print qq~csv-to-html [file] [option] > outfile\n~;
    print qq~Convert a CSV file (seperator can be sepcified) to a valid (X)HTML table.\n\n~;
    print qq~Options:\n~;
    print qq~ -h Use a header row to create <th> elements in your table (if your csv has a header row and the -h switch is not active I'll just put the header row in normal <td> and vice versa).\n~;
    print '-' x75 . "\n";
    exit;
}
# define some globals
my ($header_row);
# read in the file
open (READ, $file);
if ($add_header)
{
    $header_row = <READ>;
    my @header_row = split(',', $header_row);
    undef($header_row);
    $header_row .= qq~<tr>\n~;
    foreach my $item (@header_row)
    {
	$header_row .= qq~\t<th>$item</th>\n~;
    }
    $header_row .= qq~</tr>\n~;
}
my @data = <READ>;
close(READ);
# now we have all the info we need to make the table
my $table = qq~<table>\n~;
$table .= $header_row;
# iterate through the data rows and wrap them up in <td>
foreach my $row (@data)
{
    # add the statrting <tr>
    $table .= qq~<tr>\n~;
    foreach my $item (@row)
    {
	# remove any newline characters in the data
	chomp($item);
	# add the td to the table
	$table .= qq~\t<td>$item</td>\n~;
    }
    # finish the table row
    $table .= qq~</tr>\n~;
}
# finishe the table
$table .= qq~</table>~;


print $table;