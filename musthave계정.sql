--system 계정
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER musthave IDENTIFIED BY 1234; 

-- 권한 부여시 테이블 스페이스 권한을 추가로 부여해야한다. 
GRANT connect, resource, unlimited tablespace to musthave;

-- 테이블 스페이스 리스트 조회 확인
SELECT tablespace_name, status, contents FROM dba_tablespaces;

-- 테이블 스페이스의 용량 확인
SELECT tablespace_name, sum(bytes), max(bytes) FROM dba_free_space
    GROUP BY tablespace_name;

-- 개인계정이 어느 테이블 스페이스에 들어 있는지 확인 
SELECT username, default_tablespace FROM dba_users
    WHERE username in upper('musthave');

-- musthave 계정에 uers 테이블 스페이스에 데이터를 입력할 수 있도록 
--5m의 용량 할랑
ALTER USER musthave QUOTA 5m ON users;


--musthave 계정
SELECT * FROM tab; -- 테이블이 하나도 없다.

DROP TABLE memder;
DROP TABLE board;
DROP TABLE seq_board_num;

-- 회원 테이블 만들기

CREATE TABLE member
(
	id VARCHAR2(10) NOT NULL,
	pass VARCHAR2(10) NOT NULL,
	name VARCHAR2(30) NOT NULL,
	regidate DATE DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (id)
);

-- 모델 1 방식의 게시판 테이블 만들기
create table board(
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null, 
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

-- 외래키 설정 
alter table board
    add constraint board_mem_fk foreign key (id)
    references member(id);

-- 시퀀스 생성 
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- 더미 데이터 입력
insert into member (id, pass, name) values ('musthave', '1234', '머스트 헤브');

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '제목1입니다', '내용1입니다.', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '지금은 봄입니다', '봄의 왈츠', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '지금은 여름입니다', '여름 향기', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '지금은 가을입니다', '가을 동화', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '지금은 겨울입니다', '겨울 연가', 'musthave', sysdate, 0);

commit;

DESC member;

SELECT * FROM member;




































