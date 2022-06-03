LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/production.csv' 
INTO TABLE `production`
FIELDS TERMINATED BY ';' 
-- ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;