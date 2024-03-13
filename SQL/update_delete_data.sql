-- SCOTT
-- 데이터 추가/수정/삭제

----------------------------------- 회원 ---------------------------------------
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

EXECUTE up_insert_member( '000608', '유진', '서울시', '010-3111-2222', 'https://image.newsis.com/2012/05/25/NISI20120525_0006401508_web.jpg');

-- 회원 수정
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
    DBMS_OUTPUT.PUT_LINE( '회원 수정 완료');
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, '업데이트할 회원이 존재하지 않는다.');
END;

EXEC up_update_member (21, pmem_nickname => '유진');
EXEC up_update_member (21, pmem_addr => '대전 is good');
EXEC up_update_member (21, pmem_tel => '010-4151-2151');
EXEC up_update_member (21, pmem_profile => 'http://image.fgblkgfblkmgfbkl');

SELECT * FROM member;


-- 회원 삭제
ALTER TABLE member
DROP CONSTRAINT PK_member CASCADE;

EXECUTE up_delmember(1);

CREATE OR REPLACE PROCEDURE up_delmember
(
    pmem_num NUMBER
)
IS
BEGIN
    
    -- danggeun_pay 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM danggeun_pay
    WHERE member_num = pmem_num;
    
    -- block 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM block
    WHERE t_block_mem_num = pmem_num OR f_block_mem_num = pmem_num;  
    
    -- trade_board_like 테이블 해당 member 대응하는 데이터 삭제
    DELETE FROM trade_board_like
    WHERE member_num = pmem_num;   

    -- pay 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM pay
    WHERE seller_num = pmem_num AND buyer_num = pmem_num;        
    
    -- manner_points 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM manner_points
    WHERE press_mem_num = pmem_num OR compress_mem_num = pmem_num;   
    
    -- comm_reply_like 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM cmt_reply_like
    WHERE member_num = pmem_num;
    
    -- comm_reply 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM cmt_reply 
    WHERE member_num = pmem_num;
      
    -- comm_cmt 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM comm_cmt
    WHERE member_num = pmem_num;
    
    -- comm_cmt_like 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM comm_cmt_like
    WHERE member_num = pmem_num;

    -- comm_board_lik 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM comm_board_like
    WHERE member_num = pmem_num;
    
    -- comm_board 테이블에서 해당 member 대응하는 데이터 삭제
    DELETE FROM comm_board
    WHERE member_num = pmem_num;    
    
    -- report 테이블 해당 member 대응하는 데이터 삭제
    DELETE FROM report
    WHERE t_report_mem_num = pmem_num OR f_report_mem_num = pmem_num;    

    -- chat 테이블 해당 member 대응하는 데이터 삭제
    DELETE FROM chat
    WHERE buyer_num = pmem_num;       
    
    -- trade_board 테이블 해당 member 대응하는 데이터 삭제
    DELETE FROM trade_board
    WHERE member_num = pmem_num;  
    
    -- trade_board 테이블 해당 member 대응하는 데이터 삭제
    DELETE FROM member
    WHERE member_num = pmem_num;      
END;

EXEC up_delmember(1);

SELECT * FROM member;
SELECT * FROM trade_board;
SELECT * FROM chat;

--------------------------------------------------------------------------------



--------------------------------- 매너온도 --------------------------------------
CREATE SEQUENCE seq_manner_points
INCREMENT BY 1
START WITH 1
NOCYCLE NOCACHE;

