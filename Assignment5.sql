-- Fill in the following 15 database queries in this SQL script and submit it back via Edunet.
-- For each task only a single SQL statement should be used, except where stated otherwise (you may use sub-selects if needed).

-- Name: Dominik Wirsig
-- Matrikelnr: xx



-- 1) Find the albums with 12 or more tracks.

	select album.AlbumId, count(track.TrackId) from album inner join track on album.AlbumId = track.AlbumId group by album.AlbumId having count(track.TrackId) >= 12;

-- 2) How many albums does the artist Led Zeppelin have?
	
	select count(*) from artist inner join album on artist.ArtistId = album.ArtistId where artist.Name like "Led Zeppelin";
	
-- 3a) Retrieve a list of album titles and the unit prices for the artist "Audioslave".

	select title, track.UnitPrice from artist inner join album on artist.ArtistId = album.ArtistId inner join track on album.AlbumId = track.AlbumId where artist.Name like "Audioslave";

-- 3b) How many records are returned? (<-- You may use a second query or just interpret your results and give an answer as a comment)

-- comment: 40 records

	select count(track.UnitPrice) from artist inner join album on artist.ArtistId = album.ArtistId inner join track on album.AlbumId = track.AlbumId where artist.Name like "Audioslave";

-- 4a) Find the first and last name of any customer who does not have an invoice.

	select customer.FirstName, customer.LastName from customer left join invoice on customer.CustomerId = invoice.CustomerId where invoice.InvoiceId is null;

-- 4b) Are there any customers returned from the query? (<-- You may use a second query or just interpret your results and give an answer as a comment)

-- comment: no customer without invoice!

-- 5) Find the total price for each album.

	select title, sum(track.UnitPrice) as AlbumPrice from artist inner join album on artist.ArtistId = album.ArtistId inner join track on album.AlbumId = track.AlbumId group by title;

-- 6) What is the total price for the album "Big Ones"? (Based on the tracks)

	select title, sum(track.UnitPrice) as AlbumPrice from artist inner join album on artist.ArtistId = album.ArtistId inner join track on album.AlbumId = track.AlbumId where album.Title like "Big Ones" group by title;

-- 7) How many records are created when you apply a Cartesian join to the invoice and invoice items table?

	select count(*) from invoice cross join invoiceline;
	
-- comment: 922880 records 	

-- 8) Using a subquery, find the names of all the tracks for the album "Californication".

	select name from track where track.AlbumId = (select album.AlbumId from album where Title like "Californication");

-- 9) Find the total number of invoices for each customer along with the customer's full name, city and email.

	select concat(customer.FirstName, " " ,customer.LastName), City, Email, count(InvoiceId) from customer left join invoice on customer.CustomerId = invoice.CustomerId group by concat(customer.FirstName, " " ,customer.LastName), City, Email;

-- 10) After running the query described above, what is the email address of the 5th person, František Wichterlová?
--     (You may use a query or just interpret your results and give an answer as a comment)

-- comment: the 5th record mail address is "frantisekw@jetbrains.com"

-- 11) Retrieve the track name, album, artistID, and trackID for all the albums.

	select track.Name, album.Title, album.ArtistId, TrackId from album inner join track on album.AlbumId = track.AlbumId;

-- 12) What is the song title of trackID 12 from the album "For Those About to Rock We Salute You"?

	select track.Name from album inner join track on album.AlbumId = track.AlbumId where Title like "For Those About to Rock We Salute You" and TrackId = 12;

-- 13a) Retrieve a list with the managers last name, and the last name of the employees who report to him or her.

	select  employee.LastName, boss.LastName as LastsnameOfBoss from employee left join employee as boss on employee.ReportsTo = boss.EmployeeId;

-- 13b) Who are the reporters for the manager named Mitchell?  (<-- You may use a second query or just interpret your results and give an answer as a comment)

	select employee.LastName from employee left join employee as boss on employee.ReportsTo = boss.EmployeeId where boss.LastName like "Mitchell";

-- 14) Find the name and ID of the artists who do not have albums.

	select artist.Name, artist.ArtistId, AlbumId from artist left join album on artist.ArtistId = album.ArtistId where AlbumId is null;

-- 15a) Use a UNION to create a list of all the employee's and customer's first names and last names ordered by the last name in descending order.

	select customer.FirstName, customer.LastName from customer union select employee.FirstName, employee.LastName from employee order by LastName desc;

-- 15b) Determine what is the last name of the 6th record.  (<-- You may use a second query or just interpret your results and give an answer as a comment)
--      Remember to order things in descending order to be sure to get the correct answer.

	select customer.FirstName, customer.LastName from customer union select employee.FirstName, employee.LastName from employee order by LastName desc limit 5,1;

-- comment: the 6th Lastname is "Taylor"	
	
