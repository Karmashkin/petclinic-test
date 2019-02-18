#!/bin/bash

if [ ! -d /home/spring/src/spring-petclinic ]; then
    cd /home/spring/src
    git clone https://github.com/spring-projects/spring-petclinic.git
    cd spring-petclinic
    ./mvnw package
fi


DB_TYPE=${DB_TYPE:-hsqldb}
DB_FIRSTINIT=${DB_FIRSTINIT:-no}
DB_SERVERNAME=${DB_SERVERNAME:-mairia}
DB_BASENAME=${DB_BASENAME:-petclinic}
DB_USERNAME=${DB_USERNAME:-spring}
DB_PASSWORD=${DB_PASSWORD:-qwerty}

sed 's/database=.*/'database="${DB_TYPE}"'/' -i /home/spring/src/spring-petclinic/target/classes/application.properties
sed 's|spring\.datasource\.url=.*|'spring\.datasource\.url=jdbc:mysql:\/\/"${DB_SERVERNAME}"\/"${DB_BASENAME}"'|' -i /home/spring/src/spring-petclinic/target/classes/application-mysql.properties
sed 's/spring\.datasource\.username=.*/'spring\.datasource\.username\="${DB_USERNAME}"'/' -i /home/spring/src/spring-petclinic/target/classes/application-mysql.properties
sed 's/spring\.datasource\.password=.*/'spring\.datasource\.password\="${DB_PASSWORD}"'/' -i /home/spring/src/spring-petclinic/target/classes/application-mysql.properties
sed '/spring\.datasource\.initialization-mode=/d' -i /home/spring/src/spring-petclinic/target/classes/application-mysql.properties

sed '/^$/d' -i /home/spring/src/spring-petclinic/target/classes/application-mysql.properties
if [[ $DB_FIRSTINIT = "yes" ]]; then
printf 'spring.datasource.initialization-mode=always\n' >> /home/spring/src/spring-petclinic/target/classes/application-mysql.properties
fi

chown -R spring:spring /home/spring

cd /home/spring/src/spring-petclinic
#./mvnw package

#exec "$@"
#exec gosu spring java -jar -Dspring.profiles.active=mysql target/*.jar
exec java -jar -Dspring.profiles.active=mysql target/*.jar
