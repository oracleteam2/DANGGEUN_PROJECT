-- SCOTT
-- 데이터 출력용(화면)

-- 회원 마이페이지 조회


-- 공지사항 게시판 전체 조회


-- 공지사항 게시판 상세 조회


-- 중고거래 게시판 전체 조회


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
                ,tb.trade_price price
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

-- 게시판 수정 프로시저 
CREATE OR REPLACE PROCEDURE up_updTradeBoard(
    ptrade_num IN NUMBER
    ,pmember_num IN NUMBER
    ,pselitem_ctgr_num IN NUMBER DEFAULT NULL
    ,ptrade_title IN trade_board.trade_title%TYPE := NULL
    ,ptrade_content trade_board.trade_content%TYPE := NULL
    ,ptrade_price IN NUMBER DEFAULT NULL
    ,ptrade_location trade_board.trade_location%TYPE := NULL
    ,pupload_date IN DATE DEFAULT TO_DATE(SYSDATE, 'YY-MM-DD')
)
IS
    vmember_num trade_board.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
    SELECT member_num INTO vmember_num
    FROM trade_board
    WHERE trade_num = ptrade_num;

    -- 매개변수로 받은 member_num과 trade_board 테이블에서 가져온 member_num이 다른 경우 예외를 처리합니다.
    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;

    UPDATE trade_board
    SET trade_title = NVL(ptrade_title, trade_title)
        ,trade_content = NVL(ptrade_content, trade_content)
        ,trade_price = NVL(ptrade_price, trade_price)
        ,trade_location = NVL(ptrade_location, trade_location)
        ,upload_date = NVL(pupload_date, upload_date)
    WHERE trade_num = ptrade_num;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Trade details updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Trade number ' || ptrade_num || ' does not exist.');
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match.'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;

BEGIN
up_updtradeboard(1, pmember_num => 2
,ptrade_title => '제목 수정2', pupload_date => '24/03/08');
END;

EXEC up_selTradeBoard(1);

-- 동네생활 게시판 전체 조회


-- 동네생활 게시판 상세 조회


-- 동네생활 게시판 댓글 조회


-- 동네생활 게시판 대댓글 조회


-- 채팅방 목록 조회


-- 채팅 내용 조회


-- 결제 페이지