-- 매너온도 추가(평가)
CREATE OR REPLACE PROCEDURE up_insert_manner_points
(
    ppay_num NUMBER,
    p_chat_room_num pay.chat_room_num%TYPE,
    p_press_mem_num  NUMBER,        --매너온도 누른사람
    p_compress_mem_num NUMBER,       --매너온도 눌러진 사람
    p_평가 VARCHAR2
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
    WHERE (buyer_num = p_press_mem_num AND seller_num = p_compress_mem_num AND pay_num = ppay_num ) OR
          (buyer_num = p_compress_mem_num AND seller_num = p_press_mem_num AND pay_num = ppay_num);
          
    IF v_m_count = 0 AND v_p_count = 1 AND p_평가 LIKE '긍정' THEN
    INSERT INTO manner_points ( manner_points_num, chat_room_num, press_mem_num, compress_mem_num, manner_points, update_date )
    VALUES ( seq_manner_points.NEXTVAL, p_chat_room_num, p_press_mem_num, p_compress_mem_num, vmem_manner_points+(vmem_manner_points*0.025)  ,SYSDATE );
    ELSIF v_m_count = 0 AND v_p_count = 1 AND p_평가 LIKE '부정' THEN
    INSERT INTO manner_points ( manner_points_num, chat_room_num, press_mem_num, compress_mem_num, manner_points, update_date )
    VALUES ( seq_manner_points.NEXTVAL, p_chat_room_num, p_press_mem_num, p_compress_mem_num, vmem_manner_points-(vmem_manner_points*0.025)  ,SYSDATE );
    ELSIF v_p_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, '거래를 진행하지 않은 유저는 매너온도 평가할 수 없습니다.');
    ELSE
    RAISE_APPLICATION_ERROR(-20001, '이미 매너온도를 평가한 회원입니다.');
    END IF;
--EXCEPTION
END;


-- 매너온도 평가 시 작동되는 트리거
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
SELECT * FROM chat;
SELECT * FROM trade_board;
SELECT * FROM pay;

EXEC up_insert_manner_points(3, 3, 1, 2, '부정');


EXEC up_insert_manner_points( 1, 2, 1);
EXECUTE up_insert_pay(6);
EXECUTE up_select_mpage(1);

--------------------------------------------------------------------------------



-------------------------------- 당근페이 ---------------------------------------
-- 회원 당근페이 추가
CREATE OR REPLACE PROCEDURE up_insert_danggeun_pay
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
EXECUTE up_charge_danggeun_pay( 12, -1020000);

--------------------------------------------------------------------------------



-------------------------------- 결제 ------------------------------------------
-- 결제 테이블 INSERT
CREATE OR REPLACE PROCEDURE up_insert_pay
(
    p_chat_num chat.chat_room_num%TYPE
)
IS
    vmem_nickname member.member_nickname%TYPE;
    vseller_num NUMBER; -- 판매자
    vbuyer_num chat.buyer_num%TYPE; -- 구매자
    vtrade_num chat.trade_num%TYPE; -- chat에서 trade번호가 있을때
    vbalance danggeun_pay.balance%TYPE;
    vprice NUMBER;
    c_count NUMBER;
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
    
    SELECT COUNT( * )
        INTO c_count
    FROM pay
    WHERE chat_room_num = p_chat_num;
    
    IF c_count >= 1 THEN
    RAISE_APPLICATION_ERROR(-20001, '이미 완료된 거래입니다.');
    ELSIF vbalance >= vprice THEN
    INSERT INTO pay ( pay_num, chat_room_num, seller_num, buyer_num, pay_date, remittance_amount )
    VALUES (seq_pay.NEXTVAL, p_chat_num, vseller_num, vbuyer_num, SYSDATE, vprice);
    ELSE
    RAISE_APPLICATION_ERROR(-20002, '계좌 잔액이 부족합니다.');
    END IF;
        
    DBMS_OUTPUT.PUT_LINE ( '닉네임 : ' || vmem_nickname );
    DBMS_OUTPUT.PUT_LINE ( '금액 : ' || vprice || '원');
    DBMS_OUTPUT.PUT_LINE ( '잔액' || vbalance || '원' );
    DBMS_OUTPUT.PUT_LINE ( '  1  ' || '  2  ' || '  3  ' );
    DBMS_OUTPUT.PUT_LINE ( '  4  ' || '  5  ' || '  6  ' );
    DBMS_OUTPUT.PUT_LINE ( '  1  ' || '  2  ' || '  3  ' );
    DBMS_OUTPUT.PUT_LINE ( ' 만원  ' || ' 0  ' || '  <-  ' );
    
--EXCEPTION
END;


EXECUTE up_insert_pay(4);
SELECT * FROM chat;  
SELECT * FROM trade_board; 
SELECT * FROM pay;
SELECT * FROM danggeun_pay; 
EXECUTE up_insert_pay(1);

