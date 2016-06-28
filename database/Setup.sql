--<ScriptOptions statementTerminator=";"/>

DROP TRIGGER "DTUGRP09"."NoNegativeBalance";

DROP TRIGGER "DTUGRP09"."ValidCPR";

DROP TRIGGER "DTUGRP09"."NoNegativeAmount";

DROP TRIGGER "DTUGRP09"."AccountType_I";

ALTER TABLE "DTUGRP09"."Account" DROP CONSTRAINT "AccountExchange";

ALTER TABLE "DTUGRP09"."Account" DROP CONSTRAINT "AccountIsType";

ALTER TABLE "DTUGRP09"."Account" DROP CONSTRAINT "CustomerAccount";

ALTER TABLE "DTUGRP09"."History" DROP CONSTRAINT "AccountHistory";

ALTER TABLE "DTUGRP09"."History" DROP CONSTRAINT "HistoryTransaction";

ALTER TABLE "DTUGRP09"."History" DROP CONSTRAINT "History_Account_FK";

ALTER TABLE "DTUGRP09"."Transaction" DROP CONSTRAINT "TransactionExchange";

ALTER TABLE "DTUGRP09"."User" DROP CONSTRAINT "CityFromPostalCode";

ALTER TABLE "DTUGRP09"."UserRoles" DROP CONSTRAINT "PermissionsForRoles";

ALTER TABLE "DTUGRP09"."UserRoles" DROP CONSTRAINT "UserRoles";

ALTER TABLE "DTUGRP09"."Account" DROP CONSTRAINT "Account_PK";

ALTER TABLE "DTUGRP09"."AccountType" DROP CONSTRAINT "AccountType_PK";

ALTER TABLE "DTUGRP09"."City" DROP CONSTRAINT "City_PK";

ALTER TABLE "DTUGRP09"."Exchange" DROP CONSTRAINT "Exchange_PK";

ALTER TABLE "DTUGRP09"."History" DROP CONSTRAINT "History_PK";

ALTER TABLE "DTUGRP09"."Permissions" DROP CONSTRAINT "Permissions_PK";

ALTER TABLE "DTUGRP09"."Transaction" DROP CONSTRAINT "Transaction_PK";

ALTER TABLE "DTUGRP09"."User" DROP CONSTRAINT "Customer_PK";

ALTER TABLE "DTUGRP09"."UserRoles" DROP CONSTRAINT "UserRoles_PK";

DROP TABLE "DTUGRP09"."Account";

DROP TABLE "DTUGRP09"."AccountType";

DROP TABLE "DTUGRP09"."City";

DROP TABLE "DTUGRP09"."Exchange";

DROP TABLE "DTUGRP09"."History";

DROP TABLE "DTUGRP09"."Permissions";

DROP TABLE "DTUGRP09"."Transaction";

DROP TABLE "DTUGRP09"."User";

DROP TABLE "DTUGRP09"."UserRoles";

