-- SCOTT
-- 데이터 출력용(화면)

-- 회원 마이페이지 조회
CREATE OR REPLACE PROCEDURE up_select_mpage
(
    pmember_num member.member_num%TYPE
)
IS
    vcount_memb_tboard NUMBER;
    vmem_nickname member.member_nickname%TYPE;
    vmem_profile member.member_profile%TYPE;
    vmem_mpoints member.member_manner_points%TYPE;
    vmem_addr   member.member_address%TYPE;
    vbalance danggeun_pay.balance%TYPE;
    v_mem_count NUMBER;
BEGIN
    
    SELECT COUNT(*)
        INTO v_mem_count
    FROM member
    WHERE member_num = pmember_num;
    
    SELECT m.member_profile, m.member_nickname, m.member_manner_points, t.count_mem_tboard, m.member_address
        INTO  vmem_profile , vmem_nickname, vmem_mpoints, vcount_memb_tboard, vmem_addr
    FROM member m ,(
        SELECT COUNT(t.member_num) count_mem_tboard
        FROM member m JOIN trade_board t ON m.member_num = t.member_num 
        WHERE m.member_num = pmember_num
            ) t
    WHERE m.member_num = pmember_num;
    
    SELECT balance
        INTO vbalance
    FROM danggeun_pay
    WHERE member_num = pmember_num;
    
    DBMS_OUTPUT.PUT( vmem_profile );
    DBMS_OUTPUT.PUT_LINE( vmem_nickname );
    DBMS_OUTPUT.PUT_LINE( '당근페이 금액 : ' || vbalance ||'원');
    DBMS_OUTPUT.PUT_LINE( '매너온도 : ' || vmem_mpoints || '℃' );
    DBMS_OUTPUT.PUT_LINE( '판매물품 : ' ||vcount_memb_tboard || '개' );
    DBMS_OUTPUT.PUT_LINE( '주소 : ' || vmem_addr );

--EXCEPTION
END;

EXEC up_select_mpage(1);

-- 차단 조회
CREATE OR REPLACE PROCEDURE up_selBLOCK
(
    pmember_num NUMBER
)
IS
    vtmember_block NUMBER;
    vfmember_block NUMBER;
    vtnickname member.member_nickname%TYPE;
    vfnickname member.member_nickname%TYPE;
    vmember_num NUMBER;
    
BEGIN
    
    SELECT member_num INTO vmember_num
    FROM member
    WHERE member_num = pmember_num;
    
    SELECT member_nickname INTO vfnickname
    FROM member
    WHERE member_num = pmember_num;
    FOR rec IN(
        SELECT DISTINCT member_nickname INTO vtnickname
        FROM member m JOIN BLOCK b ON m.member_num = t_block_mem_num
    )
    LOOP
        vtnickname := rec.member_nickname;
        DBMS_OUTPUT.PUT_LINE( vfnickname || '이 ' || vtnickname || '를 차단했습니다');
    END LOOP;
    
END;

EXEC up_selBLOCK(2);

-- 공지사항 게시판 전체 조회
CREATE OR REPLACE PROCEDURE up_selNoticeBoardAll

IS
    vnotice_title notice_board.notice_title%TYPE;
    vnotice_date notice_board.notice_date%TYPE;
    vadmin_nickname admin.admin_nickname%TYPE;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('공지사항');
    DBMS_OUTPUT.PUT_LINE(' ');
    FOR vrow IN (
    SELECT notice_title
    , notice_date
    , admin_nickname
    FROM notice_board nb JOIN admin a USING(admin_num)
    ORDER BY vnotice_date
    )
    LOOP
    DBMS_OUTPUT.PUT_LINE('[공지] ' || ' ' || vrow.notice_title);
    DBMS_OUTPUT.PUT_LINE('Date : ' || vrow.notice_date || '              ' || 'Writer : '|| vrow.admin_nickname);
    DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('공지사항이 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생: ');
END;

EXEC up_selNoticeBoardAll;

-- 공지사항 게시판 상세 조회
CREATE OR REPLACE PROCEDURE up_selNoticeBoardInfo
(
    pnotice_num notice_board.notice_num%TYPE
)
IS
    vnotice_title notice_board.notice_title%TYPE;
    vnotice_content notice_board.notice_content%TYPE;
    vnotice_date notice_board.notice_date%TYPE;
    vadmin_nickname admin.admin_nickname%TYPE;
    
