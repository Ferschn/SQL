-- Füllen Sie die folgenden 12 Datenbankabfragen in dieses SQL-Script ein und geben Sie es wieder über Edunet ab.
-- Pro Aufgabe soll nur ein SQL-Statement verwendet werden, sofern nicht anders beschrieben (Sub-Selects sind aber erlaubt).

-- Name: Dominik Wirsig
-- Matrikelnummer:xxx

-- 0) (1p.) Setzen Sie Ihre Datenbank als die Standard-Datenbank für die Statements in dieser Datei. 

		- wie in der Vorlesung über python:
			con = pymysql.connect("185.39.173.142", "uebung", "uebung", "uebung", 13306)

		- Oder als SQL Statement im MySQL Workbench:
			use uebung;


-- 1) (1p.) Geben Sie alle Informationen über Employees aus, welche im Attribut TITLE den Wert "Manager" beinhalten (irgendwo).


	SELECT * FROM EMPLOYEE 
	WHERE TITLE LIKE '%Manager%';


-- 2) (2p.) Geben Sie das Attribut NAME des Produktes (Tabelle: Product), die Anzahl der Konten (Tabelle: Account) als "Anz" und dazu die Summe des Attributes AVAIL_BALANCE als "Sum" pro Prduktkategorie aus.


	Select PRODUCT.NAME,count(Account.Account_ID) as Anz,sum(Account.AVAIL_BALANCE) as Sum 
	from PRODUCT,Account where PRODUCT.PRODUCT_CD = ACCOUNT.PRODUCT_CD
	group by PRODUCT.PRODUCT_CD;


-- 3) (1p.) Geben Sie die Attribute FIRST_NAME, LAST_NAME, START_DATE der Mitarbeiter (Tabelle: Employee) aus, welcher laut dem Attribut START_DATE am längsten in Unternehmen ist.

	select START_DATE,FIRST_NAME,LAST_NAME
	from EMPLOYEE
	where START_DATE = (select min(START_DATE) from EMPLOYEE);


-- 4) (2p.) Geben Sie die Attribute FIRST_NAME, LAST_NAME, BIRTH_DATE und CITY aller Privatkunden (Tabelle: Individual) aus, bei welchen das Attribut BIRTH_DATE unter dem durchschnittlichen Wert des Attributes BIRTH_DATE liegt.


	select INDIVIDUAL.FIRST_NAME,INDIVIDUAL.LAST_NAME,INDIVIDUAL.BIRTH_DATE,CUSTOMER.CITY
	from INDIVIDUAL,CUSTOMER
	where CUSTOMER.CUST_ID = INDIVIDUAL.CUST_ID and INDIVIDUAL.BIRTH_DATE < (select avg(INDIVIDUAL.BIRTH_DATE) from INDIVIDUAL);



-- 5) (1p.) Geben Sie die Attribute FIRST_NAME und LAST_NAME aller Kundenbetreuer (Tabelle: Officer) geordnet nach deren Vornamen in absteigender Reihenfolge aus, welche den Text "Vice President" (exakt) im Attribut TITLE haben.

	select OFFICER.LAST_NAME,OFFICER.FIRST_NAME 
	FROM OFFICER
	WHERE OFFICER.TITLE='Vice President'
	ORDER BY OFFICER.FIRST_NAME DESC;


-- 6) (2p.) Geben Sie alle Städte (Tabelle: City) mit mehr als einem Kunde (Tabelle: Customer) mit den folgenden zwei Informationen aus:
--         -) Stadt (Attribut: CITY)
--         -) Anzahl an Kunden die aus dieser Stadt kommen


	Select CUSTOMER.CITY as Stadt,count(CUSTOMER.CUST_ID) as Anzahl
	from CUSTOMER
	group by CUSTOMER.CITY
	having count(CUSTOMER.CUST_ID) > 1;


 
 -- 7) (1p.) Ermitteln Sie die Anzahl an Kunden (zu bezeichnen als "Co") gruppiert anhand des Attributes CUST_TYPE_CD.

	Select CUSTOMER.CUST_TYPE_CD as Co,count(CUSTOMER.CUST_ID)
	from CUSTOMER
	group by CUSTOMER.CUST_TYPE_CD;


 -- 8) (3p.) Geben Sie Attribute CUST_ID, CITY und die Summe des Attributes AVAIL_BALANCE bezeichnet als "Sum" pro Kunde (Tabelle: Customer) aus. 
 --          Geben Sie davon nach der Summe absteigend sortiert alle Kunden aus, welche insgesamt eine "Sum" besitzen, die größer als 4000 ist.

	Select CUSTOMER.CUST_ID,CUSTOMER.CITY,sum(ACCOUNT.AVAIL_BALANCE) as Sum
	from CUSTOMER,ACCOUNT
	where CUSTOMER.CUST_ID = ACCOUNT.CUST_ID
	group by CUSTOMER.CUST_ID
	having sum(ACCOUNT.AVAIL_BALANCE) > 4000
	order by sum(ACCOUNT.AVAIL_BALANCE) desc;


 -- 9) (2p.) Geben Sie die Attribute CUST_ID, CITY von ALLEN Kunden (Tabelle: Customer) aus, und wenn es sich um einen Businesskunden (Tabelle Business) handelt auch den NAME (bei allen anderen Arten von Kunden bleibt diese Spalte leer).


	Select CUSTOMER.CUST_ID,CUSTOMER.CITY,BUSINESS.NAME
	from CUSTOMER
	LEFT JOIN BUSINESS
	ON CUSTOMER.CUST_ID = BUSINESS.CUST_ID;
 
 -- 10) (2p.) Erstellen Sie eine Tabelle "account_type" mit den Spalten "acc_type_cd" (integer) und "description" (varchar(50)).

	CREATE TABLE account_type (
    	acc_type_cd integer,
    	description varchar(50));


 
 -- 11) (2p.) Fügen Sie drei Zeilen mit folgenden Werten in die neu erstellte Tabelle ein (hier ist mehr als ein SQL-Statement erlaubt):
 --           1, Premium
 --           2, High
 --           3, Standard

	INSERT INTO account_type (acc_type_cd,description)
	VALUES (1, "Premium");
	#VALUES (2, "High");
	#VALUES (3, "Standard");



