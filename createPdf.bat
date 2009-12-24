set FOP_HOME="C:\Documents and Settings\Armin\Desktop\fop-0.95"

cd fop
call %FOP_HOME%\fop.bat -xml ..\dictionaries\MakingOutInKorean\making_out_in_korean.xml -xsl vocabularyCards.xsl -pdf ..\MakingOutInKorean.pdf -c conf\fop.xconf
cd ..
pause
