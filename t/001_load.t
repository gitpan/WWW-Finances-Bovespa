# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 10;

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
my $is_match = $object->{ _codigo } =~ m/$stock_code$/;
is ( 1 , $is_match , 'verify if the it has found any code' );
is ( valid_bovespa_hash_v1( $object ), 1, 'validate the hash result for v1' );

my $invalid_code = '_39';
my $object2 = WWW::Finances::Bovespa->new ( $invalid_code );
isnt ( $object2, 'WWW::Finances::Bovespa' );
is ( valid_bovespa_hash_v1( $object2 ), 0, 'validate the hash result for v1' );

sub valid_bovespa_hash_v1 {
    my ( $bovespa ) = @_;
    return 0 if ! exists $bovespa->{ _descricao };
    return 0 if ! exists $bovespa->{ _codigo };
    return 0 if ! exists $bovespa->{ _ibovespa };
    return 0 if ! exists $bovespa->{ _delay };
    return 0 if ! exists $bovespa->{ _data };
    return 0 if ! exists $bovespa->{ _hora };
    return 0 if ! exists $bovespa->{ _oscilacao };
    return 0 if ! exists $bovespa->{ _valor_ultimo };
    return 0 if ! exists $bovespa->{ _quant_neg };
    return 0 if ! exists $bovespa->{ _mercado };
    return 1;
}