CREATE TABLE "DTUGRP09"."Account" (
		"AccountID" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (
			START WITH 1
			INCREMENT BY 1
			MINVALUE -2147483648
			MAXVALUE 2147483647
			NO CYCLE
			CACHE 20
			NO ORDER ), 
		"AccountName" VARCHAR(45), 
		"Balance" DECIMAL(16 , 4) NOT NULL, 
		"UserID" DECIMAL(10 , 0) NOT NULL, 
		"AccountTypeName" VARCHAR(45) NOT NULL, 
		"Currency" CHAR(3) NOT NULL, 
		CONSTRAINT "Account_PK" PRIMARY KEY
		("AccountID")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."AccountType" (
		"AccountTypeName" VARCHAR(45) NOT NULL, 
		"Interest" DECIMAL(5 , 4) NOT NULL, 
		CONSTRAINT "AccountType_PK" PRIMARY KEY
		("AccountTypeName")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."City" (
		"PostalCode" DECIMAL(4 , 0) NOT NULL, 
		"City" VARCHAR(45) NOT NULL, 
		CONSTRAINT "City_PK" PRIMARY KEY
		("PostalCode")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."Exchange" (
		"Currency" CHAR(3) NOT NULL, 
		"Rate" DECIMAL(6 , 2) NOT NULL, 
		CONSTRAINT "Exchange_PK" PRIMARY KEY
		("Currency")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."History" (
		"TransactionID" INTEGER NOT NULL, 
		"Balance" DECIMAL(16 , 4) NOT NULL, 
		"AccountID" INTEGER NOT NULL, 
		"AmountLocal" DECIMAL(16 , 4) NOT NULL, 
		"TransactionType" CHAR(1) NOT NULL, 
		"Message" VARCHAR(45), 
		CONSTRAINT "History_PK" PRIMARY KEY
		("TransactionID", 
		 "AccountID")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."Permissions" (
		"PermissionName" VARCHAR(10) NOT NULL, 
		"Description" VARCHAR(100), 
		CONSTRAINT "Permissions_PK" PRIMARY KEY
		("PermissionName")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."Transaction" (
		"TransactionID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (
			START WITH 1
			INCREMENT BY 1
			MINVALUE -2147483648
			MAXVALUE 2147483647
			NO CYCLE
			CACHE 20
			NO ORDER ), 
		"TransactionTime" TIMESTAMP(2) NOT NULL, 
		"AccountIDFrom" INTEGER NOT NULL, 
		"AccountIDTo" INTEGER NOT NULL, 
		"AmountForeign" DECIMAL(16 , 4) NOT NULL, 
		"Currency" CHAR(3) NOT NULL, 
		CONSTRAINT "Transaction_PK" PRIMARY KEY
		("TransactionID")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."User" (
		"UserID" DECIMAL(10 , 0) NOT NULL, 
		"UserName" VARCHAR(45) NOT NULL, 
		"PostalCode" DECIMAL(4 , 0) NOT NULL, 
		"Address" VARCHAR(45), 
		"Phone" DECIMAL(8 , 0), 
		"Email" VARCHAR(45), 
		"Salt" CHAR(64) NOT NULL, 
		"Password" CHAR(64) NOT NULL, 
		CONSTRAINT "Customer_PK" PRIMARY KEY
		("UserID")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "DTUGRP09"."UserRoles" (
		"UserID" DECIMAL(10 , 0) NOT NULL, 
		"PermissionName" VARCHAR(10) NOT NULL, 
		CONSTRAINT "UserRoles_PK" PRIMARY KEY
		("UserID", 
		 "PermissionName")
	)
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE UNIQUE INDEX "DTUGRP09"."AccountType_PK"
	ON "DTUGRP09"."AccountType"
	("AccountTypeName");

CREATE UNIQUE INDEX "DTUGRP09"."Account_PK"
	ON "DTUGRP09"."Account"
	("AccountID");

CREATE UNIQUE INDEX "DTUGRP09"."City_PK"
	ON "DTUGRP09"."City"
	("PostalCode");

CREATE UNIQUE INDEX "DTUGRP09"."Customer_PK"
	ON "DTUGRP09"."User"
	("UserID");

CREATE UNIQUE INDEX "DTUGRP09"."Exchange_PK"
	ON "DTUGRP09"."Exchange"
	("Currency");

CREATE UNIQUE INDEX "DTUGRP09"."History_PK"
	ON "DTUGRP09"."History"
	("TransactionID", 
	 "AccountID");

CREATE UNIQUE INDEX "DTUGRP09"."Permissions_PK"
	ON "DTUGRP09"."Permissions"
	("PermissionName");

CREATE UNIQUE INDEX "DTUGRP09"."Transaction_PK"
	ON "DTUGRP09"."Transaction"
	("TransactionID");

CREATE UNIQUE INDEX "DTUGRP09"."UserRoles_PK"
	ON "DTUGRP09"."UserRoles"
	("UserID", 
	 "PermissionName");

ALTER TABLE "DTUGRP09"."Account" ADD CONSTRAINT "AccountExchange" FOREIGN KEY
	("Currency")
	REFERENCES "DTUGRP09"."Exchange"
	("Currency")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."Account" ADD CONSTRAINT "AccountIsType" FOREIGN KEY
	("AccountTypeName")
	REFERENCES "DTUGRP09"."AccountType"
	("AccountTypeName")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."Account" ADD CONSTRAINT "CustomerAccount" FOREIGN KEY
	("UserID")
	REFERENCES "DTUGRP09"."User"
	("UserID")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."History" ADD CONSTRAINT "AccountHistory" FOREIGN KEY
	("AccountID")
	REFERENCES "DTUGRP09"."Account"
	("AccountID")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."History" ADD CONSTRAINT "HistoryTransaction" FOREIGN KEY
	("TransactionID")
	REFERENCES "DTUGRP09"."Transaction"
	("TransactionID")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."History" ADD CONSTRAINT "History_Account_FK" FOREIGN KEY
	("AccountID")
	REFERENCES "DTUGRP09"."Account"
	("AccountID")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."Transaction" ADD CONSTRAINT "TransactionExchange" FOREIGN KEY
	("Currency")
	REFERENCES "DTUGRP09"."Exchange"
	("Currency")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."User" ADD CONSTRAINT "CityFromPostalCode" FOREIGN KEY
	("PostalCode")
	REFERENCES "DTUGRP09"."City"
	("PostalCode")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."UserRoles" ADD CONSTRAINT "PermissionsForRoles" FOREIGN KEY
	("PermissionName")
	REFERENCES "DTUGRP09"."Permissions"
	("PermissionName")
	ON DELETE CASCADE;

ALTER TABLE "DTUGRP09"."UserRoles" ADD CONSTRAINT "UserRoles" FOREIGN KEY
	("UserID")
	REFERENCES "DTUGRP09"."User"
	("UserID")
	ON DELETE CASCADE;

CREATE TRIGGER "DTUGRP09"."NoNegativeBalance" 
	NO CASCADE BEFORE UPDATE OF "Balance" ON "DTUGRP09"."Account"
	REFERENCING  NEW AS NEW
		OLD AS OLD
	FOR EACH ROW MODE DB2SQL
	NOT SECURED
WHEN (-- Insert search condition
-- Example: new_row.col1 = 'val1'
NEW."Balance"<0
)
-- Insert action that is performed when the search condition is met
-- Example: SET new_row.col2 = 'val2'
-- Example: CALL SQL_PROC1(new_row.col3)
SIGNAL SQLSTATE '75001' ('ERROR: A negative balance is not allowed')#;

CREATE TRIGGER "DTUGRP09"."ValidCPR" 
	NO CASCADE BEFORE INSERT ON "DTUGRP09"."User"
	REFERENCING  NEW AS NEW
	FOR EACH ROW MODE DB2SQL
	NOT SECURED
WHEN (NEW."CustomerID" NOT BETWEEN 1000000000 AND 9999999999

)
SIGNAL SQLSTATE '75001' ('ERROR: Your CPR-number must be 10 digits long (without \"- \" )');

CREATE TRIGGER "DTUGRP09"."NoNegativeAmount" 
	NO CASCADE BEFORE INSERT ON "DTUGRP09"."Transaction"
	REFERENCING  NEW AS NEW
	FOR EACH ROW MODE DB2SQL
	NOT SECURED
WHEN (-- Insert search condition
-- Example: new_row.col1 = 'val1'
NEW."Transaction"."AmountForeign" < 0
)
-- Insert action that is performed when the search condition is met
-- Example: SET new_row.col2 = 'val2'
-- Example: CALL SQL_PROC1(new_row.col3)
SIGNAL SQLSTATE '75001' ('ERROR: Negative amounts are not allowed');

