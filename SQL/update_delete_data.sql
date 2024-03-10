-- SCOTT
-- 데이터 추가/수정/삭제

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
CREATE OR REPLACE TRIGGER ut_updItemCtgr
AFTER 
UPDATE OF item_ctgr_name ON item_ctgr 
FOR EACH ROW
DECLARE
BEGIN
    up_selTradeBoard(:OLD.item_ctgr_num);
END;

UPDATE item_ctgr
SET item_ctgr_name = '의류'
WHERE item_ctgr_num = 3;

COMMIT;

-- 중고거래 게시판
-- 중고거래 테이블 수정시 상세조회 화면 수정되는 프로시저
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

BEGIN
up_updtradeboard(1, pmember_num => 1
,ptrade_title => '에어팟 맥스 새상품', pupload_date => '24/03/08');
END;

-- 상품 이미지
CREATE OR REPLACE TRIGGER utItemImage
BEFORE INSERT OR UPDATE OR DELETE ON item_image
FOR EACH ROW
DECLARE
    vmember_num trade_board.member_num%TYPE;
BEGIN
    -- item_image 테이블에 새로운 데이터가 삽입될 때
    IF INSERTING THEN
        -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
        SELECT member_num INTO vmember_num
        FROM trade_board
        WHERE trade_num = :NEW.trade_num;

        -- 가져온 member_num 값과 현재 사용자의 member_num 값을 비교하여 다른 경우에는 오류를 발생시킵니다.
        IF vmember_num != :NEW.trade_num THEN
            RAISE_APPLICATION_ERROR(-20025, '해당 trade_num에 대한 수정 권한이 없습니다.');
        END IF;
    END IF;

    -- item_image 테이블의 데이터가 수정될 때
    IF UPDATING THEN
        -- 변경된 데이터가 있는지 확인하고, 변경된 trade_num에 대한 member_num 값을 가져옵니다.
        IF :OLD.trade_num != :NEW.trade_num THEN
            -- 새로운 trade_num에 대한 member_num 값을 가져옵니다.
            SELECT member_num INTO vmember_num
            FROM trade_board
            WHERE trade_num = :NEW.trade_num;

            -- 가져온 member_num 값과 현재 사용자의 member_num 값을 비교하여 다른 경우에는 오류를 발생시킵니다.
            IF vmember_num != :NEW.trade_num THEN
                RAISE_APPLICATION_ERROR(-20025, '해당 trade_num에 대한 수정 권한이 없습니다.');
            END IF;
        END IF;
    END IF;

    -- item_image 테이블의 데이터가 삭제될 때
    IF DELETING THEN
        -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
        SELECT member_num INTO vmember_num
        FROM trade_board
        WHERE trade_num = :OLD.trade_num;

        -- 가져온 member_num 값과 현재 사용자의 member_num 값을 비교하여 다른 경우에는 오류를 발생시킵니다.
        IF vmember_num != :OLD.trade_num THEN
            RAISE_APPLICATION_ERROR(-20025, '해당 trade_num에 대한 수정 권한이 없습니다.');
        END IF;
    END IF;
END;

INSERT INTO item_image (trade_num, item_image_num, item_image_url) 
VALUES (1, seq_image.NEXTVAL, '새로운 이미지 URL');

UPDATE item_image
SET item_image_url = '수정된 이미지 URL'
WHERE item_image_num = 40;

DELETE item_image
WHERE item_image_num = 40;

-- 중고거래 게시판 좋아요
-- 이미 해당게시판에 해당회원이 좋아요를 누르면 행 삭제 없으면 삽입
CREATE OR REPLACE TRIGGER ut_insTradeBoardLike
BEFORE 
INSERT ON trade_board_like
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM trade_board_like
    WHERE trade_num = :NEW.trade_num AND member_num = :NEW.member_num;

    IF v_count > 0 THEN
        DELETE FROM trade_board_like WHERE trade_num = :NEW.trade_num AND member_num = :NEW.member_num;
    END IF;
    
    IF v_count = 0 AND :OLD.trade_num != :NEW.trade_num AND :OLD.member_num != :NEW.member_num THEN
        NULL;
    END IF;
END;

-- 좋아요 눌렀을때 거래게시판 상세조회에 반영되는 트리거
CREATE OR REPLACE TRIGGER ut_updSelTradeBoard
AFTER INSERT OR DELETE OR UPDATE ON trade_board_like
FOR EACH ROW
BEGIN
    IF INSERTING OR DELETING OR UPDATING THEN
        up_selTradeBoard(:NEW.trade_num);
    END IF;
END;

INSERT INTO trade_board_like(trade_like_num, trade_num, member_num)
VALUES(16, 7, 3);

DELETE trade_board_like
where trade_like_num = 1;

-- 동네생활 카테고리


-- 동네생활 게시판


-- 동네생활 댓글


-- 동네생활 대댓글


-- 동네생활 게시판 좋아요


-- 동네생활 댓글 좋아요


-- 동네생활 대댓글 좋아요