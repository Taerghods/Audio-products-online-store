create table Artists(
	artist_id serial primary key,
	artist_name varchar(255) not null,
	artist_lastname varchar(255)    --not null bod vali khast!! ?
);

create table Albums(
	album_id serial primary key,
	album_name varchar(255) not null,
	creation_time int not null,    --year(GetDate()) ?
	artist_id int REFERENCES Artists(artist_id)
);

create table Tracks(
	track_id serial primary key,
	track_name varchar(255) not null,
	track_size float not null,
	format varchar(255) not null,
	genre varchar(255) not null,
	duration time not null,
	price int not null,
	album_id int REFERENCES Albums(album_id)
);

create table Buyers(
	buyer_id serial primary key,
	buyer_name varchar(255) not null,
	email varchar(255) UNIQUE,
	tell varchar(255) UNIQUE
);

create type peyment_status as enum('paid','unpaid'); 
create table Orders(
	order_id serial primary key,
	peyment_status peyment_status not null,
	buy_time timestamp default now(),
	buyer_id int REFERENCES Buyers(buyer_id)
);

create table order_items(
	order_item_id serial primary key,
	quantity int not null,
	price_notification int not null,
	total int not null,
	track_id int REFERENCES Tracks(track_id),
	order_id int REFERENCES Orders(order_id)
);

-- create table Cart(
-- 	cart_id serial primary key,
-- 	totalـsum int not null,
-- 	buyer_id int REFERENCES Cart(buyer_id)
-- );
