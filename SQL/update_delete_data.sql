-- SCOTT
-- 데이터 추가/수정/삭제
----
-- 회원
-- 회원 정보 수정
CREATE OR REPLACE PROCEDURE up_update_member
(
    pmem_num member.member_num%TYPE,
    pmem_nickname member.member_nickname%TYPE := NULL,
    pmem_addr member.member_address%TYPE := NULL,
    pmem_tel member.member_tel%TYPE := NULL,
    pmem_profile member.member_profile%TYPE := NULL
)
IS
    v_is_member NUMBER;
    vmem_nickname member.member_nickname%TYPE;
    vmem_addr member.member_address%TYPE;
    vmem_tel member.member_tel%TYPE;
    vmem_profile member.member_profile%TYPE;
BEGIN
    SELECT member_nickname, member_address, member_tel, member_profile
        INTO vmem_nickname, vmem_addr, vmem_tel, vmem_profile
    FROM member
    WHERE member_num = pmem_num;


    UPDATE member
    SET  member_nickname = NVL(pmem_nickname, vmem_nickname)
        ,member_address  = NVL(pmem_addr, vmem_addr)
        ,member_tel      = NVL(pmem_tel, vmem_tel)
        ,member_profile  = NVL(pmem_profile, vmem_profile)
    WHERE member_num = pmem_num;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, '업데이트할 회원이 존재하지 않는다.');
END;

EXEC up_update_member(1, '유진')
ROLLBaCk;
SELECT * FROM member;

-- 회원 추가
CREATE OR REPLACE PROCEDURE up_insert_member
(   
    pmem_birth member.member_birth%TYPE,
    pmem_nickname member.member_nickname%TYPE,
    pmem_addr member.member_address%TYPE,
    pmem_tel member.member_tel%TYPE,
    pmem_profile member.member_profile%TYPE
)
IS
BEGIN

    INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
    VALUES (seq_member_id.NEXTVAL, pmem_birth, pmem_nickname, pmem_addr, pmem_tel, pmem_profile);

--EXCEPTION
END;

EXECUTE up_insert_member( '981012', '동스', '울산시 울주군 언양읍', '010-1111-2222', 'https://image.newsis.com/2012/05/25/NISI20120525_0006401508_web.jpg');
SELECT * FROM member;

-- 회원 삭제
ALTER TABLE memeber
DROP CONSTRAINT PK_member CASCADE;

CREATE OR REPLACE PROCEDURE up_delete_member
(
    pmem_num member.member_num%TYPE
)
IS
    v_is_member NUMBER;
BEGIN
    SELECT COUNT(*)
        INTO v_is_member
    FROM member
    WHERE member_num = pmem_num;

    IF v_is_member = 1
    THEN
    DELETE FROM member
    WHERE member_num = pmem_num;
    ELSE
    RAISE_APPLICATION_ERROR(-20002, '삭제할 회원이 없습니다');
    END IF;
--EXCEPTION
END;


-- 관리자
-- 관리자 추가 프로시저
CREATE OR REPLACE PROCEDURE up_insAdmin
(
    padmin_nickname admin.admin_nickname%TYPE := NULL
    , padmin_ID admin.admin_ID%TYPE := NULL 
    , padmin_password admin.admin_password%TYPE := NULL
)
IS
BEGIN
    INSERT INTO admin VALUES (seq_admin_id.NEXTVAL ,padmin_nickname, padmin_id, padmin_password);
--EXCEPTION
END;

EXEC up_insAdmin('관리자4', 'admin9999', '12385');

-- 관리자 정보 수정 프로시저
CREATE OR REPLACE PROCEDURE up_updAdmin
(
    padmin_num admin.admin_num%TYPE 
    , padmin_nickname admin.admin_nickname%TYPE := NULL
    , padmin_ID admin.admin_ID%TYPE := NULL 
    , padmin_password admin.admin_password%TYPE := NULL
)
IS
BEGIN
    UPDATE admin
    SET admin_nickname = NVL(padmin_nickname, admin_nickname)
        , admin_id = NVL(padmin_id, admin_id)
        , admin_password = NVL(padmin_password, admin_password)
    WHERE admin_num = padmin_num;
END;

