package Bot::BasicBot::Pluggable::Module::Friendly;

use strict;
use utf8;
use Bot::BasicBot::Pluggable::Module;
use base qw(Bot::BasicBot::Pluggable::Module);

sub chanjoin {

    my ( $self, $mess ) = @_;
    my $who = $mess->{who};

    return "Welcome $who";
}

sub said {

    my ( $self, $mess ) = @_;
    my $who  = $mess->{who};
    my $body = $mess->{body};

    sleep(1);

    if ( $body =~ /botsnack/i ) {

        my @answers = ( "sweet, thanks $who", "sorry, $who, i had enough snacks", "$who please don't feed me more" );
        return $answers[ rand @answers ];
    }

    if ( $body =~ /^re$/i ) {
        my @answers = ( "wz $who", "moin $who", "$who, auch mal wieder da?" );
        return $answers[ rand @answers ];
    }

    if ( $body =~ /^wb \s*(.*)/i ) {
        return "welcome back $1 ";
    }

    if ( $body =~ /^Gute Nacht$/i ) {
        my @answers = ( "schlaf gut, $who", "Bis morgen $who", "$who, jetzt schon?" );
        return $answers[ rand @answers ];
    }

    if ( $body =~ /^M(a+)hlzeit$/i ) {
        my @answers = ( "Guten Hunger $who", "schon wieder?", "$who, was gibt es denn Gutes?" );
        return $answers[ rand @answers ];
    }

    if ( $body =~ /^Prost/i ) {
        my @answers = ( "Prost $who", "Es reicht langsam :D", " das nächste mal eine Runde für alle?" );
        return $answers[ rand @answers ];
    }

}

sub help {
    return "i don't answer to your questions!";
}

1;

=head1 NAME


=head1 SYNOPSIS

Contacts C<weather.noaa.gov> and gets the weather report for a given
station.

=head1 IRC USAGE

    weather [for] <station>


=head1 AUTHOR

Simon Wistow, <simon@thegestalt.org>

based on code by Kevin Lenzo <lenzo@cs.cmu.edu>

=head1 COPYRIGHT

Copyright 2005, Simon Wistow

Distributed under the same terms as Perl itself.

=head1 SEE ALSO


=cut 

