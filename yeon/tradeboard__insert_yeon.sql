-- scott 접속
-- ITEM_CTGR 물품 카테고리 인서트
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 1, '디지털기기') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 2, '생활가전') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 3, '의류') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 4, '아동') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 5, '스포츠') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 6, '식품') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 7, '취미') ;
INSERT INTO ITEM_CTGR(item_ctgr_num, item_ctgr_name) VALUES ( 8, '삽니다') ;
COMMIT;
SELECT * FROM ITEM_CTGR;

-- TRADE_BOARD 중고거래게시판 시퀀스
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE ;

select * from TRADE_BOARD ;
-- TRADE_BOARD 중고거래게시판 인서트
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 1
    , 1
    , '진돌' 
    , 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12'
    , '에어팟맥스 새상품'
    ,  SYSDATE
    ,  200000
    , '미개봉 새상품인데 저는 이미 하나 있어서 팔아요'
    , '서울 양천구 목동'
    , '목동'
    , '45.5℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 2
    , 1
    , '강타'
    , 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D'
    , '접이식 헤어 드라이어'
    , SYSDATE
    , 100000
    , '반년 전에 구입한 접이식 헤어드라이어입니다. 미사용에 가까워요.'
    , '경기도 오산시 신장동'
    , '신장동'
    , '39℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 3
    , 2
    , '이효리'
    , 'https://img.freepik.com/premium-photo/caricature-of-a-carrot-with-a-face-and-limbs-generative-ai_252214-6349.jpg?w=2000'
    , '오븐 토스터'
    , SYSDATE
    , 40000
    , '교체를 위해 내놓습니다. 혼자사는 분이라면 충분히 사용할 만한 크기입니다.'
    , '경기도 김포시 양촌읍'
    , '양촌읍'
    , '42.1℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 4
    , 2
    , '바다'
    , 'https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg'
    , '와인 글라스'
    , SYSDATE
    , 30000
    , '에노테카의 와인글라스입니다. 큰 사이즈로 깨끗한 상태입니다. 눈에 띄는 흠집이나 얼룩없음.'
    , '서울 강남구 삼성2동'
    , '삼성2동'
    , '42.3℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 5
    , 3
    , '김태우'
    , 'https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/rZ1xSXKCJ4cd-IExOYahRWdrqoo.jpg'
    , '여성의류 캘빈클라인 반팔티 팝니다.'
    , SYSDATE
    , 25000
    , '3회 착용했습니다. 거의 새상품입니다. 직거래 원합니다 쿨거래 가능'
    , '경기도 부천시 상3동'
    , '상3동'
    , '36.5℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 6
    , 3
    , '손호영'
    , 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUepaBdMZtoy5GmiKF_v1vkRbwo3MgxAiIwcaztDaqiYwLdV58jhq19hUX00btfdkBUF8&usqp=CAU'
    , '까스텔바작 골프의류 니트조끼 사이즈95'
    , SYSDATE
    , 35000
    , '까스텔바작 골프의류 니트조끼 사이즈95 몇 번 안입었습니다.'
    , '경남 김해시 어방동'
    , '어방동'
    , '58.3℃'
    );    
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 7
    , 4
    , '차승원'
    , ' https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/cnoC/image/tfQwmqh621xPopjfnJ9wXkfrBcc.jpg'
    , '메리다 어린이 자전거'
    , SYSDATE
    , 70000
    , '주니어 자전거입니다. 사용감 있습니다. 직접오셔야해요'
    , '경기도 화성시 향남읍'
    , '향남읍'
    , '58.3℃'
    );   
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 8
    , 4
    , '원빈'
    , 'https://i.pinimg.com/736x/05/fe/0c/05fe0c269a225ac1251fff5bc74483ef.jpg'
    , '아동 사운드펜 팝니다.'
    , SYSDATE
    , 15000
    , '해요펜과 함께 볼 수 있는 영어책입니다. 잘 안봐서 책은 깨끗해요~'
    , '경기도 군포시 산본1동'
    , '산본1동'
    , '37.2℃'
    );     
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 9
    , 5
    , '카리나'
    , 'https://www.moneynet.co.kr/files/attach/images/33793530/304/717/049/0d8e9d6eee5e97ac11f96085c56072ab.jpg'
    , '스포츠댄스 슈즈 팔아요'
    , SYSDATE
    , 10000
    , '구매하고 몇번 안신어서 상태 양호합니다. 가볍고 편해요!!'
    , '서울 성동구 성수1가제2동'
    , '성수1가제2동'
    , '51.3℃'
    );  
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 10
    , 5
    , '손석구'
    , 'https://cdnimage.dailian.co.kr/news/201802/news_1518415236_693408_m_1.jpg'
    , '나이키 스포츠 크로스백'
    , SYSDATE
    , 48000
    , '컨디션 굿굿굿/보시는것처럼 디자인이 훌륭하여 스포츠,여행,책가방 다양하게 매고 다닐 수 있습니다. 많은 문의 부탁드려요'
    , '서울 종로구 창신제1동'
    , '창신제1동'
    , '47.2℃'
    );      
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 1
    , 6
    , '진돌' 
    , 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12'
    , '(새제품)건강식품 홍삼/산삼/인삼/벌꿀 판매'
    , SYSDATE
    , 10000
    , '모두 새상품이지만 중고거래 특성상 반품/환불X, 낱개&일괄 구매가능/네고가능'
    , '경기도 하남시 망월동'
    , '망월동'
    , '41.0℃'
    );   
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 2
    , 6
    , '강타'
    , 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D'
    , '청우식품 오란다 한박스X20봉 온라인 최저가'
    , SYSDATE
    , 20000
    , '오늘 남편이 친구 물류센터서 어렵게 싣고온 오란단 6박스 판매합니다.'
    , '경기도 파주시 목동동'
    , '목동동'
    , '39.6℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 3
    , 7
    , '이효리'
    , 'https://img.freepik.com/premium-photo/caricature-of-a-carrot-with-a-face-and-limbs-generative-ai_252214-6349.jpg?w=2000'
    , '그림그리기 책 취미'
    , SYSDATE
    , 20000
    , '오늘 남편이 친구 물류센터서 어렵게 싣고온 오란단 6박스 판매합니다.'
    , '전남 나주시 빛가람동'
    , '빛가람동'
    , '37.7℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 4
    , 7
    , '바다'
    , 'https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg'
    , '취미 게임 할리갈리 보드게임'
    , SYSDATE
    , 8000
    , '유아보드게임으로도 좋고 친구들이랑 술 마시면서 게임하기도 좋은 순발력 보드게임!'
    , '경기도 하남시 망월동'
    , '망월동'
    , '37.4℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 5
    , 8
    , '김태우'
    , 'https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/rZ1xSXKCJ4cd-IExOYahRWdrqoo.jpg'
    , '안유진 모켓샵 삽니다'
    , SYSDATE
    , 15000
    , '10000~15000까지 사고 택배비 포함한 가격입니다. 실물인증이나 빛비춤사진 꼭 보내주셔야합니다.직거래도 가능해요~'
    , '부산 연제구 연산제8동'
    , '연산제8동'
    , '37.1℃'
    );
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 6
    , 8
    , '손호영'
    , 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUepaBdMZtoy5GmiKF_v1vkRbwo3MgxAiIwcaztDaqiYwLdV58jhq19hUX00btfdkBUF8&usqp=CAU'
    , '10만원권 신세계상품권 삽니다.'
    , SYSDATE
    , 94000
    , '9.4에 50장까지 사봅니다~~'
    , '서울 관악구 중앙동'
    , '연산제8동'
    , '47.3℃'
    );

