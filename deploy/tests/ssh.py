from paramiko import SSHClient, AutoAddPolicy
import sys
from pathlib import Path


def output(stdout):
    for line in stdout:
        print(line.strip("\n"))


key_filename = "../yandex/id_rsa"
entities_ips = ["10.0.1.10", "10.0.2.10"]
domains = ["dev.naliway.space", "dev.nakateam.space"]

client = SSHClient()
client.set_missing_host_key_policy(AutoAddPolicy())
client.connect(sys.argv[1], username="ubuntu", key_filename=key_filename)
file_path = Path(key_filename)
with client.open_sftp() as sftp:
    sftp.put(key_filename, "/home/ubuntu/id_rsa")
_, stdout, stderr = client.exec_command(f"ls -la && pwd && chmod 600 id_rsa")
output(stdout)

for ip in entities_ips:
    _, stdout, stderr = client.exec_command(
        f'ssh -o "StrictHostKeyChecking no" -i id_rsa ubuntu@{ip} ip a && ping -c 1 ya.ru'
    )
    output(stdout)

for domain in domains:
    _, stdout, stderr = client.exec_command(f"ping -c 1 {domain}")
    output(stdout)
