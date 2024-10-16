#############################################################################
##
#W  poly.tst          GAP4 package IBNP          Gareth Evans & Chris Wensley
##
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
gap> START_TEST( "poly.tst" );
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

## SubSection 5.1.1
gap> A2 := AlgebraIBNP;;
gap> a := A2.1;; b := A2.2;;
gap> ord := NCMonomialLeftLengthLexicographicOrdering( A2 );;
gap> t := [ [ [1,2,1,1,2,1], [2,2,1,2], [2,1,1,2] ], [6,7,8] ];;
gap> u := [ [ [1,1,2,1], [1,2,2], [2,1] ], [4,-2,1] ];;
gap> v := [ [ [2,1,2], [1,2], [2] ], [2,-1,3] ];; 
gap> w := [ [ [1,1,2], [2,1], [1] ], [3,2,-1] ];;
gap> L4 := [ t, u, v, w ];; 
gap> PrintNPList( L4 );
 6aba^2ba + 7b^2ab + 8ba^2b 
 4a^2ba - 2ab^2 + ba 
 2bab - ab + 3b 
 3a^2b + 2ba - a 
gap> MaxDegreeNP( L4 );
6

## SubSection 5.1.2
gap> w2 := ScalarMulNP( w, 2 );;
gap> PrintNP( w2 );
 6a^2b + 4ba - 2a

## SubSection 5.1.3
gap> LtNPoly( v, w );
false
gap> LtNPoly( w, w2 );     
true
gap> u2 := AddNP( u, [ [ [2,1] ], [1] ], 1, 1 );;
gap> PrintNPList( [u,u2] );
 4a^2ba - 2ab^2 + ba 
 4a^2ba - 2ab^2 + 2ba 
gap> LtNPoly( u, u2 );
true
gap> ## LtNPoly and GtNPoly may be used within the Sort command:
gap> L5 := [u,v,w,u2,w2];
[ [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 1 ] ], 
  [ [ [ 2, 1, 2 ], [ 1, 2 ], [ 2 ] ], [ 2, -1, 3 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 3, 2, -1 ] ], 
  [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 2 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 6, 4, -2 ] ] ]
gap> Sort( L5, GtNPoly );
gap> L5;
[ [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 2 ] ], 
  [ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 4, -2, 1 ] ], 
  [ [ [ 2, 1, 2 ], [ 1, 2 ], [ 2 ] ], [ 2, -1, 3 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 6, 4, -2 ] ], 
  [ [ [ 1, 1, 2 ], [ 2, 1 ], [ 1 ] ], [ 3, 2, -1 ] ] ]

## SubSection 5.1.4
gap> LeastLeadMonomialPosNP( L5 );
5
gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "poly.tst", 10000 );

#############################################################################
##
#E  poly.tst  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
