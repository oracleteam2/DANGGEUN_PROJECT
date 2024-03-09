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
AS
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
                ,LISTAGG(ii.item_image_url, ', ') WITHIN GROUP (ORDER BY ii.item_image_url) item_images
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
                tb.trade_num, m.member_profile, m.member_nickname
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
                DBMS_OUTPUT.PUT_LINE(rec.item_images);
                DBMS_OUTPUT.PUT_LINE(' ');
                DBMS_OUTPUT.PUT_LINE('Member Profile Image: ' || rec.member_profile_image);
                DBMS_OUTPUT.PUT_LINE('Nickname: ' || rec.nickname);
                DBMS_OUTPUT.PUT_LINE('Address: ' || rec.address);
                DBMS_OUTPUT.PUT_LINE('Manner Point: ' || rec.manner_point);
                DBMS_OUTPUT.PUT_LINE(' ');
                DBMS_OUTPUT.PUT_LINE('Title: ' || rec.title);
                DBMS_OUTPUT.PUT_LINE('Content: ' || rec.content);
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


-- 동네생활 게시판 상세 조회


-- 동네생활 게시판 댓글 조회


-- 동네생활 게시판 대댓글 조회


-- 채팅방 목록 조회


-- 채팅 내용 조회


-- 결제 페이지
