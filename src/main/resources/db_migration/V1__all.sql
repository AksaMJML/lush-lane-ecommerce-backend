-- 1. Roles Table
CREATE TABLE roles (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Insert the 6 mandatory roles from the assignment
INSERT INTO roles (role_name) VALUES
                                  ('CUSTOMER'),
                                  ('ADMIN'),
                                  ('PRODUCT_MANAGER'),
                                  ('PAYMENT_PROCESSOR'),
                                  ('MARKETING_SPECIALIST'),
                                  ('DELIVERY_PERSONNEL');

-- 2. Users Table
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       first_name VARCHAR(100) NOT NULL,
                       last_name VARCHAR(100) NOT NULL,
                       email VARCHAR(150) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       role_id INT,
                       FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 3. Categories Table
CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Products Table
CREATE TABLE products (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          price DECIMAL(10, 2) NOT NULL,
                          stock_quantity INT NOT NULL,
                          category_id INT,
                          FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 5. Cart Table
CREATE TABLE cart (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      user_id INT NOT NULL,
                      status VARCHAR(50) NOT NULL,
                      FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 6. Cart_Items Table
CREATE TABLE cart_items (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            cart_id INT NOT NULL,
                            product_id INT NOT NULL,
                            quantity INT NOT NULL,
                            FOREIGN KEY (cart_id) REFERENCES cart(id),
                            FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 7. Orders Table
CREATE TABLE orders (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT NOT NULL,
                        total_amount DECIMAL(10, 2) NOT NULL,
                        order_status VARCHAR(50) NOT NULL,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 8. Order_Items Table
CREATE TABLE order_items (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             order_id INT NOT NULL,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL,
                             price_at_purchase DECIMAL(10, 2) NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(id),
                             FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 9. Payments Table
CREATE TABLE payments (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          order_id INT NOT NULL,
                          payment_status VARCHAR(50) NOT NULL,
                          transaction_id VARCHAR(100),
                          FOREIGN KEY (order_id) REFERENCES orders(id)
);