-- ITEM_IMAGE 중고상품 이미지 시퀀스
CREATE SEQUENCE SEQ_IMAGE 
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE; 

-- 상품이미지 데이터타입 변경 ( -> VARCHAR2 )
ALTER TABLE ITEM_IMAGE MODIFY(
ITEM_IMAGE_URL VARCHAR2(4000) );

-- 물품 게시판 생성 후 이미지 만들기!! 
-- ITEM_IMAGE 상품 이미지 인서트
--1. 에어팟맥스 새상품
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/f3cc3e8742b9f393e3a0294691d87e4a24254b200cf7fbde7b1df4c512dd0590.jpg?q=95&s=1440x1440&t=inside&f=webp');
--1. 접이식 헤어드라이기
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202402/a33849be0e1a93ac4d5e3d26d5db12a396d7507b4aaf505a0cccffe648e81639.jpg?q=95&s=1440x1440&t=inside&f=webp');

--2. 오븐 토스터
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/08ec535f0dc069be48db7970231f52a662446f8e07d334b7e44f23d97ffa145f_0.webp?q=95&s=1440x1440&t=inside&f=webp');
--2. 와인 글라스 세트
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202402/cc6cf7e733f70887fb9d4963c4e96d22af16021f9a86729c4f1b5f08dd6a8e68.jpg?q=95&s=1440x1440&t=inside&f=webp');

