#!/usr/bin/perl

my $sep = ';';
my $header = 0;

for (`find /home/rcalmeid/Documents/DYNAUTO/Scripts -type f -name IPWin.html`) {
	if (open FH, $_) {
		my @file = <FH>;
		close FH;

		my $htm = '';
		$htm.= $_ for @file;
		$htm =~ s/\s+/ /g;

		my ($i, $field, $value) = (0, '', '');
		my @matches = $htm =~ /<th[^>]*>([^<]+)<\/th>\s+<td[^>]*>([^<]+)<\/td>/g;
		for (@matches) {
			if (++$i % 2) {
				$field.= $_.$sep;
			} else {
				$value.= $_.$sep;
			}
		}
		print "$field\n" if ++$header == 1;
		print "$value\n";
	}
}

exit(0);
