insert into publishers (
	pid ,
	name ,
	addr ,
    city ,
    pin ,
	email ,
	phone0 ,
	phone1 
) values (100,"Jaico Publishing House","Tilakganj","Mirzapur",50000,"jaicopublishinghouse@gmail.com","9204563000","9178877892"),
(101,"Westland Publications","West of State Bank of India","Prayagraj",50011,"westlandpublications@gmail.com","9211789325","9274563291"),
(102,"Penguin Random House India","Near Westros, City Center","Delhi",50012,"penguinrandom@gmail.com","9296325811","9740321291"),
(103,"Rupa Publications","509, DB Mall","Ujjain",50013,"rupa@gmail.com","9210022361","9210022361"),
(104,"Hachette India","Infront of KV No. 1","Hisar",50014,"hachette@gmail.com","9278932111","9291123654"),
(105,"Aleph Book Company",".","Haryana",50015,"alephbookcompany@gmail.com","9789654211","9297854121"),
(106,"HarperCollins","East of Eastores","Lucknow",50016,"harpercollins@gmail.com","9213210001","9200120391");

insert into books (
	bid  ,
	name ,
	category ,
	publisher ,
	copies_total ,
	copies_assigned 
) values (100,"HCVerma","Science",100,3,1),
(101,"IEIrodov","Science",101,2,1),
(102,"Cengage Mathmatics: Algebra","Maths",102,2,0),
(103,"RDSharma Class 11","Maths",103,1,1),
(104,"Wings of Fire","Autobiography",104,1,0),
(105,"Dhyaya","UPSC",105,1,1),
(106,"Harry Potter and Goblet of Fire","Fiction",106,4,1);

insert into authors (
	aid  ,
	name ,
	dob ,
	addr ,
    city ,
    pin ,
	email ,
	phone0 ,
	phone1 
) values (100,"Chetan Bhagat","1975-01-11","Andheri","Mumbai",50000,"chetanbhagatofficial@gmail.com","9200563214","9192789645"),
(101,"Dr. APJ Abdul Kalam","1931-10-15",".",".",999,".",".","."),
(102,"Vikram Seth","1965-07-13","East City","Hyderabad",50012,"vikramseth@gmail.com","9277889911","9291001122"),
(103,"Arnab Vidhayak","1984-10-24","South of City Park","Ujjain",50013,"arnabvidhayak@gmail.com","9216666661","9278321491"),
(104,"HC Verma","2000-11-15","89/7, IIT Campus","Kanpur",50014,"hcverma@iitk.ac.in","9278453211","9278453211"),
(105,"Ruskin Bond","1942-10-06","Sanjeevani Nagar","Dehradun",50015,"rbond@gmail.com","9214565451","9291789865"),
(106,"Kiran Desai","1980-11-17","Near SK Park","Jaipur",50016,"writerkirandesai@gmail.com","9456397211","9278453211");

insert into sections (
	sid  ,
	name ,
	room_no ,
	category

) values (

100,"HP","101","Fiction"),
(101,"Kids","101","Children"),
(102,"Autobiography","101","Autobiography"),
(103,"Study","102","Maths"),
(104,"College","102","Science"),
(105,"UPSC","102","UPSC");

insert into proper_books (
	pbid  ,
	bid ,
	edition ,
	publication_year ,
	section ,
	issued
) values (100,100,"First",2010,104,1),
(101,100,"First",2010,104,0),
(102,100,"First",2010,104,0),
(103,101,"Mechanics",2012,104,1),
(104,101,"Mechanics",2012,103,0),
(105,102,"Algebra I",2014,104,0),
(106,102,"Algebra II",2015,104,0),
(107,103,"Main",2008,103,1),
(108,104,"Main",1999,102,0),
(109,105,"Maths Edition",2018,105,1),
(110,106,"Main",2000,100,1),
(111,106,"Main",2000,100,0),
(112,106,"Main",2000,100,0),
(113,106,"Main",2000,100,0);

insert into readers (
	rid  ,
	username ,
	password ,
	name ,
	dob ,
	no_of_books_assigned ,
	due_fine ,
	addr ,
	city ,
	pin ,
	email ,
	phone0 ,
	phone1
) values
(100,"user0","pass@341","Aryan Desai","2000-10-27",2,0,"Andheri","Mumbai",50000,"aryan@gmail.com","9207863250","9456302211"),
(101,"user1","pass1111","Nash Singh","2000-09-23",0,100,"Bandra","Mumbai",50011,"nash@gmail.com","9789654211","9456302211"),
(102,"user2","pass2222","Neha Dhupiya","1990-05-10",0,123,"Andheri","Mumbai",50012,"nehadhupiya@gmail.com","9214532101","9000000291"),
(103,"user3","pass3456","Prince Williams of England","1986-01-24",0,0,"Andheri","Mumbai",50013,"soontobeking@gmail.com","9456321211","9278965491"),
(104,"user4","pass9870","Ashish","2000-11-15",150,1,"North","Mumbai",0,"ashish@gmail.com","9200102211","9456302211"),
(105,"user5","pass4536","Narayan","2000-11-16",106,1,"South","Mumbai",0,"narayan@gmail.com","9456302211","9456302211"),
(106,"user6","pass1736","Sonam","2000-11-17",107,1,"East","Mumbai",0,"sonam@gmail.com","9210022131","9278965491");

insert into admins (
	adid   ,
	username ,
	password ,
	name ,
	dob ,
	post ,
	salary ,
	addr ,
    city ,
    pin ,
	email ,
	phone0 ,
	phone1  
) values (100,"admin","admin","Ashok Singh","1952-10-10","Administrator",8000000,"East Andheri","Mumbai",50000,"ashoksingh1952@gmail.com","9208956320","9192"),
(101,"staff1","staff1","Megha Vaidya","1992-06-03","Book Receptionist",5000000,"West Andheri","Mumbai",50000,"meghavaidya@gmail.com","9208965320","9178365492"),
(102,"staff2","staff2","Tushar","1995-07-02","Book Receptionist",5000000,"West Andheri","Mumbai",50000,"tushar@gmail.com","9963965320","9963965320"),
(103,"staff3","staff3","Ayush Jain","1985-09-12","Watchman",1000000,"Bandra","Mumbai",50000,"ayushjain@gmail.com","9963965320","9963965320");

insert into books_authors (
	bid  ,
	aid 
) values 
(100,101),(101,100),(102,104),(103,105),(104,103),(105,102),(106,106);

insert into rooms (
	room_no ,
	floor ,
	section1_id ,
	section2_id ,
	section3_id
) values (100,"101","100","101","102"),(101,"102","103","104","105");