#############################################################################
##
##  involutive-np.gi     GAP package IBNP        Gareth Evans & Chris Wensley
##  
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
##  Installation file for functions in ibnp package.
## 

#############################################################################
##
#M  LeftDivision( <alg> <mons> <ord> )
##
InstallMethod( LeftDivision, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, mons, ord )

    local genA, ngens, nmons, lvars, rvars, i, emoni;
    genA := GeneratorsOfAlgebra( A );
    if not ( genA[1] = One(A) ) then 
        Error( "expecting genA[1] = One(A)" );
    fi;
    genA := genA{ [2..Length(genA)] };
    ngens := Length( genA );
    nmons := Length( mons );
    lvars := ListWithIdenticalEntries( nmons, 0 );
    rvars := ListWithIdenticalEntries( nmons, 0 );
    for i in [1..nmons] do   ## for each monnomial 
        lvars[i] := [1..ngens];
        rvars[i] := [ ];
    od;
    return [ lvars, rvars ];
end );


#############################################################################
##
#M  RightDivision( <alg> <mons> <ord> )
##
InstallMethod( RightDivision, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, mons, ord )

    local genA, ngens, nmons, lvars, rvars, i, emoni;
    genA := GeneratorsOfAlgebra( A );
    if not ( genA[1] = One(A) ) then 
        Error( "expecting genA[1] = One(A)" );
    fi;
    genA := genA{ [2..Length(genA)] };
    ngens := Length( genA );
    nmons := Length( mons );
    lvars := ListWithIdenticalEntries( nmons, 0 );
    rvars := ListWithIdenticalEntries( nmons, 0 );
    for i in [1..nmons] do   ## for each monnomial 
        lvars[i] := [ ];
        rvars[i] := [1..ngens];
    od;
    return [ lvars, rvars ];
end );

#############################################################################
##
#M  LeftOverlapDivision( <alg>, <mons> <ord> )
##
InstallMethod( LeftOverlapDivision, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, mons, ord )

    ## Overview: this is an implementation of Algorithm 13.
    ## returns local overlap-based multiplicative variables
    ## Detail: this function implements various algorithms
    ## described in the thesis "Noncommutative Involutive Bases"
    ## for finding left and right multiplicative variables
    ## for a set of polynomials based on the overlaps
    ## between the leading monomials of the polynomials.

    local  genA, ngenA, nmons, lenmon, nonMult, leftMult, rightMult, 
           i, moni, leni, j, monj, lenj, k;

    genA := GeneratorsOfAlgebra( A );
    if not ( genA[1] = One(A) ) then 
        Error( "expecting genA[1] = One(A)" );
    fi;
    genA := genA{ [2..Length(genA)] };
    ngenA := Length( genA );
    nmons := Length( mons );
    if( nmons = 0 ) then 
        return [ [], [] ];
    fi;
    ## set up arrays
    lenmon := List( mons, m -> Length(m) );
    leftMult := ListWithIdenticalEntries( nmons, 0 );
    rightMult := ListWithIdenticalEntries( nmons, 0 );
    nonMult := ListWithIdenticalEntries( nmons, 0 );
    for i in [1..nmons] do
        nonMult[i] := [ ];
    od;
    ## apply the conditions
    for i in [1..nmons] do
        moni := mons[i];
        leni := lenmon[i];
        for j in [i..nmons] do
            monj := mons[j];
            lenj := lenmon[j];
            if ( i <> j ) then
                ## looking for monj as a subword of moni
                for k in [1..leni-lenj] do
                    if moni{[k..(k+lenj-1)]} = monj then
                        Info( InfoIBNP, 2, "(1) [i,j,k]=", [i,j,k],
                            " adding ", moni[k+lenj], " to ", nonMult[j] );
                        Add( nonMult[j], moni[k+lenj] );
                    fi;
                od;
                ## looking for moni as a subword of monj
                for k in [1..lenj-leni] do
                    if monj{[k..(k+leni-1)]} = moni then
                        Info( InfoIBNP, 2, "(2) [i,j,k]=", [i,j,k],
                            " adding ", monj[k+leni], " to ", nonMult[i] );
                        Add( nonMult[i], monj[k+leni] );
                    fi;
                od;
            fi;
            ## looking for overlap RHS[j] = LHS[i]
            for k in [1..lenj-1] do
                if ( k < leni ) and 
                   ( moni{[1..k]} = monj{[(lenj-k+1)..lenj]} ) then
                        Info( InfoIBNP, 2, "(3) [i,j,k]=", [i,j,k],
                            " adding ", moni[k+1], " to ", nonMult[j] );
                        Add( nonMult[j], moni[k+1] );
                fi;
            od;
            ## looking for overlap RHS[i] = LHS[j]
            for k in [1..leni-1] do
                if ( k < lenj ) and
                   ( monj{[1..k]} = moni{[(leni-k+1)..leni]} ) then
                       Info( InfoIBNP, 2, "(4) [i,j,k]=", [i,j,k],
                            " adding ", monj[k+1], " to ", nonMult[i] );
                        Add( nonMult[i], monj[k+1] );
                fi;
            od;
        od;
    od;
    for i in [1..nmons] do
        leftMult[i] := [1..ngenA];
        rightMult[i] := Difference( [1..ngenA], nonMult[i] );
    od;
    return [ leftMult, rightMult ];
