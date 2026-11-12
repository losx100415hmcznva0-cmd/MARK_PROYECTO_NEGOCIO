#!/usr/bin/env bash
# exit on error

set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate

# Crear superusuario automáticamente si no existe
python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='Mark_XLV').exists() or User.objects.create_superuser('Mark_XLV', 'losx100415hmcznva0@soycecytem.mx', 'SokoviaMark45!')"