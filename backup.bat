ECHO OFF
ECHO Backup Lotus Marketing Data v1.01

::Clear the backup.txt file
type NUL > "C:\Users\Etienne\Desktop\Lotus Backup Tool\backup.txt"

ECHO 1. Inetpub
ROBOCOPY "C:\inetpub\wwwroot" "D:\Google Drive Backup\wwwroot" /mir /nfl /ndl /log+:"C:\Users\Etienne\Desktop\Lotus Backup Tool\backup.txt"

ECHO 2. Lotus Marketing
ROBOCOPY "C:\Lotus Marketing" "D:\Google Drive Backup\Lotus Marketing" /mir /nfl /ndl /log+:"C:\Users\Etienne\Desktop\Lotus Backup Tool\backup.txt"

ECHO 3. MySQLs

::On creer le fichier avec toute les DB
"C:\Program Files\MySQL\MySQL Server 5.6\bin\mysql.exe" -u root -pPASSWORD -e "show databases" > "D:\Google Drive Backup\MySQL Data\dblist.txt"

::Puis on loop sur chaque base de donnee individuellement pour le backup
for /F "usebackq tokens=*" %%A in ("D:\Google Drive Backup\MySQL Data\dblist.txt") do (
  ECHO Backup Up: %%A....
  "C:\Program Files\MySQL\MySQL Server 5.6\bin\mysqldump.exe" -u root -pPASSWORD %%A > "D:\Google Drive Backup\MySQL Data\%%A.sql"
)

#ECHO 4. Mes Photos
#ROBOCOPY "C:\Users\Etienne\Pictures" "D:\Google Drive Backup\Pictures" /mir /nfl /ndl /log+:"C:\Users\Etienne\Desktop\Lotus Backup Tool\backup.txt"

ECHO 5. Mes Videos
ROBOCOPY "C:\Users\Etienne\Videos" "D:\Google Drive Backup\Videos" /mir /nfl /ndl /log+:"C:\Users\Etienne\Desktop\Lotus Backup Tool\backup.txt"

ECHO Backup Complete
