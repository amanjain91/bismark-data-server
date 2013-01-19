from django.conf.urls.defaults import *

urlpatterns = patterns('',
    (r'^upload/', 'bismark.views.upload'),
)
