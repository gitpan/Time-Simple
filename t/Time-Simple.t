our $VERSION = 0.1;

use Test::More tests => 37;

BEGIN {
	use lib '../lib'; # For when this script is run directly
	use Data::Dumper; # for debugging
	use_ok('Time::Simple');
};


my $ts = Time::Simple->new;
isa_ok($ts, 'Time::Simple');
like(scalar(localtime), qr/$ts/, 'Without args is Localtime');

$ts = Time::Simple->new('23:59:59');
isa_ok($ts, 'Time::Simple', 'New from scalar');
is($ts->hour,23,'hr from array');
is($ts->minute,59,'min from array');
is($ts->second,59,'sec from array');

my $printed = "$ts";
like($printed, qr/23:59:59/, 'stringified');
$ts++;
$printed = "$ts";
is($printed, '00:00:00', 'stringified');

$ts--;
$printed = "$ts";
is($printed, '23:59:59', 'stringified');

$ts = Time::Simple->new(1,2,3);
isa_ok($ts, 'Time::Simple');
is($ts->hour,1,'hr from array');
is($ts->minute,2,'min from array');
is($ts->second,3,'sec from array');
$printed = "$ts";
is($printed, '01:02:03', 'stringified');

$ts = Time::Simple->new('23:59');
isa_ok($ts, 'Time::Simple', 'New from scalar no seconds');
is($ts->hour,23,'hr from scalar');
is($ts->minute,59,'min from scalar');
is($ts->second,0,'sec from scratch');

$ts = Time::Simple->new('23');
isa_ok($ts, 'Time::Simple', 'New from scalar no seconds');
is($ts->hour,23,'hr from scalar');
is($ts->minute,0,'min from scratch');
is($ts->second,0,'sec from scratch');

$ts = Time::Simple->new('23:59:59');
like($ts->next, qr'00:00:00', 'next');

$ts = Time::Simple->new('10:00:00');
like($ts->prev, qr'09:59:59', 'prev');

# Perlop:
#    Binary "cmp" returns -1, 0, or 1 depending on whether the left argument
#    is stringwise less than, equal to, or greater than the right argument.
is( ($ts cmp "10:00:01"), -1, 'cmp >');
is( ($ts cmp "10:00:00"), 0, 'cmp ==');
is( ($ts cmp "09:59:59"), 1, 'cmp <');

is( ($ts <=> "10:00:01"), -1, '<=> >');
is( ($ts <=> "10:00:00"), 0, '<=> ==');
is( ($ts <=> "09:59:59"), 1, '<=> <');

is( ($ts cmp [10,0,1]), -1, 'cmp >');
is( ($ts cmp [10,0,0]), 0, 'cmp ==');
is( ($ts cmp [9,59,59]), 1, 'cmp <');

is( ($ts <=> [10,0,1]), -1, '<=> >');
is( ($ts <=> [10,0,0]), 0, '<=> ==');
is( ($ts <=> [9,59,59]), 1, '<=> <');

