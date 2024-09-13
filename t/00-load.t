#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

# Test if AWS::ARN module loads successfully
use_ok('AWS::ARN') or diag("Cannot load AWS::ARN");

done_testing();