EXEC up_updAdmin(1, padmin_id => 'admin1241');

SELECT * FROM admin;

ROLLBACK;

-- 관리자 삭제 프로시저

ALTER TABLE admin
DROP CONSTRAINT PK_admin CASCADE;

CREATE OR REPLACE PROCEDURE up_delAdmin
(
    padmin_num admin.admin_num%TYPE
)
IS
BEGIN
    DELETE FROM admin WHERE admin_num = padmin_num;
END;

EXEC up_delAdmin(5);


-- 신고
CREATE OR REPLACE PROCEDURE up_insReport
(
    pf_report_mem_num report.f_report_mem_num%TYPE
    , pt_report_mem_num report.t_report_mem_num%TYPE
    , preport_content report.report_content%TYPE
)
IS
    vreport_num report.report_num%TYPE;
    vf_report_mem_num report.f_report_mem_num%TYPE;
    vt_report_mem_num report.t_report_mem_num%TYPE;
    vadmin_num report.admin_num%TYPE;
    vreport_content report.report_content%TYPE;
BEGIN
    SELECT seq_report_id.NEXTVAL INTO vreport_num FROM DUAL;
    SELECT CEIL(DBMS_RANDOM.VALUE*3) INTO vadmin_num FROM dual;
    INSERT INTO report VALUES(vreport_num, pf_report_mem_num, pt_report_mem_num, vadmin_num, preport_content);
END;

EXEC up_insReport(1, 3 ,'복장불량');

SELECT * FROM report;

-- 차단
-- 차단 추가
CREATE OR REPLACE PROCEDURE up_insBlock
(
    pf_block_mem_num block.f_block_mem_num%TYPE := NULL
    , pt_block_mem_num block.t_block_mem_num%TYPE := NULL
)
IS
    vblock_date block.block_date%TYPE := SYSDATE;
BEGIN
    INSERT INTO block VALUES (pf_block_mem_num, pt_block_mem_num, vblock_date);
END;

EXEC up_insBlock(2, 1);

DELETE FROM block;

SELECT * FROM block;

-- 채팅
CREATE OR REPLACE PROCEDURE delchat
( pchat_room_num chat.chat_room_num%type
)
IS
   -- vchat_room_num chat_board.chat_room_num%type;
BEGIN
    DELETE chat 
    Where chat_room_num = pchat_room_num;
    
    dbms_output.put_line(pchat_room_num || '번 채팅방이 삭제 됐습니다.');
END;

EXEC delchat(1);
ROLLBACK;

SELECT * FROM chat;

-- 채팅 내용
CREATE Or REPLACE PROCEDURE delcontent
( pchat_num chat_board.chat_num%type
)
IS

vchat_num chat_board.chat_num%type;
    
BEGIN
    SELECT MAX(chat_num)
    INTO vchat_num
    FROM chat_board
    WHERE chat_num = pchat_num;

    DELETE 
    FROM CHAT_BOARD
    WHERE chat_num=vchat_num;

--exception

    dbms_output.put_line('마지막 채팅이 삭제됐습니다.');
END;

EXEC delcontent(2);

SELECT * FROM chat_board;

-- 당근페이
-- 회원 당근페이 추가
create or replace PROCEDURE up_insert_danggeun_pay
(
    pmem_num danggeun_pay.member_num%TYPE,
    paccount danggeun_pay.account%TYPE,
    pbank_name danggeun_pay.bank_name%TYPE,
    pbalance danggeun_pay.balance%TYPE
)
IS
    v_count NUMBER;
    v_mem_count NUMBER;
BEGIN
    SELECT COUNT(*)
        INTO v_count
    FROM danggeun_pay
    WHERE member_num = pmem_num;

    SELECT COUNT(*)
        INTO v_mem_count
    FROM member
    WHERE member_num = pmem_num;

    IF v_count = 0 AND v_mem_count = 1
    THEN
    INSERT INTO danggeun_pay
    VALUES ( pmem_num, paccount, pbank_name, pbalance );
    ELSIF v_count = 1 AND v_mem_count = 1
    THEN
    RAISE_APPLICATION_ERROR(-20001, '당근페이에 이미 존재하는 회원의_NUM입니다.');
    ELSIF v_mem_count = 0 
    THEN
    RAISE_APPLICATION_ERROR(-20002, '입력된 회원이 없는 회원입니다.');
    END IF;
