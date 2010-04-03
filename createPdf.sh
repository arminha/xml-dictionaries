#!/bin/sh

CURDIR=`pwd`
cd $CURDIR/fop
fop -xml ../dictionaries/MakingOutInKorean/making_out_in_korean.xml -xsl vocabularyCards.xsl -pdf ../MakingOutInKorean.pdf -c conf/fop.xconf
cd $CURDIR
