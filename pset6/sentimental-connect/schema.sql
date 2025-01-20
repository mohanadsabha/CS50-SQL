CREATE TABLE `users` (
`id` INT UNSIGNED AUTO_INCREMENT,
`first_name` VARCHAR(32) NOT NULL,
`last_name` VARCHAR(32),
`username` VARCHAR(32) NOT NULL UNIQUE,
`password` VARCHAR(128) NOT NULL,
PRIMARY KEY(`id`)
);

CREATE TABLE `schools` (
`id` INT UNSIGNED AUTO_INCREMENT,
`name` VARCHAR(255) NOT NULL,
`type` ENUM('Primary', 'Secondry', 'Higher Education') NOT NULL,
`location` VARCHAR(32),
`foundation_year` YEAR,
PRIMARY KEY(`id`)
);

CREATE TABLE `companies` (
`id` INT UNSIGNED AUTO_INCREMENT,
`name` VARCHAR(32) NOT NULL,
`industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
`location` VARCHAR(255),
PRIMARY KEY(`id`)
);

CREATE TABLE `people_connections` (
`user_id` INT UNSIGNED,
`conn_user_id` INT UNSIGNED,
PRIMARY KEY(`user_id`, `conn_user_id`),
FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
FOREIGN KEY(`conn_user_id`) REFERENCES `users`(`id`)
);

CREATE TABLE `school_connections` (
`user_id` INT UNSIGNED,
`school_id` INT UNSIGNED,
`start_date` DATE NOT NULL,
`end_date` DATE,
`degree_type` VARCHAR(32) NOT NULL,
PRIMARY KEY(`user_id`, `school_id`),
FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
FOREIGN KEY(`school_id`) REFERENCES `schools`(`id`)
);

CREATE TABLE `company_connections` (
`user_id` INT UNSIGNED,
`company_id` INT UNSIGNED,
`start_date` DATE NOT NULL,
`end_date` DATE,
`title` VARCHAR(32) NOT NULL,
PRIMARY KEY(`user_id`, `company_id`),
FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);
