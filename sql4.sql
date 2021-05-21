use twitter_database;
create table twitter_account(
id int primary key auto_increment,
username varchar(100) unique not null,
createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
email varchar(255) not null,
password binary(64) ,
foreign key (id) references twitter_profile(id_profile)
);

create table twitter_profile(
id_profile int primary key auto_increment,
bio varchar(255),
foreign key (id_profile) references twitter_account(id)
);

create table followers(
follower_id int not null,
followed_id int not null,
foreign key (follower_id) references twitter_account(id),
foreign key (followed_id) references twitter_account(id)
);

create table tweet(
id_tweet int primary key auto_increment,
content varchar(255),
createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_id int not null,
foreign key (user_id) references twitter_account(id)
);

create table likes(
user_id int not null,
tweet_id int not null,
foreign key (user_id) references twitter_account(id),
foreign key (tweet_id) references tweet(id_tweet)
);





DELIMITER //
create procedure createAccount(email1 varchar(255),username1 varchar(100),password1 varchar(255),bio varchar(255))
BEGIN

insert into twitter_account(email,username,password) values(email1,username1,md5(password1));
insert into twitter_profile (bio) values(bio);
END
//

call createAccount("test@test.com","test11","test","test123");
call createAccount("test1111@test.com","username2","test","test123");


DELIMITER //
create procedure User_Follow(username1 varchar(255),username2 varchar(255))
BEGIN
declare id1 int;
declare id2 int;

 set id1 = (select id from twitter_account where username = username1) ; 
  set id2 = (select id from twitter_account where username = username2) ; 
 insert into followers (follower_id,followed_id) values (id1,id2);


END
//

call User_Follow("test11","username2");



select count(*) from  tweet where  tweet.user_id = 2;













