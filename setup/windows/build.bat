SET VERSION=0.9.0
SET BKEMUDIR=C:\BKEmu-313-x32

call create_zip32.bat ru RU
call create_zip32.bat en EN

SET BKEMUDIR=C:\BKEmu-313-x64

call create_zip64.bat ru RU
call create_zip64.bat en EN