EXCEPTION
    WHEN OTHERS 
    THEN RAISE;
END;

EXEC up_insert_danggeun_pay (12, '1002151532', '국민은행', 5000000);

SELECT * FROM danggeun_pay;


-- 당근페이 금액 충전
CREATE OR REPLACE PROCEDURE up_charge_danggeun_pay
(
    pmem_num danggeun_pay.member_num%TYPE,
    pmem_charge_amount danggeun_pay.balance%TYPE
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
        INTO v_count
    FROM danggeun_pay
    WHERE member_num = pmem_num;

    IF v_count = 1 THEN
    UPDATE danggeun_pay
    SET balance = balance + pmem_charge_amount
    WHERE member_num = pmem_num;
    ELSE
    RAISE_APPLICATION_ERROR(-20001, '충전할 당근페이가 없습니다.');
    END IF;
--EXCEPTION 
END;

EXECUTE up_charge_danggeun_pay( 11, 30000);

-- 결제
--pay_num NUMBER : 결제 번호 ( PK )
--chat_room_num NUMBER : 채팅방 번호 ( FK )
--member_num NUMBER : 유저번호1 판매자
--member_num2 NUMBER : 유저번호2 구매자
--pay_date DATE : 송금날짜
--remittance_amount NUMBER : 송금금액
SELECT * FROM chat;


-- 결제 테이블 INSERT
CREATE OR REPLACE PROCEDURE up_insert_pay
(
    p_chat_num chat.chat_room_num%TYPE
)
IS
    vmem_nickname member.member_nickname%TYPE;
    vseller_num trade.member_num%TYPE; -- 판매자
    vbuyer_num chat.buyer_num%TYPE; -- 구매자
    vtrade_num chat.trade_num%TYPE; -- chat에서 trade번호가 있을때
    vbalance danggeun_pay.balance%TYPE;
    vprice NUMBER;
BEGIN
    -- 구매자
    SELECT trade_num, buyer_num
        INTO vtrade_num, vbuyer_num
    FROM chat
    WHERE chat_room_num = p_chat_num;
    
    SELECT balance
        INTO vbalance
    FROM danggeun_pay
    WHERE member_num = vbuyer_num;
    
    SELECT trade_price, member_num 
        INTO vprice, vseller_num
    FROM trade_board
    WHERE trade_num = vtrade_num;
    
    SELECT member_nickname
        INTO vmem_nickname
    FROM member
    WHERE member_num = vbuyer_num;
    
    DBMS_OUTPUT.PUT_LINE ( vmem_nickname );
    DBMS_OUTPUT.PUT_LINE ( vprice || '원');
    DBMS_OUTPUT.PUT_LINE ( '남은금액' || vbalance || '원' );
    DBMS_OUTPUT.PUT_LINE ( '1' || '2' || '3' );
    DBMS_OUTPUT.PUT_LINE ( '4' || '5' || '6' );
    DBMS_OUTPUT.PUT_LINE ( '7' || '8' || '9' );
    DBMS_OUTPUT.PUT_LINE ( ''  || '0' || '<-' );
    
    IF vbalance >= vprice THEN
    INSERT INTO pay ( pay_num, chat_room_num, seller_num, buyer_num, pay_date, remittance_amount )
    VALUES (seq_pay.NEXTVAL, p_chat_num, vseller_num, vbuyer_num, SYSDATE, vprice);
    ELSE 
    RAISE_APPLICATION_ERROR(-06502, '계좌 잔액이 부족합니다.');
    END IF;
--EXCEPTION
END;

EXECUTE up_insert_pay(1);

SELECT * FROM pay;

-- num1은 무조건 판매자 당근페이 금액 ++
-- num2는 무조건 구매자 당근페이 금액 --
CREATE OR REPLACE TRIGGER ut_update_danggeun
AFTER 
INSERT ON pay
FOR EACH ROW
BEGIN

    UPDATE danggeun_pay 
    SET balance = balance + :NEW.remittance_amount
    WHERE member_num = :NEW.seler_num;
    
    UPDATE danggeun_pay
    SET balance = balance - :NEW.remittance_amount
    WHERE member_num = :NEW.buyer_num;
END;


-- 공지사항 게시판
-- 공지사항 게시판 추가
CREATE OR REPLACE PROCEDURE up_insNoticeBoard
(
    padmin_num admin.admin_num%TYPE := NULL
    , pnotice_title notice_board.notice_title%TYPE := NULL
    , pnotice_content notice_board.notice_content%TYPE := NULL
    , pnotice_date notice_board.notice_date%TYPE := SYSDATE
)
IS
BEGIN
    INSERT INTO notice_board VALUES (seq_notice_board_id.NEXTVAL, padmin_num, pnotice_title, pnotice_content, pnotice_date);
END;

EXEC up_insNoticeBoard(3, '게시판에 대한 관리자의 권한 안내', '모든 관리자는 현 시간부로 공지사항을 제외한 모든 게시판에 대한 수정이 불가능 합니다. 관리자 재량껏 불경한 게시판은 삭제부탁드립니다.');

SELECT * FROM notice_board;

-- 공지사항 게시판 수정 프로시저
CREATE OR REPLACE PROCEDURE up_updNoticeBoard
(
    pnotice_num  notice_board.notice_num%TYPE
    , pnotice_title  notice_board.notice_title%TYPE
    , pnotice_content notice_board.notice_content%TYPE
)
IS
BEGIN
    UPDATE notice_board
    SET notice_title = NVL(pnotice_title, notice_title)
        , notice_content = NVL(pnotice_content, notice_content)
    WHERE notice_num = pnotice_num;
END;
--EXCEPTION

EXEC up_updNoticeBoard(3, '진돌님 SQLD 자격증 합격', '진돌님이 모든 참가자를 재끼고 1등하셨습니다!! 축하해주세요!!');


-- 공지사항 게시판 삭제 프로시저
CREATE OR REPLACE PROCEDURE up_delNoticeBoard
(
    pnotice_num notice_board.notice_num%TYPE
)
IS
BEGIN
    DELETE FROM notice_board WHERE notice_num = pnotice_num;
END;

EXEC up_delNoticeBoard (3);

-- 판매물품 카테고리
UPDATE item_ctgr
SET item_ctgr_name = '디지털'
WHERE item_ctgr_num = 1;

SELECT * FROM item_ctgr;
ROLLBACK;

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
,ptrade_title => '에어팟', pupload_date => '24/03/08', ptrade_price => 200000);
END;


