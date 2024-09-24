#############################################################################
##
#W  involutive-np.tst     GAP4 package IBNP      Gareth Evans & Chris Wensley
##
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
gap> START_TEST( "involutive-np.tst" );
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

gap> ## Section 6.1.1
gap> A3 := Algebra3IBNP;;
gap> a:=A3.1;;  b:=A3.2;; c:=A3.3;;
gap> ord := NCMonomialLeftLengthLexicographicOrdering( A3 );;
gap> M6 := [ a*b, a, b*c, a*c, c*b, c^2 ];;           
gap> U6 := [ [1,2], [1], [2,3], [1,3], [3,2], [3,3] ];;
gap> LeftDivision( A3, U6, ord );   
[ [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ] ], 
  [ [  ], [  ], [  ], [  ], [  ], [  ] ] ]

gap> ## Section 6.1.2
gap> RightDivision( A3, U6, ord );
[ [ [  ], [  ], [  ], [  ], [  ], [  ] ], 
  [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ] ] ]

gap> ## Section 6.1.3
gap> LeftOverlapDivision( A3, U6, ord );               
[ [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ] ], 
  [ [ 1, 2 ], [ 1 ], [ 1 ], [ 1 ], [ 1, 2 ], [ 1 ] ] ]

gap> ## Section 6.1.4
gap> RightOverlapDivision( A3, U6, ord );               
[ [ [ 1 .. 3 ], [ 1 .. 3 ], [ 2 ], [ 1 .. 3 ], [  ], [  ] ], 
  [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ] ] ]

gap> ## Section 6.1.5
gap> NoncommutativeDivision := "LeftOverlap";
"LeftOverlap"

gap> ## Section 6.1.6
gap> L3 := [ [ [ [1,2,2], [3] ], [1,-1] ],
>            [ [ [2,3,3], [1] ], [1,-1] ],
>            [ [ [3,1,1], [2] ], [1,-1] ] ];;
gap> PrintNPList( L3 );
 ab^2 - c 
 bc^2 - a 
 ca^2 - b 
gap> drec := DivisionRecord( A3, L3, ord );
rec( div := "LeftOverlap", 
  mvars := [ [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ] ], 
      [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ] ] ], 
  polys := [ [ [ [ 1, 2, 2 ], [ 3 ] ], [ 1, -1 ] ], 
      [ [ [ 2, 3, 3 ], [ 1 ] ], [ 1, -1 ] ], 
      [ [ [ 3, 1, 1 ], [ 2 ] ], [ 1, -1 ] ] ] )

gap> ## Section 6.1.7
gap> ## choose a polynomial to reduce
gap> p := 5*c^2*a^2*b^2 + 6*b^2*c^2*a^2 + 7*a^2*b^2*c^2;;
gap> ## convert to NP format and reduce
gap> Lp := GP2NP( p );
[ [ [ 3, 3, 1, 1, 2, 2 ], [ 2, 2, 3, 3, 1, 1 ], [ 1, 1, 2, 2, 3, 3 ] ], 
  [ 5, 6, 7 ] ]
gap> Lrp := IPolyReduce( A3, Lp, drec, ord );;
gap> ## convert back to a polynomial
gap> rp := NP2GP( Lrp, A3 );
(5)*c^2*a*c+(6)*b^2*c*b+(7)*a^2*b*a
gap> ## p-rp should now belong to the ideal and reduce to 0
gap> q := p - rp;;
gap> Lq := GP2NP( q );;
gap> Lrq := IPolyReduce( A3, Lq, drec, ord );;
gap> rq := NP2GP( Lrq, A3 );
<zero> of ...

gap> ## Section 6.1.8
gap> L4 := Concatenation( L3, [Lp] );;
gap> R4 := IAutoreduceNP( A3, L4, ord );;
gap> PrintNPList( R4 );
 5c^2ac + 6b^2cb + 7a^2ba 
 ca^2 - b 
 bc^2 - a 
 ab^2 - c 

gap> ## Section 6.2.1
gap> gbas := SGrobner( L3 );;
gap> Length( gbas );         
64
gap> ## that's too large an example to continue with!
gap> K3 := [ [ [ [1,1,2], [3] ], [1,-1] ],
>            [ [ [2,2,3], [1] ], [1,-1] ],
>            [ [ [3,3,1], [2] ], [1,-1] ] ];;
gap> L6 := Concatenation( L3, K3 );;
gap> gbas := SGrobner( L6 );;
gap> PrintNPList( gbas );
 b - a 
 c - a 
 a^3 - a 
gap> ## so the only reduced elements are {1,a,a^2}
gap> ibas := InvolutiveBasis( A3, L6, ord );
rec( div := "LeftOverlap", 
  mvars := 
    [ 
      [ [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], [ 1 .. 3 ], 
          [ 1 .. 3 ], [ 1 .. 3 ] ], 
      [ [ 2, 3 ], [ 2, 3 ], [ 2, 3 ], [ 2, 3 ], [ 2, 3 ], [ 2, 3 ], [ 2, 3 ] 
         ] ], 
  polys := [ [ [ [ 3, 1, 1 ], [ 1 ] ], [ 1, -1 ] ], 
      [ [ [ 2, 1, 1 ], [ 1 ] ], [ 1, -1 ] ], 
      [ [ [ 1, 1, 1 ], [ 1 ] ], [ 1, -1 ] ], 
      [ [ [ 3, 1 ], [ 1, 1 ] ], [ 1, -1 ] ], 
      [ [ [ 2, 1 ], [ 1, 1 ] ], [ 1, -1 ] ], [ [ [ 3 ], [ 1 ] ], [ 1, -1 ] ], 
      [ [ [ 2 ], [ 1 ] ], [ 1, -1 ] ] ] )
gap> PrintNPList( ibas.polys );             
 ca^2 - a 
 ba^2 - a 
 a^3 - a 
 ca - a^2 
 ba - a^2 
 c - a 
 b - a 
gap> Lr := IPolyReduce( A3, p, ibas, ord );;
gap> PrintNP( Lr );
 18a^2 

gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "involutive-np.tst", 10000 );

#############################################################################
##
#E  involutive-np.tst . . . . . . . . . . . . . . . . . . . . . . . ends here