BEGIN
    SELECT notice_title
    , notice_content
    , notice_date
    , admin_nickname
        INTO vnotice_title, vnotice_content, vnotice_date, vadmin_nickname
    FROM notice_board nb JOIN admin a USING(admin_num)
    WHERE notice_num = pnotice_num;
    DBMS_OUTPUT.PUT_LINE('공지');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Title : ' || vnotice_title);
    DBMS_OUTPUT.PUT_LINE('Date : ' || vnotice_date);
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE(vnotice_content);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    DBMS_OUTPUT.PUT_LINE('Writer : ' || vadmin_nickname);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('공지사항이 없습니다.');
END;

EXEC up_selNoticeBoardInfo(1);

-- 중고거래 게시판 전체 조회
DECLARE
  CURSOR trade_board_cursor IS
    SELECT tb.TRADE_NUM,
           m.MEMBER_NICKNAME,
             c.item_ctgr_name,
           tb.TRADE_TITLE,
           tb.TRADE_CONTENT,
           TO_CHAR(tb.UPLOAD_DATE, 'YY-MM-DD') AS UPLOAD_DATE,
           tb.TRADE_PRICE,
           tb.TRADE_LOCATION,
          
           LISTAGG(i.ITEM_IMAGE_URL, ', ') WITHIN GROUP (ORDER BY i.ITEM_IMAGE_NUM) AS IMAGE_URLS
    FROM TRADE_BOARD tb
         JOIN MEMBER m ON tb.MEMBER_NUM = m.MEMBER_NUM
         JOIN ITEM_IMAGE i ON tb.TRADE_NUM = i.TRADE_NUM
         JOIN item_ctgr c ON tb.selitem_ctgr_num = c.item_ctgr_num
    GROUP BY tb.TRADE_NUM, m.MEMBER_NICKNAME,   c.item_ctgr_name, tb.TRADE_TITLE, tb.TRADE_CONTENT, tb.UPLOAD_DATE, tb.TRADE_PRICE, tb.TRADE_LOCATION;

  trade_board_rec trade_board_cursor%ROWTYPE;
BEGIN
  OPEN trade_board_cursor;
  LOOP
    FETCH trade_board_cursor INTO trade_board_rec;
    EXIT WHEN trade_board_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('거래 번호: ' || trade_board_rec.TRADE_NUM);
    DBMS_OUTPUT.PUT_LINE('회원 닉네임: ' || trade_board_rec.MEMBER_NICKNAME);
    DBMS_OUTPUT.PUT_LINE('카테고리 : ' || trade_board_rec.item_ctgr_name);
    DBMS_OUTPUT.PUT_LINE('제목: ' || trade_board_rec.TRADE_TITLE);
    DBMS_OUTPUT.PUT_LINE('내용: ' || trade_board_rec.TRADE_CONTENT);
    DBMS_OUTPUT.PUT_LINE('업로드 일자: ' || trade_board_rec.UPLOAD_DATE);
    DBMS_OUTPUT.PUT_LINE('거래 가격: ' || trade_board_rec.TRADE_PRICE);
    DBMS_OUTPUT.PUT_LINE('거래 위치: ' || trade_board_rec.TRADE_LOCATION);
    DBMS_OUTPUT.PUT_LINE('이미지 URL: ' || trade_board_rec.IMAGE_URLS);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
  CLOSE trade_board_cursor;
END;

-- 중고거래 게시판 상세 조회
CREATE OR REPLACE PROCEDURE up_selTradeBoard
(
    ptrade_num NUMBER
)
IS
    vtrade_num NUMBER;
