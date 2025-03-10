#############################################################################
##
#W  poly.tst          GAP4 package IBNP          Gareth Evans & Chris Wensley
##

gap> START_TEST( "poly.tst" );
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

## SubSection 5.1.1
gap> A2 := AlgebraIBNP;;
gap> a := A2.1;; b := A2.2;;
gap> ord := NCMonomialLeftLengthLexicographicOrdering( A2 );;
gap> u := [ [ [1,1,2], [2,1], [1] ], [3,2,-1] ];;
gap> v := [ [ [1,1,2,1], [1,2,2], [2,1] ], [4,-2,1] ];;
gap> w := [ [ [2,1,2], [1,2], [2] ], [2,-1,3] ];; 
gap> L3 := [ u, v, w ];; 
gap> PrintNPList( L3 ); 
 3a^2b + 2ba - a 
 4a^2ba - 2ab^2 + ba 
 2bab - ab + 3b 
gap> MaxDegreeNP( L3 );
4

## SubSection 5.1.2
gap> u2 := ScalarMulNP( u, 2 );;  PrintNP( u2 );
 6a^2b + 4ba - 2a

## SubSection 5.1.3
gap> [ LtNPoly( w, u ), LtNPoly( u, u2 ) ];     
[ false, true ]
gap> v2 := AddNP( v, [ [ [2,1] ], [1] ], 1, 1 );;
gap> PrintNPList( [v,v2] );
 4a^2ba - 2ab^2 + ba 
 4a^2ba - 2ab^2 + 2ba 
gap> LtNPoly( v, v2 );
true
gap> ## LtNPoly and GtNPoly may be used within the Sort command:
gap> L4 := [u,v,u2,v2];
[ [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 3, 2, -1 ] ], 
  [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 1 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 6, 4, -2 ] ], 
  [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 2 ] ] ]
gap> Sort( L4, GtNPoly );
gap> L4;
[ [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 2 ] ], 
  [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 1 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 6, 4, -2 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 3, 2, -1 ] ] ]

## SubSection 5.1.4
gap> LeastLeadMonomialPosNP( L4 );
4
gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "poly.tst", 10000 );

#############################################################################
##
#E  poly.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
