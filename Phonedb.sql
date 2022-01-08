set echo on;

drop table CLIENT cascade constraints;
drop table PHONE cascade constraints;
drop table REGION cascade constraints;
drop table FREQUENCY cascade constraints;
drop table CELL cascade constraints;
drop table CALL cascade constraints;
drop table IN_CELL cascade constraints;
drop table CELL_FREQ cascade constraints;
drop table NEIGHBORS cascade constraints;

create table CLIENT (
CLNO int,
FIRSTNAME varchar(30) not null,
LASTNAME varchar(30) not null,
CITY varchar(30) not null,
ZIPCODE int not null,
NATIONALITY varchar(30),
STREET varchar(30) not null,
CONSTRAINT CLIENT_PK primary key(CLNO)
);

create table REGION (
NAME varchar(30),
POPULATION int not null,
HQCITY varchar(30) not null,
AREA_SQR_KM int not null,
CONSTRAINT REGION_PK primary key(NAME)
);

create table FREQUENCY (
MHZ int,
SIGNAL varchar(30),
CONSTRAINT FREQUENCY_PK primary key(MHZ)
);

create table CELL (
CELLNO int,
NAME varchar(30) not null,
RADIUS int not null,
LATITUDE float not null,
LONGTITUDE float not null,
INREGION varchar(30),
CONSTRAINT CELL_PK primary key(CELLNO),
CONSTRAINT CELL_FK foreign key(INREGION) references REGION(NAME)
);

create table PHONE (
PHONENO int,
FACTORYNO int not null,
STOLEN varchar(30) not null,
MODEL varchar(30) not null,
PUK1 int not null,
PUK2 int not null,
ACTUALCELL int not null,
HOMECELL int not null,
ISLEASEDTO int,
ISVIC varchar(30),
VICNO int UNIQUE,
CONSTRAINT PHONE_PK primary key(PHONENO),
CONSTRAINT PHONE_FK1 foreign key(ACTUALCELL) references CELL(CELLNO),
CONSTRAINT PHONE_FK2 foreign key(HOMECELL) references CELL(CELLNO),
CONSTRAINT PHONE_FK3 foreign key(ISLEASEDTO) references CLIENT(CLNO)
);

create table CALL (
CALLNO int,
TYPEOFCALL varchar(30) not null,
PRICE float not null,
FROMPHONE int,
CONSTRAINT CALL_PK primary key(CALLNO),
CONSTRAINT CALL_FK foreign key(FROMPHONE) references PHONE(PHONENO)
); 


create table IN_CELL(
CALLNO int,
CELLNO int,
DURATION_MIN float not null,
CONSTRAINT CELL_CALL_FK1 foreign key(CALLNO) references CALL(CALLNO),
CONSTRAINT CELL_CALL_FK2 foreign key(CELLNO) references CELL(CELLNO)
);

create table CELL_FREQ (
MHZ int,
CELLNO int,
CHANNELS int not null,
CONSTRAINT CELL_FREQ_FK1 foreign key(MHZ)references FREQUENCY(MHZ),
CONSTRAINT CELL_FREQ_FK2 foreign key(CELLNO)references CELL(CELLNO)
);

create table NEIGHBORS(
CELLNO int,
NEIGHBOR int,
CONSTRAINT CELLNO_FK foreign key(CELLNO) references CELL(CELLNO),
CONSTRAINT NEIGHBOR_FK foreign key(NEIGHBOR) references CELL(CELLNO)
);

insert into FREQUENCY values (750, 'weak');
insert into FREQUENCY values (800, 'medium');
insert into FREQUENCY values (850, 'strong');

commit;

insert into REGION values ('east', 410331, 'Burgas', 253 );
insert into REGION values ('west', 1291591, 'Sofia', 492 );

commit;

