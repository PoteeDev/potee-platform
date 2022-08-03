
import json
import os
from random import randint
from potee import ServiceBase
import fcntl

class FakeDB:
    def __init__(self) -> None:
        self.filename = "data.json"
        self.data = dict()
        self.create_file()

    def create_file(self):
        if not os.path.exists(self.filename):
            with open(self.filename, "a") as g:
                fcntl.flock(g, fcntl.LOCK_EX)
                g.write(json.dumps({}))
                fcntl.flock(g, fcntl.LOCK_UN)

    def add(self, value):
        with open(self.filename, "r") as g:
            data = json.loads(g.read())

        with open(self.filename, "w") as g:
            fcntl.flock(g, fcntl.LOCK_EX)
            _id = randint(1, 10000)
            data[_id] = value
            g.write(json.dumps(data))
            fcntl.flock(g, fcntl.LOCK_UN)
        return _id
        
    def get(self, _id):
        with open(self.filename, "r") as g:
            data = json.loads(g.read())
            return data.get(id)
        

srv = ServiceBase()
db = FakeDB()

@srv.ping
def comment(host):
    return "pong"

@srv.get("auth")
def get_auth(host, _id):
    return db.get(_id)

@srv.put("auth")
def put_auth(host, flag):
    return db.add(flag)

@srv.get("comment")
def get_comment(host, _id):
    return db.get(_id)

@srv.put("comment")
def put_comment(host, flag):
    return db.add(flag)

@srv.exploit("rce")
def put_comment(host):
    return 1

@srv.exploit("sql")
def put_comment(host):
    return 1

if __name__ == "__main__":
    srv.run()
