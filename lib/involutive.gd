#############################################################################
##
##  involutive.gd        GAP package IBNP        Gareth Evans & Chris Wensley
##  
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  
##  Declaration file for functions in the ibnp package.
##

DeclareOperation( "LeftMultVars", [ IsList ] ); 
DeclareOperation( "RightMultVars", [ IsList ] ); 
DeclareOperation( "EmptyMultVars", [ IsList ] ); 

############################################################################# 
## 
##  declare a few functions and global parameters to make this work 
## 
DeclareOperation( "fAlgListDegRevLexPushPosition", [ IsList, IsList ] ); 
DeclareOperation( "fAlgListNormalPush", [ IsList, IsList ] ); 
##
## DeclareOperation( "fAlgLeadMonom", [ IsList ] );
##     replaced by LeadingMonomialOfPolynomial( p, ord );
## DeclareOperation( "fAlgMonom", [ IsList ] ); 
## DeclareOperation( "fMonDivFirst", [ IsList ] ); 
## DeclareOperation( "fMonPrefix", [ IsList ] ); 
## DeclareOperation( "fMonRest", [ IsList ] ); 
## DeclareOperation( "fMonSubWord", [ IsList ] ); 
## DeclareOperation( "fAlgListPush", [ IsList ] ); 
## DeclareOperation( "fAlgListSingle", [ IsList ] ); 
## DeclareOperation( "fAlgListSort", [ IsList ] ); 
## DeclareOperation( "fAlgListFXRev", [ IsList ] ); 
## DeclareOperation( "fAlgListFXRem", [ IsList, IsList ] ); 
## DeclareOperation( "fAlgListDegRevLexPush", [ IsList ] ); 
## DeclareOperation( "qOne", [ IsList ] ); 
## DeclareOperation( "findGCD", [ IsList ] ); 
## DeclareOperation( "fMonPairListRemoveNumber", [ IsInt, IsList ] ); 
## DeclareOperation( "MultiplicativeQuickSort", [ IsList ] ); 

DegRestrict := 2; 

#############################################################################
##
#O  ThomasDivision( <alg> <polys> <ord> )     ??? is ord needed here ???
#O  JanetDivision( <alg> <polys> <ord> )
#O  PommaretDivision( <alg> <polys> <ord> )
##
DeclareOperation( "ThomasDivision", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "JanetDivision", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "PommaretDivision", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "LeftDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "RightDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "LeftOverlapDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "RightOverlapDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "StrongLeftOverlapDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "StrongRightOverlapDivision", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );

#############################################################################
##
#F  DivisionRecord( <args> )
#O  DivisionRecordCP( <alg> <polys> <ord> )
#O  DivisionRecordNP( <alg> <polys> <ord> )
#P  IsDivisionRecord( <rec> )
##
DeclareGlobalFunction( "DivisionRecord" );
DeclareOperation( "DivisionRecordCP", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "DivisionRecordNP", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );
DeclareProperty( "IsDivisionRecord", IsRecord );

#############################################################################
##
#F  IPolyReduce( <args> )
#O  IPolyReduceCP( <alg> <poly> <orec> <ord> )
#O  IPolyReduceNP( <alg> <poly> <orec> <ord> )
#F  LoggedIPolyReduce( <args> )
#O  LoggedIPolyReduceCP( <alg> <poly> <orec> <ord> )
#O  LoggedIPolyReduceNP( <alg> <poly> <orec> <ord> )
#O  CombinedIPolyReduceCP( <alg> <poly> <orec> <ord> <logging> )
#O  CombinedIPolyReduceNP( <alg> <poly> <orec> <ord> <logging> )
##
DeclareGlobalFunction( "IPolyReduce" );
DeclareOperation( "IPolyReduceCP", 
    [ IsPolynomialRing, IsPolynomial,IsRecord, IsMonomialOrdering ] );
DeclareOperation( "IPolyReduceNP",
    [ IsAlgebra, IsObject, IsRecord, IsNoncommutativeMonomialOrdering ] );
DeclareGlobalFunction( "LoggedIPolyReduce" );
DeclareOperation( "LoggedIPolyReduceCP", 
    [ IsPolynomialRing, IsPolynomial, IsRecord, IsMonomialOrdering ] );
DeclareOperation( "LoggedIPolyReduceNP",
    [ IsAlgebra, IsObject, IsRecord, IsNoncommutativeMonomialOrdering ] );
DeclareOperation( "CombinedIPolyReduceCP", 
    [ IsPolynomialRing, IsPolynomial, IsRecord, 
      IsMonomialOrdering, IsBool ] );
DeclareOperation( "CombinedIPolyReduceNP",
    [ IsAlgebra, IsObject, IsRecord, 
      IsNoncommutativeMonomialOrdering, IsBool ] );

#############################################################################
##
#F  IAutoreduce( <args> )
#O  IAutoreduceCP( <alg> <polys> <ord> )
#O  IAutoreduceNP( <alg> <polys> <ord> )
##
DeclareGlobalFunction( "IAutoreduce" );
DeclareOperation( "IAutoreduceCP", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] );
DeclareOperation( "IAutoreduceNP", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] );

#############################################################################
##
#F  InvolutiveBasis( <args> )
#O  InvolutiveBasisCP( <alg> <list> <ord> )
#O  InvolutiveBasisNP( <alg> <list> <ord> )
##
DeclareGlobalFunction( "InvolutiveBasis" );
DeclareOperation( "InvolutiveBasisCP", 
    [ IsAlgebra, IsList, IsMonomialOrdering ] ); 
DeclareOperation( "InvolutiveBasisNP", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] ); 

#############################################################################
##
#O  Seiler( <alg>, <list> <ord> )
#O  Gerdt( <alg> <list> <ord> )
#O  NormalBatch( <alg>, <list> )
##
DeclareOperation( "Seiler", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] ); 
DeclareOperation( "Gerdt", 
    [ IsAlgebra, IsList, IsNoncommutativeMonomialOrdering ] ); 
DeclareOperation( "NormalBatch", [ IsAlgebra, IsList ] ); 

#############################################################################
##
#E  involutive.gd . . . . . . . . . . . . . . . . . . . . . . . .  ends here
##  