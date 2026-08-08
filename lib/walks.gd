#############################################################################
##
##  walks.gd             GAP package IBNP        Gareth Evans & Chris Wensley
##  

#############################################################################
##
#A  MatrixOfMonomialOrdering( <ord> )
##
DeclareAttribute( "MatrixOfMonomialOrdering", IsMonomialOrdering );

#############################################################################
##
#F  GroebnerWalk( <args> )
#O  GroebnerWalkCP( <alg> <polys> <ord> )
#O  GroebnerWalkNP( <alg> <polys> <ord> )
##
DeclareGlobalName( "GroebnerWalk" );
DeclareOperation( "GroebnerWalkCP", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "GroebnerWalkNP", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );

#############################################################################
##
#F  InvolutiveWalk( <args> )
#O  InvolutiveWalkCP( <alg> <polys> <ord> )
#O  InvolutiveWalkNP( <alg> <polys> <ord> )
##
DeclareGlobalName( "InvolutiveWalk" );
DeclareOperation( "InvolutiveWalkCP", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "InvolutiveWalkNP", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );

#############################################################################
##
#E  walks.gd . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
##  