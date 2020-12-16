create table han_member(
    memberid varchar2(30) not null,
    passwd varchar2(20) not null,
    mem_name varchar2(30) not null,
    age number,
    job varchar2(40),
    grade varchar2(20) default 'silver' not null,
    reserve number default 0 not null,
    constraint mem_memberid_pk primary key(memberid),
    constraint mem_grade_value check(grade in('silver','gold','vip')),
    constraint mem_age_value check(age>=17)
);

create table han_product(
    productid varchar2(40) not null,
    productname varchar2(40) not null,
    totalstock number,
    price number not null,
    manufacturer varchar2(50) not null,
    supplydate date default sysdate,
    supply number not null,
    constraint product_id_pk primary key(productid),
    constraint product_price_value check(price>=1000),
    constraint product_supply_value check(supply >= 10)
);

create table manufacture(
    manufacturer varchar2(50) constraint manufact_manufacture_pk primary key,
    telephone varchar2(15) not null,
    address varchar2(60),
    managerid varchar2(20) not null
);

alter table han_product
add constraint product_manufacture_fk foreign key (manufacturer)
references manufacture;

create table han_board(
    brdno number not null,
    brdtitle varchar2(40) not null,
    brdcontents varchar2(1000) not null,
    brddate date default sysdate not null,
    memberid varchar2(30) not null,
    constraint board_brdno_pk primary key(brdno),
    constraint board_memberid_fk foreign key(memberid)
    references han_member(memberid)
);

create table han_orders(
    orderno number not null,
    memberid varchar2(30) not null,
    productid varchar2(40) not null,
    ordercnt number default 1 not null,
    address varchar2(100) not null,
    orderdate date default sysdate not null,
    constraint orders_orderno_pk primary key(orderno),
    constraint orders_memid_fk foreign key(memberid)
    references han_member(memberid),
    constraint orders_productid_fk foreign key(productid)
    references han_product(productid)
);

select * from han_member;
select * from manufacture;
select * from han_product;
select * from han_orders;
select * from han_board;

select distinct manufacturer from han_product;

select *
from han_product
where manufacturer like '%의류%' or
manufacturer like '%패션%';

select ho.orderno, hm.mem_name, hp.productname
from han_orders ho, han_member hm, han_product hp
where ho.productid = hp.productid
order by orderno desc;