-- 중고거래 데이터 삭제
--ALTER TABLE trade_board
--DROP CONSTRAINT PK_TRADEBOARD CASCADE;
--
--SELECT *
--FROM trade_board;
--
--SELECT *
--FROM item_image
--WHERE trade_num = 1;
--
--SELECT *
--FROM trade_board_like
--WHERE trade_num = 1;
--
--DELETE FROM trade_board
--WHERE trade_num = 1;

ROLLBACK;

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
    up_delTradeBoard(ptrade_num => 1, pmember_num => 2);
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

SELECT * FROM item_image;

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
<<<<<<< HEAD
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
--        
    END IF;
--    
    DELETE FROM trade_board_like
    WHERE trade_num IS NULL AND member_num IS NULL;
END;


INSERT INTO trade_board_like(trade_like_num, trade_num, member_num)
VALUES(16, 1, 1);

SELECT * FROM trade_board_like;

DELETE trade_board_like
where trade_like_num = 16;

=======
>>>>>>> f18a682367c179c541f4f956841bc02bba456d54
-- 멤버넘버, 트레이드 넘버 같은거에서 트레이드 보드 라이크 넘버 가져와서 그번호 삭제
CREATE OR REPLACE PROCEDURE up_insert_t_board_like
(

    pt_num NUMBER,
    pmember_num NUMBER
)
IS
    v_count NUMBER;
BEGIN
        SELECT COUNT(*)
            INTO v_count
        FROM trade_board_like
        WHERE trade_num = pt_num AND member_num = pmember_num;
        
        IF v_count = 0 THEN
            INSERT INTO trade_board_like(trade_like_num, trade_num, member_num)
            VALUES(seq_tboard_like.NEXTVAL, 1, 1);
        ELSIF v_count > 0 THEN
            DELETE FROM trade_board_like
            WHERE trade_num = pt_num AND member_num = pmember_num;
