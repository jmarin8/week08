package RestrictionEnzyme;
use Moose;

has 'name' => (isa => 'Str', is => 'rw');
has 'manufacturer' => (isa => 'Str', is => 'rw');
has 'recognitionsequence' => (isa => 'Str', is => 'rw', required => 1);

sub cut_dna{
        my $self = shift;
        my $dna = shift;
        my $enzymeseq = $self->recognitionsequence;

        print "Name: " . $self->name . " Manufacturer " . $self->manufacturer .
                " Recognition Sequence " . $self->recognitionsequence . "\n";
        print "DNA sequence: $dna\n";
        my %frags = ();
        if($enzymeseq =~ m{([^'])'([^/])}) {
                 %frags = (
                        'before' => $1,
                        'after' => $2
                        );
                my $before = $frags{'before'};
                my $after = $frags{'after'};
                while(1){
                        if ($dna =~ s/(.*${before})(${after}.*)/$1/ ) {
                                unshift @{$frags{''}}, $2;
                        }else{
                                unshift @{$frags{''}}, $dna;
                                return @{$frags{''}};
                                last;
                        }
                }
        }else{
                return "No Restriction Site Found!\n";
                exit;
        }
}

1;

=head1 Restriction Enzyme
This program is written to take a particular DNA sequence and break it up into fragments, based on a Restriction Enzyme.
The cut_dna method will use name, manufacturer, and recognition site to return the fragmented DNA. If no restriction site
is found, the method will return an error message.
=cut
