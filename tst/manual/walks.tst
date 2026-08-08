#############################################################################
##
#W  walks.tst             GAP4 package IBNP      Gareth Evans & Chris Wensley
##

gap> START_TEST( "walks.tst" );
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

gap> LoadPackage( "ibnp" );
true
gap> ## Section ???
gap> R4 := PolynomialRing( Rationals, [ "x", "y", "z", "t" ] );;
gap> x := R4.1;; y := R4.2;; z := R4.3;; t := R4.4;;
gap> R3 := PolynomialRing( Rationals, [ "u", "v", "w" ] );;
gap> u := R3.1;; v := R3.2;; w := R3.3;;
gap> R2 := PolynomialRing( Rationals, [ "a", "b" ] );;
gap> a := R2.1;; b := R2.2;;
gap> ord3L := MonomialLexOrdering( [u,v,w] );;
gap> ord3G := MonomialGrlexOrdering( [u,v,w] );;
gap> ord2G := MonomialGrlexOrdering( [a,b] );;
gap> ord4L := MonomialLexOrdering( [x,y,z,t] );;
gap> M4L := MatrixOfMonomialOrdering( ord4L );
name = MonomialLexOrdering()
ok = true
ordering is Lex
[ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ]
gap> ord4G := MonomialGrlexOrdering( [x,y,z,t] );;
gap> M4G := MatrixOfMonomialOrdering( ord4G );
name = MonomialGrlexOrdering()
ok = true
ordering is DegLex
[ [ 1, 1, 1, 1 ], [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], 
  [ 0, 0, 0, 1 ] ]
gap> ## reference manual example in section 66.18
gap> P := [ u^2+v^2+w^2-1, u^2+w^2-v, u-v ];;
gap> gb3L := GroebnerBasis( P, ord3L );;
gap> ## the order of terms is variable so do not print directly
gap> ( gb3L[1] = u^2+v^2+w^2-1 ) and ( gb3L[2] = u^2+w^2-v );
true
gap> gb3L{[3..6]};
[ u-v, -v^2-v+1, -w^2+2*v-1, 1/2*w^4+2*w^2-1/2 ]
gap> gb3L := ReducedGroebnerBasis( P, ord3L );
[ w^4+4*w^2-1, -1/2*w^2+v-1/2, -1/2*w^2+u-1/2 ]
gap> gb3G := GroebnerBasis( P, ord3G );;
gap> ( gb3G[1] = u^2+v^2+w^2-1 ) and ( gb3G[2] = u^2+w^2-v );
true
gap> gb3G{[3..5]};
[ u-v, -v^2-v+1, -w^2+2*v-1 ]
gap> gb3G := ReducedGroebnerBasis( P, ord3G );
[ u-v, w^2-2*v+1, v^2+v-1 ]
gap> ## now find gb3L from gb3G using a Groebner walk
gap> inP := [ u-v, w^2, v^2 ];;
gap> gb3Gin := ReducedGroebnerBasis( inP, ord3G );
[ u-v, w^2, v^2 ]

gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "walks.tst", 10000 );

#############################################################################
##
#E  walks.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
