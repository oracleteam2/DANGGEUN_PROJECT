-- SCOTT
-- 데이터 추가/수정/삭제
--
-- 회원


-- 관리자


-- 신고


-- 차단


-- 채팅


-- 채팅 내용


-- 당근페이


-- 결제


-- 공지사항 게시판


-- 판매물품 카테고리
-- 판매물품 카테고리 명 수정 트리거
UPDATE item_ctgr
SET item_ctgr_name = '디지털'
WHERE item_ctgr_num = 1;

COMMIT;

-- 중고거래 게시판
-- 중고거래 데이터 수정
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
    DBMS_OUTPUT.PUT_LINE('수정 완료');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Trade number ' || ptrade_num || ' does not exist.');
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match.'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;

-- 수정문
BEGIN
up_updtradeboard(1, pmember_num => 1
,ptrade_title => '에어팟 맥스 새상품', pupload_date => '24/03/08', ptrade_price => 200000);
END;


-- 중고거래 데이터 삭제
---- 중고거래 테이블이 삭제되면 아이템이미지 테이블도 삭제되는 트리거
--CREATE OR REPLACE TRIGGER ut_deImage_Like
--BEFORE
--DELETE ON trade_board -- 중고거래 게시판 테이블
--FOR EACH ROW
--BEGIN
--    DELETE FROM item_image  -- 중고거래 상품 이미지 저장테이블
--    WHERE trade_num = :OLD.trade_num;
--    
--    DELETE FROM trade_board_like
--    WHERE trade_num = :OLD.trade_num;
----EXCEPTION
----  WHEN OTHERS THEN
----    raise_application_error(-20002,'XXX');    
--END;

-- 중고거래 게시판 삭제되면 해당 좋아요 테이블도 삭제되는 트리거
--CREATE OR REPLACE TRIGGER ut_delTradeBoardLike
--BEFORE
--DELETE ON trade_board -- 중고거래 게시판 테이블
--FOR EACH ROW
--DECLARE
--BEGIN
--    DELETE FROM trade_board_like
--    WHERE trade_num = :OLD.trade_num;
--END;

ALTER TABLE trade_board
DROP CONSTRAINT PK_TRADEBOARD CASCADE;

SELECT *
FROM trade_board;

SELECT *
FROM item_image
WHERE trade_num = 1;

SELECT *
FROM trade_board_like
WHERE trade_num = 1;

DELETE FROm trade_board
WHERE trade_num = 1;

-- 거래게시판 삭제
CREATE OR REPLACE PROCEDURE up_delTradeBoard(
    ptrade_num IN NUMBER
    ,pmember_num IN NUMBER
)
IS
    vmember_num trade_board.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
    SELECT member_num INTO vmember_num
    FROM trade_board
    WHERE trade_num = ptrade_num;

    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;

    DELETE trade_board
    WHERE trade_num = ptrade_num;
        
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('삭제 완료');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Trade number ' || ptrade_num || ' does not exist.');
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match.'); 
END;

BEGIN
    up_delTradeBoard(ptrade_num => 1, pmember_num => 1);
END;

CREATE OR REPLACE TRIGGER delete_related_data_trigger
BEFORE DELETE ON trade_board
FOR EACH ROW
BEGIN
    -- trade_board_like 테이블에서 해당 trade_num에 대응하는 데이터 삭제
    DELETE FROM trade_board_like
    WHERE trade_num = :OLD.trade_num;

    -- item_image 테이블에서 해당 trade_num에 대응하는 데이터 삭제
    DELETE FROM item_image
    WHERE trade_num = :OLD.trade_num;
END;


-- 상품 이미지
-- 이미지 수정
CREATE OR REPLACE PROCEDURE up_updItemImage
(
    ptrade_num IN NUMBER
    ,pitem_image_num IN NUMBER
    ,pmember_num IN NUMBER
    ,pitem_image_url item_image.item_image_url%TYPE := NULL
)
IS
    vmember_num item_image.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    SELECT member_num INTO vmember_num
    FROM trade_board
    WHERE trade_num = ptrade_num;
    
    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;
    
    UPDATE item_image
    SET item_image_url = NVL(pitem_image_url, item_image_url)
    WHERE item_image_num = pitem_image_num;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('수정 완료');
EXCEPTION
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;

BEGIN
    up_upditemimage(ptrade_num => 1, pitem_image_num => 1, pmember_num => 1, pitem_image_url => '신규이미지url');
END;

-- 이미지 삭제
CREATE OR REPLACE PROCEDURE up_delItemImage
(
    ptrade_num IN NUMBER
    ,pitem_image_num IN NUMBER
    ,pmember_num IN NUMBER
)
IS
    vmember_num item_image.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    SELECT member_num INTO vmember_num
    FROM trade_board
    WHERE trade_num = ptrade_num;
    
    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;
    
    DELETE item_image
    WHERE item_image_num = pitem_image_num;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('삭제 완료');
EXCEPTION
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;

BEGIN
    up_delItemImage(ptrade_num => 1, pitem_image_num => 1, pmember_num => 1);
END;

-- 중고거래 게시판 좋아요
-- 이미 해당게시판에 해당회원이 좋아요를 누르면 행 삭제 없으면 삽입
DROP  TRIGGER ut_insTradeBoardLike;

CREATE OR REPLACE TRIGGER ut_insTradeBoardLike
BEFORE INSERT ON trade_board_like
FOR EACH ROW
DECLARE
    vcount NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO vcount
    FROM trade_board_like
    WHERE trade_num = :NEW.trade_num AND member_num = :NEW.member_num;

    IF vcount > 0 THEN
        DELETE FROM trade_board_like
        WHERE trade_num = :NEW.trade_num AND member_num = :NEW.member_num;
        
        :NEW.trade_num := NULL;
        :NEW.member_num := NULL;
        
    END IF;
END;

INSERT INTO trade_board_like(trade_like_num, trade_num, member_num)
VALUES(21, 7, 2);

DELETE trade_board_like
where trade_like_num = 1;

-- 동네생활 카테고리


-- 동네생활 게시판


-- 동네생활 댓글


-- 동네생활 대댓글


-- 동네생활 게시판 좋아요


-- 동네생활 댓글 좋아요


-- 동네생활 대댓글 좋아요