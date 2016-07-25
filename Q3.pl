package RestrictionEnzyme;

sub new {
	my( $class , %attribs ) = ( @_ );
	my $self = {
		name => $attribs{name} || 'unknown',
		manufacturer  => $attribs{manufacturer} || 'unknown',
		recognitionsequence  => $attribs{recognitionsequence} || die("need 'recognitionsequence'!")
	};
	return bless $self , $class;
}

sub cut_dna{
	my $self = shift;
	my $dna = shift;
	my $enzymeseq = $self->{recognitionsequence};
	
	print "Name: " . $self->{name} . " Manufacturer " . $self->{manufacturer} .
		" Recognition Sequence " . $self->{recognitionsequence} . "\n";
	print "DNA sequence: $dna\n";
	my %frags = ();
	if($enzyme_seq =~ m{([^'])'([^/])}) {
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

sub DESTROY {
	my( $self ) = ( @_ );
	print "RestrictionEnzyme::destroyed called.\n";
	$self->{_name} = undef if ($self->{_name});
	$sefl->{_manufacturer} = undef if ($self->{_manufacturer});
	$self->{_recognitionsequence} = undef if ($self->{_recognitionsequence});	
	print "Object is undefined.\n";
}

1;
