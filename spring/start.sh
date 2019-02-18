#!/bin/bash

# check and clone
#
if [ ! -d /home/spring/src/spring-petclinic ]; then
    cd /home/spring/src
    git clone https://github.com/spring-projects/spring-petclinic.git
fi

#config edit
#
SRC_REBUILD=${SRC_REBUILD:-no}
DB_TYPE=${DB_TYPE:-hsqldb}
DB_FIRSTINIT=${DB_FIRSTINIT:-no}
DB_SERVERNAME=${DB_SERVERNAME:-mairia}
DB_BASENAME=${DB_BASENAME:-petclinic}
DB_USERNAME=${DB_USERNAME:-spring}
DB_PASSWORD=${DB_PASSWORD:-qwerty}

sed 's/database=.*/'database="${DB_TYPE}"'/' -i /home/spring/src/spring-petclinic/src/main/resources/application.properties
sed 's|spring\.datasource\.url=.*|'spring\.datasource\.url=jdbc:mysql:\/\/"${DB_SERVERNAME}"\/"${DB_BASENAME}"'|' -i /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
sed 's/spring\.datasource\.username=.*/'spring\.datasource\.username\="${DB_USERNAME}"'/' -i /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
sed 's/spring\.datasource\.password=.*/'spring\.datasource\.password\="${DB_PASSWORD}"'/' -i /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
sed '/spring\.datasource\.initialization-mode=/d' -i /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
sed '/^$/d' -i /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
if [[ $DB_FIRSTINIT = "yes" ]]; then
printf '\nspring.datasource.initialization-mode=always\n' >> /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
fi

if [[ $DB_TYPE = "mysql" ]]; then
printf '\nspring.profiles.active=mysql\n' >> /home/spring/src/spring-petclinic/src/main/resources/application-mysql.properties
fi

# TODO clean ENVs

# fix permissions
chown -R spring:spring /home/spring

cd /home/spring/src/spring-petclinic

if [[ $SRC_REBUILD = "yes" ]]; then
./mvnw package
fi

#exec "$@"
exec gosu spring java -jar target/*.jar spring.profiles.active=mysql
#exec gosu spring ./mvnw spring-boot:run spring.profiles.active=mysql
#java -jar target/*.jar
