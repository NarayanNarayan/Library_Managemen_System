from django.shortcuts import render,redirect
from django.http import HttpResponse, HttpResponseRedirect ,JsonResponse
from django.urls import reverse
from django.template import loader
from django.http import Http404
from django.views import generic
from django.utils import timezone
import json
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

def userlogin(request):
	if(request.method=="GET"):
		username=request.GET['username']
		password=request.GET['password']
		sql="select rid,name from readers where username =%s and password =%s"
		arg=(username,password,)
		cursor.execute(sql,(username,password,))
		result = cursor.fetchall()
		if(len(result)>0):
			request.session['rid']=result[0][0]
			request.session['uname']=result[0][1]
			return JsonResponse({'success':True,'rid':result[0][0],'uname':result[0][1]})
		else:
			return JsonResponse({'success':False})
	else:
		return JsonResponse({'success':False})#Unreachable code

def adminlogin(request):
	if(request.method=="GET"):
		username=request.GET['username']
		password=request.GET['password']
		sql="select adid from admins where username =%s and password =%s"
		arg=(username,password,)
		cursor.execute(sql,(username,password,))
		result = cursor.fetchall()
		if(len(result)>0):
			request.session['adid']=result[0][0]
			return JsonResponse({'success':True,'adid':result[0][0]})
		else:
			return JsonResponse({'success':False})
	else:
		return JsonResponse({'success':False})#Unreachable code

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
		
		return JsonResponse({'success':True,'result':result})
	except:	
		print("In Except of searchbooks")
		return JsonResponse({'success':False})#Unreachable code
def signup(request):
	if (request.method == 'GET'):
		username=request.GET.get('username')
		password=request.GET.get('pwd')
		cpassword=request.GET.get('cpwd')
		print(request.GET.get('dob'))
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
			return JsonResponse({'success':False,'isuserexist':isuserexist,'passmatch':passmatch,'isusernameempty':isusernameempty})
		else:
			sql='''insert into readers (username, password ,name,dob,email,phone0,phone1,
			addr,city,pin,no_of_books_assigned,due_fine) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,0,0)'''
			argus=(request.GET['username'],request.GET['pwd'],request.GET['name'],request.GET['dob'],\
				request.GET['email'],request.GET['phone0'],request.GET['phone1'],request.GET['addr'],request.GET['city'],request.GET['pin'],)
			cursor.execute(sql,argus)
			print('Checkpoint')
			mydb.commit()
			sql='select rid,name from readers where username =%s'
			cursor.execute(sql,(username,))
			result = cursor.fetchall()
			request.session['rid']=result[0][0]
			request.session['uname']=result[0][1]
			print(result[0][0])
			return JsonResponse({'success':True,'rid':result[0][0],'uname':result[0][1]})

	return JsonResponse({'success':False})#Unreachable code

def updateprofile(request):
	try:
		rid=request.GET['rid']
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
		return JsonResponse({'success':True,'userdata':userdata})
	except:
		print("In Except of updateprofile")
		return JsonResponse({'success':False})#Unreachable code
def updateprofiler(request):
	print("Entered updateprofiler")
	try:
		rid=request.GET['rid']
		print('Checkpoint0')
		sql='update readers SET name=%s,username=%s,email=%s,phone0=%s,phone1=%s,addr=%s,city=%s,pin=%s where rid = %s'
		arg=(request.GET['name'],request.GET['username'],request.GET['email'],request.GET['phone0'],request.GET['phone1'],request.GET['addr'],request.GET['city'],request.GET['pin'],rid,)
		print(arg)
		cursor.execute(sql,arg)
		mydb.commit()
		print('Checkpoint')
		return JsonResponse({'success':True})
	except:
		print("In Except of updateprofiler")
	return JsonResponse({'success':False})#Unreachable code