BEGIN
    SELECT trade_num INTO vtrade_num
    FROM trade_board
    WHERE trade_num = ptrade_num;
    
    IF vtrade_num = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Trade number ' || ptrade_num || ' does not exist.');
    ELSE
        FOR rec IN (
            SELECT  
                tb.trade_num
                ,(SELECT LISTAGG(ii.item_image_url || CHR(10), ', ') WITHIN GROUP (ORDER BY ii.item_image_url) 
                  FROM item_image ii 
                  WHERE ii.trade_num = tb.trade_num
                  GROUP BY ii.trade_num) item_images
                ,m.member_profile member_profile_image
                ,m.member_nickname nickname
                ,SUBSTR(m.member_address, INSTR(m.member_address, '시 ') + 1) address
                ,m.member_manner_points manner_point
                ,tb.trade_title title
                ,ic.item_ctgr_name category_name
                ,CASE 
                    WHEN SYSDATE - TO_DATE(tb.upload_date) < 1 THEN 
                        CASE 
                            WHEN TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) >= 60 THEN
                                TRUNC(TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24)) || '시간 전'
                            ELSE 
                                TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) || '분 전'
                        END
                    ELSE 
                        TRUNC(SYSDATE - TO_DATE(tb.upload_date)) || '일 전'
                END time
                ,tb.trade_content content
                ,TO_CHAR(tb.trade_price, '999,999,999') price
                ,COUNT(DISTINCT tbl.member_num) like_count
            FROM 
                item_image ii 
                JOIN trade_board tb ON ii.trade_num = tb.trade_num
                JOIN member m ON m.member_num = tb.member_num
                JOIN item_ctgr ic ON ic.item_ctgr_num = tb.selitem_ctgr_num
                LEFT JOIN trade_board_like tbl ON tbl.trade_num = tb.trade_num
            WHERE 
                tb.trade_num = ptrade_num
            GROUP BY 
                tb.trade_num, m.member_profile, m.member_nickname, tb.trade_price
                ,SUBSTR(m.member_address, INSTR(m.member_address, '시 ') + 1) 
                ,m.member_manner_points, tb.trade_title, ic.item_ctgr_name
                , CASE 
                    WHEN SYSDATE - TO_DATE(tb.upload_date) < 1 THEN 
                        CASE 
                            WHEN TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) >= 60 THEN
                                TRUNC(TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) / 60) || '시간 전'
                            ELSE 
                                TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) || '분 전'
                        END
                    ELSE 
                        TRUNC(SYSDATE - TO_DATE(tb.upload_date)) || '일 전'
                END
                , tb.trade_content
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Item Image:');
            DBMS_OUTPUT.PUT(rec.item_images);
            DBMS_OUTPUT.PUT_LINE(' ');
            DBMS_OUTPUT.PUT_LINE('Member Profile Image: ' || rec.member_profile_image);
            DBMS_OUTPUT.PUT_LINE('Nickname: ' || rec.nickname);
            DBMS_OUTPUT.PUT_LINE('Address: ' || rec.address);
            DBMS_OUTPUT.PUT_LINE('Manner Point: ' || rec.manner_point);
            DBMS_OUTPUT.PUT_LINE(' ');
            DBMS_OUTPUT.PUT_LINE('Title: ' || rec.title);
            DBMS_OUTPUT.PUT_LINE('Content: ' || rec.content);
            DBMS_OUTPUT.PUT_LINE('PRICE: ' || rec.price || '원');
            DBMS_OUTPUT.PUT_LINE(' ');
            DBMS_OUTPUT.PUT_LINE('Category Name: ' || rec.category_name);
            DBMS_OUTPUT.PUT_LINE('Time: ' || rec.time);
            DBMS_OUTPUT.PUT_LINE('Like Count: ' || rec.like_count);
        END LOOP;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Trade number ' || ptrade_num || ' does not exist.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred.');
END;

EXEC up_selTradeBoard(1);


-- 동네생활 게시판 전체 조회
DECLARE
  CURSOR comm_board_cursor IS
    SELECT cb.COMM_BOARD_NUM,
           cb.COMM_TITLE,
           cb.COMM_CONTENT,
           TO_CHAR(cb.COMM_UPLOAD_DATE, 'YY-MM-DD') AS UPLOAD_DATE
          -- m.MEMBER_NICKNAME
    FROM comm_board cb
    JOIN member m ON cb.MEMBER_NUM = m.MEMBER_NUM;
  comm_board_rec comm_board_cursor%ROWTYPE;
  board_number NUMBER := 0;
BEGIN
  OPEN comm_board_cursor;
  LOOP
    FETCH comm_board_cursor INTO comm_board_rec;
    EXIT WHEN comm_board_cursor%NOTFOUND;
    board_number := board_number + 1;
    DBMS_OUTPUT.PUT_LINE('게시물 번호: ' || board_number);
    DBMS_OUTPUT.PUT_LINE('게시물 제목: ' || comm_board_rec.COMM_TITLE);
    DBMS_OUTPUT.PUT_LINE('게시물 내용: ' || comm_board_rec.COMM_CONTENT);
    DBMS_OUTPUT.PUT_LINE('게시물 작성일: ' || comm_board_rec.UPLOAD_DATE);
    --DBMS_OUTPUT.PUT_LINE('게시물 작성자: ' || comm_board_rec.MEMBER_NICKNAME);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
  END LOOP;
  CLOSE comm_board_cursor;
END;

-- 동네생활 게시판 상세 조회
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
                        WHEN SYSDATE - TO_DATE(cb.comm_upload_date) > 30 THEN TRUNC((SYSDATE - TO_DATE(cb.comm_upload_date)) / 30 ) || '개월 전'
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

EXEC up_selcommboard(1);

-- 동네생활 게시판 댓글 조회
CREATE OR REPLACE PROCEDURE up_checkcmt
IS
  vcomm_num comm_cmt.comm_num%TYPE;
  vmember_num comm_cmt.member_num%TYPE;
  vcomm_date comm_cmt.comm_date%TYPE;
  vcomm_content comm_cmt.comm_content%TYPE;
