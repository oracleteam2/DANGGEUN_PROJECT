-- SCOTT
-- 각 테이블 조회

-- 회원
SELECT * FROM member;


-- 관리자
SELECT * FROM admin;


-- 신고
SELECT * FROM report;


-- 차단
SELECT * FROM block;


-- 채팅
SELECT * FROM chat;


-- 채팅 내용
SELECT * FROM chat_board;

-- 당근페이
SELECT * FROM DANGGEUN_pay;


-- 결제
SELECT * FROM pay;

-- 공지사항 게시판
SELECT * FROM notice_board;


-- 판매 물품 카테고리
SELECT * FROM ITEM_CTGR;


-- 중고거래 게시판
SELECT * FROM TRADE_BOARD;

-- 상품 이미지
SELECT * FROM item_image
ORDER BY trade_num, item_image_num;
ALTER TABLE item_image ADD member_num NUMBER;


-- 중고거래 게시판 좋아요
SELECT * FROM trade_board_like
ORDER BY trade_like_num;
ROLLBACK;
DELETE trade_board_like
WHERE trade_like_num = 19;
-- 동네생활 카테고리


-- 동네생활 게시판


-- 동네생활 댓글


-- 동네생활 대댓글


-- 동네생활 게시판 좋아요


-- 동네생활 댓글 좋아요


-- 동네생활 대댓글 좋아요








