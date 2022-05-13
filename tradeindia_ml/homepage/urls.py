from django.urls import path, include
from . import views

urlpatterns = [
        path('<str:language>/', views.homepage, name = 'homepage'),
        path('', views.homepage, name = 'homepage'),
]