insert into CELL values (1, 'Dandy', 60, 42.69751, 23.32415, 'west');
insert into CELL values (2, 'Jonah', 60, 42.69751, 23.32415, 'west');
insert into CELL values (3, 'Miny', 40, 42.510578, 27.461014, 'east');
insert into CELL values (4, 'Jane', 40, 42.510578, 27.461014, 'east');

commit;

insert into CLIENT values (1, 'Ivan', 'Moskov', 'Pernik', 1000, 'Rusian', 'Golf str.');
insert into CLIENT values (2, 'Dimitar', 'Atanasov', 'Sofia', 1618, 'Bulgarian', 'Lincoln str.');
insert into CLIENT values (3, 'Maria', 'Ghandi', 'Varna', 1932, 'Indian', 'Sinemorec str.');
insert into CLIENT values (4, 'Ana', 'Ansel', 'Burgas', 2367, 'French', 'Ah moreto str.');
insert into CLIENT values (5, 'Pavel', 'Ginev', 'Sofia', 1734, 'Ukraien', 'Narodno horo str.');

commit;

insert into PHONE values(3886574358, 36, 'No', 'Samsung Galaxy Z', 23584691, 12345678, 1, 2, 1, 'Yes', 8223477263);
insert into PHONE values(2886574358, 32, 'Yes', 'Samsung Galaxy S', 19648532, 87654321, 1, 2, 1, 'No', null);
insert into PHONE values(4886574358, 12, 'No', 'Iphone 5 CE', 33584691, 12345687, 1, 3, 2, 'No', null);
insert into PHONE values(5886574358, 18, 'Yes', 'Iphone 11', 43584694, 13245768, 3, 3, 3, 'No', null);
insert into PHONE values(6886574358, 27, 'No', 'Huawei P30', 53584695, 32145678, 3, 4, 4, 'No', null);
insert into PHONE values(9886574358, 7, 'No', 'OnePlus 8t', 63584696, 67813245, 1, 2, 5, 'Yes', 8323477263);

commit;

insert into CALL values(1, 'Long Distance', 5.70, 4886574358);
insert into CALL values(2, 'Short Distance', 0.56, 9886574358);
insert into CALL values(3, 'Private', 10.0, 3886574358);

commit;

insert into IN_CELL values(1, 2, 36.42);
insert into IN_CELL values(2, 4, 1.13);
insert into IN_CELL values(3, 1, 67.21);

commit;

insert into CELL_FREQ values(750, 1, 15);
insert into CELL_FREQ values(800, 1, 30);
insert into CELL_FREQ values(800, 2, 30);
insert into CELL_FREQ values(850, 2, 45);
insert into CELL_FREQ values(750, 3, 15);
insert into CELL_FREQ values(850, 3, 45);
insert into CELL_FREQ values(750, 4, 15);
insert into CELL_FREQ values(800, 4, 30);

commit;

insert into NEIGHBORS values(1, 2);
insert into NEIGHBORS values(1, 3);
insert into NEIGHBORS values(2, 1);
insert into NEIGHBORS values(2, 3);
insert into NEIGHBORS values(3, 2);
insert into NEIGHBORS values(3, 4);
insert into NEIGHBORS values(4, 2);
insert into NEIGHBORS values(4, 3);

commit;

SELECT * FROM CLIENT;
SELECT * FROM REGION;
SELECT * FROM FREQUENCY;
SELECT * FROM PHONE;
SELECT * FROM CALL;
SELECT * FROM CELL_FREQ;
SELECT * FROM IN_CELL;
SELECT * FROM NEIGHBORS;

SELECT COUNT(*) FROM CLIENT;
SELECT COUNT(*) FROM REGION;
SELECT COUNT(*) FROM FREQUENCY;
SELECT COUNT(*) FROM PHONE;
SELECT COUNT(*) FROM CALL;
SELECT COUNT(*) FROM CELL_FREQ;
SELECT COUNT(*) FROM IN_CELL;
SELECT COUNT(*) FROM NEIGHBORS;


