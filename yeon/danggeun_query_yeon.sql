-------------------------- danggeun_query_yeon--------------------------
-- [[동네생활 게시판 상세 조회]] 
-- [동네생활게시판+동네생활카테고리+게시판좋아요+회원+동네생활댓글+댓글좋아요+대댓글+대댓글좋아요]
-- 게시판 제목
-- 게시회원프로필이미지 / 회원닉네임
-- 게시회원주소 / 업로드시간
-- 게시글 제목
-- 게시글 내용
-- 조회수 X
-- 좋아요
SELECT  cb.comm_board_num             --동네생활게시판넘버
        , cc.comm_ctgr_num            --카테고리번호
        , cc.comm_ctgr_name           --카테고리이름
        , member_profile              --회원프로필이미지
        , member_nickname             --회원닉네임
        , SUBSTR(m.member_address,7)    --게시글회원주소
        , cb.comm_upload_date           --업로드일자
        , cb.comm_title                 --게시글제목
        , cb.comm_content               --게시글내용
        , (SELECT distinct COUNT(comm_board_num) FROM comm_board_like cbl where cbl.comm_board_num = cb.comm_board_num  GROUP BY COMM_BOARD_NUM ) --게시판좋아요갯수 
FROM comm_board cb JOIN comm_ctgr cc ON cb.comm_ctgr_num = cc.comm_ctgr_num 
                   JOIN member m ON cb.member_num = m.member_num 
                   JOIN comm_board_like bl ON cb.member_num = bl.member_num
                   
                   --order by cc.comm_ctgr_num --카테고리번호
 ;
                    
-- 게시판 좋아요 개수 세기
SELECT distinct COUNT(comm_board_num) FROM COMM_BOARD_LIKE cbl where cbl.COMM_BOARD_NUM = '11' GROUP BY COMM_BOARD_NUM;
SELECT * FROM comm_board_like;
-- 게시판 댓글 갯수 세기
SELECT distinct COUNT(comm_num) FROM comm_cmt where  comm_board_num = '19'  GROUP BY comm_num;
SELECT * FROM COMM_CMT;
-- 게시판 댓글 좋아요 개수 세기
--SELECT comm_board_num, cmt_num  FROM comm_cmt_like ccl  where ccl.comm_board_num = '2' order BY comm_board_num;
--SELECT * FROM comm_cmt_like; 
-- 게시판 대댓글 갯수 세기
SELECT distinct COUNT(rcmt_num) FROM cmt_reply cr where comm_num = '2'  GROUP BY rcmt_num;
SELECT * FROM cmt_reply;
-- 게시판 대댓글 좋아요 갯수 세기
SELECT distinct COUNT(rcmt_num) FROM cmt_reply_like crl where crl.rcmt_num = '1' GROUP BY rcmt_num;
SELECT * FROM cmt_reply_like;


                     
-- 주소 동 자르기
select SUBSTR(member_address,7) from member ;     

SELECT COUNT(*) FROM cmt_reply GROUP BY cmt_board_num;  -- 대댓글좋아요갯수

-- 동네생활 게시판+동네생활 게시판 좋아요 갯수
SELECT t.*
from(
select count(comm_like_num) 게시판좋아요넘버         
from comm_board cb JOIN comm_board_like cbl ON cb.comm_board_num = cbl.comm_board_num
group by cb.comm_board_num, comm_ctgr_num
order by cb.comm_board_num
) t;
--
select cb.comm_board_num 게시판번호
        , comm_ctgr_num 게시판카테고리번호
        , count(comm_like_num) 게시판좋아요넘버         
from comm_board cb JOIN comm_board_like cbl ON cb.comm_board_num = cbl.comm_board_num
group by cb.comm_board_num, comm_ctgr_num
order by cb.comm_board_num;
--
select cb.comm_board_num 게시판번호
        , comm_ctgr_num 게시판카테고리번호
        , comm_like_num 게시판좋아요넘버         
from comm_board cb JOIN comm_board_like cbl ON cb.comm_board_num = cbl.comm_board_num
order by cb.comm_board_num;

