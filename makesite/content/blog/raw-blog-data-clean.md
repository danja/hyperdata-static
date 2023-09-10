using standard linux tools, how do I modify a text file to remove the spaces from any strings in it of the following form : '<mbox:dylan_beadle -at- yahoo.com>'. Match the < > characters, I'd like the result '<mbox:dylan_beadle-at-yahoo.com>'

(some fails with sed)

perl -pe 's/<mbox:([^>]+)>/my $x = $&; $x =~ s| -at- |-at-|g; $x =~ s| ||g; $x/ge' main_backup.n3  >  main_backup-cleaner.n3

Could you now extend the previous Perl so that :
<mbox:dylan_beadle -at- yahoo.com> becomes <mbox:dylan_beadle@yahoo.com>
<mbox:thaynes{at}openlinksw.com> becomes <mbox:thaynes@openlinksw.com>

perl -pe 's|<mbox:([^>]+)>|my $x = $&; $x =~ s|\s*-at-\s*|\@|g; $x =~ s|\{at\}|\@|g; $x =~ s|\s||g; $x|ge' main_backup.n3 > main_backup-cleaner.n3

perl -pe 's|<mbox:([^>]+)>|my $x = $1; $x =~ s|\s*-at-\s*|\@|g; $x =~ s|\{at\}|\@|g; $x =~ s|\s||g; "<mbox:$x>"|ge' main_backup.n3 > main_backup-cleaner.n3




