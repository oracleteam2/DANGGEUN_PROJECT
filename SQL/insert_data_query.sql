-- SCOTT
-- 데이터 삽입
11
22
--COMM : COMMUNITY
--CMT : COMMENT
--CTGR : CATEGORY
--NUM : NUMBER

-- '&' 을 문자로 취급하게하는 코드
SHOW DEFINE;
SET DEFINE OFF;


-- 회원 시퀀스
-- 회원넘버(pk), 생년월일, 닉네임, 주소, 전화번호, 프로필이미지, 매너온도(default)
CREATE SEQUENCE SEQ_MEMBER_ID
START WITH 1
INCREMENT BY 1;



INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1998-06-29', '진돌', '부산광역시 해운대구 중동', '010-4044-4444', 'https://cliimage.commutil.kr/phpwas/restmb_allidxmake.php?pp=002&idx=3&simg=20170712195535009572d12411ff9587970114.jpg&nmt=12');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1990-03-12', '안유진', '서울특별시 강남구 중동', '010-1234-4444', 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1991-05-23', '장원영', '서울특별시 강남구 중동', '010-9822-4224', 'https://img.freepik.com/premium-photo/caricature-of-a-carrot-with-a-face-and-limbs-generative-ai_252214-6349.jpg?w=2000');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1992-07-27', '차은우', '서울특별시 노원구 중동', '010-4467-2454', 'https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1993-11-19', '고수', '서울특별시 마포구 중동', '010-7014-1244', 'https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/rZ1xSXKCJ4cd-IExOYahRWdrqoo.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1994-12-04', '윈터', '대구광역시 수성구 중동', '010-8344-8894', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUepaBdMZtoy5GmiKF_v1vkRbwo3MgxAiIwcaztDaqiYwLdV58jhq19hUX00btfdkBUF8&usqp=CAU 
');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1995-09-02', '강동원', '대전광역시  서구 중동', '010-7744-4477', ' https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/cnoC/image/tfQwmqh621xPopjfnJ9wXkfrBcc.jpg');


INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1996-08-24', '원빈', '부산광역시 해운대구 좌동', '010-1253-8964', 'https://i.pinimg.com/736x/05/fe/0c/05fe0c269a225ac1251fff5bc74483ef.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '1997-02-15', '카리나', '인천광역시 남구 중동', '010-2834-5315', 'https://www.moneynet.co.kr/files/attach/images/33793530/304/717/049/0d8e9d6eee5e97ac11f96085c56072ab.jpg');

INSERT INTO member(member_num, member_birth, member_nickname, member_address, member_tel, member_profile) 
VALUES (seq_member_id.NEXTVAL, '2000-07-11', '손석구', '제주특별시 제주시 아라일동', '010-2427-2453', 'https://cdnimage.dailian.co.kr/news/201802/news_1518415236_693408_m_1.jpg');

COMMIT;

-- 관리자 생성
-- ADMIN 테이블, 관리자 넘버 ( PK ), 관리자닉네임, 관리자ID, 관리자비밀번호
CREATE SEQUENCE SEQ_ADMIN_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자1', 'admin123', '1234');

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자2', 'admin4875', '842135');

INSERT INTO admin
VALUES (SEQ_ADMIN_ID.NEXTVAL, '관리자3', 'admin9753', '84651321');


-- DANNGN_PAY 테이블, 회원 넘버 ( PK ), 계좌번호, 은행이름, 잔액
INSERT INTO DANGGEUN_pay
VALUES(1, '91098112453', 'KB국민은행', 1350000);
INSERT INTO DANGGEUN_pay
VALUES(2, '33332955474', '신한은행', 350000);
INSERT INTO DANGGEUN_pay
VALUES(3, '91963923557953', 'KEB하나은행', 275000);
INSERT INTO DANGGEUN_pay
VALUES(4, '1234811255453', 'NH농협은행', 64000);
INSERT INTO DANGGEUN_pay
VALUES(5, '44445930203', 'SC제일은행', 170000);
INSERT INTO DANGGEUN_pay
VALUES(6, '123456789434', '씨티은행', 600000);
INSERT INTO DANGGEUN_pay
VALUES(7, '45629759232', '케이뱅크', 1790000);
INSERT INTO DANGGEUN_pay
VALUES(8, '914346765579', '카카오뱅크', 510000);
INSERT INTO DANGGEUN_pay
VALUES(9, '09173549283', 'DGB대구은행', 200000);
INSERT INTO DANGGEUN_pay
VALUES(10, '056737235267', 'BNK부산은행', 660000);
COMMIT;

-- PAY 테이블, 회원 넘버, 회원 넘버2
CREATE SEQUENCE seq_pay
START WITH 1
INCREMENT BY 1;

INSERT INTO pay
VALUES(1, 3);

-- ITEM_CTGR 테이블
--물품 카테고리 넘버 ( PK )
--물품 카테고리 이름
INSERT INTO ITEM_CTGR VALUES ( 1, '디지털기기') ;
INSERT INTO ITEM_CTGR VALUES ( 2, '생활가전') ;
INSERT INTO ITEM_CTGR VALUES ( 3, '의류') ;
INSERT INTO ITEM_CTGR VALUES ( 4, '아동') ;
INSERT INTO ITEM_CTGR VALUES ( 5, '스포츠') ;
INSERT INTO ITEM_CTGR VALUES ( 6, '식품') ;
INSERT INTO ITEM_CTGR VALUES ( 7, '취미') ;
INSERT INTO ITEM_CTGR VALUES ( 8, '삽니다') ;
COMMIT;