-- 동네생활 게시판 좋아요 갯수 조회
--SELECT *
--FROM (
--    SELECT comm_board_num
--    FROM comm_board_like
--    )
--PIVOT( COUNT(comm_board_num) FOR comm_board_num IN ('1', '2','3','4','5','6','7','8','9','10'
--                                                   , '11', '12','13','14','15','16','17','18','19','20') );
-- up_updtboardlike 프로시서 생성 - 추가                                                   
--CREATE OR REPLACE PROCEDURE up_updtboardlike
--(
--    prcmt_like_num  comm_board_like.rcmt_like_num%TYPE := NULL
--    , pmember_num comm_board_like.member_num%TYPE  
--    , prcmt_num   comm_board_like.prcmt_num%TYPE    
--)
--IS
--  vrcmt_like_num  comm_board_like.rcmt_like_numno%TYPE;
--  vmember_num comm_board_like.member_num%TYPE;
--  vrcmt_num   comm_board_like.prcmt_num%TYPE;
--BEGIN
--    -- 수정 전의 원래 dname, loc
--    SELECT rcmt_like_num, member_num, rcmt_num INTO vrcmt_like_num, vmember_num, vrcmt_num
--    FROM comm_board_like
--    WHERE rcmt_num = prcmt_num; 
--    
--    IF prcmt_like_num IS NULL AND pmember_num IS NULL THEN
--       UPDATE comm_board_like
--       SET rcmt_like_num = vrcmt_like_num, member_num = vmember_num
--       WHERE member_num = pmember_num;
--    ELSIF prcmt_like_num IS NULL THEN
--       UPDATE comm_board_like
--       SET rcmt_like_num = vrcmt_like_num, member_num = pmember_num
--       WHERE member_num = pmember_num;
--    ELSIF pmember_num IS NULL THEN
--       UPDATE comm_board_like
--       SET rcmt_like_num = prcmt_like_num, member_num = vmember_num
--       WHERE member_num = pmember_num;  
--    ELSE
--      UPDATE comm_board_like
--       SET rcmt_like_num = prcmt_like_num, member_num = pmember_num
--       WHERE member_num = pmember_num; 
--    END IF;    
--    COMMIT;
---- EXCEPTION
--END;
-- 삭제

---------------------------------------------------
-- [[동네생활 게시판 상세 조회]] 
-- [동네생활게시판+동네생활카테고리+게시판좋아요+회원+동네생활댓글+댓글좋아요+대댓글+대댓글좋아요]
-- 게시판 제목
-- 게시회원프로필이미지 / 회원닉네임
-- 게시회원주소 / 업로드시간
-- 게시글 제목
-- 게시글 내용
-- 조회수
-- 좋아요
-- 댓글 갯수
-- 댓글회원프로필이미지 / 회원닉네임
-- 댓글회원주소 / 업로드 시간
-- 댓글 내용
-- 댓글 좋아요 갯수
-- 대댓글 회원프로필이미지 / 회원닉네임
-- 대댓글회원주소 / 업로드 시간
-- 대댓글 내용
-- 대댓글 좋아요 갯수
-- 우리 동네 인기글
-- 게시판 제목
-- 게시글 제목
-- 게시글 내용
-- 회원주소 / 업로드시간 / 조회수 / 좋아요수 / 댓글수

select * from comm_board ;
desc comm_board;
--
SELECT  cb.comm_board_num               --동네생활게시판넘버
        , cc.comm_ctgr_name             --  카테고리이름
        , m.member_profile              --게시글회원프로필
        , m.member_nickname             --게시글회원닉네임
        , SUBSTR(m.member_address,7)    --게시글회원주소
        , cb.comm_upload_date           --업로드일자
        , cb.comm_title                 --게시글제목
        , cb.comm_content               --게시글내용
        , (SELECT distinct COUNT(comm_board_num) FROM comm_board_like cbl where cbl.comm_board_num = cb.comm_board_num  GROUP BY COMM_BOARD_NUM ) 게시판좋아요갯수 
         ,(SELECT distinct COUNT(comm_num) FROM comm_cmt cct where cct.comm_board_num = cb.comm_board_num   GROUP BY comm_num)        게시판댓글갯수
        , (select member_profile from member where member_num = cct.member_num ) 댓글회원프로필
        , (select member_nickname from member where member_num = cct.member_num ) 댓글회원닉네임  
        , (select SUBSTR(member_address,7) from member where member_num = cct.member_num ) 댓글회원주소
        , cct.comm_content              댓글내용
        --, (SELECT distinct COUNT(cmt_num) FROM comm_cmt_like ccl where ccl.comm_board_num = cb.comm_board_num GROUP BY cmt_num ) 댓글좋아요갯수
        , (SELECT distinct COUNT(rcmt_num) FROM cmt_reply cr where cr.comm_num = cct.comm_num  GROUP BY rcmt_num )  대댓글갯수
        , (select member_profile from member where member_num = cr.member_num ) 대댓글회원프로필
        , (select member_nickname from member where member_num = cr.member_num ) 대댓글회원닉네임  
        , (select SUBSTR(member_address,7) from member where member_num = cr.member_num )  대댓글회원주소
        , rcmt_content                                                           대댓글내용
        , (SELECT distinct COUNT(rcmt_num) FROM cmt_reply_like crl where crl.rcmt_num = cr.rcmt_num GROUP BY rcmt_num )대댓글좋아요갯수