--3. 여성의류 캘빈클라인 반팔티
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/51a2ebe878d07f4ff8223922c38bea16a348775645e01ab5ff4fc146499ca61d.jpg?q=95&s=1440x1440&t=inside&f=webp');
--3. 까스텔바작 골프의류 니트조끼 사이즈 95
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/bd0118fec665620ed0284959a46cfd4b69caf2034b3ed4046594d3ff680de518_0.webp?q=95&s=1440x1440&t=inside&f=webp');

--4. 메리다 어린이 자전거
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/ac29d7c003f5c248866caf0beb4b197ecfad62315987dbb241d512aa66d4d574_0.webp?q=95&s=1440x1440&t=inside&f=webp');
--4. 아동 사운드펜
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/c05c5dbd0a7f9024e140997cfb00a0d97aba1a67ef280682dccd3a3eabadd00a_0.webp?q=95&s=1440x1440&t=inside&f=webp');

--5. 스포츠댄스 슈즈
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/cc0557c1b1fe9644ab8d7aeb6286941269238e30cbdc2974313889ac57aa934c_0.webp?q=95&s=1440x1440&t=inside&f=webp');
--5. 나이키 스포츠 크로스백
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/dab501b13199011884360972c1c83a6359920d1183ec11858b692996b8fae9ba.jpg?q=95&s=1440x1440&t=inside&f=webp');

--6. 건강식품 홍삼/산삼/인삼 판매
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/443d225e529c56a3e1ca01ce43bb0c5996e8e155d344c856170e94551bc1cd8b.jpg?q=95&s=1440x1440&t=inside&f=webp');
--6. 청우식품 오란다 한박스
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/eb7d278209226ba4e0f50d785e2bfcd3eea172940114b282f8ae3b5210871388_0.webp?q=95&s=1440x1440&t=inside&f=webp');

--7. 그림그리기 책
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/381060bf56789f968187e21207f799f9c8ac683c9ec4c7a93f5467edb88a9b3f.jpg?q=95&s=1440x1440&t=inside&f=webp');
--7. 취미 할리갈리 보드게임
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/09dc177b0574a519229a12c93671ae4649c5527293e52504eaa39873d24f6704.jpg?q=95&s=1440x1440&t=inside&f=webp');

--8. 안유진 모켓샵 삽니다
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/0bc0de5e3842995b678fd4c32d76b51f9d4745182e4b82a7fea1fa7b8f531429_0.webp?q=95&s=1440x1440&t=inside&f=webp');
--8. 신세계 상품권
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/f63093fdcb0c7ce520dd22f3609316a3be290e5a75d3210eca1c5e3152d5fef1_0.webp?q=95&s=1440x1440&t=inside&f=webp');
------------------------------------------------------------------------------------


-- TRADE_BOARD 중고거래게시판 시퀀스
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE ;
-- ITEM_IMAGE 중고상품 이미지 시퀀스
CREATE SEQUENCE SEQ_IMAGE 
INCREMENT BY 1
START WITH 1
NOCYCLE
NOCACHE;

------------------------------------------------------------------------------------
select * from TRADE_BOARD ;
-- TRADE_BOARD 중고거래게시판 인서트 + ITEM_IMAGE 상품이미지 인서트 
--1. 에어팟맥스 새상품
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 1
    , 1
    , '에어팟맥스 새상품'
    , '미개봉 새상품인데 저는 이미 하나 있어서 팔아요'
    ,  SYSDATE
    ,  200000
    , '목동'
    );   
--1. 에어팟맥스 새상품
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/f3cc3e8742b9f393e3a0294691d87e4a24254b200cf7fbde7b1df4c512dd0590.jpg?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=https%3A%2F%2Fshopping-phinf.pstatic.net%2Fmain_8711646%2F87116460443.jpg&type=f372_372');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMDVfMTU4%2FMDAxNzAxNzY0Mjk0MDc4.iDJ3j4hn_JIb1eL1BLSkxrtmFn7PCNcoVusyNmeDzXwg.42yYugGj2rjwedgzSYFmzOer2zHl1bejswZ96rkQsqEg.JPEG.sol__l2%2FKakaoTalk_20231205_170011141_01.jpg&type=a340');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimage.msscdn.net%2Fimages%2Fgoods_img%2F20240118%2F3806183%2F3806183_17080610408383_500.jpg&type=a340');


