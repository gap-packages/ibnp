#############################################################################
##
#W  monom.tst         GAP4 package IBNP          Gareth Evans & Chris Wensley
##
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
gap> START_TEST( "monom.tst" );
gap> LoadPackage( "ibnp" );
true
gap> ibnp_infolevel_saved := InfoLevel( InfoIBNP );; 
gap> SetInfoLevel( InfoIBNP, 0 );; 

## SubSection 

gap> GBNP.ConfigPrint( "a", "b" );
gap> u := [[ [1,1,2,1], [1,2,2], [2,1] ], [1,-2,1] ];;
gap> v := [[ [2,1,1,2], [2,1,1], [1,2] ], [2,-1,3] ];; 
gap> L1 := [ u, v ];; 
gap> PrintNPList( L1 );
 a^2ba - 2ab^2 + ba 
 2ba^2b - ba^2 + 3ab 
gap> A := AlgebraIBNP;
<algebra-with-one over Rationals, with 2 generators>
gap> L2 := List( L1, p -> NP2GP(p,A) );
[ (1)*a^2*b*a+(-2)*a*b^2+(1)*b*a, (2)*b*a^2*b+(-1)*b*a^2+(3)*a*b ]
gap> DisplayIBNP( L2, 1 );
 a^2ba - 2ab^2 + ba 
 2ba^2b - ba^2 + 3ab 
gap> DisplayIBNP( L2, 2 );
[ [ [ 1, 1, 2, 1 ], [ 1, 2, 2 ], [ 2, 1 ] ], [ 1, -2, 1 ] ]
[ [ [ 2, 1, 1, 2 ], [ 2, 1, 1 ], [ 1, 2 ] ], [ 2, -1, 3 ] ]
gap> M1 := LMonsNP( L1 );                                             
[ [ 1, 1, 2, 1 ], [ 2, 1, 1, 2 ] ]
gap> PrintNP( [ M1, [1,1] ] );
 a^2ba + ba^2b 
gap> m1 := M1[1];; 
gap> for i in [1..5] do 
>        Print( PrefixNM( m1, i ), "\n" ); 
>    od;
[ 1 ]
[ 1, 1 ]
[ 1, 1, 2 ]
[ 1, 1, 2, 1 ]
[ 1, 1, 2, 1 ]
gap> for i in [1..5] do 
>        Print( SuffixNM( m1, i ), "\n" ); 
>    od;
[ 1 ]
[ 2, 1 ]
[ 1, 2, 1 ]
[ 1, 1, 2, 1 ]
[ 1, 1, 2, 1 ]
gap> m1 := [2,1,1,1,2,2,1,1];;           ## m1 = ba^3b^2a^2
gap> m2 := [1,1,2,2,1,1];;               ## m2 = a^2b^2a^2
gap> SuffixPrefixPosNM( m1, m2, 1, 5 );  ## overlap is a
1
gap> SuffixPrefixPosNM( m1, m2, 2, 5 );  ## overlap is a^2
2
gap> SuffixPrefixPosNM( m1, m2, 3, 5 );  ## no longer overlap
0
gap> SuffixPrefixPosNM( m2, m1, 1, 5 );  ## overlap is ba^2
3
gap> m3 := [ 1, 1, 2 ];;
gap> SubwordPosNM( m3, m1, 1 );
3
gap> SubwordPosNM( m3, m2, 1 );
1
gap> SubwordPosNM( m3, m2, 2 );
0
gap> IsSubwordNM( [ 2, 1, 2 ], m1 );
false
gap> mon := [2,2,2,2,1,1,1,3,3];;
gap> LeadVarNM( mon );           
2
gap> LeadExpNM( mon );           
4
gap> TailNM( mon );           
[ 1, 1, 1, 3, 3 ]
gap> GBNP.ConfigPrint( "a", "b", "c" );
gap> m := [ 1, 2, 3, 1, 2, 1, 2, 3 ];;
gap> d := [ 1, 2 ];;
gap> PrintNMList( [ m, d ] );
abcababc
ab                   
gap> divs := DivNM( m, d ); 
[ [ [ 1, 2, 3, 1, 2 ], [ 3 ] ], [ [ 1, 2, 3 ], [ 1, 2, 3 ] ], 
  [ [  ], [ 3, 1, 2, 1, 2, 3 ] ] ]
gap> PrintNMList( divs[1] );
abcab
c
gap> PrintNMList( divs[2] );
abc
abc
gap> PrintNMList( divs[3] );
1
cababc

gap> SetInfoLevel( InfoIBNP, ibnp_infolevel_saved );; 
gap> STOP_TEST( "monom.tst", 10000 );

#############################################################################
##
#E  monom.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
