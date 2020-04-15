set /a logcount +=1
if %logcount% == 5 ( set /a logcount=0)
set log="logs\%headerlog%-%logcount%.log"