--1. 접이식 헤어드라이기
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 2
    , 1
    , '다이슨 수퍼소닉 헤어드라이어 블루 블러쉬 판매합니다.'
     , '미개봉 새제품 정품입니다. 직거래는 신장동에서 가능합니다.'
    , '2024-03-01'
    , 100000
    , '신장동'
    );
--1. 접이식 헤어드라이기
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/9887accfc129500a7c887f3a94b6441752b6db9f061b690f82777ec7e06e7ed5_0.webp?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/861b835995343e320e6259fa92c2d3c9b3f059c7b1b226a5cafa3993773daba7_1.webp?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/9887accfc129500a7c887f3a94b6441752b6db9f061b690f82777ec7e06e7ed5_2.webp?q=95&s=1440x1440&t=inside&f=webp');

--2. 오븐 토스터
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 3
    , 2
    , '오븐 토스터'
    , '교체를 위해 내놓습니다. 혼자사는 분이라면 충분히 사용할 만한 크기입니다.'
    , '2024-02-28'
    , 40000  
    , '양촌읍'
    );
--2. 오븐 토스터
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/08ec535f0dc069be48db7970231f52a662446f8e07d334b7e44f23d97ffa145f_0.webp?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/community/community/20240216/2ffbac14-1384-480d-acc4-4fdeb42fabb5.png?&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fdnvefa72aowie.cloudfront.net%2Forigin%2Farticle%2F202312%2Fac867456b1fe127309cf94a172a46ac2d514cafc2a982e622383af25493a2f60.jpg%3Fq%3D95%26s%3D1440x1440%26t%3Dinside%26f%3Dwebp&type=sc960_832');

--2. 와인 글라스 세트
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 4
    , 2
    , '와인 글라스'
    , '에노테카의 와인글라스입니다. 큰 사이즈로 깨끗한 상태입니다. 눈에 띄는 흠집이나 얼룩없음.'
    , '2024-02-16'
    , 30000  
    , '삼성2동'
    );
--2. 와인 글라스 세트
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202402/cc6cf7e733f70887fb9d4963c4e96d22af16021f9a86729c4f1b5f08dd6a8e68.jpg?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshopping.phinf.naver.net%2Fmain_3754868%2F37548689017.20230131125646.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20230324_114%2F1679637966978NtLwq_JPEG%2FTLbli_100901_7.jpg&type=sc960_832');

 --3. 여성의류 캘빈클라인 반팔티
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 5
    , 3
    , '여성의류 캘빈클라인 반팔티 팝니다.'
    , '3회 착용했습니다. 거의 새상품입니다. 직거래 원합니다 쿨거래 가능'
    , '2024-02-04'
    , 25000   
    , '상3동'
    );
 --3. 여성의류 캘빈클라인 반팔티
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/51a2ebe878d07f4ff8223922c38bea16a348775645e01ab5ff4fc146499ca61d.jpg?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimage.musinsa.com%2Fmfile_s01%2F2022%2F04%2F15%2Fff67c3458fdaa4d4f3b5e3dc23c5506d184029.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA1MTVfOTkg%2FMDAxNjg0MTUwNTU0MjM4.QyxnLWV6NqLFYleqyR-PK8W_Z7_hgeoXg2RKDEQ6QdQg.kWGLc6KYE0tnxdvtGlQHbtkfQ79kteDu199f559s1Tog.JPEG.tnstnqorqo%2FIMG_8125.JPG&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fck-s3.s3.ap-northeast-2.amazonaws.com%2Fecom%2F24SS%2FCKJ%2FJ223860-YAF%2FJ223860-YAF-ITEM-2.jpg&type=a340');

--3. 까스텔바작 골프의류 니트조끼 사이즈 95
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 6
    , 3
    , '까스텔바작 골프의류 니트조끼 사이즈95'
    , '까스텔바작 골프의류 니트조끼 사이즈95 몇 번 안입었습니다.'
    , '2024-02-01'
    , 35000
    , '어방동'
    ); 
--3. 까스텔바작 골프의류 니트조끼 사이즈 95
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20210828_228%2F163013337942202vwE_JPEG%2F31269162995911619_1021975160.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20210710_203%2F1625916196021Ubx5S_JPEG%2F33380828139819908_936957536.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fccimg.hellomarket.com%2Fimages%2F2023%2Fitem%2F02%2F16%2F13%2F2522936_5731861_1.jpg%3Fsize%3Ds6&type=sc960_832');

