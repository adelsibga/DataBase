USE `medicines`;

-- 1. Добавить внешние ключи ----------------------
-- Таблица `dealer` 
ALTER TABLE `medicines`.`dealer` 
ADD CONSTRAINT `id_company`
  FOREIGN KEY (`id_company`)
  REFERENCES `medicines`.`company` (`id_company`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
 -- Таблица `order`
ALTER TABLE `medicines`.`order` 
ADD CONSTRAINT `id_production`
  FOREIGN KEY (`id_production`)
  REFERENCES `medicines`.`production` (`id_production`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_dealer`
  FOREIGN KEY (`id_dealer`)
  REFERENCES `medicines`.`dealer` (`id_dealer`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `id_pharmacy`
  FOREIGN KEY (`id_pharmacy`)
  REFERENCES `medicines`.`pharmacy` (`id_pharmacy`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
  -- Таблица `production` 
ALTER TABLE `medicines`.`production` 
ADD CONSTRAINT `id_medicine`
  FOREIGN KEY (`id_medicine`)
  REFERENCES `medicines`.`medicine` (`id_medicine`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION; 

-- 2.Выдать информацию по всем заказам лекарства “Кордеон” компании “Аргус” 
-- с указанием названий аптек, дат, объема заказов
SELECT 
	`order`.`date`, `order`.`quantity`, `pharmacy`.`name`
FROM `pharmacy` JOIN `order` ON `pharmacy`.`id_pharmacy` = `order`.`id_pharmacy`
JOIN `production` ON `production`.`id_production` = `order`.`id_production`
JOIN `company` ON `production`.`id_company` = `company`.`id_company`
JOIN `medicine` ON `medicine`.`id_medicine` = `production`.`id_medicine`
WHERE `medicine`.`name` = 'Кордеон' AND `company`.`name` = 'Аргус';

-- 3.Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января
SELECT
    `company`.`name`, `medicine`.`name`, `order`.`date`
FROM `production` JOIN `order` ON `order`.`id_production` = `production`.`id_production`
JOIN `company` ON `production`.`id_company` = `company`.`id_company`
JOIN `medicine` ON `production`.`id_medicine` = `medicine`.`id_medicine`
WHERE `production`.`id_production` NOT IN (
	SELECT
		`id_production`
	FROM `order`
	WHERE `date` < '2019-01-25'
) AND `company`.`name` = 'Фарма'
GROUP BY `medicine`.`name`;

-- 4.Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов
SELECT 
	`company`.`name`, MIN(production.rating), MAX(production.rating)
FROM `order` JOIN `production` ON `production`.`id_production` = `order`.`id_production`
JOIN `company` ON `production`.`id_company` = `company`.`id_company`
GROUP BY `company`.`id_company`, `company`.`name`
HAVING COUNT(*) >= 120;

-- 5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. 
-- Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT  `dealer`.`name`, `pharmacy`.`name`
FROM `dealer`
LEFT JOIN `order` ON `order`.`id_dealer` = `dealer`.`id_dealer`
LEFT JOIN `pharmacy` ON `pharmacy`.`id_pharmacy` = `order`.`id_pharmacy`
LEFT JOIN `company` ON `dealer`.`id_company` = `company`.`id_company`
WHERE `company`.`name` = 'AstraZeneca'
GROUP BY `dealer`.`name`, `pharmacy`.`name`;

-- 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней
SELECT 
	`medicine`.`name`, `medicine`.`cure_duration`, `production`.`price`
FROM `medicine` JOIN `production` ON `medicine`.`id_medicine` = `production`.`id_medicine`
WHERE `production`.`price` > 3000 AND `medicine`.`cure_duration` <= 7;

UPDATE `production`
JOIN `medicine` ON `medicine`.`id_medicine` = `production`.`id_medicine`
SET `production`.`price` = `production`.`price` * 0.8
WHERE `production`.`price` > 3000 AND `medicine`.`cure_duration` <= 7;

UPDATE `production`
JOIN `medicine` ON `medicine`.`id_medicine` = `production`.`id_medicine`
SET `production`.`price` = `production`.`price` / 0.8
WHERE `production`.`price` > 3000 AND `medicine`.`cure_duration` <= 7;

-- 7. Добавить необходимые индексы.
CREATE INDEX `IX_medicine_name` 
	ON `medicine` (`name`);

CREATE INDEX `IX_company_name` 
	ON `company` (`name`);   
    
CREATE INDEX `IX_order_date` 
	ON `order` (`date`);
 
 CREATE INDEX `IX_production_price` 
	ON `production` (`price`);  

 CREATE INDEX `IX_medicine_cure_duration` 
	ON `medicine` (`cure_duration`);  