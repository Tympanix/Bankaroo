CREATE PROCEDURE Backup ()
	VERSION V1
	ISOLATION LEVEL CS
	RESULT SETS 1
	LANGUAGE SQL
P1: BEGIN
	INSERT INTO "DTUGRP09"."BackupHistory" SELECT * FROM "DTUGRP09"."History";
	INSERT INTO "DTUGRP09"."BackupTransaction" SELECT * FROM "DTUGRP09"."Transaction";
	
	DELETE FROM "DTUGRP09"."History";	
	DELETE FROM "DTUGRP09"."Transaction";	
END P1