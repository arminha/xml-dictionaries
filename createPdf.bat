set FOP_HOME="D:\fop-0.95"

cd fop
call %FOP_HOME%\fop.bat -xml ..\dictionaries\MakingOutInKorean\making_out_in_korean.xml -xsl vocabularyCards.xsl -pdf ..\MakingOutInKorean.pdf -c conf\fop.xconf
cd ..
pause
