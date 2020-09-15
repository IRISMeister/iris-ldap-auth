docker-compose up -d iris
docker-compose exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 20"
docker-compose exec -T iris iris session iris -U %SYS < OS/init.os
docker-compose up -d ldap-admin

# LDAP Entries
docker-compose exec ldap-server ldapadd -Y EXTERNAL -Q -H ldapi:/// -f /ldap_files/memberof.ldif
docker-compose exec ldap-server ldapadd -Y EXTERNAL -Q -H ldapi:/// -f /ldap_files/groups-and-users.ldif
