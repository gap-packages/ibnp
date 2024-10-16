#############################################################################
##
##  PackageInfo.g        GAP package `ibnp'      Gareth Evans & Chris Wensley
##  
##  Copyright (C) 2024: please refer to the COPYRIGHT file for details.
##

SetPackageInfo( rec(

PackageName := "IBNP",
Subtitle := "Involutive Bases for Noncommutative Polynomials",
Version := "0.11",
Date := "16/10/2024", 
License := "GPL-2.0-or-later",

Persons := [
  rec(
    LastName      := "Evans",
    FirstNames    := "Gareth A.",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "gareth@mathemateg.com",
    PostalAddress := Concatenation( [ 
                        "Ysgol y Creuddyn \n",
                       "Ffordd Derwen, Bae Penrhyn \n",
                       "Llandudno, LL30 3LB \n",
                       "U.K."] ),
  ),
  rec(
    LastName      := "Wensley",
    FirstNames    := "Christopher D.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "cdwensley.maths@btinternet.com",
    WWWHome       := "https://github.com/cdwensley",
    Place         := "Llanfairfechan"
  )
],

Status := "deposited",
CommunicatedBy := "",
AcceptDate := "",

SourceRepository := rec( 
  Type := "git", 
  URL := "https://github.com/gap-packages/ibnp"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://gap-packages.github.io/ibnp/",
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL, 
                                  "/releases/download/v", ~.Version, 
                                  "/", ~.PackageName, "-", ~.Version ), 
SupportEmail := "cdwensley.maths@btinternet.com",
ArchiveFormats  := ".tar.gz",

AbstractHTML :=
"The ibnp package provides ...",

PackageDoc := rec(
  BookName  := "ibnp",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Involutive Bases for Noncommutative Polynomials",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.9.0",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.6.1" ], 
                           [ "GBNP", ">= 1.1.0" ], 
                           [ "utils", ">=0.81" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

Autoload := false, 

TestFile := "tst/testall.g", 

Keywords := [ "involutive bases" ], 

BannerString := Concatenation(
    "Loading IBNP ", String( ~.Version ), 
    " (Involutive Bases for Noncommutative Polynomials)\n", 
    "by Gareth Evans and Chris Wensley (https://github.com/cdwensley).\n", 
    "Report issues at https://github.com/gap-packages/ibnp/issues.\n", 
    "--------------------------------------------------------------------\n" ),

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "&copyright; 2024, Gareth Evans and Chris Wensley.<P/>\n", 
            "The &IBNP; package is free software; you can redistribute ", 
            "it and/or modify it under the terms of the GNU General ", 
            "Public License as published by the Free Software Foundation; ", 
            "either version 2 of the License, or (at your option) ", 
            "any later version.\n"
            ),
        Abstract := Concatenation( 
            "The &IBNP; package provides ...\n <P/>",
            "Bug reports, comments, suggestions for additional features, ", 
            "and offers to implement some of these, will all be ", 
            "very welcome.\n <P/>", 
            "Please submit any issues at ", 
            "<URL>https://github.com/gap-packages/ibnp/issues/</URL> ", 
            "or send an email to the second author at ", 
            "<Email>cdwensley.maths@btinternet.com</Email>.\n <P/>" 
            ), 
        Acknowledgements := Concatenation( 
            "This documentation was prepared with the ", 
            "&GAPDoc; <Cite Key='GAPDoc'/> and ", 
            "&AutoDoc; <Cite Key='AutoDoc'/> packages.<P/>\n", 
            "The procedure used to produce new releases uses the package ", 
            "<Package>GitHubPagesForGAP</Package> ", 
            "<Cite Key='GitHubPagesForGAP' /> ", 
            "and the package <Package>ReleaseTools</Package>.<P/>" 
            ),
    ) 
),

));