end );

#############################################################################
##
#M  RightOverlapDivision( <alg>, <mons> <ord> )
##
InstallMethod( RightOverlapDivision, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, mons, ord )

    ## Overview: this is an implementation of Algorithm 13.
    ## returns local overlap-based multiplicative variables
    ## Detail: this function implements various algorithms
    ## described in the thesis "Noncommutative Involutive Bases"
    ## for finding left and right multiplicative variables
    ## for a set of polynomials based on the overlaps
    ## between the leading monomials of the polynomials.
    ## This function is the mirror image of LeftOverlapDivision.

    local  genA, ngenA, nmons, lenmon, nonMult, leftMult, rightMult, 
           i, moni, leni, j, monj, lenj, k;

    genA := GeneratorsOfAlgebra( A );
    if not ( genA[1] = One(A) ) then 
        Error( "expecting genA[1] = One(A)" );
    fi;
    genA := genA{ [2..Length(genA)] };
    ngenA := Length( genA );
    nmons := Length( mons );
    if( nmons = 0 ) then 
        return [ [], [] ];
    fi;
    ## set up arrays
    lenmon := List( mons, m -> Length(m) );
    leftMult := ListWithIdenticalEntries( nmons, 0 );
    rightMult := ListWithIdenticalEntries( nmons, 0 );
    nonMult := ListWithIdenticalEntries( nmons, 0 );
    for i in [1..nmons] do
        nonMult[i] := [ ];
    od;
    ## apply the conditions
    for i in [1..nmons] do
        moni := mons[i];
        leni := lenmon[i];
        for j in [i..nmons] do
            monj := mons[j];
            lenj := lenmon[j];
            if ( i <> j ) then
                ## looking for monj as a subword of moni
                for k in [2..leni-lenj+1] do
                    if moni{[k..(k+lenj-1)]} = monj then
                        Info( InfoIBNP, 2, "(1) [i,j,k]=", [i,j,k],
                            " adding ", moni[k-1], " to ", nonMult[j] );
                        Add( nonMult[j], moni[k-1] );
                    fi;
                od;
                ## looking for moni as a subword of monj
                for k in [2..lenj-leni+1] do
                    if monj{[k..(k+leni-1)]} = moni then
                        Info( InfoIBNP, 2, "(2) [i,j,k]=", [i,j,k],
                            " adding ", monj[k-1], " to ", nonMult[i] );
                        Add( nonMult[i], monj[k-1] );
                    fi;
                od;
            fi;
            ## looking for overlap RHS[j] = LHS[i]
            for k in [1..lenj-1] do
                if ( k < leni ) and
                   ( moni{[1..k]} = monj{[(lenj-k+1)..lenj]} ) then
                        Info( InfoIBNP, 2, "(3) [i,j,k]=", [i,j,k],
                            " adding ", monj[lenj-k], " to ", nonMult[i] );
                        Add( nonMult[i], monj[lenj-k] );
                fi;
            od;
            ## looking for overlap RHS[i] = LHS[j]
            for k in [1..leni-1] do
                if ( k < lenj ) and
                   ( monj{[1..k]} = moni{[(leni-k+1)..leni]} ) then
                        Info( InfoIBNP, 2, "(4) [i,j,k]=", [i,j,k],
                            " adding ", moni[leni-k], " to ", nonMult[j] );
                        Add( nonMult[j], moni[leni-k] );
                fi;
            od;
        od;
    od;
    for i in [1..nmons] do
        rightMult[i] := [1..ngenA];
        leftMult[i] := Difference( [1..ngenA], nonMult[i] );
    od;
    return [ leftMult, rightMult ];