--4. 메리다 어린이 자전거
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 7
    , 4
    , '메리다 어린이 자전거'
    , '주니어 자전거입니다. 사용감 있습니다. 직접오셔야해요'
    , '2024-01-30'
    , 70000
    , '향남읍'
    );   
--4. 메리다 어린이 자전거
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/ac29d7c003f5c248866caf0beb4b197ecfad62315987dbb241d512aa66d4d574_0.webp?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA0MjdfNTEg%2FMDAxNTI0ODMwNDU5MjM0.EEzN1PjwOjDrsQt6AMdKGUGqZ7GWp8FE17w6Ff5oLgYg.1SUuiexNmY8B7L9vEgMnjcYzvX_iUZdZP0cOvF7ZHZUg.JPEG.1984velo%2FKakaoTalk_20180427_200934077.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fcafefiles.naver.net%2FMjAxOTA0MDdfMjcg%2FMDAxNTU0NTkxMTA2ODE1.uCJ7D0xtEAz85zKy0c510bZML4FGoZPPWw1kRX9mRrMg.H7DLcFWg2Iry0ZOJ9A0a_keNHGjIOQVRJSF9H5_Olygg.JPEG.kyungin0315%2FAE5B12D6-F4F9-451A-8825-8A539D88F208.jpeg&type=sc960_832' );
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAxMjdfMjA3%2FMDAxNzA2MzQzNjc5MjE0.Ma3dduyAiiLYPyGbnhlADUZnC0ftAZaNrGO8eAUveKgg.z9rEJ1hwJtwifePsI2izr_uxh7kWulM94rqEmSpUfmIg.JPEG.okuro1977%2F%25B8%25DE%25B8%25AE%25B4%25D920.jpg&type=sc960_832' );

--4. 아동 사운드펜
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 8
    , 4
    , '아동 사운드펜 팝니다.'
    , '해요펜과 함께 볼 수 있는 영어책입니다. 잘 안봐서 책은 깨끗해요~'
    , '2024-01-14'
    , 15000
    , '산본1동'
    );     
--4. 아동 사운드펜
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/c05c5dbd0a7f9024e140997cfb00a0d97aba1a67ef280682dccd3a3eabadd00a_0.webp?q=95&s=1440x1440&t=inside&f=webp');    
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAxMDRfNTkg%2FMDAxNzA0MzU5MzQ2MzYw.SnuXXedY-d-o69g7wa4U5rFq0uOGx6I8m3gT5VMX6k4g.iU1C4BUd1IQ-xeHEp-e9wT-lwvUk6IKjj8mFlZZB-SQg.JPEG.yaena1143%2FIMG_2961.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20200304_158%2F1583306549050vLuw0_JPEG%2F20668882615659850_1383306984.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fcafefiles.naver.net%2FMjAxOTExMjhfMjYg%2FMDAxNTc0OTIwNDE3NTQ4.SBjpdDpT1NVClTOyhy6zoEA5iYg_cuLKEbkcDoP5JDYg.E7Z3seCuctdf6b5lvyjmUFFmfN8mNrg_v1sdRLk1-ZUg.JPEG%2FexternalFile.jpg&type=sc960_832');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20220503_138%2F1651533711184nSJx7_JPEG%2F52669539010215726_920666573.jpg&type=sc960_832');
----------------------------------------------------여기까지 이미지 추가함
--5. 스포츠댄스 슈즈
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 9
    , 5
    , '스포츠댄스 슈즈 팔아요'
    , '구매하고 몇번 안신어서 상태 양호합니다. 가볍고 편해요!!'
    , SYSDATE
    , 10000
    , '성수1가제2동'
    );  
--5. 스포츠댄스 슈즈
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/cc0557c1b1fe9644ab8d7aeb6286941269238e30cbdc2974313889ac57aa934c_0.webp?q=95&s=1440x1440&t=inside&f=webp');
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fshopping.phinf.naver.net%2Fmain_4423427%2F44234275577.20231124174445.jpg&type=sc960_832');

--5. 나이키 스포츠 크로스백
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 10
    , 5
    , '나이키 스포츠 크로스백'
    , '컨디션 굿굿굿/보시는것처럼 디자인이 훌륭하여 스포츠,여행,책가방 다양하게 매고 다닐 수 있습니다. 많은 문의 부탁드려요'
    , SYSDATE
    , 48000    
    , '창신제1동'
    );  