-- 당근페이 수정
CREATE OR REPLACE TRIGGER ut_update_danggeun
AFTER 
INSERT ON pay
FOR EACH ROW
BEGIN
    UPDATE danggeun_pay 
    SET balance = balance + :NEW.remittance_amount
    WHERE member_num = :NEW.seller_num;
    
    UPDATE danggeun_pay
    SET balance = balance - :NEW.remittance_amount
    WHERE member_num = :NEW.buyer_num;
END;

--------------------------------------------------------------------------------



--------------------------------- 관리자 ---------------------------------------
-- 관리자 추가 
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

EXEC up_insAdmin('관리자5', 'admin9899', '12342385');

-- 관리자 수정
CREATE OR REPLACE PROCEDURE up_updAdmin
(
    padmin_num admin.admin_num%TYPE 
    , padmin_nickname admin.admin_nickname%TYPE := NULL
    , padmin_ID admin.admin_ID%TYPE := NULL 
    , padmin_password admin.admin_password%TYPE := NULL
)
IS
    vadmin_num admin.admin_num%TYPE;
BEGIN
    SELECT admin_num INTO vadmin_num
    FROM admin
    WHERE admin_num = padmin_num;

    UPDATE admin
    SET admin_nickname = NVL(padmin_nickname, admin_nickname)
        , admin_id = NVL(padmin_id, admin_id)
        , admin_password = NVL(padmin_password, admin_password)
    WHERE admin_num = padmin_num;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20014, '존재하지 않는 관리자 번호입니다.');
END;

EXEC up_updAdmin(2, padmin_nickname => '유진2');
EXEC up_updAdmin(2, padmin_id => 'yuejin');
EXEC up_updAdmin(2, padmin_password => 01040457834);

-- 관리자 로그, 수정사항 정보 테이블
CREATE TABLE admin_log_info
(
    memo VARCHAR(1000)
    , log_date DATE DEFAULT SYSDATE
);

-- 관리자의 수정사항(생성, 수정)조회를 위한 트리거
CREATE OR REPLACE TRIGGER ut_AdminLogInfo
AFTER
INSERT OR UPDATE OR DELETE ON admin
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO admin_log_info (memo) VALUES ('[' || :NEW.admin_id || '] -> 관리자 생성');
    ELSIF UPDATING THEN 
        IF :OLD.admin_nickname != :NEW.admin_nickname THEN
            INSERT INTO admin_log_info (memo) VALUES ('관리자의 닉네임정보 [' || :OLD.admin_nickname || '->' || :NEW.admin_nickname || '] 변경');
        ELSIF :OLD.admin_id != :NEW.admin_id THEN
            INSERT INTO admin_log_info (memo) VALUES ('[' || :OLD.admin_nickname || '] 의 관리자 ID가 [' || :OLD.admin_id || '->' || :NEW.admin_id || '] 변경');
        ELSIF :OLD.admin_password != :NEW.admin_password THEN
            INSERT INTO admin_log_info (memo) VALUES ('[' || :OLD.admin_nickname || '] 의 관리자 비밀번호가 [' || :OLD.admin_password || '->' || :NEW.admin_password || '] 변경');
        END IF;
    END IF;
--EXCEPTION
END;

-- 관리자의 모든 수정사항 조회를 위한 프로시저
CREATE OR REPLACE PROCEDURE up_AdminLogInfo
IS
    vmemo admin_log_info.memo%TYPE;  
BEGIN
    SELECT memo INTO vmemo 
    FROM admin_log_info 
    WHERE ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE('--> Admin Log File <--');
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM admin_log_info)
        LOOP
            DBMS_OUTPUT.PUT_LINE('About Admin Log : ' || vrow.memo);
            DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20015, '수정된 기록이 없습니다.');
END;

EXEC up_AdminLogInfo;

-- 회원 로그, 수정사항 정보 테이블
CREATE TABLE member_log_info
(
    memo VARCHAR2(1000)
    , log_date DATE DEFAULT SYSDATE
);