BEGIN
  FOR vrow IN 
  (SELECT 
    comm_num, member_num, comm_date, comm_content
   FROM comm_cmt)
  LOOP
    vcomm_num := vrow.comm_num;
    vmember_num := vrow.member_num;
    vcomm_date := vrow.comm_date;
    vcomm_content := vrow.comm_content;

    -- 댓글 정보 출력
    DBMS_OUTPUT.put_line('**댓글 번호: ' || vcomm_num);
    DBMS_OUTPUT.put_line('**작성자 번호: ' || vmember_num);
    DBMS_OUTPUT.put_line('**작성 날짜: ' || TO_CHAR(vcomm_date, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.put_line('**댓글 내용: ' || vcomm_content);
    DBMS_OUTPUT.put_line('-----------------------------');
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('**댓글이 존재하지 않습니다.');
END;

EXEC up_checkcmt;

-- 동네생활 게시판 대댓글 조회
CREATE OR REPLACE PROCEDURE up_checkReply
IS
  vrcmt_num cmt_reply.rcmt_num%TYPE;
  vmember_num cmt_reply.member_num%TYPE;
  vrcmt_date cmt_reply.rcmt_date%TYPE;
  vrcmt_content cmt_reply.rcmt_content%TYPE;
BEGIN
  FOR vrow IN 
  (SELECT 
    rcmt_num, member_num, rcmt_date, rcmt_content
   FROM cmt_reply)
  LOOP
    vrcmt_num := vrow.rcmt_num;
    vmember_num := vrow.member_num;
    vrcmt_date := vrow.rcmt_date;
    vrcmt_content := vrow.rcmt_content;

    -- 댓글 정보 출력
    DBMS_OUTPUT.put_line('**대댓글 번호: ' || vrcmt_num);
    DBMS_OUTPUT.put_line('**작성자 번호: ' || vmember_num);
    DBMS_OUTPUT.put_line('**작성 날짜: ' || TO_CHAR(vrcmt_date, 'YYYY-MM-DD'));
    DBMS_OUTPUT.put_line('**대댓글 내용: ' || vrcmt_content);
    DBMS_OUTPUT.put_line('-----------------------------');
  END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('**대댓글이 존재하지 않습니다.');
END;

EXEC up_checkReply;

-- 채팅방 목록 조회
CREATE OR REPLACE PROCEDURE seek_list
(
    ptrade_num chat.trade_num%type
)
is
    vtrade_num chat.trade_num%type;
    vbuyer_num chat.buyer_num%type;
    vmember_nickname member.member_nickname%type;
    vtrade_title trade_board.trade_title%type;
    vmember_adress member.member_address%type;
    vmember_manner_points member.member_manner_points%type;
begin 
for slc in(
    select c.trade_num, buyer_num, member_nickname, trade_title , member_address, member_manner_points
    from chat c join member m on c.buyer_num = m.member_num
                join trade_board t on c.trade_num = t.trade_num
    where c.trade_num= ptrade_num)
    
    loop
    
    DBMS_OUTPUT.PUT_LINE('게시판 제목 : ' || slc.trade_title ||'   '||   '채팅 상대방 : ' ||  slc.member_nickname || ' 상대방 주소 : ' || slc.member_address ||'   '|| '매너 온도 : ' || slc.member_manner_points);    
    
    end loop;
end;

exec seek_list(2); 

-- 채팅 내용 조회
CREATE OR REPLACE PROCEDURE seek_chat_content
(
    ptrade_num chat_board.trade_num%type
)
is
--    vchat_content chat_board.chat_content%type;
 --   vmember_num2 chat.member_num2%type;
    vmember_nickname member.member_nickname%type;
    vtrade_title trade_board.trade_title%type;
    vmember_manner_points member.member_manner_points%type;
begin 
    select trade_title, member_manner_points, member_nickname into vtrade_title, vmember_manner_points, vmember_nickname
    from trade_board t join member m on t.member_num = m.member_num
    where trade_num = ptrade_num;
    
 DBMS_OUTPUT.PUT_LINE('판매중인 물품 : ' || vtrade_title  ||'   '||   '채팅 상대방 : ' ||  vmember_nickname  ||'  '|| ' 상대방 매너온도 : ' || vmember_manner_points);

for vcc in(
 select chat_content , buyer_num, b.chat_time
    from chat c join member m on c.buyer_num = m.member_num
                join chat_board  b on c.trade_num = b.trade_num            
    where b.trade_num=ptrade_num

)
  loop  
  
  
    DBMS_OUTPUT.PUT_LINE('채팅내용 : ' || vcc.chat_content || '   ' || '채팅 시간 : ' || vcc.chat_time);    
   end loop;

end;

exec seek_chat_content(2);
