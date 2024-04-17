#!bin/bash
echo "Testing Webapp ...\n\n"
curl -i http://172.17.0.1:8080| grep -i "Odoo"
sleep 3

echo "Testing odoo ...\n\n"
curl -i http://172.17.0.1:8069| grep 200 # odoo
sleep 3

echo "Testing postgres ...\n\n"
curl -i http://172.17.0.1:5432| grep 200 # postgresql
sleep 3

echo "Testing pgadmin ...\n\n"
curl -i http://172.17.0.1:8081| grep 200 # pgadmin
sleep 3