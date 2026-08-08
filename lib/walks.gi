#############################################################################
##
#W  walks.gi              GAP4 package IBNP      Gareth Evans & Chris Wensley
##

#############################################################################
##
#M  MatrixOfMonomialOrdering( <ord> )
##
InstallMethod( MatrixOfMonomialOrdering, "method for monomial ordering",
    true, [ IsMonomialOrdering ], 0,
function( ord )
    local  n, name, L, M, ok, i, j;
    n := Length( OccuringVariableIndices( ord ) );
    name := Name( ord );
    Print( "name = ", name, "\n" );
    L := ListWithIdenticalEntries( n, 0 );
    M := ListWithIdenticalEntries( n, 0 );
    for i in [1..n] do
        M[i] := ListWithIdenticalEntries( n, 0 );
        M[i][i] := 1;
    od;
    ok := IsMatrix( M );
    Print( "ok = ", ok, "\n" );
    if ( name = "MonomialLexOrdering()" ) then
        Print( "ordering is Lex\n" );
    elif ( name = "MonomialGrlexOrdering()" ) then
        Print( "ordering is DegLex\n" );
        L := ListWithIdenticalEntries( n, 1 );
        M := Concatenation( [ L ], M );
    else
        Print( "unknown ordering name\n" );
        return fail;
    fi;
    return M;
end );

#############################################################################
##
#M  GroebnerWalk( <args> )
##
BindGlobal( "GroebnerWalk", 
function( arg )
    local nargs, A, polys, ord;
    nargs := Length( arg );
    if not ( nargs = 3 ) then 
        Error( "expecting arguments [ A, polys, ord ]" ); 
    fi;
    A := arg[1];
    polys := arg[2];
    ord := arg[3];
    if not IsNearAdditiveMagma( A ) then 
        Error( "expecting an algebra as first parameter" ); 
    fi;
    if IsCommutative( A ) then 
        return GroebnerWalkCP( A, polys, ord ); 
    else 
        return GroebnerWalkNP( A, polys, ord );
    fi;
end );

#############################################################################
##
#M  GroebnerWalkCP( <alg> <polys> <ord> )
##
InstallMethod( GroebnerWalkCP, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: 

    return 0;
end );

#############################################################################
##
#M  GroebnerWalkNP( <alg> <polys> <ord> )
##
InstallMethod( GroebnerWalkNP, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: 

    return 0;
end );

#############################################################################
##
#M  InvolutiveWalk( <args> )
##
BindGlobal( "InvolutiveWalk", 
function( arg )
    local nargs, A, polys, ord;
    nargs := Length( arg );
    if not ( nargs = 3 ) then 
        Error( "expecting arguments [ A, polys, ord ]" ); 
    fi;
    A := arg[1];
    polys := arg[2];
    ord := arg[3];
    if not IsNearAdditiveMagma( A ) then 
        Error( "expecting an algebra as first parameter" ); 
    fi;
    if IsCommutative( A ) then 
        return InvolutiveWalkCP( A, polys, ord ); 
    else 
        return InvolutiveWalkNP( A, polys, ord );
    fi;
end );

#############################################################################
##
#M  InvolutiveWalkCP( <alg> <polys> <ord> )
##
InstallMethod( InvolutiveWalkCP, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: 

    return 0;
end );

#############################################################################
##
#M  InvolutiveWalkNP( <alg> <polys> <ord> )
##
InstallMethod( InvolutiveWalkNP, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: 

    return 0;
end );

#############################################################################
##
#E  walks.gi . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
## 