end );

#############################################################################
##
#M  DivisionRecordNP( <alg> <polys> <ord> )
##
InstallMethod( DivisionRecordNP, "generic method for list of monomials",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: returns local overlap-based multiplicative variables
    ## Detail: this function implements various algorithms
    ## described in the thesis "Noncommutative Involutive Bases"
    ## for finding left and right multiplicative variable 
    ## for a set of noncommutative polynomials

    local  genA, ngens, npolys, p, Lp, mons, mvars;

    genA := GeneratorsOfAlgebra( A );
    ngens := Length( genA );
    if( polys = [ ] ) then 
        return [ ];
    fi;
    npolys := Length( polys );
    ## set up arrays
    mons := LMonsNP( polys ); 
    if ( NoncommutativeDivision = "Left" ) then 
        mvars := LeftDivision( A, mons, ord );
    elif ( NoncommutativeDivision = "Right" ) then
        mvars := RightDivision( A, mons, ord );
    elif ( NoncommutativeDivision = "LeftOverlap" ) then
        mvars := LeftOverlapDivision( A, mons, ord );
    elif ( NoncommutativeDivision = "RightOverlap" ) then
        mvars := RightOverlapDivision( A, mons, ord );
    else
        Error( "invalid NoncommutativeDivision" );
    fi;
    return rec( polys := polys, mvars := mvars,
                div := NoncommutativeDivision );
end );

