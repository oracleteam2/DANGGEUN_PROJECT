

이동영 (토,월 예비군)
-- 회원 수정
-- 회원 마이페이지 조회
-- 회원삭제
-- 당근페이 금액충전
-- 회원 당근페이 추가
-- 회원 추가





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
BEGIN
    
    SELECT COUNT(*)
        INTO v_mem_count
    FROM member
    WHERE member_num = 1;
    
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


-- 회원 정보 수정
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


-- 회원 당근페이 추가
create or replace PROCEDURE up_insert_danggeun_pay
(
    pmem_num danggeun_pay.member_num%TYPE,
    paccount VARCHAR2,
    pbank_name danggeun_pay.bank_name%TYPE,
    pbalance danggeun_pay.balance%TYPE := 0
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


-- 당근페이 금액 충전
CREATE OR REPLACE PROCEDURE up_charge_danggeun_pay
(
    pmem_num danggeun_pay.member_num%TYPE,
    pmem_charge_amount danggeun_pay.balance%TYPE
)
IS
    v_count NUMBER;
    v_account NUMBER;
    v_balance NUMBER;
    v_bank_name VARCHAR2;
BEGIN
    SELECT COUNT(*)
        INTO v_count
    FROM danggeun_pay
    WHERE member_num = pmem_num;
    
    SELECT account, balance, bank_name
        INTO v_account, v_balance, v_bank_name
    FROM danggeun_pay
    WHERE member_num = pmem_num;
    
    v_balance := v_balance + pmem_charge_amount;
    
    DBMS_OUTPUT.PUT_LINE ( v_bank_name || v_account  );
    DBMS_OUTPUT.PUT_LINE ( pmem_charge_amount || '원');
    DBMS_OUTPUT.PUT_LINE ( '충전후 잔액' || v_balance || '원' );
    DBMS_OUTPUT.PUT_LINE ( '1' || '2' || '3' );
    DBMS_OUTPUT.PUT_LINE ( '4' || '5' || '6' );
    DBMS_OUTPUT.PUT_LINE ( '7' || '8' || '9' );
    DBMS_OUTPUT.PUT_LINE ( ''  || '0' || '<-' );
    
    IF v_count = 1 THEN
    UPDATE danggeun_pay
    SET balance = balance + pmem_charge_amount
    WHERE member_num = pmem_num;
    ELSE
    RAISE_APPLICATION_ERROR(-20001, '충전할 당근페이가 없습니다.');
    END IF;
--EXCEPTION 
END;


-- 회원 삭제
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
--  Encountered the symbol "INSERT" when expecting one of the following: 

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


-- 수정사항
-- 매너온도 테이블
-- 거래가 이뤄진 사람들(채팅방이 있고, 거래가 완료된 사람들)끼리 매너온도 올리거나 낮출 수 있다.
-- 거래완료 상태를 체크해야할것 같다.
-- 채팅관련해서도 트러블이 있을수 있어서 굳이 거래완료가 아니더라도 채팅을 했으면 매너온도 올리거나 낮추는거 가능한걸로 가면 좋을것같다.

--manner_point_num: 매너온도 ( PK )
--chat_room_num : 채팅방 
--manner_points: 매너온도 점수.
--updateDate: 매너온도 업데이트 날짜.
-- 누군가 매너온도를 눌렀을때 어떤 회원의
-- 1 -> 2번의 매너온도 눌렀다.
-- 매개변수 2개주고
-- 1번과 2번의 pay게시판이 생성이 되어 있는지 확인
-- 있으면 온도 올려주는 INSERT하고 회원 매너온도 테이블에서 UPDATE트리거 작동
SELECT * FROM chat;
-- 매너온도 테이블에 press_mem_num, compress_mem_num 추가할 데이터
-- 매너온도 ++ 해주는 로직 ( -- 하는 로직은 생각해 봐야할듯 )

CREATE OR REPLACE PROCEDURE up_insert_manner_points
(
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
    WHERE (buyer_num = p_press_mem_num AND seller_num = p_compress_mem_num) OR
          (buyer_num = p_compress_mem_num AND seller_num = p_press_mem_num);
          
    IF v_m_count = 0 AND v_p_count = 1 AND p_평가 LIKE '긍정' THEN
    INSERT INTO manner_points ( manner_proints_num, chat_room_num, press_mem_num, compress_mem_numm manner_points, update_date )
    VALUES ( seq_manner_points.NEXTVAL, p_chat_room_num, p_press_mem_num, p_compress_mem_num, vmem_manner_points+(vmem_manner_points*0.025)  ,SYSDATE );
    ELSIF v_m_count = 0 AND v_p_count = 1 AND p_평가 LIKE '부정' THEN
    INSERT INTO manner_points ( manner_proints_num, chat_room_num, press_mem_num, compress_mem_numm manner_points, update_date )
    VALUES ( seq_manner_points.NEXTVAL, p_chat_room_num, p_press_mem_num, p_compress_mem_num, vmem_manner_points-(vmem_manner_points*0.025)  ,SYSDATE );
    ELSE
    RAISE_APPLICATION_ERROR(-20001, '이미 매너온도를 평가한 회원입니다.');
    END IF;
--EXCEPTION
END;

CREATE OR REPLACE TRIGGER ut_update_mem_manner
AFTER
INSERT ON manner_points
FOR EACH ROW
BEGIN
    UPDATE member
    SET manner_points = :NEW.manner_points
    WHERE member_num = :NEW.compress_mem_num;
END;





-- 회원넘버
EXECUTE up_select_mpage(1);

-- 주민등록번호, 닉네임, 주소, 전화번호, 프로필이미지
EXECUTE up_insert_member( '981012', '동스', '울산시 울주군 언양읍', '010-1111-2222', 'https://image.newsis.com/2012/05/25/NISI20120525_0006401508_web.jpg');

-- 회원넘버, 회원닉네임, 회원주소, 회원전화번호, 회원 프로필이미지
EXECUTE up_update_member(10, '진스');

-- 회원넘버, 계좌번호, 은행이름, 충전할 돈(기본은 0원값)
EXECUTE up_insert_danggeun_pay( 13, 0901091101878, '국민은행');

-- 회원넘버, 충전금액
EXECUTE up_charge_danggeun_pay( 13, 30000);

-- 회원넘버 ( 관련있는 데이터 전부 삭제하는 BEFORE 트리거 있어야할듯 어지러움 )
EXECUTE up_delete_member(13);

-- 채팅방 번호
EXECUTE up_insert_pay(1);

-- 채팅방번호, 누른사람넘버, 눌러진사람 넘버, 평가(부정, 긍정)
EXECUTE( 6, 2, 1, '부정'); 





EXECUTE up_insert_pay(6);
SELECT * FROM danggeun_pay;
SELECT * FROM member;

ALTER TABLE member DISABLE CONSTRAINT [제약 조건 이름];