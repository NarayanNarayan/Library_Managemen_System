from django.shortcuts import render,redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.template import loader
from django.http import Http404
from django.views import generic
from django.utils import timezone

import mysql.connector
mydb = mysql.connector.connect(
	host="localhost",
	user="root",
	password="loop",
	database="test"
)
cursor = mydb.cursor()

def likelist(t):
	l=[]
	for i in t:
		l.append('%%%s%%'%i)
	return l

def index(request):
	return redirect('lib:home')

def userlogin(request):
	if(request.method=="POST"):
		username=request.POST['username']
		password=request.POST['password']
		sql="select rid,name from readers where username =%s and password =%s"
		arg=(username,password,)
		cursor.execute(sql,(username,password,))
		result = cursor.fetchall()
		if(len(result)>0):
			request.session['rid']=result[0][0]
			request.session['uname']=result[0][1]
			return redirect('lib:mainuser')
		else:
			return render(request,'lib/userlogin.html',{'ismached':False})
	else:
		return render(request,'lib/userlogin.html',{'ismached':True})
def adminlogin(request):
	if(request.method=="POST"):
		username=request.POST['username']
		password=request.POST['password']
		sql="select adid from admins where username =%s and password =%s"
		arg=(username,password,)
		cursor.execute(sql,(username,password,))
		result = cursor.fetchall()
		if(len(result)>0):
			request.session['adid']=result[0][0]
			return redirect('lib:mainadmin')
		else:
			return render(request,'lib/adminlogin.html',{'ismached':False})
	else:
		return render(request,'lib/adminlogin.html',{'ismached':True})
def searchbooks(request):
	try:
		bid=request.GET['bid']
		bname=request.GET['bname']
		category=request.GET['category']
		auth=request.GET.get('auth')
		publisher=request.GET.get('publisher')

		sql="""select bid,books.name as bname,category,authors.name as aname,publishers.name as pname,copies_total - copies_assigned as copiesleft
		from books,authors,publishers where bid like %s  and  books.name like %s  and category like %s and publisher=pid and publishers.name like %s and authors.name in 
		(select name from authors natural inner join books_authors where name like %s and books.bid = books_authors.bid)"""
		cursor.execute(sql,likelist((bid,bname,category,auth,publisher,)))
		result = cursor.fetchall()
		
		return render(request,'lib/searchbooks.html',{'result':result})
	except:	
		print("In Except of searchbooks")
		return render(request,'lib/searchbooks.html',{'result':{}})
def signup(request):
	if (request.method == 'POST'):
		username=request.POST.get('username')
		password=request.POST.get('pwd')
		cpassword=request.POST.get('cpwd')
		print(request.POST.get('dob'))
		isusernameempty=False
		passmatch=True
		isuserexist=False
		if(username==''):
			isusernameempty=True
		if(password!=cpassword):
			passmatch=False
		sql='select username from readers where username=%s'
		cursor.execute(sql,(username,))
		result = cursor.fetchall()
		data={}
		for x in result:
			if username in x:
				isuserexist=True
		if(isuserexist or not passmatch or isusernameempty):
			return render(request,'lib/signupr.html',{'isuserexist':isuserexist,'passmatch':passmatch,'isusernameempty':isusernameempty})
		else:
			sql='''insert into readers (username, password ,name,dob,email,phone0,phone1,
			addr,city,pin,no_of_books_assigned,due_fine) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,0,0)'''
			argus=(request.POST['username'],request.POST['pwd'],request.POST['name'],request.POST['dob'],\
				request.POST['email'],request.POST['phone0'],request.POST['phone1'],request.POST['addr'],request.POST['city'],request.POST['pin'],)
			cursor.execute(sql,argus)
			print('Checkpoint')
			mydb.commit()
			sql='select rid,name from readers where username =%s'
			cursor.execute(sql,(username,))
			result = cursor.fetchall()
			request.session['rid']=result[0][0]
			request.session['uname']=result[0][1]
			print(result[0][0])
			return redirect('lib:mainuser')

	return render(request,'lib/signup.html',)

def onlyadmin(func):
	def ofunc(req):
		if('adid' in req.session):
			return func(req)
		else:
			return redirect('lib:adminlogin')
	return ofunc