#############################################################################
##
#M  IPolyReduceNP( <alg> <poly> <drec> <ord> )
##
InstallMethod( IPolyReduceNP, 
    "generic method for a poly, record with fields [polys, mult vars]", true,
    [ IsAlgebra, IsObject, IsRecord, IsNoncommutativeMonomialOrdering ], 0,
function( A, obj, drec, ord )
##
## Overview: Reduces 2nd arg w.r.t. 3rd arg (polys and vars)
##
## Detail: drec is a record containing a list 'polys' of polynomials
## and their multiplicative variables 'vars'.
## Given a polynomial _pol_, this function involutively
## reduces the polynomial with respect to the given FAlgList polys
## with associated left and right multiplicative variables vars.
## The type of reduction (head reduction / full reduction) is
## controlled by the global variable headReduce.
## If IType > 3, we can take advantage of fast global reduction.
## External Variables Required: ULong nRed; int IType, pl;
## Global Variables Used: int headReduce;

    local  polys, vars, pol, pl, i, numpolys, cutoffL, cutoffR, value,
           lenOrig, lenSub, poli, front, back, diff, factors, mon, moni,
           varL, varR, facL, facR, monj, coeff, coeffi, lcm, gcd, M,
           appears, term, found, reduced, f, facf, lenf, lenL, lenR,
           polL, polR;

    if not IsDivisionRecord( drec ) then
        Error( "third argument should be an overlap record" );
    fi;
    ## determine whether obj is in NP or GP format
    if IsList( obj ) then 
        pol := obj;
    else
        pol := GP2NP( obj );
        if ( pol = fail ) then
            Error( "obj should be a polynomial in NP or GP format" );
        fi;
    fi;
    pl := InfoLevel( InfoIBNP );
    polys := drec.polys;
    vars := drec.mvars;
## Print( "reducing pol = ", pol, "\n" );
## Print( "vars = ", vars, "\n" );
    front := [ [ ], [ ] ];
    back := pol;
    numpolys := Length( polys );
    ## we now recursively reduce every term in the polynomial
    ## until no more reductions are possible
    while ( back[1] <> [ ] ) do 
        reduced := true;
        while reduced and ( back <> [ [], [] ] ) do
            reduced := false;
            mon := back[1][1];
            coeff := back[2][1];
            i := 0;
            while ( i < numpolys ) and ( not reduced ) do  
                ## for each polynomial in the list
                i := i+1;
                poli := polys[i];
## Print( "poli = ", poli, "\n" );
                if ( IType >= 3 ) then
                    lenOrig := Length( mon );
                fi;
                moni := poli[1][1];  ## pick a test monomial                                                                 
                if ( IType < 3 ) then  ## Local Division
                    ## does the ith polynomial divide our polynomial?
                    ## if so, place all possible ways in factors
                    factors := DivNM( mon, moni );
                else
                    if ( IType = 5 ) then 
                        factors := [ ]; ## no divisors w.r.t. empty division
                    else
                        lenSub := Length( moni );
                        ## Check if a prefix/suffix is possible
                        if ( lenSub <= lenOrig ) then
                            if ( IType = 3 ) then 
                            ## Left Division: look for Suffix.
                                if ( moni = 
                                    SuffixNM( mon, lenSub ) ) then
                                    if ( lenOrig = lenSub ) then
                                        factors := [ [ ], [ ] ];
                                    else
                                        factors := [ PrefixNM( mon, lenOrig-lenSub ), [ ] ];
                                    fi;
                                fi;
                            elif ( IType = 4 ) then 
                                ## Right Division; look for Prefix
                                if ( moni = 
                                     PrefixNM( mon, lenSub ) ) then
                                    if ( lenOrig = lenSub ) then
                                        factors := [ [ ], [ ] ];
                                    else
                                        factors := [ [ ], SuffixNM( mon, lenOrig-lenSub ) ];
                                    fi;
                                fi;
                            fi;
                        fi;
                    fi;
                fi;
                lenf := Length(factors);
                if ( lenf > 0 ) then ## moni divides mon
                    M := 0;  ## assume that the first conventional division 
                             ## is not an involutive division
                             ## While there are conventional divisions left 
                             ## to look at and  while none of these have yet
                             ## proved to be involutive divisions
                    found := false;
                    f := 0;
                    while ( not found ) and ( f < lenf ) and ( M = 0 ) do
                        ## assume that this conventional division 
                        ## is an involutive division
                        f := f+1;
                        facf := factors[f];
                        M := 1;
                        if ( IType < 3 ) then ## Local Division
                            ## extract the ith left & right mult variables
                            varL := vars[1][i];
                            varR := vars[2][i];
                            ## Extract the left and right factors
                            facL := facf[1];
                            facR := facf[2];
                            ## test all variables in facL for left
                            ## multiplicability in the ith monomial
                            lenL := Length( facL );
                            ## decide whether one/all variables in facL 
                            ## are left multiplicative
                            if ( MType = 1 ) then ## right-most variable only
                                if ( lenL > 0 ) then
                                    monj := facL[ lenL ];
                                    appears := monj in varL;
                                    ## if the generator doesn't appear this 
                                    ## is not an involutive division
                                    if ( not appears ) then 
                                        M := 0;
                                    fi;
                                fi;
                            else ## all variables checked
                                while ( lenL > 0 ) do
                                    lenL := lenL - LeadExpNM( facL );
                                    ## extract a generator
                                    monj := PrefixNM( facL, 1 );
                                    ## test to see if the generator appears 
                                    ## in the list of left mult variables
                                    appears := monj in varL;
                                    ## if the generator doesn't appear this 
                                    ## is not an involutive division
                                    if ( not appears ) then
                                        M := 0;
                                        break; ## exit from the while loop
                                    fi;
                                    facL := TailNM( facL );
                                    ## prepare to look at the next generator
                                od;
                            fi;
                            ## test all variables in facR for right
                            ## multiplicability in the ith monomial
                            if ( M = 1 ) then
                                lenR := Length( facR );
                                ## decide whether one/all variables in facR
                                ## are left multiplicative
                                if ( MType = 1 ) then ## Left-most var only
                                    if ( lenR > 0 ) then
                                        monj := facR[1];
                                        appears := monj in varR;
                                        ## if the generator doesn't appear
                                        ## this is not an involutive division
                                        if ( not appears ) then
                                            M := 0;
                                        fi;
                                    fi;
                                else ## all variables checked
                                    while ( lenR > 0 ) do
                                        lenR := lenR - LeadExpNM( facR );
                                        ## extract a generator
                                        monj := PrefixNM( facR, 1 );
                                        ## test to see if the gen appears
                                        ## in the list of right mult vars
                                        appears := monj in varR;
                                        ## if the gen doesn't appear this
                                        ## is not an involutive division
                                        if ( not appears ) then
                                            M := 0;
                                            break;  ## exit from while loop
                                        fi;
                                        facR := TailNM( facR );
                                    od;
                                fi;
                            fi;
                        else ## Global division
                            M := 1;
                        fi;
                                                     
#### large chunk which was commented out has now been deleted
                                                    
                        ## if this conventional division wasn't involutive, 
                        ## look at the next division
                        if ( M = 1 ) then
                            found := true;
                        fi;
                    od;
                       
                    ## if an involutive division was found
                    if found then
                        if ( pl > 3 ) then
                            Print( "found: ", mon, " = ", facf[1], ",",
                                              moni, ",", facf[2], "\n" );
                        fi;
                        ## indicate a reduction has been carried out 
                        ## to exit the loop
                        ## pick the divisor's leading coefficient
                        coeffi := poli[2][1];
                        ## pick 'nice' cancelling coefficients
                        lcm := Lcm( coeff, coeffi );
                        ## construct poly #i## -1## coefficient 
                        ## to get lead terms the same 
                        if ( facL <> [ ] ) then 
                            diff := MulNP( [ [facL], [1] ], poli ); 
                        else 
                            diff := poli;
                        fi;
                        if ( facR <> [ ] ) then
                            diff := MulNP( diff, [ [facR], [1] ] );
                        fi;
                        diff := AddNP( back, diff, lcm/coeff, -lcm/coeffi );
                        front := [ front[1], (lcm/coeff)*front[2] ];
##                        if ( diff <> [ [ ], [ ] ] ) then
##                            gcd := Gcd( diff[2] );
##                            diff := MulNP( diff, [ [ [] ], [1/gcd] ] );
##Print( "[gcd,diff] = ", [gcd,diff], "\n" );
##                        fi;
                        reduced := true;
                        ## in the next iteration we will be 
                        ## reducing the new polynomial diff
                        back := CleanNP( diff );
                    fi;
                fi;
            od;
        od;
        ## no reduction of the lead term, so add it to front
        if ( back <> [ [ ], [ ] ] ) then
            term := [ [ back[1][1] ], [ back[2][1] ] ];
            if ( front = [ [ ], [ ] ] ) then 
                front := term;
            else
                front := AddNP( front, term, 1, 1 ); 
            fi; 
            back := AddNP( back, term, 1, -1 );
        fi;
    od;
    return front;  ## return the reduced and simplified polynomial
end );

