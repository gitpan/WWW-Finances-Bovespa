# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 8;

BEGIN {
    use_ok( 'WWW::Finances::Bovespa' ); 
    use_ok( 'WWW::Mechanize' );
    use_ok( 'XML::XPath' );
    use_ok( 'XML::XPath::XMLParser' );
}

my $stock_code = 'PETR3';
my $object = WWW::Finances::Bovespa->new ( $stock_code );
isa_ok ( $object, 'WWW::Finances::Bovespa' );

is ( defined $object->{ _codigo } , 1 , 'is defined' );
is ( $object->{ _codigo } , '#' . $stock_code , 'verify if the it has found any code' );

my $invalid_code = '_39';
my $object2 = WWW::Finances::Bovespa->new ( $invalid_code );
isnt ( $object, 'WWW::Finances::Bovespa' );

