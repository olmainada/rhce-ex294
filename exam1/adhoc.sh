

#!/bin/bash

ansible localhost -m user -a "name=ansible generate_ssh_key=yes groups=wheel append=yes" -u root
ansible localhost -m file -a "path=/ansible_key state=directory" -u root
ansible localhost -m shell -a " cat /home/ansible/.ssh/id_rsa.pub > /ansible_key/id_rsa.pub" -u root
ansible all -m user -a " name=ansible " -u root
ansible all -m authorized_key  -a " user=ansible key={{ lookup('file', '/ansible_key/id_rsa.pub')}}" -u root
ansible all -m copy -a " content='ansible ALL=(ALL) NOPASSWD:ALL' dest=/etc/sudoers.d/ansible" -u root