DROP SEQUENCE seq_tboard;
DROP SEQUENCE seq_image;

DELETE FROM item_image;

DELETE FROM trade_board;
-- TRADE_BOARD 테이블
-- trade_num ( PK ), member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location

-- ITEM_IMAGE 테이블
-- trade_num, item_image_num (PK) ,item_image_url

-- TRADE_BOARD INSERT 하나 하고 ITEM_IMAGE INSERT를 순차적으로 진행하시면 됩니다.
--
-- 시퀀스 생성
CREATE SEQUENCE seq_tboard INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE seq_image INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;

--
-- 에어팟맥스 새상품
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    seq_tboard.NEXTVAL
    , 1
    , 1
    , '에어팟맥스 새상품'
    , '미개봉 새상품인데 저는 이미 하나 있어서 팔아요'
    ,  SYSDATE
    ,  200000
    , '중동'
    );   
-- 에어팟맥스 새상품
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( seq_image.NEXTVAL, seq_tboard.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/f3cc3e8742b9f393e3a0294691d87e4a24254b200cf7fbde7b1df4c512dd0590.jpg?q=95&s=1440x1440&t=inside&f=webp',1);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( seq_image.NEXTVAL, seq_tboard.CURRVAL,  'https://search.pstatic.net/common/?src=https%3A%2F%2Fshopping-phinf.pstatic.net%2Fmain_8711646%2F87116460443.jpg&type=f372_372',1);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( seq_image.NEXTVAL, seq_tboard.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMDVfMTU4%2FMDAxNzAxNzY0Mjk0MDc4.iDJ3j4hn_JIb1eL1BLSkxrtmFn7PCNcoVusyNmeDzXwg.42yYugGj2rjwedgzSYFmzOer2zHl1bejswZ96rkQsqEg.JPEG.sol__l2%2FKakaoTalk_20231205_170011141_01.jpg&type=a340', 1);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( seq_image.NEXTVAL, seq_tboard.CURRVAL, 'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimage.msscdn.net%2Fimages%2Fgoods_img%2F20240118%2F3806183%2F3806183_17080610408383_500.jpg&type=a340', 1);


-- 접이식 헤어드라이기
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 2
    , 1
    , '다이슨 수퍼소닉 헤어드라이어 블루 블러쉬 판매합니다.'
     , '미개봉 새제품 정품입니다. 직거래는 신장동에서 가능합니다.'
    , '2024-03-01'
    , 100000
    , '중동'
    );
    
-- 접이식 헤어드라이기
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/9887accfc129500a7c887f3a94b6441752b6db9f061b690f82777ec7e06e7ed5_0.webp?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/861b835995343e320e6259fa92c2d3c9b3f059c7b1b226a5cafa3993773daba7_1.webp?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/9887accfc129500a7c887f3a94b6441752b6db9f061b690f82777ec7e06e7ed5_2.webp?q=95&s=1440x1440&t=inside&f=webp', 2);


-- 오븐 토스터
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 3
    , 2
    , '오븐 토스터'
    , '교체를 위해 내놓습니다. 혼자사는 분이라면 충분히 사용할 만한 크기입니다.'
    , '2024-02-28'
    , 40000  
    , '강남역'
    );

-- 오븐 토스터
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/08ec535f0dc069be48db7970231f52a662446f8e07d334b7e44f23d97ffa145f_0.webp?q=95&s=1440x1440&t=inside&f=webp', 3);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/community/community/20240216/2ffbac14-1384-480d-acc4-4fdeb42fabb5.png?&f=webp', 3);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fdnvefa72aowie.cloudfront.net%2Forigin%2Farticle%2F202312%2Fac867456b1fe127309cf94a172a46ac2d514cafc2a982e622383af25493a2f60.jpg%3Fq%3D95%26s%3D1440x1440%26t%3Dinside%26f%3Dwebp&type=sc960_832', 3);

-- 와인 글라스 세트
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 4
    , 2
    , '와인 글라스'
    , '에노테카의 와인글라스입니다. 큰 사이즈로 깨끗한 상태입니다. 눈에 띄는 흠집이나 얼룩없음.'
    , '2024-02-16'
    , 30000  
    , '노원역'
    );
    
