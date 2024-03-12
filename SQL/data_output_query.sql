-- SCOTT
-- 데이터 출력용(화면)

-- 회원 마이페이지 조회


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
                    WHEN SYSDATE - TO_DATE(tb.upload_date) < 1 THEN TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) || '분 전'
                    ELSE TRUNC(SYSDATE - TO_DATE(tb.upload_date)) || '일 전'
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
                    WHEN SYSDATE - TO_DATE(tb.upload_date) < 1 THEN TRUNC((SYSDATE - TO_DATE(tb.upload_date)) * 24 * 60) || '분 전'
                    ELSE TRUNC(SYSDATE - TO_DATE(tb.upload_date)) || '일 전'
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


-- 동네생활 게시판 댓글 조회


-- 동네생활 게시판 대댓글 조회


-- 채팅방 목록 조회
CREATE OR REPLACE PROCEDURE seek_list
(
    ptrade_num chat.trade_num%type
)
is
    vtrade_num chat.trade_num%type;
    vmember_num2 chat.member_num2%type;
    vmember_nickname member.member_nickname%type;
    vtrade_title trade_board.trade_title%type;
    vmember_adress member.member_address%type;
    vmember_manner_points member.member_manner_points%type;
begin 
for slc in(
    select c.trade_num, member_num2, member_nickname, trade_title , member_address, member_manner_points
    from chat c join member m on c.member_num2 = m.member_num
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
 select chat_content , member_num2, b.chat_time
    from chat c join member m on c.member_num2 = m.member_num
                join chat_board  b on c.trade_num = b.trade_num            
    where b.trade_num=ptrade_num

)
  loop  
  
  
    DBMS_OUTPUT.PUT_LINE('채팅내용 : ' || vcc.chat_content || '   ' || '채팅 시간 : ' || vcc.chat_time);    
   end loop;

end;

exec seek_chat_content(2);

-- 결제 페이지