FROM comm_board cb JOIN comm_ctgr cc ON cb.comm_ctgr_num = cc.comm_ctgr_num 
                   JOIN member m ON cb.member_num = m.member_num 
                   JOIN comm_board_like cbl ON cb.member_num = cbl.member_num
                   JOIN comm_cmt cct  ON cct.comm_board_num = cb.comm_board_num
                   JOIN comm_cmt_like ccl ON cb.member_num = ccl.member_num
                   JOIN cmt_reply cr ON cr.comm_num = cct.comm_num
                   JOIN cmt_reply_like crl ON crl.rcmt_num = cr.rcmt_num
                   ;
----------------------------------------
-- up_commboard 동네생활 게시판 상세 조회 프로시저1
-----------------------------------------
-------------------------------------------------------
-- up_seltblcommboard 동네생활 게시판 상세 조회 프로시저2
-------------------------------------------------------
-- 진성님---------------------------------------------------------
-- 동네생활대댓글좋아요테이블
SELECT * FROM
cmt_reply_like;  
------------------------대댓글좋아요갯수
SELECT DISTINCT rcmt_num, COUNT(*) like_count 
from cmt_Reply_like -- 동네대댓글좋아요
GROUP BY rcmt_num;

-- 동네생활댓글좋아요테이블
SELECT * 
FROM comm_cmt_like; 
----------------------------------------------------------------

-- 동네생활 게시판 상세 조회
-- 동네생활 게시판 좋아요
-- 동네생활 카테고리
-- 동네생활 대댓글 좋아요

-- TBL_COMMBOARD 테이블 생성
CREATE TABLE tbl_commboard
AS
(       SELECT  cb.comm_board_num       board_num  --동네생활게시판넘버
        , cc.comm_ctgr_num              ctgr_num  --카테고리번호
        , cc.comm_ctgr_name             ctgr_name  --카테고리이름
        , member_profile                profile  --회원프로필이미지
        , member_nickname               nickname  --회원닉네임
        , SUBSTR(m.member_address,7)    member_address   --게시글회원주소
        , cb.comm_upload_date           upload_date    --업로드일자
        , cb.comm_title                 title       --게시글제목
        , cb.comm_content               comm_content     --게시글내용
        , (SELECT distinct COUNT(comm_board_num) FROM comm_board_like cbl where cbl.comm_board_num = cb.comm_board_num  GROUP BY COMM_BOARD_NUM ) board_like_cnt --게시판좋아요갯수 
        FROM comm_board cb JOIN comm_ctgr cc ON cb.comm_ctgr_num = cc.comm_ctgr_num 
                   JOIN member m ON cb.member_num = m.member_num 
                   JOIN comm_board_like bl ON cb.member_num = bl.member_num   
);

-- [[동네생활 게시판 상세 조회]] 
-- [동네생활게시판+동네생활카테고리+게시판좋아요+회원+동네생활댓글+댓글좋아요+대댓글+대댓글좋아요]
-- 게시판 제목
-- 게시회원프로필이미지 / 회원닉네임
-- 게시회원주소 / 업로드시간
-- 게시글 제목
-- 게시글 내용
-- 조회수 X
-- 좋아요