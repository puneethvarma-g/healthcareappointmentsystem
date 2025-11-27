INSERT INTO users (id, username, password, email) VALUES
(1, 'john_doe', 'password123', 'john@example.com'),
(2, 'jane_smith', 'password456', 'jane@example.com');

INSERT INTO appointments (id, user_id, appointment_date, description) VALUES
(1, 1, '2023-10-01 10:00:00', 'Dental checkup'),
(2, 1, '2023-10-05 14:00:00', 'Annual physical exam'),
(3, 2, '2023-10-10 09:30:00', 'Eye examination');