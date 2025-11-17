CREATE TABLE Category (
    cate_id INT AUTO_INCREMENT PRIMARY KEY,
    cate_name VARCHAR(255) NOT NULL,
    icons VARCHAR(255) NULL
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    sale_price DECIMAL(10,2),
    quantity INT NOT NULL DEFAULT 0,
    image VARCHAR(255),
    cate_id INT NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_products_category 
        FOREIGN KEY (cate_id) REFERENCES category(cate_id)
);
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `userName` varchar(100) NOT NULL,
  `fullName` varchar(150) DEFAULT NULL,
  `passWord` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `roleid` int NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `userName` (`userName`)
) 
CREATE TABLE tokens (
    idtoken INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    expiryTime DATETIME NOT NULL,
    used BOOLEAN DEFAULT FALSE,
     FOREIGN KEY (email) REFERENCES users(email)
);