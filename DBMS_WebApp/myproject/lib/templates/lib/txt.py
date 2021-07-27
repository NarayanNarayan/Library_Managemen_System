
import mysql.connector
mydb = mysql.connector.connect(
	host="localhost",
	user="root",
	password="loop",
	database="test"
)
cursor = mydb.cursor()

bid=''
bname='book'
category='cat'
def likelist(t):
	l=[]
	for i in t:
		l.append('%%%s%%'%i)
	return l

#sql="select bid,name,category,copies_total,copies_assigned from books where bid like %s  and  name like %s  and category like %s"
#cursor.execute(sql,likelist((bid,bname,category,)))
# sql="""select bid,books.name as bname,category,authors.name as aname,publishers.name as pname,copies_total - copies_assigned as copiesleft
# 		from books,authors,publishers where bid like %s  and  books.name like %s  and category like %s and publisher=pid and publishers.name like %s and authors.name in 
# 		(select name from authors natural inner join books_authors where name like %s and books.bid = books_authors.bid)"""
# cursor.execute(sql,likelist((0,'','Math','','',)))
# sql='update readers SET name=%s,username=%s,dob=%s,email=%s,phone0=%s,phone1=%s,addr=%s,city=%s,pin=%s where rid = %s'
# arg=('potato pc', 'user0', '2025-12-31', 'email0@gmail.com', '9200', '9192', ' Kuua me', 'Mirzapur', '50000', 100)
sql='select * from readers'
cursor.execute(sql)
print(cursor.fetchall())




mydb.commit()
