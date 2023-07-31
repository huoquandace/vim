
clean:
	del /s /q *~
	@for /d /r . %%d in (__pycache__) do @if exist "%%d" (rmdir /s /q "%%d")

push:
	git add .
	git commit -m up
	git push

all:
	python project/manage.py makemigrations
	python project/manage.py migrate
	python project/manage.py shell -c "from django.contrib.auth import get_user_model; \
		get_user_model().objects.filter(username='admin').exists() or \
		get_user_model().objects.create_superuser('admin', 'admin@admin.com', 'admin')"
	python project/manage.py runserver 80
up:
	python project/manage.py makemigrations
	python project/manage.py migrate
	python project/manage.py runserver 80
dumpdata:
	python project/manage.py dumpdata > project/data.json

loaddata:
	python project/manage.py loaddata project/data.json
