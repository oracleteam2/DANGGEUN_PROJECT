-- SCOTT
-- ê°? ?…Œ?´ë¸? ì¡°íšŒ
-- ?šŒ?›
SELECT * FROM member;


-- ê´?ë¦¬ì
SELECT * FROM admin;


-- ?‹ ê³?
SELECT * FROM report;


-- ì°¨ë‹¨
SELECT * FROM block;


-- ì±„íŒ…
SELECT * FROM chat;


-- ì±„íŒ… ?‚´?š©
SELECT * FROM chat_board;

-- ?‹¹ê·¼í˜?´
SELECT * FROM DANGGEUN_pay;


-- ê²°ì œ
SELECT * FROM pay;

-- ê³µì??‚¬?•­ ê²Œì‹œ?Œ
SELECT * FROM notice_board;


-- ?Œë§? ë¬¼í’ˆ ì¹´í…Œê³ ë¦¬
SELECT * FROM ITEM_CTGR;


-- ì¤‘ê³ ê±°ë˜ ê²Œì‹œ?Œ
SELECT * FROM TRADE_BOARD
ORDER BY trade_num;
DELETE trade_board
WHERE trade_num = 12;




-- »óÇ° ÀÌ¹ÌÁö
SELECT * FROM item_image;

SELECT trade_num, item_image_num, member_num FROM item_image
ORDER BY trade_num, item_image_num;
ALTER TABLE item_image ADD member_num NUMBER;
ROLLBACK;

-- ì¤‘ê³ ê±°ë˜ ê²Œì‹œ?Œ ì¢‹ì•„?š”
SELECT * FROM trade_board_like
ORDER BY trade_like_num;

DELETE trade_board_like
WHERE trade_like_num = 1;
-- ?™?„¤?ƒ?™œ ì¹´í…Œê³ ë¦¬

-- ?™?„¤?ƒ?™œ ê²Œì‹œ?Œ


-- ?™?„¤?ƒ?™œ ?Œ“ê¸?


-- ?™?„¤?ƒ?™œ ???Œ“ê¸?


-- ?™?„¤?ƒ?™œ ê²Œì‹œ?Œ ì¢‹ì•„?š”


-- ?™?„¤?ƒ?™œ ?Œ“ê¸? ì¢‹ì•„?š”


-- ?™?„¤?ƒ?™œ ???Œ“ê¸? ì¢‹ì•„?š”








