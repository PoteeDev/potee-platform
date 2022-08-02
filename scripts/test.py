import json
from random import randint
import time
import sys
import os

time.sleep(1)


filename = "storage.local"


def save():
    with open(filename, "w") as f:
        f.write(json.dumps(fake_storage, indent=2))


def load():
    if os.path.exists(filename):
        with open(filename) as f:
            return json.loads(f.read())
    else:
        return dict()


fake_storage = load()


def main():
    global fake_storage
    if sys.argv[1] == "ping":
        return randint(1, 1)
    elif sys.argv[1] == "put":
        if sys.argv[2] == "comment":
            key = randint(0, 100000)
            fake_storage[key] = sys.argv[4]
            return key
        if sys.argv[2] == "auth":
            key = randint(0, 100000)
            fake_storage[key] = sys.argv[4]
            return key
    elif sys.argv[1] == "get":
        if sys.argv[2] == "comment":
            return fake_storage.get(sys.argv[4])
        if sys.argv[2] == "auth":
            return fake_storage.get(sys.argv[4])
    elif sys.argv[1] == "exploit":
        if sys.argv[2] == "sql":
            return randint(0, 1)
        elif sys.argv[2] == "rce":
            return randint(0, 1)


if __name__ == "__main__":
    result = main()
    save()
    print(result, end="")
