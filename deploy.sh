#!/bin/bash
filename="keys/id_rsa"
command=${1:-apply}
cd deploy
if [ $command == "apply" ];
then
    mkdir ./keys
    echo "generate $filename and $filename.rsa keys"
    ssh-keygen -t rsa -f ./$filename -b 4096 -q -P ""
    ansible-playbook --version
    terraform  init
    terraform plan  -var-file config.tfvars.json
fi

terraform $command -auto-approve -var-file config.tfvars.json

if [ $? -eq 0 ] && [ $command == "apply" ];
then
    ansible_path="ansible"
    ansible-playbook -i $ansible_path/inventory $ansible_path/playbook.yml
fi
