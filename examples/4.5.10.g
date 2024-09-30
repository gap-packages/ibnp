#############################################################################
##
#W  4.5.10.g          GAP4 package IBNP          Gareth Evans & Chris Wensley
##
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  

## this implements Example 4.5.10 in the thesis,

LoadPackage( "ibnp" );
CommutativeDivision := "Janet";;
oldlimit := InvolutiveAbortLimit;;
InvolutiveAbortLimit := 10;

R := PolynomialRing( Rationals, [ "s", "t", "w", "x", "y", "z" ] );;
s:=R.1;; t:=R.2;; w:=R.3;; x:=R.4;; y:=R.5;; z:=R.6;;

R2 := PolynomialRing( Rationals, [ "x", "y" ] );;
x := R2.1;; y := R2.2;;
ord2 := MonomialLexOrdering( [y,x] );;

F := [ 2*x*y + x^2 + 5, y^2 + x + 8 ];;
drecF := DivisionRecord( R2, F, ord2 );
Print( "drecF = ", drecF, "\n" );
ibasF := InvolutiveBasisCP( R2, F, ord2 );
Print( "ibasF = ", ibasF, "\n" );

R3 := PolynomialRing( Rationals, [ "t", "x", "y" ] );;
t := R3.1;; x := R3.2;; y := R3.3;;
ord3 := MonomialLexOrdering( [y,x,t] );;

H := [ 2*x*y + x^2 + 5*t^2, y^2 + x*t + 8*t^2 ];;
drecH := DivisionRecord( R3, H, ord3 );
Print( "drecH = ", drecH, "\n" );
ibasH := InvolutiveBasisCP( R3, H, ord3 );
Print( "ibasH = ", ibasH, "\n" );

InvolutiveAbortLimit := oldlimit;;

############################################################################
##
#E  4.5.10.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
