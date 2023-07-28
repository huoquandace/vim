
clean:
	del /s /q *~
	@for /d /r . %%d in (__pycache__) do @if exist "%%d" (rmdir /s /q "%%d")

push:
	git add .
	git commit -m up
	git push
