Pic2Go-Server
===============

Server for Pic2Go, written in `python3` with `Flask`.


## Usage (For Development ONLY)

1. (Preferably in a Virtualenv) `pip install -r requirements.txt`
2. `env FLASK_APP=pic2go.py FLASK_ENVIRONMENT=development flask run`
3. `curl -F 'pic=@test.jpg' 'http://127.0.0.1:5000/'`
