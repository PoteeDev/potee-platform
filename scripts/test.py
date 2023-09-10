from potee.main import Checker

from aiohttp import ClientSession

c = Checker()


@c.ping(method="http")
async def test(s: ClientSession, url: str):
    r = await s.get(f"http://{url}:5000/ping", timeout=1)
    return await r.text()


@c.put("example", method="http")
async def put_auth(s, url, flag):
    r = await s.post(f"http://{url}:5000/put", data={"flag": flag}, timeout=1)
    return await r.text()


@c.get("example", method="http")
async def get_auth(s, url, value):
    r = await s.get(f"http://{url}:5000/get/{value}")
    return await r.text()


@c.exploit("sql", method="http")
async def test(s: ClientSession, url: str):
    r = await s.get(f"http://{url}:5000/exploit")
    answer = await r.text()
    if answer == "yes":
        return "yes"
    return "no"


@c.exploit("rce", method="http")
async def test(s: ClientSession, url: str):
    r = await s.get(f"http://{url}:5000/exploit")
    answer = await r.text()
    if answer == "yes":
        return "yes"
    return "no"


if __name__ == "__main__":
    c.run()
