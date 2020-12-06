#!/usr/bin/env python3

from flask import Flask,request,render_template
from flask_api import status


app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello World from %s" % request.remote_addr


@app.route("/status")
def status():
    with app.test_client() as client:
        response = client.get('/')
        if response.status_code == 200:
            status = 'Healthy'
        else:
            status = 'Unhealthy'
        return "Application Status %s" % status


@app.errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404


if __name__ == "__main__":
	app.run()
