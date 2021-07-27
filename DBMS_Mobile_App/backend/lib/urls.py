from django.urls import path

from . import views
app_name='lib'
urlpatterns = [

    path('userlogin/', views.userlogin, name='userlogin'),
    path('adminlogin/', views.adminlogin, name='adminlogin'),

    path('submitbook/',views.submitbook, name='submitbook'),
    path('issuebook/',views.issuebook, name='issuebook'),

    path('searchbooks/', views.searchbooks, name='searchbooks'),
    path('signup/', views.signup, name='signup'),

    path('updateprofile/', views.updateprofile, name='updateprofile'),
    path('updateprofiler/', views.updateprofiler, name='updateprofiler'),
    path('chpwd/', views.chpwd, name='chpwd'),

    path('add_author/', views.add_author, name='add_author'),
    path('add_book/', views.add_book, name='add_book'),
    path('add_publisher/', views.add_publisher, name='add_publisher'),
    path('add_section/', views.add_section, name='add_section'),
    path('add_admin/', views.add_admin, name='add_admin'),
    path('add_properbooks/', views.add_properbooks, name='add_properbooks'),

    path('show_authors/', views.show_authors, name='show_authors'),
    path('show_books/', views.show_books, name='show_books'),
    path('show_publishers/', views.show_publishers, name='show_publishers'),
    path('show_readers/', views.show_readers, name='show_readers'),
    path('show_sections/', views.show_sections, name='show_sections'),
    path('show_admins/', views.show_admins, name='show_admins'),

    path('submitbook/', views.submitbook, name='submitbook'),
    path('issuebook/', views.issuebook, name='issuebook'),


]