CREATE TABLE author (
    author_id  number(10),
    author_name  varchar2(100)  not null,
    author_desc  varchar2(500),
    primary key(author_id)
);
--묵시적방법
insert into author values(1,'박경리','토지 작가');

--명시적방법
insert into author (author_id, author_name)
values(2,'박경리');

--명시적방법 오류상황

insert into author(author_id,author_desc)
values(3, '나혼자 산다 출연');

update author
set author_name = '기안84',
    author_desc = '나혼자산다 출연 웹툰작가'
where author_id = 1;

update author
set author_name = '이문열'
where author_id = 1;

delete from author;
select * from user_sequences;

insert into author
values(seq_author_id.nextval,'이문열','경북 영양');

insert into author
values(seq_author_id.nextval,'박경리','경남 통영');

insert into author
values(seq_author_id.nextval,'유시민','17대국회의원');

insert into author
values(seq_author_id.nextval,'기안84','나혼자산다');

select seq_author_id.currval
from dual;

select seq_author_id.nextval
from dual;

select *
from author;
--번호표기계 --> 시퀀스
create sequence seq_author_id
increment by 1 ---> 한번 실행되면 몇씩 증가할지
start with 1; -->몇번부터 시작할지

drop sequence seq_author_id;