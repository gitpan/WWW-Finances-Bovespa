package WWW::Finances::Bovespa;
use strict;
use warnings;
use WWW::Mechanize;
use XML::XPath;

BEGIN {
    use Exporter ();
    use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
    $VERSION     = '0.08';
    @ISA         = qw(Exporter);
    #Give a hoot don't pollute, do not export more than needed by default
    @EXPORT      = qw();
    @EXPORT_OK   = qw();
    %EXPORT_TAGS = ();
}


=head2 Usage

 use WWW:Finances::Bovespa
 my $cotacao = WWW::Finances::Bovespa->new( 'PETR3' );
 print $cotacao->{ _codigo };
 print $cotacao->{ _descricao };
 print $cotacao->{ _codigo };
 print $cotacao->{ _ibovespa };
 print $cotacao->{ _delay };
 print $cotacao->{ _data };
 print $cotacao->{ _hora };
 print $cotacao->{ _oscilacao };
 print $cotacao->{ _valor_ultimo };
 print $cotacao->{ _quant_neg };
 print $cotacao->{ _mercado };


See Also   : http://www.bovespa.com.br

=cut

sub new
{
    
    my $proto = shift;
    my $class = ref $proto || $proto;
    my $self = {};
    bless $self, $class;
    my $codigo = shift ; 

    my $base_url = 'http://www.bmfbovespa.com.br/cotacoes2000/formCotacoesMobile.asp?codsocemi=';
    if ( ! $codigo || $codigo eq '' ) {
        warn "Utilize um código da bovespa para obter resultados.";
        return 0;
    }

    my $mech = WWW::Mechanize->new();
    $mech->agent_alias( 'Windows IE 6' );
    $mech->get( $base_url . $codigo );
    my $content = $mech->content;

    my $xml = XML::XPath->new( xml => $content );


    foreach my $node_html ( $xml->findnodes( '//PAPEL', ) ) {
        $self->{ _descricao } = $node_html->getAttribute( 'DESCRICAO' );
        $self->{ _codigo } = $node_html->getAttribute( 'CODIGO' );
        $self->{ _ibovespa } = $node_html->getAttribute( 'IBOVESPA' );
        $self->{ _delay } = $node_html->getAttribute( 'DELAY' );
        $self->{ _data } = $node_html->getAttribute( 'DATA' );
        $self->{ _hora } = $node_html->getAttribute( 'HORA' );
        $self->{ _oscilacao } = $node_html->getAttribute( 'OSCILACAO' );
        $self->{ _valor_ultimo } = $node_html->getAttribute( 'VALOR_ULTIMO' );
        $self->{ _quant_neg } = $node_html->getAttribute( 'QUANT_NEG' );
        $self->{ _mercado } = $node_html->getAttribute( 'MERCADO' );
    }

    return $self;
}



=head1 NAME

  DEPRECATED! Use WWW::Finances::Bovespa2 instead which is moosified. 
  But this version will keep working.

=head1 SYNOPSIS

  WWW::Finances::Bovespa reads the latest stock options values directly 
  from BOVESPA.com.br
  Be aware that these values always have a 15min delay. 

=head1 BUGS

  Let me know

=head1 SUPPORT

  Email me

=head1 AUTHOR

  Hernan Lopes
  CPAN ID: HERNAN
  HERNAN
  hernanlopes@gmail.com

=head1 COPYRIGHT

This program is free software licensed under the...

  The BSD License

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

 http://www.bovespa.com.br

=cut



1;

