delimiter $$
create trigger increase_copies_assigned
after insert on issuedby
for each row
begin 
    update books
    set copies_assigned = copies_assigned + 1
        where books.bid = NEW.bid;
end $$
delimiter ;


delimiter $$
create trigger decrease_copies_assigned
after update on issuedby
for each row
begin 
    update books
    set copies_assigned = copies_assigned - 1
        where books.bid = NEW.bid;
end $$
delimiter ;



delimiter $$
create trigger increase_issued_count
after insert on issuedby
for each row
begin 
    update readers
    set no_of_books_assigned = no_of_books_assigned + 1
        where readers.rid = NEW.rid;
end $$
delimiter ;