--        ELSE
        END IF;
--EXCEPTION
END;

EXECUTE up_insert_t_board_like(1, 1);

SELECT * FROM trade_board_like;

DELETE trade_board_like
where trade_like_num = 16;

ROLLBACK;

-- 매너온도
-- 거래가 이뤄진 사람들(채팅방이 있고, 거래가 완료된 사람들)끼리 매너온도 올리거나 낮출 수 있다.
-- 거래완료 상태를 체크해야할것 같다.
-- 채팅관련해서도 트러블이 있을수 있어서 굳이 거래완료가 아니더라도 채팅을 했으면 매너온도 올리거나 낮추는거 가능한걸로 가면 좋을것같다.
CREATE SEQUENCE seq_manner_points 
INCREMENT BY 1
START WITH 1
NOCYCLE NOCACHE;
--manner_point_num: 매너온도 ( PK )
--chat_room_num : 채팅방 
--manner_points: 매너온도 점수.
--updateDate: 매너온도 업데이트 날짜.
-- 누군가 매너온도를 눌렀을때 어떤 회원의
-- 1 -> 2번의 매너온도 눌렀다.
-- 매개변수 2개주고
-- 1번과 2번의 pay게시판이 생성이 되어 있는지 확인
-- 있으면 온도 올려주는 INSERT하고 회원 매너온도 테이블에서 UPDATE트리거 작동

-- 매너온도 테이블에 press_mem_num, compress_mem_num 추가할 데이터
-- 매너온도 ++ 해주는 로직 ( -- 하는 로직은 생각해 봐야할듯 )
CREATE OR REPLACE PROCEDURE up_insert_manner_points
(
    p_chat_room_num pay.chat_room_num%TYPE,
    p_press_mem_num  NUMBER,        --매너온도 누른사람
    p_compress_mem_num NUMBER       --매너온도 눌러진 사람
)
IS
    v_p_count NUMBER;
    v_m_count NUMBER;
    vmem_manner_points member.member_manner_points%TYPE;
BEGIN
    
    SELECT member_manner_points
        INTO vmem_manner_points
    FROM member
    WHERE member_num = p_compress_mem_num;
    
    SELECT COUNT(*)
        INTO v_m_count
    FROM manner_points
    WHERE chat_room_num = p_chat_room_num AND press_mem_num = p_press_mem_num;
    
    SELECT COUNT(*)
        INTO v_p_count
    FROM pay
    WHERE (buyer_num = p_press_mem_num AND seller_num = p_compress_mem_num) OR
          (buyer_num = p_compress_mem_num AND seller_num = p_press_mem_num);
          
    IF v_m_count = 0 AND v_p_count = 1 THEN
    INSERT INTO manner_points ( manner_points_num, chat_room_num, press_mem_num, compress_mem_num, manner_points, update_date )
    VALUES ( seq_manner_points.NEXTVAL, p_chat_room_num, p_press_mem_num , p_compress_mem_num, vmem_manner_points+(vmem_manner_points*0.025)  ,SYSDATE );
    ELSE
    RAISE_APPLICATION_ERROR(-20001, '이미 매너온도를 평가한 회원입니다.');
    END IF;
--EXCEPTION
END;

SELECT * FROM chat;

CREATE OR REPLACE TRIGGER ut_update_mem_manner
AFTER
INSERT ON manner_points
FOR EACH ROW
BEGIN
    UPDATE member
    SET member_manner_points = :NEW.manner_points
    WHERE member_num = :NEW.compress_mem_num;
END;

SELECT * FROM member;
SELECT * FROM manner_points;

EXEC up_insert_manner_points( 1, 2, 1);
EXECUTE up_insert_pay(6);
EXECUTE up_select_mpage(1);

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
-- 
END ;

EXEC UP_INSCOMMCTAR(10, '가전제품');

SELECT * FROM comm_ctgr;

DELETE FROM comm_ctgr WHERE comm_ctgr_num = 10;

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

EXEC up_updcommctgr(1, '인기');

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

EXEC up_delcommctgr(1);


-- 동네생활 게시판


