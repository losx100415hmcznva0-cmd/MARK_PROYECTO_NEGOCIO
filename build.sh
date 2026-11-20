#!/usr/bin/env bash
set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate --no-input
python manage.py shell -c "
import os
from django.contrib.auth import get_user_model
U = get_user_model()
u, _ = U.objects.get_or_create(username=os.environ['DJANGO_SUPERUSER_USERNAME'])
u.email = os.environ.get('DJANGO_SUPERUSER_EMAIL', '')
u.is_staff = u.is_superuser = True
u.set_password(os.environ['DJANGO_SUPERUSER_PASSWORD'])
u.save()
print('SUPERUSUARIO LISTO:', repr(u.username), u.is_superuser, 'total usuarios:', U.objects.count())
"