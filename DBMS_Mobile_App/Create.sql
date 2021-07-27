create database test;

use test;

create table publishers (
	pid int AUTO_INCREMENT,
	name varchar(100),
	addr varchar(100),
    city varchar(100),
    pin int,
	email varchar(100),
	phone0 varchar(20),
	phone1 varchar(20),
	primary key(pid)
);

create table books (
	bid int AUTO_INCREMENT,
	name varchar(100),
	category varchar(100),
	publisher int,
	copies_total int,
	copies_assigned int,
	primary key(bid),
	foreign key(publisher) references publishers(pid)
);

create table authors (
	aid int AUTO_INCREMENT,
	name varchar(100),
	dob date,
	email varchar(100),
	addr varchar(100),
    city varchar(100),
    pin int,
	phone0 varchar(20),
	phone1 varchar(20),
	primary key(aid)
);

create table sections (
	sid int AUTO_INCREMENT,
	name varchar(100),
	room_no int,
	category varchar(100),
	primary key(sid)

);

create table proper_books (
	pbid int AUTO_INCREMENT,
	bid int,
	edition varchar(100),
	publication_year int,
	section int,
	issued int default 0,
	primary key (pbid),
	foreign key (bid) references books(bid),
	foreign key (section) references sections(sid)
);

create table readers (
	rid int AUTO_INCREMENT,
	username varchar(100),
	password varchar(100),
	name varchar(100),
	dob date,
	email varchar(100),
	phone0 varchar(20),
	phone1  varchar(20),
	addr varchar(100),
	city varchar(100),
	pin int,
	no_of_books_assigned int,
	due_fine int,
	primary key(rid)
);

create table admins (
	adid  int AUTO_INCREMENT,
	username varchar(100),
	password varchar(100),
	name varchar(100),
	post varchar(100),
	salary varchar(20),
	dob date,
	email varchar(100),
	phone0 varchar(20),
	phone1 varchar(20),
	addr varchar(100),
    city varchar(100),
    pin int,
    primary key(adid)
);

create table books_authors (
	bid int AUTO_INCREMENT,
	aid int,
	index book_author(bid,aid),
	primary key (bid,aid),
	foreign key (bid) REFERENCES books(bid),
	foreign key (aid) REFERENCES authors(aid)
);

create table rooms (
	room_no int,
	floor int,
	section1_id int,
	section2_id int,
	section3_id int,
	primary key (room_no)

);


create table issuedby (
	bid int,
	rid int,
	assigned_date date,
	expeced_return date,
	return_date date,
	fine int default 0,
	issued_by varchar(100),
	primary key(bid,rid),
	foreign key (bid) references proper_books(pbid),
	foreign key (rid) references readers(rid)
);