#############################################################################
##
#M  IAutoreduceNP( <alg> <polys> <ord> )
##
InstallMethod( IAutoreduceNP, "generic method for list of polys",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, polys, ord )

    ## Overview: Autoreduces an FAlgList recursively 
    ## until no more reductions are possible 
    ## Detail: This function involutively reduces each member of an FAlgList 
    ## w.r.t. all the other members of the list, removing the polynomial 
    ## from the list if it is involutively reduced to 0. This process is
    ## iterated until no more such reductions are possible. 

    local d, twod, pl, oldPoly, newPoly, nrec, new, old, oldCopy, drec,
          vars, pos, pushPos, len, gcd;

    len := Length( polys );
    ## twod := 2^d;
    pl := InfoLevel( InfoIBNP );
    if( len < 2 ) then 
        ## the input basis is empty or consists of a single polynomial
        return polys;
    fi;

    ## start by reducing the final element (working backwards means
    ## that less work has to be done calculating multiplicative variables)
    pos := len;
    ## if we are using a local division and the basis is sorted by DegRevLex,
    ## the last polynomial is irreducible so we do not have to consider it.
    if ( ( DType < 3 ) and ( SType = 1 ) ) then 
        pos := pos-1;
    fi;
    ## make a copy of the input basis for traversal
    old := StructuralCopy( polys );
    while( pos > 0 ) do   ## for each polynomial in old
        ## extract the pos-th element of the basis
        oldPoly := old[pos];
        if ( pl > 3 ) then 
            Print( "\nreducing polynomial polys(",pos,")\n" ); 
            Print( "Looking at element ", oldPoly, " of basis\n" );
        fi;
        ## construct basis without 'poly'
        oldCopy := StructuralCopy( old );  ## make a copy of old
        len := Length( oldCopy );
        ## calculate Multiplicative Variables if using a local division
        if( DType < 3 ) then
            drec := DivisionRecordNP( A, oldCopy, ord );
            vars := drec.mvars;
            ## vars := fMonPairListRemoveNumber( pos, vars );
            vars[1] := Concatenation( vars[1]{[1..pos-1]}, 
                                      vars[1]{[pos+1..len]} ); 
            vars[2] := Concatenation( vars[2]{[1..pos-1]}, 
                                      vars[2]{[pos+1..len]} ); 
        fi;

        ## new := fAlgListFXRem( old, oldPoly ); ## remove oldPoly from old
        new := Concatenation( old{[1..pos-1]}, old{[pos+1..len]} );
        Sort( new, GtNPoly );
        nrec := DivisionRecord( A, new, ord );
        old := StructuralCopy( oldCopy );     ## restore old
        ## to recap, old is now unchanged whilst new holds all
        ## the elements of old except oldPoly.

        ## involutively reduce the old polynomial w.r.t. the truncated list
        newPoly := IPolyReduceNP( A, oldPoly, nrec, ord );

        ## if the polynomial did not reduce to 0
        if not ( newPoly = [ [ ], [ ] ] ) then 
            ## divide the polynomial through by its GCD
            gcd := Gcd( newPoly[2] );
            newPoly := [ newPoly[1], newPoly[2]/gcd ];
            if( pl > 2 ) then 
                Print( "reduced pol to " ); 
                PrintNP( newPoly );
                Print( "\n" );
            fi;
            ## check for trivial ideal
            if ( newPoly = [ ] ) then 
                return AlgebraOneNP;
            fi;
            if IsNegInt( newPoly[2][1] ) then 
                newPoly[2] := -newPoly[2];
            fi;
            ## if the old polynomial is equal to the new polynomial
            ## (i.e. no reduction took place)
            if ( oldPoly = newPoly ) then 
                ## we may proceed to look at the next polynomial 
                pos := pos - 1;
            else 
                ## otherwise some reduction took place so start again
                ## if we are restricting prolongations based on degree,...
                if ( DegRestrict = 1 ) then 
                    ## ... and if the degree of the lead term of the 
                    ## new polynomial exceeds the current bound...
