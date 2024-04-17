#!bin/bash
release="releases.txt"
if test -f "$release"; then
    echo "---- GETTING ODOO and PGADMIN URL ----"
    export ODOO_URL=$(awk 'NR==1 {print $2}' $release )
    export PGADMIN_URL=$(awk 'NR==2 {print $2}' $release )
    export version=$(awk 'NR==3 {print $2}' $release )
else
  echo "Using Default URL"
fi
exec "$@"