@onlyadmin
def mainadmin(request):
	return render(request,'lib/mainadmin.html')

def mainuser(request):
	print("In mainuser")
	if('rid' in request.session):
		return render(request,'lib/mainuser.html')
	else: return redirect('lib/login')

def updateprofile(request):
	try:
		rid=request.session['rid']
		sql='select name,username,dob,email,phone0,phone1,addr,city,pin from readers where rid = %s'
		cursor.execute(sql,(rid,))
		result = cursor.fetchall()
		userdata={}
		if(len(result)>0):
			userdata['name']=result[0][0]
			userdata['username']=result[0][1]
			userdata['dob']=result[0][2]
			userdata['email']=result[0][3]
			userdata['phone0']=result[0][4]
			userdata['phone1']=result[0][5]
			userdata['addr']=result[0][6]
			userdata['city']=result[0][7]
			userdata['pin']=result[0][8]
		return render(request,'lib/updateprofile.html',{'userdata':userdata})
	except:
		print("In Except of updateprofile")
		return redirect(request,'lib:home')
def updateprofiler(request):
	print("Entered updateprofiler")
	try:
		rid=request.session['rid']
		print('Checkpoint0')
		sql='update readers SET name=%s,username=%s,dob=%s,email=%s,phone0=%s,phone1=%s,addr=%s,city=%s,pin=%s where rid = %s'
		arg=(request.POST['name'],request.POST['username'],request.POST['dob'],request.POST['email'],request.POST['phone0'],request.POST['phone1'],request.POST['addr'],request.POST['city'],request.POST['pin'],rid,)
		print(arg)
		cursor.execute(sql,arg)
		print('Checkpoint')
		mydb.commit()
	except:
		print("In Except of updateprofiler")
	return redirect('lib:mainuser')

def chpwd(request):
	if(request.method=="POST"):
		if(request.POST['pwd']==request.POST['cpwd']):
			sql='update readers SET password=%s where rid = %s'
			arg=(request.POST['pwd'],request.session['rid'],)
			cursor.execute(sql,arg)
			mydb.commit()
			return redirect('lib:mainuser')
		else:
			return render(request,'lib/chpwd.html',{'passmatch':False})
	return render(request,'lib/chpwd.html',{'passmatch':True})

def main(request):
	myresult=[[100,200,300]]
	
	return render(request,'lib/main.html',{'data':myresult})

def home(request):
	return render(request,'lib/home.html',{})

def userlogout(request):
	try:
		del(request.session['rid'])
		return redirect('lib:userlogin')
	except:
		return redirect('lib:userlogin')

def adminlogout(request):
	try:
		del(request.session['adid'])
		return redirect('lib:adminlogin')
	except:
		return redirect('lib:adminlogin')