Error("here");
                    if ( Length( LeadingMonomialOfPolynomial( newPoly, ord ) ) > d ) then 
                        ## ... we must adjust the bound accordingly
                        d := Length( LeadingMonomialOfPolynomial( newPoly, ord ) );
                        if ( pl > 2 ) then 
                            Print( "new value of d = ", d, "\n" );
                        fi;
                        twod := 2*d;
                    fi;
                fi;
                ## add the new polynomial onto the list
                if ( DType < 3 ) then   ## local division 
                    if ( SType = 1 ) then   ## DegRevLex sorted
                        ## push the new polynomial onto the list
Error("here");
                        old := fAlgListDegRevLexPushPosition( 
                                   newPoly, new, pushPos );
                        ## if it is inserted into the same position we 
                        ## may continue and look at the next polynomial
                        if ( pushPos = pos ) then 
                            pos := pos-1;      
                        ## if it is inserted into a later position 
                        ## we continue from one position above
                        else 
                            if ( pushPos > pos ) then 
                                pos := pushPos - 1;
                            fi;
                        ## Note: the case pushPos < pos cannot occur 
                        fi;
                    elif ( SType = 2 ) then   ## no sorting 
                        ## push the new polynomial onto the end of the list
                        old := Concatenation( new, [ newPoly ] );
                        Sort( old, GtNPoly );
                        ## return to the end of the list minus one
                        ## (we know the last element is irreducible)
                        pos := Length( old ) - 1;
                    else   ## sorted by main ordering
                        ## push the new polynomial onto the list
