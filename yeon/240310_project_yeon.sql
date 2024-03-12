-------------------------------------------------------------------------조연화
-- [[동네생활 게시판 상세 조회]] 
-- up_seltblcommboard 동네게시판조회
CREATE OR REPLACE PROCEDURE up_selcommboard
(
    pcomm_board_num NUMBER
)
IS 
    vcomm_board_num NUMBER;
BEGIN
    SELECT comm_board_num INTO vcomm_board_num
    FROM comm_board
    WHERE comm_board_num = pcomm_board_num;
    
    FOR com IN ( SELECT  distinct cb.comm_board_num           board_num  --동네생활게시판넘버
                    , cc.comm_ctgr_num              ctgr_num  --카테고리번호
                    , cc.comm_ctgr_name             ctgr_name  --카테고리이름
                    , member_profile                profile  --회원프로필이미지
                    , member_nickname               nickname  --회원닉네임
                    , SUBSTR(m.member_address,7)    member_address   --게시글회원주소
                    , CASE 
                        WHEN SYSDATE - TO_DATE(cb.comm_upload_date) < 1 THEN TRUNC((SYSDATE - TO_DATE(cb.comm_upload_date)) * 24 * 60) || '분 전'
                        ELSE TRUNC(SYSDATE - TO_DATE(cb.comm_upload_date)) || '일 전'
                      END upload_date    --업로드일자
                    , cb.comm_title                 title       --게시글제목
                    , cb.comm_content               comm_content     --게시글내용
                    , (SELECT distinct COUNT(comm_board_num) FROM comm_board_like cbl where cbl.comm_board_num = cb.comm_board_num  GROUP BY COMM_BOARD_NUM ) board_like_cnt --게시판좋아요갯수 
                    FROM comm_board cb JOIN comm_ctgr cc ON cb.comm_ctgr_num = cc.comm_ctgr_num 
                               JOIN member m ON cb.member_num = m.member_num 
                               JOIN comm_board_like bl ON cb.member_num = bl.member_num
                    where cb.comm_board_num = pcomm_board_num             
                   )
    LOOP
     DBMS_OUTPUT.PUT_LINE('ctgr_name : ' || com.ctgr_name); 
     DBMS_OUTPUT.PUT_LINE('profile : ' || com.profile);      
     DBMS_OUTPUT.PUT_LINE( 'nickname : ' ||  com.nickname );   
     DBMS_OUTPUT.PUT_LINE('address : ' || com.member_address);  
     DBMS_OUTPUT.PUT_LINE( 'upload_date : ' ||  com.upload_date );  
     DBMS_OUTPUT.PUT_LINE( 'title : ' ||  com.title );              
     DBMS_OUTPUT.PUT_LINE( 'content : ' ||  com.comm_content ); 
     DBMS_OUTPUT.PUT_LINE(' '); 
    END LOOP;
--EXCEPTION
  -- ROLLBACK;
END;
EXEC up_selcommboard(4); 

--------------------------------------------------------------------------------
-- [[동네생활 게시판 좋아요]]
-- 추가/삭제
SELECT * FROM comm_board_like;
desc comm_board_like ;
--프로시저
-- up_udtcmtreplylike 게시판좋아요 추가
CREATE OR REPLACE PROCEDURE up_insboardlike
(
    pcomm_like_num  comm_board_like.comm_like_num%TYPE
    , pmember_num   comm_board_like.member_num%TYPE
    , pcomm_board_num     comm_board_like.comm_board_num%TYPE
)
IS
BEGIN
    INSERT INTO comm_board_like ( comm_like_num, member_num, comm_board_num )
    values (pcomm_like_num, pmember_num, pcomm_board_num );
    commit;
    
    DBMS_OUTPUT.PUT_LINE('동네생활 게시판 좋아요 넘버: ' || pcomm_like_num || ', ' || '회원 넘버 : ' || pmember_num
                        || ', ' || '동네생활 게시판 넘버: ' || ', ' || pcomm_board_num );
--EXCEPTION
END;
EXEC up_insboardlike(SEQ_COMM_LIKE.NEXTVAL, 10, 2);

--up_delcmtreplylike 게시판좋아요 삭제
CREATE OR REPLACE PROCEDURE up_delboardlike
(
    pcomm_like_num  comm_board_like.comm_like_num%TYPE
    , pmember_num   comm_board_like.member_num%TYPE
    , pcomm_board_num     comm_board_like.comm_board_num%TYPE
)
IS
BEGIN
    DELETE FROM comm_board_like
    where member_num = pmember_num ;
    commit ;
    
--EXCEPTION
END;
EXEC up_delboardlike(25,10,2);

-- 게시판좋아요 추가/삭제 트리거 생성
-- 트리거 만들기전 임시테이블생성
create table tbl_boardlike
(   member_num      NUMBER      PRIMARY KEY
    ,cnt_boardlike    NUMBER    
    ,  CONSTRAINT FK_tblboardlike_member_num FOREIGN KEY(member_num) REFERENCES tbl_boardlike(member_num)
);

