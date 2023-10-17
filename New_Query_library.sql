-- Active: 1697468983688@@127.0.0.1@3306@le_library
--@block

CREATE DATABASE le_database;
USE le_database;
CREATE TABLE user_info (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

SHOW DATABASES;
INSERT INTO user_info (username, password)
VALUES
('user1', 'password1'),
('user2', 'password2'),
('user3', 'password3');

-- 后端验证用户身份
DELIMITER $$
CREATE PROCEDURE AuthenticateUser(IN in_username VARCHAR(255), IN in_password VARCHAR(255), OUT out_user_id INT)
BEGIN
    DECLARE user_id INT;
    
    -- 使用哈希密码进行验证
    SELECT user_id INTO user_id
    FROM user_info
    WHERE username = in_username AND password = SHA2(in_password, 256);
    
    IF user_id IS NOT NULL THEN
        SET out_user_id = user_id;
    ELSE
        SET out_user_id = -1; -- 验证失败，返回-1或其他标识
    END IF;
END;
$$
DELIMITER ;