Error("here");
                        old := fAlgListNormalPush( newPoly, new );
                        ## return to the end of the list
                        pos := Length( old );
                    fi;
                else   ## global division 
                    ## push the new polynomial onto the end of the list
                    old := Concatenation( new, [ newPoly ]  );
                    Sort( old, GtNPoly );
                    ## return to the end of the list minus one
                    ## (we know the last element is irreducible)
                    pos := Length( old ) - 1;
                fi;
            fi; 
        else    
            ## the polynomial reduced to zero
            ## remove the polynomial from the list
            old := StructuralCopy( new );
            ## continue to look at the next element
            pos := pos - 1;
            if ( pl > 2 ) then 
                Print( "Reduced p to 0\n");
            fi;
        fi;
    od;
    Sort( old, GtNPoly );
    ##  return the fully autoreduced basis
    if ( old = polys ) then ## no change
        return true;
    else
        return old;
    fi;
end );

#############################################################################
##
#M  InvolutiveBasisNP( <alg> <polys> )
##
InstallMethod( InvolutiveBasisNP, "generic method for algebra + list of polys",
    true, [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ], 0,
function( A, polys, ord )

    ##  Implements Algorithm 12 for computing locally involutive bases. 

    local  pl, gens, ngens, all, zero, mrec, mvars, nvars, basis0, basis,
           nbasis, done, prolong, u, lenu, v, i, j, k, npro, found;

    pl := InfoLevel( InfoIBNP );
    DType := 1;
    SType := 2;
    gens := GeneratorsOfAlgebra( A );
    if not ( gens[1] = One(A) ) then 
        Error( "expecting gens[1] = One(A)" );
    fi;
    gens := gens{ [2..Length(gens)] };
    ngens := Length( gens );
    all := [ 1..ngens ];
    zero := [ [ ], [ ] ];
    if ( pl > 2 ) then 
        Print( "Computing an Involutive Basis...\n");
    fi;
    basis := List( polys, p -> CleanNP(p) );
    done := false;
    while ( not done ) do
        Sort( basis, GtNPoly );
        if ( pl > 2 ) then
            Print( "restarting with basis:\n" );
            PrintNPList( basis );
        fi;
        basis0 := ShallowCopy( basis );
        basis := IAutoreduceNP( A, basis0, ord );
        if ( basis = true ) then 
            basis := basis0;
        fi;
        nbasis := Length( basis );
        mrec := DivisionRecordNP( A, basis, ord );
        mvars := mrec.mvars;
        nvars := [ List( mvars[1], v -> Difference( all, v ) ), 
                   List( mvars[2], v -> Difference( all, v ) ) ];
        if ( pl > 2 ) then 
            Print( "nvars = ", nvars, "\n" );
        fi;
        ## construct the prolongations
        prolong := [ ];
        for i in [1..nbasis] do
            ## left prolongations
            lenu := Length( basis[i][1] );
            for j in nvars[1][i] do
                u := StructuralCopy( basis[i] );
                for k in [1..lenu] do
                    u[1][k] := Concatenation( [j], u[1][k] );
                od;
                Add( prolong, CleanNP( u ) );
            od;
            ## right prolongations
            for j in nvars[2][i] do
                u := StructuralCopy( basis[i] );
                for k in [1..lenu] do
                    Add( u[1][k], j );
                od;
                Add( prolong, CleanNP( u ) );
            od;
        od;
        Sort( prolong, LtNPoly );
        if ( pl > 2 ) then
            Print( "prolong = \n" );
            PrintNPList( prolong );
        fi;
        npro := Length( prolong ); 
        found := false;
        i := 0;
        while ( not found ) and ( i < npro ) do 
            i := i+1;
            u := prolong[i];
            v := IPolyReduceNP( A, u, mrec, ord );
            if ( v <> [ [ ], [ ] ] ) then 
                found := true; 
                if IsNegInt( v[2][1] ) then 
                    v[2] := -v[2];
                fi;
                Add( basis, v );
            fi;
        od;
        if not found then
            done := true;
        fi;
    od;
    return DivisionRecordNP( A, basis, ord );
end );

#############################################################################
##
#E  involutive-np.gi . . . . . . . . . . . . . . . . . . . . . . .  ends here
## 