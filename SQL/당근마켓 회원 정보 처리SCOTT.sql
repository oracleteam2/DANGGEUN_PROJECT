

이동영 (토,월 예비군)
-- 회원 수정
-- 회원 마이페이지 조회
-- 회원삭제
-- 당근페이 금액충전
-- 회원 당근페이 추가
-- 회원 추가


-- 회원 관련데이터 삭제
-- 매너온도
-- 결제
-- 수정사항


-- 회원 마이페이지 조회
CREATE OR REPLACE PROCEDURE up_selmypage
(
    pmember_num member.member_num%TYPE
)
IS
    vcount_memb_tboard NUMBER;
    vmem_nickname member.member_nickname%TYPE;
    vmem_profile member.member_profile%TYPE;
    vmem_mpoints member.member_manner_points%TYPE;
    vmem_addr   member.member_address%TYPE;
BEGIN

    SELECT m.member_profile, m.member_nickname, m.member_manner_points, t.count_mem_tboard, m.member_address
        INTO  vmem_profile , vmem_nickname, vmem_mpoints, vcount_memb_tboard, vmem_addr
    FROM member m ,(
        SELECT COUNT(t.member_num) count_mem_tboard
        FROM member m JOIN trade_board t ON m.member_num = t.member_num 
        WHERE m.member_num = pmember_num
            ) t
    WHERE m.member_num = pmember_num;

    DBMS_OUTPUT.PUT( vmem_profile );
    DBMS_OUTPUT.PUT_LINE( vmem_nickname );
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

-- 결제 테이블
-- 채팅에서 거래게시판 번호 1개있으면 그거 들고와서 2명의 유저간의 거래를 한다. 
CREATE SEQUENCE seq_pay 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

--채팅에서 거래번호를 넣어야한다.
--pay_num NUMBER : 결제 번호 ( PK )
--chat_room_num NUMBER : 채팅방 번호 ( FK )
--member_num NUMBER : 유저번호1 
--member_num2 NUMBER : 유저번호2 
--pay_date DATE : 송금날짜
--remittance_amount NUMBER : 송금금액

CREATE OR REPLACE PROCEDURE up_insert_pay
(
    p_chat_num chat.chat_room_num%TYPE
)
IS
    vmem_num1 chat.member_num%TYPE;
    vmem_num2 chat.member_num2%TYPE;
    vtrade_num chat.trade_num%TYPE; -- chat에서 trade번호가 있을때
    vprice NUMBER;
BEGIN

    SELECT member_num, member_num2, trade_num
        INTO vmem_num1, vmem_num2, vtrade_num
    FROM chat
    WHERE chat_room_num = p_chat_num;
    
    SELECT trade_price
        INTO vprice
    FROM trade_board
    WHERE trade_num = vtrade_num;
    
    INSERT INTO pay ( pay_num, chat_room_num, member_num, member_num2, pay_date, remittance_amount )
    VALUES (seq_pay.NEXTVAL, p_chat_num, vmem_num1, vmem_num2, SYSDATE, vprice);
--EXCEPTION
END;

-- num1은 무조건 판매자 당근페이 금액 ++
-- num2는 무조건 구매자 당근페이 금액 --
CREATE OR REPLACE TRIGGER ut_update_danggeun
AFTER 
INSERT ON pay
FOR EACH ROW
BEGIN

    UPDATE danggeun_pay 
    SET balance = balance + :NEW.remittance_amount
    WHERE member_num = :NEW.member_num;
    
    UPDATE danggeun_pay
    SET balance = balance - :NEW.remittance_amount
    WHERE member_num = :NEW.member_num2;
END;



-- 매너온도 테이블
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



