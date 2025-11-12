CREATE TABLE Users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    userName VARCHAR(100) NOT NULL UNIQUE,
    fullName VARCHAR(150),
    passWord VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    roleid INT NOT NULL,
    phone VARCHAR(20),
    createdDate DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO Users (email, userName, fullName, passWord, avatar, roleid, phone)
VALUES ('user@example.com', 'user1', 'Normal User', '123456', '', 2, '0987654321');