-- [관리자 권한] 회원의 모든 수정사항(생성, 삭제, 수정)조회를 위한 트리거 
CREATE OR REPLACE TRIGGER ut_MemberLogInfo
AFTER
INSERT OR UPDATE OR DELETE ON member
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO member_log_info (memo) VALUES ( '[' || :NEW.member_nickname || ']' || ' -> 생성');
    ELSIF UPDATING THEN 
        IF :OLD.member_nickname != :NEW.member_nickname THEN
            INSERT INTO member_log_info (memo) VALUES ( '[' || :OLD.member_nickname || ']' || '님의 이름정보가 ' || '[' || :OLD.member_nickname || ' -> ' || :NEW.member_nickname || ']' || '  변경');
        ELSIF :OLD.member_tel != :NEW.member_tel THEN
            INSERT INTO member_log_info (memo) VALUES ( '[' || :OLD.member_nickname || ']' || '님의 전화번호가 ' || '[' || :OLD.member_tel || ' -> ' || :NEW.member_tel || ']' || ' 변경');
        ELSIF :OLD.member_address != :NEW.member_address THEN
            INSERT INTO member_log_info (memo) VALUES (  '[' || :OLD.member_nickname || ']' || '님의 주소가 ' || '[' || :OLD.member_address || ' -> ' || :NEW.member_address || ']' || ' 변경');
        ELSIF :OLD.member_profile != :NEW.member_profile THEN
            INSERT INTO member_log_info (memo) VALUES ( '[' || :OLD.member_nickname || ']' || '님의 프로필 이미지가 ' || '[' || :OLD.member_profile || ' -> ' || :NEW.member_profile || ']' || ' 변경');
        END IF;
    ELSIF DELETING THEN 
        INSERT INTO member_log_info (memo) VALUES ( :OLD.member_nickname || ' -> 삭제');
    END IF;
--EXCEPTION
END;

-- [관리자 권한] 회원의 모든 수정정보 조회를 위한 프로시저
CREATE OR REPLACE PROCEDURE up_MemberLogInfo
IS
    vmemo member_log_info.memo%TYPE DEFAULT NULL;
BEGIN
    SELECT memo INTO vmemo 
    FROM member_log_info 
    WHERE ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('--> MEMBER LOG FILE <--');
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM member_log_info)
        LOOP
            DBMS_OUTPUT.PUT_LINE('About Member Log : ' || vrow.memo);
            DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20014, '수정된 내용이 없습니다.');
END;

EXEC up_MemberLogInfo;

-- 공지사항 게시판 수정사항 정보테이블
CREATE TABLE NoticeBoard_log_info
(
    memo VARCHAR2(1000)
    , log_date DATE DEFAULT SYSDATE
);

-- [관리자 권한] 공지사항 게시판의 모든 수정사항 조회를 위한 트리거
CREATE OR REPLACE TRIGGER ut_NoticeBoardLogInfo
AFTER
INSERT OR UPDATE OR DELETE ON notice_board
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO NoticeBoard_log_info (memo) VALUES ( '[' ||  :NEW.notice_title || ']' || ' -> 게시판 생성');
    ELSIF UPDATING THEN 
        IF :OLD.notice_title != :NEW.notice_title THEN
            INSERT INTO NoticeBoard_log_info (memo) VALUES ( '[' || :OLD.notice_title || ' -> ' || :NEW.notice_title || ']' || ' 게시판 이름 변경');
        ELSIF :OLD.notice_content != :NEW.notice_content THEN
            INSERT INTO NoticeBoard_log_info (memo) VALUES ( '[' || :OLD.notice_content || ' -> ' || :NEW.notice_content || ']' || ' 게시판 내용 변경');
        END IF;
    ELSIF DELETING THEN 
        INSERT INTO NoticeBoard_log_info (memo) VALUES ( '[' || :OLD.notice_title || ']' || ' -> 게시판 삭제');
    END IF;
--EXCEPTION
END;

-- [관리자 권한] 공지사항 게시판의 모든 수정사항 조회 프로시저
CREATE OR REPLACE PROCEDURE up_NoticeBoardLogInfo
IS
    vmemo NoticeBoard_log_info.memo%TYPE;
BEGIN
    SELECT memo INTO vmemo 
    FROM noticeboard_log_info 
    WHERE ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE('--> Notice Board Log File <--');
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM NoticeBoard_log_info)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ABout NoticeBoard Log : ' || vrow.memo);
        DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20014, '수정된 게시판이 없습니다.');
END;
    
EXEC up_NoticeBoardLogInfo;

--------------------------------------------------------------------------------



-------------------------------- 신고 ------------------------------------------
-- 신고 추가
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

--------------------------------------------------------------------------------



--------------------------------- 차단 -----------------------------------------
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