@onlyadmin
def add_author(request):
	if(request.method=="POST"):
		sql='insert into authors (name,dob,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s,%s)'
		arg=(request.POST['name'],request.POST['dob'],\
		request.POST['email'],request.POST['phone0'],request.POST['phone1'],request.POST['addr'],request.POST['city'],request.POST['pin'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return redirect('lib:mainadmin')
	else:
		return render(request,'lib/add_author.html')

@onlyadmin
def add_book(request):
	if(request.method=="POST"):
		sql='insert into books (name,category,publisher,copies_total,copies_assigned) values (%s,%s,%s,%s,0)'
		arg=(request.POST['name'],request.POST['category'],request.POST['publisher'],request.POST['copies_total'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return redirect('lib:mainadmin')
	else:
		return render(request,'lib/add_book.html')

@onlyadmin
def add_publisher(request):
	if(request.method=="POST"):
		sql='insert into publishers (name,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s)'
		arg=(request.POST['name'],request.POST['email'],request.POST['phone0'],request.POST['phone1'],request.POST['addr'],request.POST['city'],request.POST['pin'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return redirect('lib:mainadmin')
	else:	
		return render(request,'lib/add_publisher.html')

@onlyadmin
def add_section(request):
	if(request.method=="POST"):
		sql='insert into sections (name,room_no,category) values (%s,%s,%s)'
		arg=(request.POST['name'],request.POST['room_no'],request.POST['category'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return redirect('lib:mainadmin')
	else:	
		return render(request,'lib/add_section.html')

@onlyadmin
def add_admin(request):
	if(request.method=="POST"):
		if(request.POST['pwd']==request.POST['cpwd']):
			sql='insert into admins (name,username,password,post,salary,dob,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
			arg=(request.POST['name'],request.POST['username'],request.POST['pwd'],request.POST['post'],request.POST['salary'],request.POST['dob'],\
			request.POST['email'],request.POST['phone0'],request.POST['phone1'],request.POST['addr'],request.POST['city'],request.POST['pin'],)
			cursor.execute(sql,arg)
			mydb.commit()
			return redirect('lib:mainadmin')
		else:
			return render(request,'lib/add_admin.html' ,{'passmatch':False})
	else:	
		return render(request,'lib/add_admin.html',{'passmatch':True})

@onlyadmin
def add_properbooks(request):
	if(request.method=="POST"):
		sql = "INSERT INTO proper_books (bid,edition,publication_year,section) values (%s,%s,%s,%s)"
		arg=(request.POST['bid'],request.POST['edition'],request.POST['publication_year'],request.POST['section'],)
		for i in range(int(request.POST['copies'])):
			cursor.execute(sql,arg)
		mydb.commit()
		return redirect('lib:mainadmin')
	else:
		return render(request,'lib/add_properbooks.html' ,{'passmatch':False})

@onlyadmin
def show_authors(request):
	sql='select * from authors'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_authors.html',{'result':result})

@onlyadmin
def show_books(request):
	sql='select * from books'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_books.html',{'result':result})

@onlyadmin
def show_publishers(request):
	sql='select * from publishers'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_publishers.html',{'result':result})

@onlyadmin
def show_readers(request):
	sql='select * from readers'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_readers.html',{'result':result})

@onlyadmin	
def show_sections(request):
	sql='select * from sections'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_sections.html',{'result':result})

@onlyadmin
def show_admins(request):
	sql='select * from admins'
	cursor.execute(sql)
	result = cursor.fetchall()
	return render(request,'lib/show_admins.html',{'result':result})

@onlyadmin
def submitbook(request):
	if(request.method=="POST"):
		sql="update issuedby set return_date=%s , fine=%s where bid=%s and rid=%s"
		cursor.execute(sql,(request.POST['submitdate'],request.POST['fine'],request.POST['bid'],request.POST['rid'],))
		sql="UPDATE proper_books set issued=0 WHERE pbid=%s"
		cursor.execute(sql,(request.POST['bid'],))
		mydb.commit()
		return redirect('lib:mainadmin')
	else:
		return render(request,'lib/submitbook.html')

@onlyadmin
def issuebook(request):
	if(request.method=="POST"):
		sql="insert into issuedby (bid,rid,assigned_date,issued_by) values (%s,%s,%s,%s)"
		cursor.execute(sql,(request.POST['bid'],request.POST['rid'],request.POST['issuedate'],request.POST['issued_by'],))
		sql="UPDATE proper_books set issued=1 WHERE pbid=%s"
		cursor.execute(sql,(request.POST['bid'],))
		mydb.commit()
		return redirect('lib:mainadmin')
	else:
		return render(request,'lib/issuebook.html')

# def login(request):
# 	if(request.method=="POST"):
# 		username=request.POST['username']
# 		password=request.POST['password']
# 		level=request.POST.get('level')
# 		if(level=="user"):
# 			sql="select rid from readers where username =%s and password =%s"
# 		elif(level=="admin"):
# 			sql="select adid from admins where username =%s and password =%s"
# 		else:
# 			pass
# 		if(level!="guest"):
# 			arg=(username,password,)
# 			cursor.execute(sql,(username,password,))
# 			result = cursor.fetchall()
# 			print(result)
# 			if(len(result)>0):
# 				if(level=="user"):
# 					request.session['rid']=result[0][0]
# 					return redirect('lib:mainuser')
# 				if(level=="admin"):
# 					request.session['adid']=result[0][0]
# 					return redirect('lib:mainadmin')
# 			else:
# 				return render(request,'lib/login.html',{'ismached':False})
# 		else:
# 			return redirect('lib:main')
# 	else:
# 		return render(request,'lib/login.html',{'ismached':True})