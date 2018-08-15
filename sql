CREATE TABLE `finacial_products` (
   `product_id` INT(11) NOT NULL AUTO_INCREMENT,
   `name` VARCHAR(32) NOT NULL COMMENT '理财产品名称',
   `price` FLOAT(10,1) NOT NULL COMMENT '理财产品定价',
   `detail` TEXT COMMENT '理财产品描述',
   `pic` VARCHAR(64) DEFAULT NULL COMMENT '理财产品图片',
   `invasttime` DATETIME NOT NULL COMMENT '理财产品收益日期',
   PRIMARY KEY (`product_id`)
   )ENGINE=INNODB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `customer` (
   `cus_id` INT(10) NOT NULL AUTO_INCREMENT,
   `username` VARCHAR(32) NOT NULL COMMENT '用户名称',
   `acno` VARCHAR(32) NOT NULL COMMENT '卡号',
   `gender` VARCHAR(4) NOT NULL COMMENT '性别',
   `phone` VARCHAR(256) DEFAULT NULL COMMENT '电话',
   PRIMARY KEY (`cus_id`)
   ) ENGINE=INNODB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

CREATE TABLE `batch` (
   `batch_id` INT(11) NOT NULL AUTO_INCREMENT,
   `cus_id` INT(11) NOT NULL COMMENT '创建批次用户ID',
   `number` VARCHAR(32) NOT NULL COMMENT '批次编码',
   `createtime` DATETIME NOT NULL COMMENT '创建批次时间',
   `note` VARCHAR(100) DEFAULT NULL COMMENT '备注',
   PRIMARY KEY (`batch_id`),
   KEY `FK_batch_1` (`cus_id`),
   CONSTRAINT `FK_batch_id` FOREIGN KEY (`cus_id`) REFERENCES `customer` 
   (`cus_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
   )ENGINE=INNODB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `batchdetail` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `batch_id` INT(11) NOT NULL COMMENT '批次ID',
  `product_id` INT(11) NOT NULL COMMENT '批次产品ID',
  `product_num` INT(11) DEFAULT NULL COMMENT '理财产品购买数量',
  PRIMARY KEY (`id`),
  KEY `FK_batchdetail_1` (`batch_id`),
  KEY `FK_batchdetail_2` (`product_id`),
  CONSTRAINT `FK_batchdetail_1` FOREIGN KEY (`batch_id`) REFERENCES `batch`
  (`batch_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_batchdetail_2` FOREIGN KEY (`product_id`) REFERENCES `finacial_products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  )ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

SELECT batch.*,customer.username,customer.acno,batchdetail.product_id,batchdetail.product_num,finacial_products.name,finacial_products.detail,finacial_products.price
FROM batch,customer,batchdetail,finacial_products
WHERE batch.cus_id = customer.cus_id AND batchdetail.batch_id = batch.batch_id AND finacial_products.product_id = batchdetail.product_id;