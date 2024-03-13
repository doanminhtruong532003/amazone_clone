create table categories
(
    categories_id int auto_increment
        primary key,
    name          varchar(255)                       not null,
    description   varchar(255)                       null,
    avatar        varchar(255)                       null,
    status        int                                not null,
    hot           int                                not null,
    created_at    datetime default CURRENT_TIMESTAMP null,
    update_at     datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
);

create table keywords
(
    keywords_id int auto_increment
        primary key,
    name        varchar(255)                       not null,
    description varchar(255)                       null,
    status      int                                not null,
    hot         int                                not null,
    created_at  datetime default CURRENT_TIMESTAMP null,
    update_at   datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
);

create table products
(
    products_id   int auto_increment
        primary key,
    name          varchar(255)                       not null,
    description   varchar(255)                       null,
    content       text                               null,
    avatar        varchar(255)                       null,
    status        int                                not null,
    number        int                                not null,
    categories_id int                                null,
    hot           int                                not null,
    price         int                                not null,
    sale          int                                not null,
    total_pay     int                                not null,
    total_rating  int                                not null,
    total_stars   int                                not null,
    created_at    datetime default CURRENT_TIMESTAMP null,
    update_at     datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint products_ibfk_1
        foreign key (categories_id) references categories (categories_id)
);

create index categories_id
    on products (categories_id);

create table products_images
(
    products_id int                                null,
    name        varchar(255)                       not null,
    path        varchar(255)                       not null,
    created_at  datetime default CURRENT_TIMESTAMP null,
    update_at   datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint products_images_ibfk_1
        foreign key (products_id) references products (products_id)
);

create index products_id
    on products_images (products_id);

create table products_keywords
(
    products_id int not null,
    keywords_id int not null,
    primary key (products_id, keywords_id),
    constraint products_keywords_ibfk_1
        foreign key (products_id) references products (products_id),
    constraint products_keywords_ibfk_2
        foreign key (keywords_id) references keywords (keywords_id)
);

create index keywords_id
    on products_keywords (keywords_id);

create table slides
(
    slides_id  int auto_increment
        primary key,
    name       varchar(255)                       not null,
    avatar     varchar(255)                       not null,
    link       varchar(255)                       not null,
    status     int                                not null,
    created_at datetime default CURRENT_TIMESTAMP null,
    update_at  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
);

create table user_type
(
    user_type_id int auto_increment
        primary key,
    name         varchar(255)                       not null,
    description  varchar(255)                       null,
    created_at   datetime default CURRENT_TIMESTAMP null,
    update_at    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
);

create table users
(
    users_id   int auto_increment
        primary key,
    name       varchar(255)                       not null,
    email      varchar(255)                       not null,
    password   varchar(255)                       not null,
    phone      varchar(255)                       null,
    gender     varchar(50)                        null,
    address    varchar(255)                       null,
    avatar     varchar(255)                       null,
    status     int                                not null,
    created_at datetime default CURRENT_TIMESTAMP null,
    update_at  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint email
        unique (email)
);

create table comments
(
    comments_id int auto_increment
        primary key,
    content     text                               null,
    products_id int                                null,
    users_id    int                                null,
    created_at  datetime default CURRENT_TIMESTAMP null,
    update_at   datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint comments_ibfk_1
        foreign key (products_id) references products (products_id),
    constraint comments_ibfk_2
        foreign key (users_id) references users (users_id)
);

create index products_id
    on comments (products_id);

create index users_id
    on comments (users_id);

create table orders
(
    orders_id              int auto_increment
        primary key,
    price                  int                                not null,
    users_id               int                                null,
    total_quantity         int                                not null,
    order_status_payment   int                                not null,
    order_status_transport int                                not null,
    total_discount         int                                not null,
    total_price            int                                not null,
    note                   text                               null,
    created_at             datetime default CURRENT_TIMESTAMP null,
    update_at              datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint orders_ibfk_1
        foreign key (users_id) references users (users_id)
);

create index users_id
    on orders (users_id);

create table ratings
(
    ratings_id   int auto_increment
        primary key,
    content      text                               null,
    products_id  int                                null,
    users_id     int                                null,
    number_stars int                                not null,
    created_at   datetime default CURRENT_TIMESTAMP null,
    update_at    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint ratings_ibfk_1
        foreign key (products_id) references products (products_id),
    constraint ratings_ibfk_2
        foreign key (users_id) references users (users_id)
);

create index products_id
    on ratings (products_id);

create index users_id
    on ratings (users_id);

create table transactions
(
    transactions_id int auto_increment
        primary key,
    orders_id       int                                null,
    products_id     int                                null,
    price           int                                not null,
    quantity        int                                not null,
    discount        int                                not null,
    total_price     int                                not null,
    name            varchar(255)                       null,
    avatar          varchar(255)                       null,
    status          int                                not null,
    created_at      datetime default CURRENT_TIMESTAMP null,
    update_at       datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint transactions_ibfk_1
        foreign key (orders_id) references orders (orders_id),
    constraint transactions_ibfk_2
        foreign key (products_id) references products (products_id)
);

create index orders_id
    on transactions (orders_id);

create index products_id
    on transactions (products_id);

create table users_types
(
    users_id     int not null,
    user_type_id int not null,
    primary key (users_id, user_type_id),
    constraint users_types_ibfk_1
        foreign key (users_id) references users (users_id),
    constraint users_types_ibfk_2
        foreign key (user_type_id) references user_type (user_type_id)
);

create index user_type_id
    on users_types (user_type_id);