--게시판좋아요 추가/삭제 트리거
CREATE OR REPLACE TRIGGER ut_insboardlike
AFTER
INSERT OR DELETE ON comm_board_like   
FOR EACH ROW
BEGIN 
   IF INSERTING THEN
      INSERT INTO comm_board_like (MEMBER_NUM) VALUES ( :NEW.MEMBER_NUM );
   ELSIF DELETING THEN
      INSERT INTO comm_board_like (MEMBER_NUM) VALUES ( :OLD.MEMBER_NUM ); 
   END IF;
-- EXCEPTION  
END;

DESC comm_board_like;
SELECT * FROM comm_board_like WHERE COMM_BOARD_NUM = 1;
INSERT INTO comm_board_like VALUES (SEQ_COMM_LIKE.NEXTVAL,2,1 );
---------------------------------------------------------------------------------
-- 동네생활 카테고리
-- 추가/수정/삭제
SELECT * FROM comm_ctgr ;
-- UP_INSCOMMCTAR 동네카테고리 추가프로시저
CREATE OR REPLACE PROCEDURE UP_INSCOMMCTAR
(
    pcomm_ctgr_num   comm_ctgr.comm_ctgr_num%TYPE 
    , pcomm_ctgr_name  comm_ctgr.comm_ctgr_name%TYPE 
)
IS
BEGIN
    INSERT INTO comm_ctgr ( comm_ctgr_num, comm_ctgr_name )
    values (pcomm_ctgr_num, pcomm_ctgr_name );
    commit;
    
    DBMS_OUTPUT.PUT_LINE('카테고리번호: ' || pcomm_ctgr_num || ', ' || '카테고리이름 : ' || pcomm_ctgr_name );
-- EXCEPTION 카테고리 넘버가같은경우는 입력되지않도록
END ;
-- ORA-06502: PL/SQL: numeric or value error: character to number conversion error
EXEC UP_INSCOMMCTAR ( 7, '추가하기' );

--up_updcommctgr 동네카테고리 수정프로시저
CREATE OR REPLACE PROCEDURE up_updcommctgr
(
    pcomm_ctgr_num   comm_ctgr.comm_ctgr_num%TYPE 
    , pcomm_ctgr_name  comm_ctgr.comm_ctgr_name%TYPE := NULL
)
IS
BEGIN    
       UPDATE comm_ctgr
       SET comm_ctgr_name  = NVL(pcomm_ctgr_name, comm_ctgr_name)
       WHERE comm_ctgr_num = pcomm_ctgr_num; 
       COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('카테고리번호: ' || pcomm_ctgr_num || ', ' || '카테고리이름 : ' || pcomm_ctgr_name );
-- EXCEPTION
END;
EXEC up_updcommctgr( 7, '사라져라');

-- 삭제
CREATE OR REPLACE PROCEDURE up_delcommctgr
(
    pcomm_ctgr_num NUMBER
)
IS
BEGIN
    DELETE FROM comm_ctgr
    where comm_ctgr_num = pcomm_ctgr_num ;
    commit ;
--EXCEPTION
END;
EXEC up_delcommctgr(7);
--
-----------------------------------------------------------------------------------
-- [[동네생활 대댓글 좋아요]]
-- 추가/삭제
SELECT * FROM cmt_reply_like ;
DESC cmt_reply_like;
-- 프로시저
-- up_inscmtreplylike 대댓글좋아요 추가
CREATE OR REPLACE PROCEDURE up_inscmtreplylike
(
    prcmt_like_num  cmt_reply_like.rcmt_like_num%TYPE
    , pmember_num   cmt_reply_like.member_num%TYPE
    , prcmt_num     cmt_reply_like.rcmt_num%TYPE
)
IS
BEGIN
    INSERT INTO cmt_reply_like ( rcmt_like_num, member_num, rcmt_num )
    values (prcmt_like_num, pmember_num, prcmt_num );
    commit;
    
    DBMS_OUTPUT.PUT_LINE('동네생활 대댓글 좋아요 넘버: ' || prcmt_like_num || ', ' || '회원 넘버 : ' || pmember_num
                        || ', ' || '동네생활 대댓글 넘버: ' || ', ' || prcmt_num );
--EXCEPTION
END;
EXEC up_inscmtreplylike(SEQ_RCMT_LIKE.NEXTVAL, 2, 1);

--up_delcmtreplylike 대댓글좋아요 삭제
CREATE OR REPLACE PROCEDURE up_delcmtreplylike
(
    prcmt_like_num  cmt_reply_like.rcmt_like_num%TYPE
    , pmember_num   cmt_reply_like.member_num%TYPE
    , prcmt_num     cmt_reply_like.rcmt_num%TYPE
)
IS
BEGIN
    DELETE FROM cmt_reply_like
    where member_num = pmember_num ;
    commit ;
    
--EXCEPTION
END;
EXEC up_delcmtreplylike(23, 2, 1);

-- 대댓글 추가/삭제 트리거 생성