-- 동네생활 댓글
-- 동네생활 댓글 추가
CREATE OR REPLACE PROCEDURE add_comment(
    p_board_num IN NUMBER,
    p_member_num IN NUMBER,
    p_content IN VARCHAR2,
    pcomm_num NUMBER
    ) -- 댓글 추가에 대한 매개변수
AS
BEGIN
    -- 새로운 댓글 INSERT
    INSERT INTO comm_cmt VALUES (p_board_num, pcomm_num, p_member_num, SYSDATE, p_content);
END;

EXEC add_comment(1, 2, '집가고싶다', 20);

SELECT * FROM comm_cmt;

-- 동네생활 댓글 삭제
CREATE OR REPLACE PROCEDURE up_delcmt
(
    p_comm_board_num comm_cmt.comm_board_num%TYPE := NULL
)
IS
  v_rows_deleted INTEGER;
BEGIN
    DELETE FROM comm_cmt WHERE comm_board_num = p_comm_board_num;

    v_rows_deleted := SQL%ROWCOUNT;

    IF v_rows_deleted > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_rows_deleted || '개의 댓글이 삭제되었습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('삭제할 댓글이 없습니다.');
    END IF;
END;

EXEC up_delcmt(10);

-- 동네생활 댓글 수정
CREATE OR REPLACE PROCEDURE up_updCmt
(
  -- 입력 매개변수 이름 변경 (comm_cmt 컬럼과 구분)
  pcomm_board_num NUMBER,
  pcomm_num NUMBER,
  p_new_date comm_cmt.comm_date%TYPE := SYSDATE,
  p_new_content comm_cmt.comm_content%TYPE := NULL
)
IS
BEGIN
  -- UPDATE 구문 수정 (comm_board_num 1회만 설정)
  UPDATE comm_cmt
  SET comm_content = NVL(p_new_content, comm_content)
  WHERE comm_board_num = pcomm_board_num;
END;

EXEC up_updCmt( 1, p_new_content => '내용 수정' )

-- 동네생활 대댓글
-- 2-1. 동네생활 대댓글 추가
CREATE OR REPLACE PROCEDURE add_reply(
    p_board_num IN NUMBER,
    p_comm_num IN NUMBER,
    p_member_num IN NUMBER,
    p_content IN VARCHAR2) -- 대댓글 추가에 대한 각 매개변수
AS
BEGIN
    -- 새로운 대댓글 추가(INSERT문)
    INSERT INTO cmt_reply (
        cmt_board_num,
        comm_num,
        member_num,
        rcmt_content)
    -- 대댓글 추가에 대한 값
    VALUES (
        p_board_num,
        p_comm_num,
        p_member_num,
        p_content);
END;

EXEC add_reply()

-- 대댓글 수정
CREATE OR REPLACE PROCEDURE up_insrely
(
    p_new_rcmt_num cmt_reply.rcmt_num%TYPE := NULL,
    p_new_member_num cmt_reply.member_num%TYPE := NULL,
    p_new_rcmt_date cmt_reply.rcmt_date%TYPE := NULL,
    p_new_rcmt_content cmt_reply.rcmt_content%TYPE := NULL
)
IS
BEGIN
    UPDATE cmt_reply
    SET rcmt_num = NVL(p_new_rcmt_num, rcmt_num),
        member_num = NVL(p_new_member_num, member_num),
        rcmt_date = NVL(p_new_rcmt_date, rcmt_date),
        rcmt_content = NVL(p_new_rcmt_content, rcmt_content)
    WHERE rcmt_num = p_new_rcmt_num;
END;
EXEC up_insrely();

-- 동네생활 게시판 좋아요
-- 추가/삭제
SELECT * FROM comm_board_like ;
-- up_udtcmtreplylike 게시판좋아요 추가 (완료)
CREATE OR REPLACE PROCEDURE up_insboardlike
(
    pcomm_like_num  comm_board_like.comm_like_num%TYPE
    , pmember_num   comm_board_like.member_num%TYPE
    , pcomm_board_num     comm_board_like.comm_board_num%TYPE
)
IS
    vrow comm_board_like%ROWTYPE;
