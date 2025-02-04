classDiagram
direction BT
class actor {
   varchar(45) first_name
   varchar(45) last_name
   timestamp last_update
   smallint(5) unsigned actor_id
}
class actor_info {
   smallint(5) unsigned actor_id
   varchar(45) first_name
   varchar(45) last_name
   mediumtext film_info
}
class address {
   varchar(50) address
   varchar(50) address2
   varchar(20) district
   smallint(5) unsigned city_id
   varchar(10) postal_code
   varchar(20) phone
   timestamp last_update
   smallint(5) unsigned address_id
}
class category {
   varchar(25) name
   timestamp last_update
   tinyint(3) unsigned category_id
}
class city {
   varchar(50) city
   smallint(5) unsigned country_id
   timestamp last_update
   smallint(5) unsigned city_id
}
class country {
   varchar(50) country
   timestamp last_update
   smallint(5) unsigned country_id
}
class customer {
   tinyint(3) unsigned store_id
   varchar(45) first_name
   varchar(45) last_name
   varchar(50) email
   smallint(5) unsigned address_id
   tinyint(1) active
   datetime create_date
   timestamp last_update
   smallint(5) unsigned customer_id
}
class customer_list {
   smallint(5) unsigned ID
   varchar(91) name
   varchar(50) address
   varchar(10) zip code
   varchar(20) phone
   varchar(50) city
   varchar(50) country
   varchar(6) notes
   tinyint(3) unsigned SID
}
class film {
   varchar(128) title
   text description
   year(4) release_year
   tinyint(3) unsigned language_id
   tinyint(3) unsigned original_language_id
   tinyint(3) unsigned rental_duration
   decimal(4,2) rental_rate
   smallint(5) unsigned length
   decimal(5,2) replacement_cost
   enum('g', 'pg', 'pg-13', 'r', 'nc-17') rating
   set('trailers', 'commentaries', 'deleted scenes', 'behind the scenes') special_features
   timestamp last_update
   smallint(5) unsigned film_id
}
class film_actor {
   timestamp last_update
   smallint(5) unsigned actor_id
   smallint(5) unsigned film_id
}
class film_category {
   timestamp last_update
   smallint(5) unsigned film_id
   tinyint(3) unsigned category_id
}
class film_list {
   smallint(5) unsigned FID
   varchar(128) title
   text description
   varchar(25) category
   decimal(4,2) price
   smallint(5) unsigned length
   enum('g', 'pg', 'pg-13', 'r', 'nc-17') rating
   mediumtext actors
}
class film_text {
   varchar(255) title
   text description
   smallint(5) unsigned film_id
}
class inventory {
   smallint(5) unsigned film_id
   tinyint(3) unsigned store_id
   timestamp last_update
   mediumint(8) unsigned inventory_id
}
class language {
   char(20) name
   timestamp last_update
   tinyint(3) unsigned language_id
}
class nicer_but_slower_film_list {
   smallint(5) unsigned FID
   varchar(128) title
   text description
   varchar(25) category
   decimal(4,2) price
   smallint(5) unsigned length
   enum('g', 'pg', 'pg-13', 'r', 'nc-17') rating
   mediumtext actors
}
class payment {
   smallint(5) unsigned customer_id
   tinyint(3) unsigned staff_id
   int(11) rental_id
   decimal(5,2) amount
   datetime payment_date
   timestamp last_update
   smallint(5) unsigned payment_id
}
class rental {
   datetime rental_date
   mediumint(8) unsigned inventory_id
   smallint(5) unsigned customer_id
   datetime return_date
   tinyint(3) unsigned staff_id
   timestamp last_update
   int(11) rental_id
}
class sales_by_film_category {
   varchar(25) category
   decimal(27,2) total_sales
}
class sales_by_store {
   varchar(101) store
   varchar(91) manager
   decimal(27,2) total_sales
}
class staff {
   varchar(45) first_name
   varchar(45) last_name
   smallint(5) unsigned address_id
   blob picture
   varchar(50) email
   tinyint(3) unsigned store_id
   tinyint(1) active
   varchar(16) username
   varchar(40) password
   timestamp last_update
   tinyint(3) unsigned staff_id
}
class staff_list {
   tinyint(3) unsigned ID
   varchar(91) name
   varchar(50) address
   varchar(10) zip code
   varchar(20) phone
   varchar(50) city
   varchar(50) country
   tinyint(3) unsigned SID
}
class store {
   tinyint(3) unsigned manager_staff_id
   smallint(5) unsigned address_id
   timestamp last_update
   tinyint(3) unsigned store_id
}

address  -->  city : city_id
city  -->  country : country_id
customer  -->  address : address_id
customer  -->  store : store_id
film  -->  language : original_language_id:language_id
film  -->  language : language_id
film_actor  -->  actor : actor_id
film_actor  -->  film : film_id
film_category  -->  category : category_id
film_category  -->  film : film_id
inventory  -->  film : film_id
inventory  -->  store : store_id
payment  -->  customer : customer_id
payment  -->  rental : rental_id
payment  -->  staff : staff_id
rental  -->  customer : customer_id
rental  -->  inventory : inventory_id
rental  -->  staff : staff_id
staff  -->  address : address_id
staff  -->  store : store_id
store  -->  address : address_id
store  -->  staff : manager_staff_id:staff_id
