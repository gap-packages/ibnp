#############################################################################
##
##  poly.gd          GAP package IBNP            Gareth Evans & Chris Wensley
##  
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
##  Declaration file for functions in the ibnp package.
##

#############################################################################
##
#O  IsZeroNP( <poly> )
##
DeclareOperation( "IsZeroNP", [ IsList ] );

#############################################################################
##
#O  MaxDegreeNP( <list> )
##
DeclareOperation( "MaxDegreeNP", [ IsList ] ); 

#############################################################################
##
#O  ScalarMulNP( <poly> <const> )
##
DeclareOperation( "ScalarMulNP", [ IsList, IsScalar ] ); 

#############################################################################
##
#O  LtNPoly( <list> )
#O  GtNPoly( <list> )
##
DeclareOperation( "LtNPoly", [ IsList, IsList ] ); 
DeclareOperation( "GtNPoly", [ IsList, IsList ] ); 

#############################################################################
##
#O  LeastLeadMonomialPosNP( <list> )
##
DeclareOperation( "LeastLeadMonomialPosNP", [ IsList ] ); 

#############################################################################
##
#E  poly.gd . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
##  