--------------------------------------------------------------------------------



---------------------------------- 채팅 ----------------------------------------
-- 채팅 삭제
CREATE OR REPLACE PROCEDURE delchat
( 
    pchat_room_num chat.chat_room_num%type
)
IS
BEGIN
    DELETE chat 
    WHERE chat_room_num = pchat_room_num;
    
    dbms_output.put_line(pchat_room_num || '번 채팅방이 삭제 됐습니다.');
END;

EXEC delchat(1);


-- 채팅 내용 삭제
CREATE OR REPLACE PROCEDURE delcontent
(
    pchat_num chat_board.chat_num%type
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

--EXCEPTION

    dbms_output.put_line('마지막 채팅이 삭제됐습니다.');
END;

EXEC delcontent(2);

--------------------------------------------------------------------------------



----------------------------- 공지사항 게시판 -----------------------------------
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

-- 공지사항 게시판 수정
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


-- 공지사항 게시판 삭제
CREATE OR REPLACE PROCEDURE up_delNoticeBoard
(
    pnotice_num notice_board.notice_num%TYPE
)
IS
BEGIN
    DELETE FROM notice_board WHERE notice_num = pnotice_num;
END;

EXEC up_delNoticeBoard (3);

--------------------------------------------------------------------------------



------------------------- 판매물품 카테고리 수정 --------------------------------
UPDATE item_ctgr
SET item_ctgr_name = '디지털'
WHERE item_ctgr_num = 1;

--------------------------------------------------------------------------------



------------------------------- 상품 이미지 -------------------------------------
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

--------------------------------------------------------------------------------



---------------------------- 중고거래 게시판 ------------------------------------
-- 중고거래 게시판 수정
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
    up_updtradeboard(1, pmember_num => 2
    ,ptrade_title => '에어팟', pupload_date => '24/03/08', ptrade_price => 200000);
END;

-- 중고거래 게시판 삭제
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

-- 중고거래 게시판 삭제 트리거
CREATE OR REPLACE TRIGGER ut_del_related_trade_board
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

--------------------------------------------------------------------------------



--------------------------- 중고거래 게시판 좋아요 ------------------------------
-- 추가/삭제
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

--------------------------------------------------------------------------------



--------------------------- 동네생활 카테고리 -----------------------------------
-- 동네생활 카테고리 추가
CREATE OR REPLACE PROCEDURE UP_INSCOMMCTGR
(
    pcomm_ctgr_num   comm_ctgr.comm_ctgr_num%TYPE 
    , pcomm_ctgr_name  comm_ctgr.comm_ctgr_name%TYPE 
)
IS
BEGIN
    INSERT INTO comm_ctgr ( comm_ctgr_num, comm_ctgr_name )
    VALUES (pcomm_ctgr_num, pcomm_ctgr_name );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('카테고리번호: ' || pcomm_ctgr_num || ', ' || '카테고리이름 : ' || pcomm_ctgr_name );
-- 
END ;

EXEC UP_INSCOMMCTGR(10, '가전제품');

-- 동네생활 카테고리 수정
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

-- 동네생활 카테고리 삭제
CREATE OR REPLACE PROCEDURE up_delcommctgr
(
    pcomm_ctgr_num NUMBER
)
IS
BEGIN
    DELETE FROM comm_ctgr
    WHERE comm_ctgr_num = pcomm_ctgr_num ;
    COMMIT ;
--EXCEPTION
END;

EXEC up_delcommctgr(1);

--------------------------------------------------------------------------------



------------------------------- 동네생활 게시판 ---------------------------------
-- 동네생활 게시판 수정
CREATE OR REPLACE PROCEDURE up_updCommBoard(
    pcomm_board_num IN NUMBER
    ,pmember_num IN NUMBER
    ,pcomm_ctgr_num IN NUMBER DEFAULT NULL
    ,pcomm_title IN comm_board.comm_title%TYPE := NULL
    ,pcomm_content comm_board.comm_content%TYPE := NULL
    ,pcomm_upload_date IN DATE DEFAULT TO_DATE(SYSDATE, 'YY-MM-DD')
)
IS
    vmember_num comm_board.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
    SELECT member_num INTO vmember_num
    FROM comm_board
    WHERE comm_board_num = pcomm_board_num;

    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;

    UPDATE comm_board
    SET comm_title = NVL(pcomm_title, comm_title)
        ,comm_ctgr_num = NVL(pcomm_ctgr_num, comm_ctgr_num)
        ,comm_content = NVL(pcomm_content, comm_content)
        ,comm_upload_date = pcomm_upload_date
    WHERE comm_board_num = pcomm_board_num;
    
    
    DBMS_OUTPUT.PUT_LINE('수정 완료');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Comm board number ' || pcomm_board_num || ' does not exist.');
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match.'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;

BEGIN
    up_updCommBoard(pcomm_board_num => 1, pmember_num => 9, pcomm_title => '제목 수정');
END;


-- 동네생활 게시판 삭제
SELECT * FROM comm_board;
CREATE OR REPLACE PROCEDURE up_delCommBoard(
    pcomm_board_num IN NUMBER
    ,pmember_num IN NUMBER
)
IS
    vmember_num comm_board.member_num%TYPE;
    MEMBER_NOT_MATCHED EXCEPTION;
BEGIN
    -- 해당 trade_num에 대한 member_num 값을 가져옵니다.
    SELECT member_num INTO vmember_num
    FROM comm_board
    WHERE comm_board_num = pcomm_board_num;

    IF vmember_num != pmember_num THEN
        RAISE MEMBER_NOT_MATCHED;
    END IF;

    DELETE comm_board
    WHERE comm_board_num = pcomm_board_num;
        

    DBMS_OUTPUT.PUT_LINE('삭제 완료');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Comm board number ' || pcomm_board_num || ' does not exist.');
    WHEN MEMBER_NOT_MATCHED THEN
        DBMS_OUTPUT.PUT_LINE('Member number ' || pmember_num || ' does not match.'); 
END;

-- 동네생활 게시판 삭제 트리거 (1번 게시판 삭제시 댓글까지 같이 DELETE)
CREATE OR REPLACE TRIGGER ut_del_related_comm_board
BEFORE DELETE ON comm_board
FOR EACH ROW
BEGIN
    DELETE FROM cmt_reply_like
    WHERE rcmt_num = (SELECT rcmt_num FROM cmt_reply WHERE cmt_board_num = :OLD.comm_board_num);

    DELETE FROM cmt_reply
    WHERE cmt_board_num = :OLD.comm_board_num;
    
    DELETE FROM comm_cmt_like
    WHERE comm_board_num = :OLD.comm_board_num;
    
    DELETE FROM comm_cmt
    WHERE comm_board_num = :OLD.comm_board_num;
    
    DELETE FROM comm_board_like
    WHERE comm_board_num = :OLD.comm_board_num;
    
END;

BEGIN
    up_delCommBoard(pcomm_board_num => 1, pmember_num => 1);
END;

--------------------------------------------------------------------------------



------------------------ 동네생활 게시판 좋아요 ---------------------------------
-- 동네생활 게시판 좋아요 추가/삭제

CREATE OR REPLACE PROCEDURE up_insdelboardlike
(
    pcomm_like_num  comm_board_like.comm_like_num%TYPE
    , pmember_num   comm_board_like.member_num%TYPE
    , pcomm_board_num     comm_board_like.comm_board_num%TYPE
)
IS
    cnt_boardlike NUMBER;
BEGIN
    SELECT COUNT(comm_like_num) INTO cnt_boardlike
    FROM comm_board_like 
    WHERE member_num = pmember_num AND comm_board_num = pcomm_board_num ;
    
    IF cnt_boardlike < 1 THEN 
        INSERT INTO comm_board_like VALUES (pcomm_like_num, pmember_num, pcomm_board_num) ;
    ELSIF cnt_boardlike = 1 THEN
        DELETE FROM comm_board_like WHERE member_num = pmember_num;
    END IF; 
    
    COMMIT;
    
--EXCEPTION
END;

EXEC up_insboardlike ( 14, 8, 11 );

--------------------------------------------------------------------------------



------------------------------- 동네생활 댓글 -----------------------------------
-- 동네생활 댓글 수정
CREATE OR REPLACE PROCEDURE up_updcmt
(
    p_comm_board_num comm_cmt.comm_board_num%TYPE := NULL,
    p_comm_num comm_cmt.comm_num%TYPE := NULL,
    p_member_num comm_cmt.member_num%TYPE := NULL,
    p_comm_date comm_cmt.comm_date%TYPE := NULL,
    p_comm_content comm_cmt.comm_content%TYPE := NULL
)
IS
  v_rows_updated INTEGER;
BEGIN
    UPDATE comm_cmt
    SET comm_board_num = NVL(p_comm_board_num, comm_board_num),
        comm_num = NVL(p_comm_num, comm_num),
        member_num = NVL(p_member_num, member_num),
        comm_date = NVL(p_comm_date, comm_date),
        comm_content = NVL(p_comm_content, comm_content)
    WHERE comm_num = p_comm_num AND comm_board_num = p_comm_board_num;

    v_rows_updated := SQL%ROWCOUNT;

    IF v_rows_updated > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_rows_updated || '개의 댓글이 수정되었습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('수정할 댓글이 없습니다.');
    END IF;
END;
EXEC up_updcmt(21, 23, 30, SYSDATE, '수정된 댓글 내용입니다.');

-- 동네생활 댓글 삭제
CREATE OR REPLACE PROCEDURE up_delcmt
(
    p_comm_board_num comm_cmt.comm_board_num%TYPE := NULL
)
IS
  v_rows_deleted INTEGER;
BEGIN
    -- 자식 레코드(대댓글) 삭제
    DELETE FROM cmt_reply WHERE comm_board_num = p_comm_board_num;

    -- 부모 레코드(댓글) 삭제
    DELETE FROM comm_cmt WHERE comm_board_num = p_comm_board_num;

    v_rows_deleted := SQL%ROWCOUNT;

    IF v_rows_deleted > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_rows_deleted || '개의 댓글이 삭제되었습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('삭제할 댓글이 없습니다.');
    END IF;
END;

EXEC up_delcmt(1);

--------------------------------------------------------------------------------



-------------------------- 동네생활 댓글 좋아요 ---------------------------------
-- 동네생활 댓글 좋아요 추가
CREATE OR REPLACE PROCEDURE up_inslike(
    p_board_num IN NUMBER,
    p_cmt_num IN NUMBER,
    p_member_num IN NUMBER)
AS
BEGIN
    -- 새로운 좋아요 정보 추가
    INSERT INTO comm_cmt_like (
        comm_cmt_like,  -- 고유 식별자 컬럼에 시퀀스 값을 할당
        comm_board_num,
        cmt_num,
        member_num)
    VALUES (
        comm_cmt_like_seq.NEXTVAL,  -- 여기서 시퀀스의 다음 값을 사용
        p_board_num,
        p_cmt_num,
        p_member_num);
        
    -- INSERT 작업 후 커밋
    COMMIT;
    
    -- 추가된 좋아요 정보 출력
    DBMS_OUTPUT.put_line('게시판 번호: ' || p_board_num || ', 댓글 번호: ' || p_cmt_num || '에 대한 좋아요가 추가되었습니다. 회원 번호: ' || p_member_num);
END;
-- EXEC up_inslike(1, 10, 3);


-- 동네생활 댓글 좋아요 삭제(취소)
CREATE OR REPLACE PROCEDURE up_dellike(
    p_board_num IN NUMBER,
    p_cmt_num IN NUMBER,
    p_member_num IN NUMBER) -- 삭제할 게시판 번호, 댓글 번호, 좋아요를 누른 회원 번호 매개변수
AS
  v_count NUMBER := 0; -- 삭제된 행의 수를 저장할 변수 초기화
BEGIN
    -- 좋아요 정보 삭제
    DELETE FROM comm_cmt_like
    WHERE comm_board_num = p_board_num
      AND cmt_num = p_cmt_num
      AND member_num = p_member_num;
    
    -- 삭제된 행의 수를 변수에 저장
    v_count := SQL%ROWCOUNT;

    -- 삭제 작업 후 커밋
    COMMIT;
    
    -- 삭제된 좋아요 정보 출력
    IF v_count > 0 THEN
        DBMS_OUTPUT.put_line(v_count || '개의 좋아요가 삭제되었습니다. 게시판 번호: ' || p_board_num || ', 댓글 번호: ' || p_cmt_num || ', 회원 번호: ' || p_member_num || '.');
    ELSE
        DBMS_OUTPUT.put_line('삭제할 좋아요 정보가 없습니다.');
    END IF;
END;

EXEC up_dellike(1, 10, 3);

--------------------------------------------------------------------------------



----------------------------- 동네생활 대댓글 -----------------------------------
-- 동네생활 대댓글 수정
CREATE OR REPLACE PROCEDURE up_updreply
(
  p_new_board_num cmt_reply.cmt_board_num%TYPE := NULL,  -- 대댓글 게시글 번호
  p_new_num cmt_reply.rcmt_num%TYPE := NULL,  -- 대댓글 번호
  p_new_member_num cmt_reply.member_num%TYPE := NULL,  -- 작성자 번호
  p_new_date cmt_reply.rcmt_date%TYPE := NULL,  -- 대댓글 작성 날짜
  p_new_content cmt_reply.rcmt_content%TYPE := NULL  -- 대댓글 내용
)
IS
BEGIN
  -- 대댓글 정보 업데이트
  UPDATE cmt_reply
  SET cmt_board_num = NVL(p_new_board_num, cmt_board_num),
      rcmt_num = NVL(p_new_num, rcmt_num),
      member_num = NVL(p_new_member_num, member_num),
      rcmt_date = NVL(p_new_date, rcmt_date),
      rcmt_content = NVL(p_new_content, rcmt_content)
  WHERE rcmt_num = p_new_num;

  -- 업데이트된 행이 있는지 확인하고 결과 메시지 출력
  IF SQL%ROWCOUNT > 0 THEN
    DBMS_OUTPUT.PUT_LINE('대댓글 번호 ' || p_new_num || '가 성공적으로 수정되었습니다.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('대댓글 번호 ' || p_new_num || '에 해당하는 대댓글이 없습니다.');
  END IF;
END;
-- EXEC up_updreply(10, 10, 10, SYSDATE, '수정된 대댓글 내용입니다.');

-- 동네생활 대댓글 삭제
CREATE OR REPLACE PROCEDURE up_delreply
(
    p_rcmt_num cmt_reply.rcmt_num%TYPE -- 대댓글 번호
)
IS
BEGIN
    -- 대댓글에 대한 모든 좋아요 삭제
    DELETE FROM cmt_reply_like WHERE rcmt_num = p_rcmt_num;

    -- 대댓글 삭제
    DELETE FROM cmt_reply WHERE rcmt_num = p_rcmt_num;

    -- 삭제된 행이 있는지 확인하고 결과 메시지 출력
    IF SQL%ROWCOUNT > 0 THEN
      DBMS_OUTPUT.PUT_LINE('대댓글 번호 ' || p_rcmt_num || '에 해당하는 대댓글이 성공적으로 삭제되었습니다.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('대댓글 번호 ' || p_rcmt_num || '에 해당하는 대댓글이 없습니다.');
    END IF;
END;

EXEC up_delreply(10);

--------------------------------------------------------------------------------



-------------------------- 동네생활 대댓글 좋아요 -------------------------------
-- 동네생활 대댓글 좋아요 추가/삭제
CREATE OR REPLACE PROCEDURE up_insdelcmtreplylike

(
    prcmt_like_num  cmt_reply_like.rcmt_like_num%TYPE
    , pmember_num   cmt_reply_like.member_num%TYPE
    , prcmt_num     cmt_reply_like.rcmt_num%TYPE
)
IS
   cnt_replylike NUMBER;
BEGIN      

    SELECT COUNT(rcmt_like_num) INTO cnt_replylike
    FROM cmt_reply_like 
    WHERE member_num = pmember_num AND rcmt_num = prcmt_num ;
    
    SELECT COUNT(rcmt_like_num) INTO cnt_replylike
    FROM cmt_reply_like 
    WHERE member_num = pmember_num AND rcmt_num = prcmt_num ;

    IF cnt_replylike < 1 THEN 
        INSERT INTO cmt_reply_like VALUES (prcmt_like_num, pmember_num, prcmt_num) ;
    ELSIF cnt_replylike = 1 THEN
        DELETE FROM cmt_reply_like WHERE member_num = pmember_num;
    END IF; 
    
    COMMIT;

--EXCEPTION
END;

EXEC up_insdelcmtreplylike(25, 2, 1);

--------------------------------------------------------------------------------
