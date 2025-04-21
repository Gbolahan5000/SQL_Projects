
CREATE TABLE tailors (
    tailor_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR,
    phone_number INTEGER,
    email VARCHAR(255)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone_number INTEGER,
    email VARCHAR(255)
);

CREATE TABLE order_types (
    order_type_id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    tailor_id INT,
    order_type_id INT,
    order_date DATE,
    delivery_date DATE,
    payment_recieved BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (tailor_id) REFERENCES tailors (tailor_id),
    FOREIGN KEY (order_type_id) REFERENCES order_types (order_type_id)
);