-- 와인 글라스 세트
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202402/cc6cf7e733f70887fb9d4963c4e96d22af16021f9a86729c4f1b5f08dd6a8e68.jpg?q=95&s=1440x1440&t=inside&f=webp', 4);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshopping.phinf.naver.net%2Fmain_3754868%2F37548689017.20230131125646.jpg&type=sc960_832', 4);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20230324_114%2F1679637966978NtLwq_JPEG%2FTLbli_100901_7.jpg&type=sc960_832', 4);


 -- 여성의류 캘빈클라인 반팔티
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 5
    , 3
    , '여성의류 캘빈클라인 반팔티 팝니다.'
    , '3회 착용했습니다. 거의 새상품입니다. 직거래 원합니다 쿨거래 가능'
    , '2024-02-04'
    , 25000   
    , '마포역'
    );

 -- 여성의류 캘빈클라인 반팔티
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/51a2ebe878d07f4ff8223922c38bea16a348775645e01ab5ff4fc146499ca61d.jpg?q=95&s=1440x1440&t=inside&f=webp', 5);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimage.musinsa.com%2Fmfile_s01%2F2022%2F04%2F15%2Fff67c3458fdaa4d4f3b5e3dc23c5506d184029.jpg&type=sc960_832', 5);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA1MTVfOTkg%2FMDAxNjg0MTUwNTU0MjM4.QyxnLWV6NqLFYleqyR-PK8W_Z7_hgeoXg2RKDEQ6QdQg.kWGLc6KYE0tnxdvtGlQHbtkfQ79kteDu199f559s1Tog.JPEG.tnstnqorqo%2FIMG_8125.JPG&type=sc960_832', 5);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL, 'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fck-s3.s3.ap-northeast-2.amazonaws.com%2Fecom%2F24SS%2FCKJ%2FJ223860-YAF%2FJ223860-YAF-ITEM-2.jpg&type=a340', 5);

-- 까스텔바작 골프의류 니트조끼 사이즈 95
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES ( 
    SEQ_TBOARD.NEXTVAL
    , 6
    , 3
    , '까스텔바작 골프의류 니트조끼 사이즈95'
    , '까스텔바작 골프의류 니트조끼 사이즈95 몇 번 안입었습니다.'
    , '2024-02-01'
    , 35000
    , '수성구청'
    ); 

-- 까스텔바작 골프의류 니트조끼 사이즈 95
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20210828_228%2F163013337942202vwE_JPEG%2F31269162995911619_1021975160.jpg&type=sc960_832', 6);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20210710_203%2F1625916196021Ubx5S_JPEG%2F33380828139819908_936957536.jpg&type=sc960_832', 6);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fccimg.hellomarket.com%2Fimages%2F2023%2Fitem%2F02%2F16%2F13%2F2522936_5731861_1.jpg%3Fsize%3Ds6&type=sc960_832', 6);


-- 메리다 어린이 자전거
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 7
    , 4
    , '메리다 어린이 자전거'
    , '주니어 자전거입니다. 사용감 있습니다. 직접오셔야해요'
    , '2024-01-30'
    , 70000
    , '좌동'
    );   

-- 메리다 어린이 자전거
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/ac29d7c003f5c248866caf0beb4b197ecfad62315987dbb241d512aa66d4d574_0.webp?q=95&s=1440x1440&t=inside&f=webp', 7);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA0MjdfNTEg%2FMDAxNTI0ODMwNDU5MjM0.EEzN1PjwOjDrsQt6AMdKGUGqZ7GWp8FE17w6Ff5oLgYg.1SUuiexNmY8B7L9vEgMnjcYzvX_iUZdZP0cOvF7ZHZUg.JPEG.1984velo%2FKakaoTalk_20180427_200934077.jpg&type=sc960_832', 7);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fcafefiles.naver.net%2FMjAxOTA0MDdfMjcg%2FMDAxNTU0NTkxMTA2ODE1.uCJ7D0xtEAz85zKy0c510bZML4FGoZPPWw1kRX9mRrMg.H7DLcFWg2Iry0ZOJ9A0a_keNHGjIOQVRJSF9H5_Olygg.JPEG.kyungin0315%2FAE5B12D6-F4F9-451A-8825-8A539D88F208.jpeg&type=sc960_832', 7);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAxMjdfMjA3%2FMDAxNzA2MzQzNjc5MjE0.Ma3dduyAiiLYPyGbnhlADUZnC0ftAZaNrGO8eAUveKgg.z9rEJ1hwJtwifePsI2izr_uxh7kWulM94rqEmSpUfmIg.JPEG.okuro1977%2F%25B8%25DE%25B8%25AE%25B4%25D920.jpg&type=sc960_832', 7 );


-- 아동 사운드펜
INSERT INTO TRADE_BOARD ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES (
    SEQ_TBOARD.NEXTVAL
    , 8
    , 4
    , '아동 사운드펜 팝니다.'
    , '해요펜과 함께 볼 수 있는 영어책입니다. 잘 안봐서 책은 깨끗해요~'
    , TO_DATE('2023-02-23','YY-MM-DD')
    , 15000
    , '중동 스타벅스'
    );     
    
-- 아동 사운드펜
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,  'https://dnvefa72aowie.cloudfront.net/origin/article/202403/c05c5dbd0a7f9024e140997cfb00a0d97aba1a67ef280682dccd3a3eabadd00a_0.webp?q=95&s=1440x1440&t=inside&f=webp', 8);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAxMDRfNTkg%2FMDAxNzA0MzU5MzQ2MzYw.SnuXXedY-d-o69g7wa4U5rFq0uOGx6I8m3gT5VMX6k4g.iU1C4BUd1IQ-xeHEp-e9wT-lwvUk6IKjj8mFlZZB-SQg.JPEG.yaena1143%2FIMG_2961.jpg&type=sc960_832', 8);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20200304_158%2F1583306549050vLuw0_JPEG%2F20668882615659850_1383306984.jpg&type=sc960_832', 8);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL,'https://search.pstatic.net/common/?src=http%3A%2F%2Fcafefiles.naver.net%2FMjAxOTExMjhfMjYg%2FMDAxNTc0OTIwNDE3NTQ4.SBjpdDpT1NVClTOyhy6zoEA5iYg_cuLKEbkcDoP5JDYg.E7Z3seCuctdf6b5lvyjmUFFmfN8mNrg_v1sdRLk1-ZUg.JPEG%2FexternalFile.jpg&type=sc960_832', 8);
INSERT INTO item_image ( item_image_num , trade_num , item_image_url, member_num)
VALUES ( SEQ_IMAGE.NEXTVAL, SEQ_TBOARD.CURRVAL, 'https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20220503_138%2F1651533711184nSJx7_JPEG%2F52669539010215726_920666573.jpg&type=sc960_832', 8);

