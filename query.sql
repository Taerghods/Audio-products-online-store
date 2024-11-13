insert into Artists(artist_name, artist_lastname) values ('Hojat', 'Ashrafzade');
insert into Albums(album_name, creation_time, artist_id) values ('Kaman Abroo', 2012, 5);
insert into Tracks(track_name, track_size, format, genre, duration, price, album_id) values ('Nime Janam', 3.2, 'mp3', 'classic', '00:02:58', 200, 5);
insert into Buyers(buyer_name, email, tell) values ('Selena', 'selena@yahoo.com','091212345678');
insert into Orders(peyment_status, buyer_id) values ('unpaid', 6);
insert into order_items(quantity, price_notification, total, track_id, order_id) values (2, 200, 3*200, 13,2);

select * from Artists;
select * from Albums;
select * from Tracks;
select * from Buyers;
select * from Orders;
select * from order_items;

-- q1:
select Al.album_id, count(T.track_id), AVG(T.duration), sum(T.price) AS sum_price from Albums Al
join Tracks T on Al.album_id = T.album_id group by Al.album_id order by sum_price asc;

--q2:
select track_id, quantity from order_items oi
where oi.quantity >= 0.6 * (select max(quantity) from order_items oi) order by oi.quantity desc;

--q3:?
select Ar.artist_name, Ar.artist_lastname from Artists Ar
inner join Tracks T on Ar.artist_id = T.artist_id where T.genre = 'rock' group by Ar.artist_id, Ar.artist_name, Ar.artist_lastname having count(T.track_id) >= 10;

--q4:?
select B.buyer_name, max(oi.buy_time) from Buyers B 
join order_items oi on B.buyer_id = oi.buyer_id group by B.buyer_name order by oi.buy_time

-- q5:
select Al.album_id, Al.album_name from Albums Al
join Tracks T on Al.album_id = T.album_id
join order_items OI on T.track_id = OI.track_id group by Al.album_id, Al.album_name having sum(OI.quantity) = 1;

--q6:
update Tracks set T.price = T.price * 0.5
where (select sum(oi.quantity * T.price) from order_items oi
where oi.track_id = T.track_id) < 0.002 * (select sum(oi2.quantity * T2.price) from order_items oi2
join Tracks T2 on oi2.track_id = T2.track_id where T2.genre = T.genre);

