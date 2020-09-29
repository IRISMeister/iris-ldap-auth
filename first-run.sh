docker-compose up -d iris
docker-compose exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 30"
rm -f ./iris.log
docker-compose exec -T iris iris session iris -U %SYS < OS/bootstrap.os > iris.log
docker-compose up -d ldap-admin

# a little pause
sleep 2
# LDAP Entries
docker-compose exec ldap-server ldapadd -Y EXTERNAL -Q -H ldapi:/// -f /ldap_files/memberof.ldif
docker-compose exec ldap-server ldapadd -Y EXTERNAL -Q -H ldapi:/// -f /ldap_files/groups-and-users.ldif
