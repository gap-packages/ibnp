#############################################################################
##
#W  involutive-cp.tst     GAP4 package IBNP      Gareth Evans & Chris Wensley
##

gap> START_TEST( "involutive-cp.tst" );
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

gap> ## Section 3.2.2
gap> CommutativeDivision := "Pommaret";
"Pommaret"

gap> ## Section 3.2.3
gap> R := PolynomialRing( Rationals, [ "x", "y", "z" ] );;
gap> x := R.1;; y := R.2;; z := R.3;;
gap> ord := MonomialLexOrdering( [x,y,z] );;

gap> ## Section 3.2.4
gap> U := [ x^5*y^2*z, x^4*y*z^2, x^2*y^2*z, x*y*z^3, x*z^3, y^2*z, z ];
[ x^5*y^2*z, x^4*y*z^2, x^2*y^2*z, x*y*z^3, x*z^3, y^2*z, z ]
gap> PommaretDivision( R, U, ord );
[ [ 1 ], [ 1 ], [ 1 ], [ 1 ], [ 1 ], [ 1, 2 ], [ 1 .. 3 ] ]

gap> ## Section 3.2.5
gap> ThomasDivision( R, U, ord );
[ [ 1, 2 ], [  ], [ 2 ], [ 3 ], [ 3 ], [ 2 ], [  ] ]

gap> ## Section 3.2.6
gap> JanetDivision( R, U, ord );
[ [ 1, 2 ], [ 1, 2 ], [ 2 ], [ 1, 2, 3 ], [ 1, 3 ], [ 2 ], [ 1 ] ]

gap> ## Section 3.2.7
gap> R := PolynomialRing( Rationals, [ "a", "b" ] );;
gap> a := R.1;; b := R.2;;
gap> L2 := [ b^3 - 3*a, a^3 - 3*b ];;
gap> ord := MonomialGrlexOrdering( [a,b] );;
gap> GB2 := ReducedGroebnerBasis( L2, ord );;
gap> GB2 = L2;
true
gap> CommutativeDivision := "Pommaret";;
gap> drec2 := DivisionRecordCP( R, L2, ord );
rec( div := "Pommaret", mvars := [ [ 1, 2 ], [ 1 ] ], 
  polys := [ b^3-3*a, a^3-3*b ] )

gap> ## Section 3.2.8
gap> p := a^3*b^3 + 2*a^3*b + 3*a*b^3;;
gap> q := IPolyReduce( R, p, drec2, ord );
2*a^3*b+9*a^2+9*a*b

gap> ## Section 3.2.9
gap> r := LoggedIPolyReduceCP( R, p, drec2, ord );
rec( logs := [ a^3+3*a, 3*a ], polys := [ b^3-3*a, a^3-3*b ], 
  result := 2*a^3*b+9*a^2+9*a*b )
gap> p = r.result + r.logs[1]*r.polys[1] + r.logs[2]*r.polys[2];
true

gap> ## Section 3.2.10
gap> L3 := Concatenation( L2, [p] );;
gap> IAutoreduceCP( R, L3, ord );
[ b^3-3*a, a^3-3*b, 2*a^3*b+9*a^2+9*a*b ]
gap> L4 := Concatenation( L2, [ a^3*b-3*b^2, a^3*b^2-9*a ] );;
gap> IAutoreduceCP( R, L4, ord );
true

gap> ## Section 3.3.2
gap> ibasP := InvolutiveBasis( R, L2, ord );
rec( div := "Pommaret", mvars := [ [ 1, 2 ], [ 1 ], [ 1 ], [ 1 ] ], 
  polys := [ b^3-3*a, a^3-3*b, a^3*b-3*b^2, a^3*b^2-9*a ] )
gap> r := IPolyReduce( R, p, ibasP, ord );
9*a^2+9*a*b+6*b^2

gap> CommutativeDivision := "Thomas";;
gap> ibasT := InvolutiveBasis( R, L2, ord );
rec( div := "Thomas", 
  mvars := [ [ 2 ], [ 1 ], [ 2 ], [ 1 ], [ 2 ], [ 1 ], [ 1, 2 ] ], 
  polys := [ b^3-3*a, a^3-3*b, a*b^3-3*a^2, a^3*b-3*b^2, a^2*b^3-9*b, 
      a^3*b^2-9*a, a^3*b^3-9*a*b ] )
gap> CommutativeDivision := "Janet";;
gap> ibasJ := InvolutiveBasis( R, L2, ord );;
gap> ( ibasJ.mvars = ibasP.mvars ) and ( ibasJ.polys = ibasP.polys );
true

gap> r := LoggedIPolyReduceCP( R, p, ibasT, ord );
rec( logs := [ 0, 0, 3, 2, 0, 0, 1 ], 
  polys := [ b^3-3*a, a^3-3*b, a*b^3-3*a^2, a^3*b-3*b^2, a^2*b^3-9*b, 
      a^3*b^2-9*a, a^3*b^3-9*a*b ], result := 9*a^2+9*a*b+6*b^2 )

gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "involutive-cp.tst", 10000 );

#############################################################################
##
#E  involutive-cp.tst . . . . . . . . . . . . . . . . . . . . . . . ends here
