set FOP_HOME="C:\Documents and Settings\Armin\Desktop\fop-0.95"

cd fop
call %FOP_HOME%\fop.bat -fo ..\test.fo -pdf ..\test.pdf -c conf\fop.xconf
cd ..
pause
