#############################################################################
##
#W  testall.g         GAP4 package IBNP          Gareth Evans & Chris Wensley
##
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##  

LoadPackage( "ibnp" ); 
dir := DirectoriesPackageLibrary("ibnp","tst");
TestDirectory(dir, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));
FORCE_QUIT_GAP(1);