--5. 나이키 스포츠 크로스백
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/dab501b13199011884360972c1c83a6359920d1183ec11858b692996b8fae9ba.jpg?q=95&s=1440x1440&t=inside&f=webp');
    
--6. 건강식품 홍삼/산삼/인삼 판매
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 1
    , 6
    , '(새제품)건강식품 홍삼/산삼/인삼/벌꿀 판매'
    , '모두 새상품이지만 중고거래 특성상 반품/환불X, 낱개&일괄 구매가능/네고가능'
    , SYSDATE
    , 10000
    , '망월동'
    );   
--6. 건강식품 홍삼/산삼/인삼 판매
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/443d225e529c56a3e1ca01ce43bb0c5996e8e155d344c856170e94551bc1cd8b.jpg?q=95&s=1440x1440&t=inside&f=webp');

--6. 청우식품 오란다 한박스
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 2
    , 6
    , '청우식품 오란다 한박스X20봉 온라인 최저가'
    , '오늘 남편이 친구 물류센터서 어렵게 싣고온 오란단 6박스 판매합니다.'
    , SYSDATE
    , 20000
    , '목동동'
    ); 
--6. 청우식품 오란다 한박스
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/eb7d278209226ba4e0f50d785e2bfcd3eea172940114b282f8ae3b5210871388_0.webp?q=95&s=1440x1440&t=inside&f=webp');
   
--7. 그림그리기 책
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 3
    , 7
    , '그림그리기 책 취미'
    , '혼자하기 너무 좋은 취미입니다 가볍게 해보실 분은 구매해보세요~'
    , SYSDATE
    , 20000
    , '빛가람동'
    );
--7. 그림그리기 책
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/381060bf56789f968187e21207f799f9c8ac683c9ec4c7a93f5467edb88a9b3f.jpg?q=95&s=1440x1440&t=inside&f=webp');

--7. 취미 할리갈리 보드게임
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_BOARD.NEXTVAL
    , 4
    , 7
    , '취미 게임 할리갈리 보드게임'
    , '유아보드게임으로도 좋고 친구들이랑 술 마시면서 게임하기도 좋은 순발력 보드게임!'
    , SYSDATE
    , 8000
    , '망월동'
    );
--7. 취미 할리갈리 보드게임
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/09dc177b0574a519229a12c93671ae4649c5527293e52504eaa39873d24f6704.jpg?q=95&s=1440x1440&t=inside&f=webp');

    
--8. 안유진 모켓샵 삽니다
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 5
    , 8
    , '안유진 모켓샵 삽니다'
    , '10000~15000까지 사고 택배비 포함한 가격입니다. 실물인증이나 빛비춤사진 꼭 보내주셔야합니다.직거래도 가능해요~'
    , SYSDATE
    , 15000
    , '연산제8동'
    );
--8. 안유진 모켓샵 삽니다
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/0bc0de5e3842995b678fd4c32d76b51f9d4745182e4b82a7fea1fa7b8f531429_0.webp?q=95&s=1440x1440&t=inside&f=webp');

--8. 신세계 상품권
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_BOARD.NEXTVAL
    , 6
    , 8
    , '10만원권 신세계상품권 삽니다.'
    , '9.4에 50장까지 사봅니다~~'
    , SYSDATE
    , 94000
    , '연산제8동'
    );
--8. 신세계 상품권
INSERT INTO item_image ( trade_num, item_image_num, item_image_url)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/f63093fdcb0c7ce520dd22f3609316a3be290e5a75d3210eca1c5e3152d5fef1_0.webp?q=95&s=1440x1440&t=inside&f=webp');
 

-----------------------------------------------------------------------------------
INSERT INTO ITEM_IMAGE VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_BOARD.CURRVAL,  '');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1998-06-29', '진돌', '부산광역시 해운대구 중동', '010-4044-4444', 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12');

-- & = 문자값으로 사용하도록 설정
SHOW DEFINE;

SET DEFINE OFF;

--- TRADE_PRICE 데이터타입(NUMBER-> VARCHAR2) 변경 
ALTER TABLE item_image MODIFY(
ITEM_IMAGE_URL varchar2(4000) );


SELECT * FROM member;
select * from ITEM_CTGR ;
SELECT * FROM ITEM_IMAGE;

CREATE SEQUENCE seq_member_id ;