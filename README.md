# Oscar-Ceremony
Database System to handle all winners from 1975-2025. Also implemented connectivity using Java 

#### FILES IN THE ZIP FOLDER

```
create_tables   SQL  file to create tables
loading_Sample   SQL  file to load values into the tables
Procedures   SQL  file to load the procedures into the database
Triggers   SQL file to load the triggers into the database
Views   SQL file to load the Views into the database
Indexes   SQL file to load the indexes into the database
CreateDB   SQL file which executes all of the above
Queries   SQL file to load the queries ACat, ApartOf, Awards, Presents, Ceremony, Film, Person, Nom
```
```
CSV CSV files that should be loaded
into the secure folder
load_csv SH Script to automatically load the
csv files to the secure folder.
mysql-connector-j-8.1.0 FOLDER This folder is used to run the java
connectivity system
DBMenu JAVA Main java file where the menu is
run from
DBUpdate JAVA Java file responsible for updating
values in the database
DBQuery JAVA Java file responsible for displaying
the queries
DBInsert JAVA Java file responsible for inserting
data into the database
DBDelete JAVA Java file responsible for deleting
data from the database
DBFind JAVA Java file responsible for finding
information of a person in the
database.
```

```
PAGE 1
```
### INSTALLING MYSQL (IF NOT CONFIGURED)

```
 First run
o sudo apt update
 Then install the mysql-server package
o sudo apt install mysql-server
 Ensure that the server is running using
o sudo systemctl start mysql.service
```
### CREATING A DEDICATED USER (IF NOT CONFIGURED)

```
 First run
o sudo mysql
 Then add your user using this command, replace ‘user’ and ‘password’ with the actual username and password.
o CREATE USER ‘user’@’localhost’ IDENTIFIED BY ‘password’;
 Give the user all the needed permissions to databases
o GRANT ALL PRIVILEGES ON *.* TO ‘user’@’localhost’ WITH GRANT OPTION;
 Finally, free up any memory using
o FLUSH PRIVILEGES;
 Now u can exit and login back again with the new user and password using
o Mysql -u user -p
o And enter the password.
```
### STEPS FOR CREATING THE DATABASE

```
 Firstly, extract the files from the zip folder
 Next, open the terminal from the extracted folder
 Run the command below in the regular terminal to load all the csv files to the secure folder
o ./load_csv.sh
 Login to mysql server with a dedicated user (not root)
 Run the command below
o Source CreateDB.sql
 This file will run all the SQL files.
```

```
PAGE 2
```
##### CreateDB.sql


```
PAGE 3
```
### HOW TO RUN THE QUERIES

```
 To run the queries being implemented we simply run the below command in mysql
o Source Queries.sql
```
### HOW TO INSTALL JAVA (IF NOT CONFIGURED)

```
 First run the following command
o sudo apt install openjdk-21-jdk-headless
```
### HOW TO USE JAVA FOR CONNECTIVITY

```
 Open terminal in the extracted folder
 Compile the code with this command
o javac -cp .:mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar DBMenu.java;
 We can run the code with the following command
o java -cp .:mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar DBMenu.java;
 Enter the username and password for your mysql server user
```