-- 모니터 거래
INSERT INTO trade_board ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES 
    ( 
    seq_Tboard.NEXTVAL
    , 1
    , 1
    , '모니터 24인치 커브드 AK'
    , '사무실에서 사용했습니다 집기처분 중입니다. 커브드로 보기좋아요'
    , TO_DATE('2023-02-21','YY-MM-DD')
    , 20000
    , '중동'
    );

-- 모니터 거래 이미지
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202309/e66df18442ef31f0ebb34d6171d91626863ea6cacdc7e4bc3ef91241d3daafa7.jpg?q=95&s=1440x1440&t=inside&f=webp', 1);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202309/5dca6ae7ff3000b33d78f98595a1f0bbbce56472bcdbd7c1ec4628aab36802c9.jpg?q=95&s=1440x1440&t=inside&f=webp', 1);



-- 주니어 자전거
INSERT INTO trade_board ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES 
    ( 
    seq_tboard.NEXTVAL
    , 2
    , 5
    , 'RITE WAY 주니어 자전거'
    , '18 인치 주니어 자전거입니다. 1년간의 사용이므로 상태는 좋습니다만, 약간의 스크래치라면 신경이 쓰이지 않는 분의 연락을 기다리고 있습니다.'
    , TO_DATE('2023-01-30','YY-MM-DD')
    , 1000000
    , '강남역'
    );

-- 주니어 자전거 이미지     
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/a42229bfc28ea3427d8a61c3032e91bd91d557fef62de6b5b136adf6c1373c53.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/d32d07b745d60a6d252608cce09a3fdfaebfab329a6fc4bd433d6fa0033a83b1.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/ad34d9b59c5e2d1a586113bed1262ff763323741f7c331382e620c293e941d75.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/8c9314be1295267df2b22832cd46b3be30c12e4e1cd552d293a52e1caa9198db.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202401/7e7eff3d0e19c0f0d63bea281872492944515ebc25e729a4ba60d02275011ea2.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);


-- 아이폰 거래
INSERT INTO trade_board ( trade_num, member_num, selitem_ctgr_num, trade_title, trade_content, upload_date, trade_price, trade_location)
VALUES 
    ( 
    seq_tboard.NEXTVAL
    , 2
    , 1
    , 'iPhone 8 Gold 64GB'
    , '심 잠금 해제 된 아이폰입니다. 배터리 최대 용량: 95% .'
    , TO_DATE('2023-01-21','YY-MM-DD')
    , 350000
    , '강남역'
    );

-- 아이폰 거래 이미지
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202210/CF1D735E3998828421B45FCBD98687B733405FCF51E2EA8FD64219FD7A741EE0.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202210/E9E849356D1CB51E516EB459E5D593F8159705A15FEAF2C899783737A4EB0C7A.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);
INSERT INTO item_image ( trade_num, item_image_num, item_image_url, member_num)
VALUES ( seq_tboard.CURRVAL, seq_image.NEXTVAL, 'https://d3pl61q8x5fmnh.cloudfront.net/origin/article/202210/6EA3286D098D6EF7041FACC4CD0210F197F872987848678C25130E5E848FDEFF.jpg?q=95&s=1440x1440&t=inside&f=webp', 2);

COMMIT;


-- CHAT 테이블, 채팅방 넘버 ( PK ), 회원 넘버, 회원 넘버2
CREATE SEQUENCE SEQ_CHATROOM_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 1, 2);

INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 3, 5);

INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 1, 10);

INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 2, 8);

INSERT INTO chat
VALUES(SEQ_CHATROOM_ID.NEXTVAL, 6, 9);


-- CHAT_BOARD 테이블, 채팅방 넘버, 채팅 넘버 ( PK ), 회원넘버, 채팅내용, 채팅시간
CREATE SEQUENCE SEQ_CHATCONTENT_ROOM1_ID 
START WITH 1
INCREMENT BY 1;

SELECT * FROM trade_board;



INSERT INTO chat_board(trade_num,chat_num, CHAT_CONTENT, CHAT_TIME )
VALUES (1,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '안녕하세요~ 혹시 물건 팔렸나요?','11시 23분');



INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (2,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '직거래 하고싶은데 가능하신가요?', '12시 24분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (2,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '그럼 역삼동까지 오실수 있으신가요?', '14시 20분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (2,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '네 그럼 6시까지 거기로 가겠습니다', '15시 15분');



INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (3,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '감사합니다 좋은 하루 되세요', '08시 23분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (3,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '네 오늘 거래 잘 해주셔서 감사했습니다~', '10시 03분');



INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (4,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '혹시 남자 친구 있으세요?', '19시 56분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (4,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '네~ 있어요 :)', '20시 01분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (4,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '네 혹시 없으시면... 예 수고용', '21시 00분');

--


INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (5,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '혹시 물건 팔렸나요?', '15시 31분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (5,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '아니요 아직 판매중입니다', '17시 28분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (5,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, '혹시 제가 바빠서 그런데 택배로 보내주실수 있을까요?', '17시 30분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (5,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, 'ㄴㄴ ㅈㅅ 직거래만합니다', '17시 42분');

INSERT INTO chat_board(trade_num, CHAT_NUM, CHAT_CONTENT, CHAT_TIME )
VALUES (5,SEQ_CHATCONTENT_ROOM1_ID.NEXTVAL, ' ㅇㅋ ㅅㄱㅇ ', '17시 50분');


commit;

-- 신고
CREATE SEQUENCE SEQ_REPORT_ID
START WITH 1
INCREMENT BY 1;

-- 프로시저로 인서트

-- BLOCK 테이블, 회원넘버1, 회원넘버2

-- 프로시저로 인서트

-- 공지사항 게시판
-- 공지사항 넘버(pk), 관리자넘버, 제목, 내용, 날짜
CREATE SEQUENCE SEQ_NOTICE_BOARD_ID
START WITH 1
INCREMENT BY 1;

INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 1, '저희 당근은 네고 불가입니다', '저희 당근은 금일부로 네고할 수 없습니다. 네고시 회원자격을 박탈하겠습니다.', SYSDATE);

INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 2, '의료광고 심의필 작성 방법 공지', '의료광고의 경우, 필수적으로 의료광고 심의필란에 심의필 번호를 작성해 주시기 바랍니다. 심의필란에 작성하지 않고, 다른 위치에 작성한 경우 심사 시 승인이 어려울 수 있습니다.', '2023-03-30');

INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 1, '통계 집계 오류 해결', '통계 화면에서 9월 26일 이후의 조회수 등 방문 데이터가 노출되지 않았어요.
                                                           10월 4일 장애 복구 완료 하였으며, 모든 일자에서 정상적으로 통계를 확인하실 수 있어요.
                                                           이용에 불편을 드려 대단히 죄송합니다.
                                                           보다 안정적인 서비스를 제공하는 당근 비즈니스가 되겠습니다.', '2023-06-21');
                                                           
INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 2, '전문가모드 사례공모전 안내', '당근 전문가모드와 함께 비즈니스의 성장을 만들어낸 여러분의 이야기를 담아내는, ‘제 1회 전문가모드 사례 공모전’이 시작되었어요.', '2023-08-12');

INSERT INTO notice_board
VALUES(SEQ_NOTICE_BOARD_ID.NEXTVAL, 3, '에어컨 견적 요청을 손쉽게 받아보세요.', '고객이 보낸 견적 요청을 확인하고 견적을 보낼 수 있어요. 견적 요청서에 제품 정보와 요청 내용이 담겨 있어 매번 직접 정보를 물어봐야 했던 번거로움이 사라져요.', '2024-02-16');

COMMIT;


-- 동네생활 카테고리 테이블
--동네생활 카테고리 넘버 ( PK ), 동네생활 카테고리 이름

INSERT INTO comm_ctgr VALUES( 1,'인기');
INSERT INTO comm_ctgr VALUES( 2,'자유');
INSERT INTO comm_ctgr VALUES( 3,'질문');
INSERT INTO comm_ctgr VALUES( 4,'정보공유');
INSERT INTO comm_ctgr VALUES( 5,'분실');
INSERT INTO comm_ctgr VALUES( 6,'사건사고');

COMMIT;

-- 동네생활 게시판
-- COMM_BOARD 테이블 
-- COMM_BOARD_NUM ( PK ), COMM_CTGR_NUM, MEMBER_NUM, COMM_TITLE, COMM_CONTENT, COMM_UPLOAD_DATE
CREATE SEQUENCE SEQ_BOARD
START WITH 1
INCREMENT BY 1;


INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'누구든지 하루에 10분만 투자하면 부자가 될 수 있습니다. ','부자되는 법',1,to_date('21-04-23','yy-mm-dd'),9);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'전31살 남자고 인천공항에 일때문에 픽업 가는데 공항가시는분 있으면공항까지 카풀합니다 ~ 연휴때 고향내려가는 차편 매진?瑛뻑 어떤분이 감사하게도 카풀해주셔서 편하게 갔던 기억이있어서 올려봅니다^^ ','내일 (3.7)오전 6시30분 출발 동수원사거리쪽에서',1,to_date('20-01-13','yy-mm-dd'),6);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'치킨먹고싶어요 있으면 좋겠다 ','망포동쪽에 치킨트럭 온데 있어요?',1,to_date('22-11-03','yy-mm-dd'),7);

