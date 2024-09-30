#############################################################################
##
##  start.gi         GAP package IBNP            Gareth Evans & Chris Wensley
##  
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
##  Installation file for functions in ibnp package.
## 

#############################################################################
##
#V  InfoIBNP
##
DeclareInfoClass( "InfoIBNP" );
SetInfoLevel( InfoIBNP, 1 );

#############################################################################
##
##  declare default algebras Algebra2 and Algebra3
##
Algebra2IBNP := FreeAssociativeAlgebraWithOne(Rationals,"a","b"); 
Algebra3IBNP := FreeAssociativeAlgebraWithOne(Rationals,"a","b","c"); 
Algebra4IBNP := FreeAssociativeAlgebraWithOne(Rationals,"a","A","b","B"); 
AlgebraIBNP := Algebra2IBNP;
AlgebraZeroNP := [ [ ], [ ] ]; 
AlgebraOneNP := [ [ [  ] ], [ 1 ] ]; 
AlgebraGensNP := [1,2];    
AlgebraNumGensNP := 2;

#############################################################################
##
##  declare various parameters
##
ZeroNP := [ [ [] ], [0] ];   ## NP form of the zero polynomial
InvolutiveAbortLimit := 20;  ## abort when generating an infinite basis 

#############################################################################
##
#M  DisplayIBNP( <polys>, <pl> )
## 
##  displays a list of polynomials according to print level
##
InstallMethod( DisplayIBNP, "displays list of polynomials by print level",
    true, [ IsList, IsInt ], 0,
function( polys, pl ) 
    local i, pol, Lpol;
    for i in [1..Length(polys)] do 
        pol := polys[i]; 
        Lpol := GP2NP( pol ); 
        ## if pl=1, display the polynomial using the original generators
        if( pl = 1 ) then 
            PrintNP( Lpol );
        ## else  display the polynomial using ASCII generators
        elif ( pl = 2 ) then  
            Print( Lpol, "\n" ); 
        else 
            Error( "pl not in [1,2]" );  
        fi; 
    od; 
end );

#############################################################################
##
#M  SetAlgebraIBNP( <alg> )
## 
##  this replaces the default Algebra with alg 
##  and that will be used for all future computations 
##
InstallMethod( SetAlgebraIBNP, "fix an Algebra2 for the current computations",
    true, [ IsAlgebra ], 0,
function( alg )

    AlgebraIBNP := alg; 
    AlgebraGensNP := [1..Length( GeneratorsOfLeftOperatorRingWithOne(alg) )];    
    AlgebraNumGensNP := Length( AlgebraGensNP ); 
end ); 

#############################################################################
##
#M  declare default divisions
## 
CommutativeDivision := "Pommaret";
NoncommutativeDivision := "LeftOverlap";

#############################################################################
##
#E  start.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
## 