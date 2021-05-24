from django.urls import include, path
from django.contrib import admin
from django.conf.urls.static import static
from django.conf import settings

# Setup automatic URL routing
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
                  path('admin/', admin.site.urls),
                  path('api/user/', include('user.urls')),
              ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