INSERT INTO comm_board(comm_board_num,comm_content,comm_title,comm_ctgr_num,comm_upload_date,member_num)
VALUES(seq_board.nextval,'보통 기존에 살던 전세집 계약일 몇달전에 집을 알아보나요?  예를 들어 8월말이 만료라면 언제부터 새로 계약할 전세집을 알아보는게 좋을까요?
 ','전세 계약 궁금증',2,to_date('24-01-01','yy-mm-dd'),3);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'안녕하세요:) 얼마 전 수원 이사와서 기존 풋살팀은 갈수 없게 되어  성인 축구교실이라도 다녀볼까 합니다.  괜찮은 곳 있으면 소개 부탁드려요 감사합니다
 ','망포근처 성인축구교실 문의드립니다',2,to_date('23-07-16','yy-mm-dd'),1);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,' 히피펌 하고 싶은데
 ','남자 펌 잘하는 곳 있나요',2,to_date('23-09-12','yy-mm-dd'),2);
 
INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,' 댓글 달아주세요!
 ','베이스 치시는분 계신가요?',3,to_date('23-05-02','yy-mm-dd'),4);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'저랑 해장국에 소주한잔하실래요? 3 0 남
 ','망포역근처퇴근하신분',3,to_date('23-06-11','yy-mm-dd'),8);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'지금 영통구청 앞에 버거킹쪽에 사람많고 촬영하는데 뭔지 아시는분?
 ','지금 영통구청 앞에 버거킹쪽에 사람많고 촬영하는데 뭔지 아시는분?',3,to_date('23-10-01','yy-mm-dd'),7);
 
 
INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'영통부근에 좋은내과좀 알려주십시요. 지금 다니는 연세내과 맘에 안들어서요. 너무 상업적으로 환자를 상대하는것 같아요
 ','병원문의',4,to_date('23-05-10','yy-mm-dd'),4);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'너무 목이 간질거리며 심하게 기침이 나옵니다', '병원 안내좀 해주시면 감사합니다.', 4, to_date('23-01-21','yy-mm-dd'),8);


INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'영통구 쪽에 옥탑방을 좀 구하고 싶은데요, 매물이 잘 없네요ㅠ 앱 말고 방 찾아볼 수 있는 방법좀 있을까요?
 ','영통구 옥탑방',4,to_date('23-12-11','yy-mm-dd'),5);


INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'어른 중간 정강이까지 오는 크기의 갈색 포메라니안 입니다 보신 분은 댓글 달아주세요 ㅜㅜ',  '저희 집 백돌이를 읽어 버렸어요 ㅜㅡㅜ
',5,to_date('23-02-12','yy-mm-dd'),9);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'오늘 오후 5시에 망포역에서 국민은행 체크카드 분실했는데 매장에 들어오 분실물이 없다고 하네요 혹시
보신 분 계시면 댓글로 좀 알려주세요 ㅜㅜㅜ','오늘 오후 5시에 망포역 스타벅스에서 카드 주우신분?',5,to_date('23-06-01','yy-mm-dd'),1);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'오늘 경희대 앞에 자전거를 잠깐 세워놨는데 누가 가져갔네요 저한테 정말 소중한 자전거 입니다 혹시 찾아 주시는 분 있으면 사례 해드릴게요 ㅜㅜ 
로드 바이크고 색상은 빨강색입니다.!!',
'오늘 오전 9시쯤 자전거를 잃어 버렸습니다. ',5,to_date('23-01-30','yy-mm-dd'),4);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'오늘 홈플러스 1층 이디야 앞 복도에서 우리은행 체크카드를 주웠습니다. 그냥 경찰에 가져다 줄까 하다가 여기에다 글 올립니다!! 카드 주인은 김x진 98년1월 30일 생이라고 적혀있습니다.!',
' 체크카드를 주웠습니다. ',5,to_date('24-02-27','yy-mm-dd'),6);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'어제 밤 수원대 근처 호수에서 50대 여자시신이 발견됐다고 하네요 ㅜㅜ 다들 조심하세요',
' 수원대 여자 시신 ',6,to_date('24-03-06','yy-mm-dd'),3);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'요즘 밤만 되면 전깃 줄에 까마귀 떼들이 앉아서 난리네요 ㅜㅜ 저번에 새똥 맞을 뻔 했는데 다들 전깃줄 밑으로는 지나다니시지 않는게 좋을거 같아요 !!',
' 까마귀 떼 ',6,to_date('23-08-27','yy-mm-dd'),4);

INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'오늘 영동초등학교 앞에서 우회전 하는 차량에 초등학생 아이가 치여 크게 다쳤다고 하네요 차량들도 조심히 다녀야 겠지만 집안에서 각자 아이들에게 교통 교육을 확실히 시킬 필요가 있을거 같네요 ㅜㅜ 걱정이 많습니다 ㅜㅜㅜㅜ',
' 영동초 앞 교통사고 ',6,to_date('23-2-27','yy-mm-dd'),2);


INSERT INTO comm_board(COMM_BOARD_NUM,COMM_CONTENT,COMM_TITLE,COMM_CTGR_NUM,COMM_UPLOAD_DATE,MEMBER_NUM)
VALUES(seq_board.nextval,'오늘 큰 사거리에 있는 5백년 된 나무가 번개를 맡고 부러졌네요 ㅜㅜ 뭔가 마을을 지켜주는 수호신 같은 존재였는데 부러지니까 괜히 마음이 안 좋습니다 ㅜㅜ',
'500년 된 나무 ... ',6,to_date('22-08-16','yy-mm-dd'),8);

COMMIT;

-- COMM_BOARD_LIKE  테이블
-- 동네생활 게시판 좋아요 넘버( PK )
--회원 넘버
--동네생활 게시판 넘버
CREATE SEQUENCE SEQ_COMM_LIKE
START WITH 1
INCREMENT BY 1;


INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,1,1);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,5,3);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,7,13);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,3,12);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,3,10);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,8,5);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,9,4);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,7,9);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,6,4);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,5,12);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,3,16);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,6,12);

INSERT INTO comm_board_like Values(SEQ_COMM_LIKE.NEXTVAL,7,11);


COMMIT;

-- 동네생활 댓글  
-- COMM_BOARD_NUM  , COMM_NUM ( PK ) , COMM_WRITER_NICKNAME, COMM_DATE, COMM_CTGR_NAME, COMM_CONTENT

-- 댓글 넘버 시퀀스 생성
CREATE SEQUENCE SEQ_COMM_NUM
START WITH 1
INCREMENT BY 1;

SELECT * FROM comm_board;


--1
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (1, SEQ_COMM_NUM.NEXTVAL, 8, '2023-01-14', '유익한 내용이었습니다');
--2
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (2, SEQ_COMM_NUM.NEXTVAL, 4, '2020-01-15', '혹시 카풀 가능할까요?');
--3
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (3, SEQ_COMM_NUM.NEXTVAL, 5, '2022-11-03', '화요일 아니었나?');
--4
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (4, SEQ_COMM_NUM.NEXTVAL, 7, '2024-01-01', '부동산에 물어보면 정확할듯');
--5
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (5, SEQ_COMM_NUM.NEXTVAL, 3, '2023-07-16', '우리팀 들어오실래여?');
--6
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (6, SEQ_COMM_NUM.NEXTVAL, 4, '2023-09-12','마로 미용실 괜찮음.');
--7
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (7, SEQ_COMM_NUM.NEXTVAL, 8, '2023-05-02', '베이스 배우려면 전화주세요 010-2245-8243');
--8
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (8, SEQ_COMM_NUM.NEXTVAL, 7, '2023-06-11', '어디로 가면됩니까? 같이 한 잔 하시죠.');
--9
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (9, SEQ_COMM_NUM.NEXTVAL, 5, '2023-10-01', '생생 정보통인듯?');
--10
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (10, SEQ_COMM_NUM.NEXTVAL, 3, '2023-05-10', '바로내과로 가요. 거기 원장님 진료 잘봐줘요.');
--11
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (11, SEQ_COMM_NUM.NEXTVAL, 2, '2023-01-21', '광수형내과나 바로 내과로 가시면 좋아요!');
--12
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (12, SEQ_COMM_NUM.NEXTVAL, 2, '2023-12-11', '저희 부동산으로 오세요. 잘해드릴게! 천사부동산 검색.');
--13
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (13, SEQ_COMM_NUM.NEXTVAL, 1, '2023-02-12', '꼭 찾으시길 바랄게여.');
--14
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (14, SEQ_COMM_NUM.NEXTVAL, 9, '2023-06-01', '카드 무슨색이었나요?');
--15
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (15, SEQ_COMM_NUM.NEXTVAL, 7, '2023-01-30', '헉! 혹시 몰라서 제가 경찰서에다가 놨어요.');
--16
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (16, SEQ_COMM_NUM.NEXTVAL, 10, '2024-02-27', '그거 제꺼인데 지금 어디 계시나요?');
--17
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (17, SEQ_COMM_NUM.NEXTVAL, 5, '2024-03-06', 'ㄷㄷ 개무섭네여;');
--18
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (18, SEQ_COMM_NUM.NEXTVAL, 7, '2023-08-27', '민원 넣었는데도 쉽지 않나봐요 ㅠㅠ');
--19
INSERT INTO COMM_CMT (COMM_BOARD_NUM, COMM_NUM, MEMBER_NUM,  COMM_DATE, COMM_CONTENT)
VALUES (19, SEQ_COMM_NUM.NEXTVAL, 8, '2023-2-27', '우리 딸한테도 말해놔야겠네요. 감사합니다.');




-- 동네생활 대댓글
-- RCMT_NUM, COMM_NUM, RCMT_WRITER_NICKNAME ( PK ), CMT_BOARD_NUM, RCMT_CONTENT, RCMT_DATE
CREATE SEQUENCE SEQ_RCMT_NUM
START WITH 1
INCREMENT BY 1;


