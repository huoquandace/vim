
clean:
	del /s /q *~
	@for /d /r . %%d in (__pycache__) do @if exist "%%d" (rmdir /s /q "%%d")

push:
	git add .
	git commit -m up
	git push

up:
	python project/manage.py makemigrations
	python project/manage.py migrate
	python project/manage.py shell -c "from django.contrib.auth import get_user_model; \
		get_user_model().objects.filter(username='admin').exists() or \
		get_user_model().objects.create_superuser('admin', 'admin@admin.com', 'admin')"
	python project/manage.py runserver 80

dump:
	python project/manage.py dumpdata django.contrib.admin > data.json

loaddata:
	python project/manage.py dumpdata > data.json
