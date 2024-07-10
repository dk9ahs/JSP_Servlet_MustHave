--system ����
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER musthave IDENTIFIED BY 1234; 

-- ���� �ο��� ���̺� �����̽� ������ �߰��� �ο��ؾ��Ѵ�. 
GRANT connect, resource, unlimited tablespace to musthave;

-- ���̺� �����̽� ����Ʈ ��ȸ Ȯ��
SELECT tablespace_name, status, contents FROM dba_tablespaces;

-- ���̺� �����̽��� �뷮 Ȯ��
SELECT tablespace_name, sum(bytes), max(bytes) FROM dba_free_space
    GROUP BY tablespace_name;

-- ���ΰ����� ��� ���̺� �����̽��� ��� �ִ��� Ȯ�� 
SELECT username, default_tablespace FROM dba_users
    WHERE username in upper('musthave');

-- musthave ������ uers ���̺� �����̽��� �����͸� �Է��� �� �ֵ��� 
--5m�� �뷮 �Ҷ�
ALTER USER musthave QUOTA 5m ON users;


--musthave ����
SELECT * FROM tab; -- ���̺��� �ϳ��� ����.

DROP TABLE memder;
DROP TABLE board;
DROP TABLE seq_board_num;

-- ȸ�� ���̺� �����

CREATE TABLE member
(
	id VARCHAR2(10) NOT NULL,
	pass VARCHAR2(10) NOT NULL,
	name VARCHAR2(30) NOT NULL,
	regidate DATE DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (id)
);

-- �� 1 ����� �Խ��� ���̺� �����
create table board(
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null, 
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

-- �ܷ�Ű ���� 
alter table board
    add constraint board_mem_fk foreign key (id)
    references member(id);

-- ������ ���� 
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- ���� ������ �Է�
insert into member (id, pass, name) values ('musthave', '1234', '�ӽ�Ʈ ���');

insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�.', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '������ ���Դϴ�', '���� ����', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '������ �����Դϴ�', '���� ���', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '������ �����Դϴ�', '���� ��ȭ', 'musthave', sysdate, 0);
insert into board values (seq_board_num.nextval, '������ �ܿ��Դϴ�', '�ܿ� ����', 'musthave', sysdate, 0);

commit;

DESC member;

SELECT * FROM member;




































