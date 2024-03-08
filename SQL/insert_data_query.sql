-- SCOTT
-- 데이터 삽입

-- 회원
-- 회원 넣기전에 추가해주세요
ALTER TABLE member MODIFY (member_manner_points DEFAULT '36.5');

CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 1
INCREMENT BY 1;

SHOW DEFINE;
SET DEFINE OFF;

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1998-06-29', '진돌', '부산광역시 해운대구 중동', '010-4044-4444', 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1990-03-12', '강타', '서울특별시 강남구 중동', '010-1234-4444', 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1991-05-23', '이효리', '서울특별시 강남구 중동', '010-9822-4224', 'https://img.freepik.com/premium-photo/caricature-of-a-carrot-with-a-face-and-limbs-generative-ai_252214-6349.jpg?w=2000

');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1992-07-27', '바다', '서울특별시 노원구 중동', '010-4467-2454', 'https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1993-11-19', '김태우', '서울특별시 마포구 중동', '010-7014-1244', 'https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/rZ1xSXKCJ4cd-IExOYahRWdrqoo.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1994-12-04', '손호영', '대구광역시 수성구 중동', '010-8344-8894', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUepaBdMZtoy5GmiKF_v1vkRbwo3MgxAiIwcaztDaqiYwLdV58jhq19hUX00btfdkBUF8&usqp=CAU 
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1995-09-02', '차승원', '대전광역시  서구 중동', '010-7744-4477', ' https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/cnoC/image/tfQwmqh621xPopjfnJ9wXkfrBcc.jpg
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1996-08-24', '원빈', '부산광역시 해운대구 좌동', '010-1253-8964', 'https://i.pinimg.com/736x/05/fe/0c/05fe0c269a225ac1251fff5bc74483ef.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1997-02-15', '카리나', '인천광역시 남구 중동', '010-2834-5315', 'https://www.moneynet.co.kr/files/attach/images/33793530/304/717/049/0d8e9d6eee5e97ac11f96085c56072ab.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '2000-07-11', '손석구', '제주특별시 제주시 아라일동', '010-2427-2453', 'https://cdnimage.dailian.co.kr/news/201802/news_1518415236_693408_m_1.jpg');

-- 관리자
CREATE SEQUENCE SEQ_ADMIN_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자1', 'admin123', '1234');

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자2', 'admin4875', '842135');

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자3', 'admin9753', '84651321');

-- 신고
CREATE SEQUENCE SEQ_REPORT_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO report
VALUES (SEQ_REPORT_ID.NEXTVAL, 1, 3);

-- 차단
INSERT INTO block
VALUES (3, 5);

-- 채팅
CREATE SEQUENCE SEQ_CHATROOM_ID
START WITH 1
INCREMENT BY 1;
 
INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 1, 2);

-- 채팅 내용
CREATE SEQUENCE SEQ_CHATCONTENT_ROOM1_ID --1번채팅방 내용번호
START WITH 1
INCREMENT BY 1;

INSERT INTO chat_board
VALUES (1, SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '첫채팅', SYSDATE);


-- 당근페이
INSERT INTO DANNGN_pay
VALUES(1, '91098112453', '국민', 50000);

-- 결제
INSERT INTO pay
VALUES(1, 3);


-- 공지사항 게시판
CREATE SEQUENCE SEQ_NOTICE_BOARD_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 1,  '저희 당근은 네고 불가입니다', '저희 당근은 금일부로 네고할 수 없습니다. 네고시 회원자격을 박탈하겠습니다.', SYSDATE);


-- 판매 물품 카테고리


-- 중고거래 게시판


-- 상품 이미지


-- 중고거래 게시판 좋아요


-- 동네생활 카테고리


-- 동네생활 게시판


-- 동네생활 댓글
INSERT INTO COMM_CMT (COMM_NUM, COMM_BOARD_NUM, COMM_WRITER_NICKNAME, COMM_DATE, COMM_CTGR_NAME, COMM_CONTENT) 
VALUES (1, 100, '뿡빵이', TO_DATE('21-04-21','YY-MM-DD'), '인기게시판', '댓글 내용입니다.'),
       (2, 200, '하호하미', TO_DATE('21-01-01','YY-MM-DD'), '인기게시판', '댓글 내용입니다.'),
       (3, 300, '민트', TO_DATE('21-01-01','YY-MM-DD'), '인기게시판', '댓글 내용입니다.'),
       (4, 400, '초코', TO_DATE('21-01-01','YY-MM-DD'), '자유게시판', '댓글 내용입니다.'),
       (5, 500, 'Willer', TO_DATE('21-01-01','YY-MM-DD'), '자유게시판', '댓글 내용입니다.'),
       (6, 600, '초키처키', TO_DATE('21-01-01','YY-MM-DD'), '자유게시판', '댓글 내용입니다.'),
       (7, 700, 'guitar215', TO_DATE('21-01-01','YY-MM-DD'), '질문게시판', '댓글 내용입니다.'),
       (8, 800, 'kamel94', TO_DATE('21-01-01','YY-MM-DD'), '질문게시판', '댓글 내용입니다.'),
       (9, 900, '동동', TO_DATE('21-01-01','YY-MM-DD'), '질문게시판', '댓글 내용입니다.'),
       (10, 1000, '오쪼꼬미니미', TO_DATE('21-01-01','YY-MM-DD'), '정보공유', '댓글 내용입니다.');

-- 동네생활 대댓글
INSERT INTO CMT_REPLY (RCMT_NUM, COMM_NUM, RCMT_WRITER_NICKNAME, CMT_BOARD_NUM, RCMT_CONTENT, RCMT_DATE) 
VALUES (1, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (2, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (3, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (4, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (5, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (6, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (7, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (8, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (9, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD')),
       (10, 1, '답변 작성자 닉네임', 100, '답변 내용입니다.', TO_DATE('21-04-21','YY-MM-DD'));

-- 동네생활 게시판 좋아요


-- 동네생활 댓글 좋아요
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM) 
VALUES (1, 100, 1, 1),
       (2, 200, 1, 1),
       (3, 300, 1, 1),
       (4, 400, 1, 1),
       (5, 500, 1, 1),
       (6, 600, 1, 1),
       (7, 700, 1, 1),
       (8, 800, 1, 1),
       (9, 900, 1, 1),
       (10, 1000, 1, 1);


-- 동네생활 대댓글 좋아요
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM) 
VALUES (1, 1, 1),
       (2, 1, 1),
       (3, 1, 1),
       (4, 1, 1),
       (5, 1, 1),
       (6, 1, 1),
       (7, 1, 1),
       (8, 1, 1),
       (9, 1, 1),
       (10, 1, 1);






















