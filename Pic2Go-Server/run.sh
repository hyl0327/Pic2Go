cd ..
gunicorn -w 4 -b 0.0.0.0:8787 --chdir Pic2Go-Server Pic2Go-Server.pic2go:app