BEGIN
    --PLS-00103: Encountered the symbol "DISTINCT" when expecting one of the following:
    select * into vrow
    from comm_board_like where member_num != pmember_num and comm_board_num = pcomm_board_num ;
    
    INSERT INTO comm_board_like ( comm_like_num, member_num, comm_board_num )
    values (pcomm_like_num, pmember_num, pcomm_board_num );
    commit;
    
    DBMS_OUTPUT.PUT_LINE('동네생활 게시판 좋아요 넘버: ' || pcomm_like_num || ', ' || '회원 넘버 : ' || pmember_num
                        || ', ' || '동네생활 게시판 넘버: ' || ', ' || pcomm_board_num );
--EXCEPTION
END;

EXEC up_insboardlike()

--select * 
--from comm_board_like where member_num != 1 and comm_board_num = 1 ;
--exec up_insboardlike ( 20, 2, 1);

--up_delcmtreplylike 게시판좋아요 삭제 ( 완료 )
CREATE OR REPLACE PROCEDURE up_delboardlike
(
    pcomm_like_num  comm_board_like.comm_like_num%TYPE
    , pmember_num   comm_board_like.member_num%TYPE
    , pcomm_board_num     comm_board_like.comm_board_num%TYPE
)
IS
    vrow comm_board_like%ROWTYPE;
BEGIN   
    
    SELECT * INTO vrow
    from comm_board_like where member_num = pmember_num and comm_like_num = pcomm_like_num ;
    
    DELETE FROM comm_board_like
    where member_num = pmember_num ;
    commit ;
--EXCEPTION
END;


SELECT * FROM comm_board_like ;

--
EXEC up_delboardlike( 14, 1, 1);
--
--DESC comm_board_like;
--SELECT * FROM comm_board_like WHERE COMM_BOARD_NUM = 1;
--INSERT INTO comm_board_like VALUES (15,2,1 );

-- 동네생활 댓글 좋아요


-- 동네생활 대댓글 좋아요
-- 추가/삭제
SELECT * FROM cmt_reply_like ;
DESC cmt_reply_like;

-- 동네생활 대댓글 좋아요
---- 추가/삭제
-- up_inscmtreplylike 대댓글좋아요 추가
CREATE OR REPLACE PROCEDURE up_inscmtreplylike
(
    prcmt_like_num  cmt_reply_like.rcmt_like_num%TYPE
    , pmember_num   cmt_reply_like.member_num%TYPE
    , prcmt_num     cmt_reply_like.rcmt_num%TYPE
)
IS
    vrlrow cmt_reply_like%ROWTYPE;
    select * into vrlrow
    from cmt_reply_like where member_num != pmember_num and rcmt_num = prcmt_num
                       
BEGIN
      
    INSERT INTO cmt_reply_like ( rcmt_like_num, member_num, rcmt_num )
    values (prcmt_like_num, pmember_num, prcmt_num );
    commit;
    
--    DBMS_OUTPUT.PUT_LINE('동네생활 대댓글 좋아요 넘버: ' || prcmt_like_num || ', ' || '회원 넘버 : ' || pmember_num
--                        || ', ' || '동네생활 대댓글 넘버: ' || ', ' || prcmt_num );
    
--EXCEPTION
END;

--EXEC up_inscmtreplylike(20, 2, 1);
--select * from cmt_reply_like;
--delete from cmt_reply_like where rcmt_like_num = 23;
--select * 
--from cmt_reply_like where member_num != 2 and rcmt_num = 1 ;
--up_delcmtreplylike 대댓글좋아요 삭제
CREATE OR REPLACE PROCEDURE up_delcmtreplylike
(
    prcmt_like_num  cmt_reply_like.rcmt_like_num%TYPE
    , pmember_num   cmt_reply_like.member_num%TYPE
    , prcmt_num     cmt_reply_like.rcmt_num%TYPE
)
IS
    vrlrow cmt_reply_like%ROWTYPE;
BEGIN
    SELECT * INTO vrow
    from comm_board_like where member_num = pmember_num and rcmt_num = prcmt_num ;
    
    DELETE FROM cmt_reply_like
    where member_num = pmember_num ;
    commit ;
    
--EXCEPTION
END;

--EXEC up_delcmtreplylike(19, 5, 1);
--SELECT * FROM cmt_reply_like;
