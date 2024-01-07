

host="mysqldb.cyjfj58cggo4.us-east-1.rds.amazonaws.com"
username="admin"
password="admin123"
database="mydatabase"
table="table01"
# Install required packages
sudo apt update
sudo apt install -y apache2 php libapache2-mod-php php-mysql
# To connect to the database
$ mysql -h mysqldb.cyjfj58cggo4.us-east-1.rds.amazonaws.com -P 3306 -u admin -p
admin123

# Creating DB
mysql> CREATE DATABASE mydatabase;
Query OK, 1 row affected (0.00 sec)
# List DB
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mydatabase         |
| mysql              |
| mysqlDB            |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)

# Pointing the desired DB to use
mysql> USE mydatabase;
Database changed
# Creating Table using the desired Schema
mysql> Create table table01 (id INT PRIMARY KEY, name VARCHAR(50), age INT);
Query OK, 0 rows affected (0.04 sec)
# Result
mysql> SHOW TABLES;
+----------------------+
| Tables_in_mydatabase |
+----------------------+
| table01              |
+----------------------+
1 row in set (0.00 sec)
# Interesting 1st Data into table just created
mysql> INSERT INTO table01(id,name,age) VALUES (01,'Ross',35);
Query OK, 1 row affected (0.00 sec)
# Interesting 2nd Data into table just created
mysql> INSERT INTO table01(id,name,age) VALUES (02,'Chandler',32);
Query OK, 1 row affected (0.00 sec)
# Interesting 3rd Data into table just created
mysql> INSERT INTO table01(id,name,age) VALUES (03,'Rachel',32);
Query OK, 1 row affected (0.01 sec)
# Interesting 4th Data into table just created
mysql> INSERT INTO table01(id,name,age) VALUES (04,'Phebe',30);
Query OK, 1 row affected (0.00 sec)
# Interesting 5th Data into table just created
mysql> INSERT INTO table01(id,name,age) VALUES (05,'Joe',30);
Query OK, 1 row affected (0.00 sec)


# Final Result
mysql> SELECT * FROM table01; +----+----------+------+ |id|name |age | +----+----------+------+ |1|Ross |35|
| 2 | Chandler | 32 |
| 3|Rachel |4|Phebe
|5|Joe +----+----------+------+ 5 rows in set (0.00 sec)


sudo tee /var/www/html/index.php >/dev/null <<EOF
<?php
\$conn = new mysqli("$host", "$username", "$password", "$database");
if (\$conn->connect_error) {
   die("Connection failed: " . \$conn->connect_error);
}
\$sql = "SELECT * FROM $table";
\$result = \$conn->query(\$sql);
if (\$result->num_rows > 0) {
   echo "<table><tr><th>ID</th><th>Name</th></tr>";
   while(\$row = \$result->fetch_assoc()) {
       echo "<tr><td>" . \$row["id"] . "</td><td>" . \$row["name"] . "</td></tr>";
   }
   echo "</table>";
} else {
   echo "0 results";
}
\$conn->close();
?>
EOF
# Configure Apache to serve PHP files
sudo sed -i "s/index.html/index.php/g" /etc/apache2/mods-enabled/dir.conf
# Restart Apache
sudo systemctl restart apache2
# Display public IP
echo "Web application is now accessible at: http://$(curl -s
http://checkip.amazonaws.com)/"