def chpwd(request):
	if(request.method=="GET"):
		sql='update readers SET password=%s where rid = %s'
		arg=(request.GET['pwd'],request.GET['rid'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	return JsonResponse({'success':False})#Unreachable code


def add_author(request):
	if(request.method=="GET"):
		sql='insert into authors (name,dob,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s,%s)'
		arg=(request.GET['name'],request.GET['dob'],\
		request.GET['email'],request.GET['phone0'],request.GET['phone1'],request.GET['addr'],request.GET['city'],request.GET['pin'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	else:
		return JsonResponse({'success':False})#Unreachable code


def add_book(request):
	if(request.method=="GET"):
		sql='insert into books (name,category,publisher,copies_total,copies_assigned) values (%s,%s,%s,%s,0)'
		arg=(request.GET['name'],request.GET['category'],request.GET['publisher'],request.GET['copies_total'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	else:
		return JsonResponse({'success':False})#Unreachable code


def add_publisher(request):
	if(request.method=="GET"):
		sql='insert into publishers (name,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s)'
		arg=(request.GET['name'],request.GET['email'],request.GET['phone0'],request.GET['phone1'],request.GET['addr'],request.GET['city'],request.GET['pin'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	else:	
		return JsonResponse({'success':False})#Unreachable code


def add_section(request):
	if(request.method=="GET"):
		sql='insert into sections (name,room_no,category) values (%s,%s,%s)'
		arg=(request.GET['name'],request.GET['room_no'],request.GET['category'],)
		cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	else:	
		return JsonResponse({'success':False})#Unreachable code


def add_admin(request):
	if(request.method=="GET"):
		if(request.GET['pwd']==request.GET['cpwd']):
			sql='insert into admins (name,username,password,post,salary,dob,email,phone0,phone1,addr,city,pin) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
			arg=(request.GET['name'],request.GET['username'],request.GET['pwd'],request.GET['post'],request.GET['salary'],request.GET['dob'],\
			request.GET['email'],request.GET['phone0'],request.GET['phone1'],request.GET['addr'],request.GET['city'],request.GET['pin'],)
			cursor.execute(sql,arg)
			mydb.commit()
			return JsonResponse({'success':True})
		else:
			return JsonResponse({'success':False,'passmatch':False})
	else:	
		return JsonResponse({'success':False})#Unreachable code


def add_properbooks(request):
	if(request.method=="GET"):
		sql = "INSERT INTO proper_books (bid,edition,publication_year,section) values (%s,%s,%s,%s)"
		arg=(request.GET['bid'],request.GET['edition'],request.GET['publication_year'],request.GET['section'],)
		for i in range(int(request.GET['copies'])):
			cursor.execute(sql,arg)
		mydb.commit()
		return JsonResponse({'success':True})
	else:
		return JsonResponse({'success':False})#Unreachable code








def show_authors(request):
	sql='select * from authors'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})


def show_books(request):
	sql='select * from books'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})


def show_publishers(request):
	sql='select * from publishers'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})


def show_readers(request):
	sql='select * from readers'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})

	
def show_sections(request):
	sql='select * from sections'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})


def show_admins(request):
	sql='select * from admins'
	cursor.execute(sql)
	result = cursor.fetchall()
	return JsonResponse({'success':True,'result':result})









def submitbook(request):
	if(request.method=="GET"):
		sql="update issuedby set return_date=%s , fine=%s where bid=%s and rid=%s"
		cursor.execute(sql,(request.GET['submitdate'],request.GET['fine'],request.GET['bid'],request.GET['rid'],))
		sql="UPDATE proper_books set issued=0 WHERE pbid=%s"
		cursor.execute(sql,(request.GET['bid'],))
		mydb.commit()
		return JsonResponse({'success':True})
	else:
		return JsonResponse({'success':False})#Unreachable code


def issuebook(request):
	if(request.method=="GET"):
		sql="insert into issuedby (bid,rid,assigned_date,issued_by) values (%s,%s,%s,%s)"
		cursor.execute(sql,(request.GET['bid'],request.GET['rid'],request.GET['issuedate'],request.GET['issued_by'],))
		sql="UPDATE proper_books set issued=1 WHERE pbid=%s"
		cursor.execute(sql,(request.GET['bid'],))
		mydb.commit()
		return JsonResponse({'success':True})
	else:
		return JsonResponse({'success':False})#Unreachable code

# def login(request):
# 	if(request.method=="GET"):
# 		username=request.GET['username']
# 		password=request.GET['password']
# 		level=request.GET.get('level')
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