--1
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (1, 1, SEQ_RCMT_NUM.NEXTVAL, 9, '더 유익한 내용으로 찾아 뵙겠습니다.', '2023-01-15');
--2
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (2, 2, SEQ_RCMT_NUM.NEXTVAL, 6, '지금 어디 계시나요? 저 출발해야되서...', '2020-01-15');
--3
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (3, 3, SEQ_RCMT_NUM.NEXTVAL, 4, 'ㅇㅇ 화요일 맞는듯', '2022-11-03');
--4
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)       
VALUES (4, 4, SEQ_RCMT_NUM.NEXTVAL, 6, '우리부동산 전화주세요 010-6547-2321', '2024-01-01');
--5
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (5, 5, SEQ_RCMT_NUM.NEXTVAL, 2, '할 곳이 있나?', '2023-07-16');
--6
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (6, 6, SEQ_RCMT_NUM.NEXTVAL, 5, 'ㄴㄴ 마로 미용실 구림 가지마셈', '2023-09-12');
--7
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (7, 7, SEQ_RCMT_NUM.NEXTVAL, 1, '저도 같이 껴도 될까요?', '2023-05-02');
--8
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (8, 8, SEQ_RCMT_NUM.NEXTVAL, 10, '네, 생생 정보통 맞는듯', '2023-06-11');
--9
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (9, 9, SEQ_RCMT_NUM.NEXTVAL, 4, '맞아요, 바로내과 저도 추천!!!', '2023-10-01');
--10
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (10, 10, SEQ_RCMT_NUM.NEXTVAL, 6, '바로 내과로 가시는 게 좋아요!', '2023-05-10');
--11
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (11, 11, SEQ_RCMT_NUM.NEXTVAL, 9, '요즘 전세 사기 많아서 부동산도 못믿음', '2023-01-21');
--12
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (12, 12, SEQ_RCMT_NUM.NEXTVAL, 3, '찾으셨나요?', '2023-12-11');
--13
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (13, 13, SEQ_RCMT_NUM.NEXTVAL, 5, '아까 가게에서 본 것 같은데...', '2023-02-12');
--14
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (14, 14, SEQ_RCMT_NUM.NEXTVAL, 4, '그걸 왜 경찰서에?...', '2023-06-01');
--15
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (15, 15, SEQ_RCMT_NUM.NEXTVAL, 8, '빨간색인가? 본 것 같은데?', '2023-01-30');
--16
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (16, 16, SEQ_RCMT_NUM.NEXTVAL, 10, '찾았나보네', '2024-02-27');
--17
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (17, 17, SEQ_RCMT_NUM.NEXTVAL, 2, '뉴스에도 나왔던데 너무 무서웠음 ㅠㅠ', '2024-03-06');
--18
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (18, 18, SEQ_RCMT_NUM.NEXTVAL, 4, '진짜 너무 시끄러워요! 빨리 해결됐으면..', '2023-08-27');
--19
INSERT INTO CMT_REPLY (CMT_BOARD_NUM, COMM_NUM, RCMT_NUM, MEMBER_NUM, RCMT_CONTENT, RCMT_DATE)
VALUES (19, 19, SEQ_RCMT_NUM.NEXTVAL, 5, '우리 아들도 큰일날 뻔 했던거 생각나네요.', '2023-2-27');

COMMIT;


-- 동네생활 댓글 좋아요 테이블
-- COMM_CMT_LIKE ( PK ), COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM

CREATE SEQUENCE SEQ_COMM_CMT_LIKE
START WITH 1
INCREMENT BY 1;

--1
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 1, 1, 2);
--2
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 1, 3, 8);
--3
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 2, 7, 4);
--4
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 3, 7, 2);
--5
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 2, 3, 1);
--6
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 7, 5, 10);
--7
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 1, 4, 3);
--8
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 10, 4, 6);
--9
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 15, 6, 5);
--10
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 19, 7, 7);
--11
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 18, 1, 4);
--12
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 16, 8, 2);
--13
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 1, 9, 3);
--14
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 12, 10, 1);
--15
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 3, 8, 4);
--16
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 7, 3, 8);
--17
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 6, 1, 3);
--18
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 5, 9, 6);
--19
INSERT INTO COMM_CMT_LIKE (COMM_CMT_LIKE, COMM_BOARD_NUM, MEMBER_NUM, CMT_NUM)
VALUES (SEQ_COMM_CMT_LIKE.NEXTVAL, 15, 9, 3);

COMMIT;

-- 동네생활 대댓글 좋아요 테이블
-- RCMT_LIKE_NUM ( PK ), RCMT_NUM, MEMBER_NUM
CREATE SEQUENCE SEQ_RCMT_LIKE
START WITH 1
INCREMENT BY 1;


--1
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 1, 1);
--2
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 10, 1);
--3
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 9, 6);
--4
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 4, 7);
--5
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)      
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 3, 8);
--6
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 1, 9);
--7
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)      
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 2, 8);
--8
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 4, 7);
--9
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 8, 1);
--10
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)       
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 6, 2);
--11
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 7, 2);
--12
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 3, 5);
--13
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 2, 5);
--14
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 5, 2);
--15
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 6, 4);
--16
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 7, 10);
--17
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 4, 7);
--18
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 2, 5);
--19
INSERT INTO CMT_REPLY_LIKE (RCMT_LIKE_NUM, RCMT_NUM, MEMBER_NUM)
VALUES (SEQ_RCMT_LIKE.NEXTVAL, 1, 5);







-- TRADE_BOARD_LIKE 테이블 ( 트리거로 중복 좋아요 처리 )
-- trade_like_num  (PK), trade_num, member_num

-- 물품 게시판 좋아요 시퀀스
CREATE SEQUENCE seq_tboard_like 
INCREMENT BY 1 
START WITH 1 
NOCYCLE NOCACHE;

SELECT * FROM trade_board_like;

DROP SEQUENCE seq_tboard_like;

DELETE FROM trade_board_like;

INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 1, 1);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 1);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 3, 1);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 1, 2);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 3);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 1, 4);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 2);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 3, 2);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 1, 5);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 5);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 4);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 1, 3);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 6);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 7);
INSERT INTO trade_board_like (trade_like_num, trade_num, member_num) VALUES  ( seq_tboard_like.NEXTVAL, 2, 8);

COMMIT;


