
import json
import os
from random import randint
from potee import ServiceBase
import fcntl
class FakeDB:
    def __init__(self, name, srv) -> None:
        self.filename = f"{name}_{srv}_data.json"
        self.data = dict()
        self.get_data()

    def get_data(self):
        if not os.path.exists(self.filename):
            self.data = {}
        else:         
            with open(self.filename, "r") as g:
                self.data = json.loads(g.read())

    def add(self, value):

        with open(self.filename, "w") as g:
            fcntl.flock(g, fcntl.LOCK_EX)
            _id = randint(1, 10000)
            self.data[_id] = value
            g.write(json.dumps(self.data))
            fcntl.flock(g, fcntl.LOCK_UN)
        return _id
        
    def get(self, _id):
        with open(self.filename, "r") as g:
            data = json.loads(g.read())
            return data.get(_id)
        

srv = ServiceBase()


@srv.ping
def comment(host):
    return "pong"

@srv.get("auth")
def get_auth(host, _id):
    db = FakeDB(host, "auth")
    return db.get(_id)

@srv.put("auth")
def put_auth(host, flag):
    db = FakeDB(host, "auth")
    return db.add(flag)

@srv.get("comment")
def get_comment(host, _id):
    db = FakeDB(host, "comment")
    return db.get(_id)

@srv.put("comment")
def put_comment(host, flag):
    db = FakeDB(host, "comment")
    return db.add(flag)

@srv.exploit("rce")
def put_comment(host):
    return 1

@srv.exploit("sql")
def put_comment(host):
    return 1

if __name__ == "__main__":
    srv.run()
