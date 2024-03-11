-- 모든 관리자 정보 조회
CREATE OR REPLACE PROCEDURE up_selAdminAll
IS
    vadmin_nickname admin.admin_nickname%TYPE;
    vadmin_ID admin.admin_ID%TYPE;
    vadmin_password admin.admin_password%TYPE;
BEGIN
    FOR vrow IN (SELECT admin_nickname
                        , admin_id
                        , admin_password
                 FROM admin)
    LOOP
    DBMS_OUTPUT.PUT_LINE('NAME : ' || vrow.admin_nickname);
    DBMS_OUTPUT.PUT_LINE('ID : ' || vrow.admin_id);
    DBMS_OUTPUT.PUT_LINE('admin_password : ' || vrow.admin_password);
    DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('관리자가 없습니다.');
END;

EXEC up_selAdminAll;


--------------------------------------------------------------------------------


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





-- 관리자 삭제 프로시저
CREATE OR REPLACE PROCEDURE up_delAdmin
(
    padmin_num admin.admin_num%TYPE
)
IS
BEGIN
    DELETE FROM admin WHERE admin_num = padmin_num;
END;

EXEC up_delAdmin(5);


-- 관리자 로그 조회 테이블
CREATE TABLE admin_log_info
(
    memo VARCHAR(1000)
    , log_date DATE DEFAULT SYSDATE
);



-- 관리자의 수정사항(생성, 수정, 삭제)조회를 위한 트리거
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
    ELSIF DELETING THEN 
        INSERT INTO admin_log_info (memo) VALUES ('[' || :OLD.admin_id || '] -> 관리자 삭제');
    END IF;
--EXCEPTION
END;


-- 관리자 로그 정보에 대한 프로시저
CREATE OR REPLACE PROCEDURE up_AdminLogInfo
IS
    vmemo admin_log_info.memo%TYPE;
--    NO_UPDATE EXCEPTION;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('관리자 수정사항');
--    IF vmemo IS NULL
--        THEN RAISE NO_UPDATE;
--    ELSE
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM admin_log_info)
        LOOP
            DBMS_OUTPUT.PUT_LINE('About Admin Log : ' || vrow.memo);
            DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
--    END IF;
--EXCEPTION 
--    WHEN NO_UPDATE THEN
--        DBMS_OUTPUT.PUT_LINE('수정된 내용이 없습니다.');
END;

EXEC up_AdminLogInfo;
ROLLBACK;


--------------------------------------------------------------------------------


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

EXEC up_delNoticeBoard(1);

-- 공지사항 로그 조회 테이블
CREATE TABLE NoticeBoard_log_info
(
    memo VARCHAR2(1000)
    , log_date DATE DEFAULT SYSDATE
);
SELECT * FROM NoticeBoard_log_info;


-- 공지사항 게시판에 대한 수정사항 조회를 위한 트리거
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


-- 공지사항 게시판에 대한 수정사항 조회 프로시저
CREATE OR REPLACE PROCEDURE up_NoticeBoardLogInfo
IS
    vmemo NoticeBoard_log_info.memo%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('공지사항 게시판 수정사항');
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM NoticeBoard_log_info)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ABout NoticeBoard Log : ' || vrow.memo);
        DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
--EXCEPTION
END;
    
EXEC up_NoticeBoardLogInfo;


--------------------------------------------------------------------------------


-- 공지사항 전체조회
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


--------------------------------------------------------------------------------


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

EXEC up_selNoticeBoardInfo(3);

ROLLBACK;


--------------------------------------------------------------------------------


-- 회원 로그 정보에 대한 테이블 생성
CREATE TABLE member_log_info
(
    memo VARCHAR2(1000)
    , log_date DATE DEFAULT SYSDATE
);

DROP TABLE member_log_info;


-- 관리자 권한으로 회원의 모든 수정사항(로그인, 생성, 삭제, 수정)조회를 위한 트리거 
CREATE OR REPLACE TRIGGER ut_MemberLogInfo
AFTER
INSERT OR UPDATE OR DELETE ON member
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO member_log_info (memo) VALUES ( :NEW.member_nickname || ' -> 생성');
    ELSIF UPDATING THEN 
        IF :OLD.member_nickname != :NEW.member_nickname THEN
            INSERT INTO member_log_info (memo) VALUES ( '[' || :OLD.member_nickname || ']' || '님의 이름정보 ' || '[' || :OLD.member_nickname || ' -> ' || :NEW.member_nickname || ']' || '  변경');
        ELSIF :OLD.member_tel != :NEW.member_tel THEN
            INSERT INTO member_log_info (memo) VALUES ( '[' || :OLD.member_nickname || ']' || '님의 전화번호 ' || '[' || :OLD.member_tel || ' -> ' || :NEW.member_tel || ']' || ' 변경');
        ELSIF :OLD.member_address != :NEW.member_address THEN
            INSERT INTO member_log_info (memo) VALUES (  '[' || :OLD.member_nickname || ']' || '님의 주소 ' || '[' || :OLD.member_address || ' -> ' || :NEW.member_address || ']' || ' 변경');
        END IF;
    ELSIF DELETING THEN 
        INSERT INTO member_log_info (memo) VALUES ( :OLD.member_nickname || ' -> 삭제');
    END IF;
--EXCEPTION
END;


-- 모든 회원 로그 정보에 대한 프로시저
CREATE OR REPLACE PROCEDURE up_MemberLogInfo
IS
    vmemo member_log_info.memo%TYPE DEFAULT NULL;
--    NO_DATA_FOUND EXCEPTION;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('회원 수정사항');
    SELECT memo INTO vmemo 
    FROM member_log_info 
    WHERE ROWNUM = 1;
    
--    IF vmemo IS NULL
--        THEN RAISE NO_DATA_FOUND;
--    ELSE
    FOR vrow IN (SELECT memo, TO_CHAR(log_date, 'YYYY-MM-DD HH24:MI:SS') log_date FROM member_log_info)
        LOOP
            DBMS_OUTPUT.PUT_LINE('About Member Log : ' || vrow.memo);
            DBMS_OUTPUT.PUT_LINE('TIME : ' || vrow.log_date);
            DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
--    END IF;
--EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--        DBMS_OUTPUT.PUT_LINE('수정된 내용이 없습니다.');
END;

EXEC up_MemberLogInfo;

--------------------------------------------------------------------------------
