#!/usr/bin/perl -w

use strict;

use Test::Builder;

# This test ought to catch all of these
# - callbacks being executed before done_testing
# - callbacks not being called
# - callbacks being called out of order

my $tb = Test::Builder->new;
$tb->level(0);

my $xyzzy = 0;

$tb->add_done_testing_callback(sub {
        $tb->is_eq($xyzzy, 1, '1st callback called from done_testing');
        $xyzzy = 2;
    });

$tb->is_eq($xyzzy, 0, 'Registered callback not called yet');

$tb->add_done_testing_callback(sub {
        $tb->is_eq($xyzzy, 2, '2nd callback called after first callback');
    });

$xyzzy = 1;

$tb->done_testing(3);
