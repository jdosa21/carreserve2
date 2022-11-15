DROP TABLE car4.car;
DROP TABLE car4.journal;
DROP TABLE car4.reserve;
DROP TABLE car4.user_info;


CREATE TABLE IF NOT EXISTS `car4`.car
(
  id     INT(11)      NOT NULL AUTO_INCREMENT COMMENT 'PK',
  name  TEXT NOT NULL COMMENT '차종',
  num    TEXT  NOT NULL COMMENT '차량번호',
  km  TEXT      NOT NULL COMMENT '주행거리',
  PRIMARY KEY (id)
) COMMENT '차량';

CREATE TABLE IF NOT EXISTS `car4`.journal
(
  id   INT(11)      NOT NULL AUTO_INCREMENT COMMENT 'PK',
  jkm  TEXT NOT NULL COMMENT '차종',
  condi    TEXT  NOT NULL COMMENT '차량상태',
  uni  TEXT      NOT NULL COMMENT '특이사항',
  jname  TEXT      NOT NULL COMMENT '예약자 이름',
  jcarnum  TEXT      NOT NULL COMMENT '예약된 차량번호',
  jrt  TEXT      NOT NULL COMMENT '예약된 시간',
  jdest  TEXT      NOT NULL COMMENT '행선지',
  jpurpose  TEXT      NOT NULL COMMENT '사용 목적',
  date  DATETIME      NOT NULL COMMENT '등록시간',
  PRIMARY KEY (id)
) COMMENT '운행일지';

CREATE TABLE IF NOT EXISTS `car4`.reserve
(
  id     INT(11)      NOT NULL AUTO_INCREMENT COMMENT 'PK',
  purpose  TEXT NOT NULL COMMENT '사용 목적',
  dest    TEXT  NOT NULL COMMENT '행선지',
  rt  TEXT      NOT NULL COMMENT '예약 시간',
  rcarnum  TEXT      NOT NULL COMMENT '예약 차량번호',
  rname  TEXT      NOT NULL COMMENT '예약자 이름',
  PRIMARY KEY (id)
) COMMENT '예약정보';



CREATE TABLE IF NOT EXISTS `car4`.user_info
(
  id     INT(11)      NOT NULL AUTO_INCREMENT COMMENT 'PK',
  email  TEXT NOT NULL COMMENT '이름',
  password    TEXT  NOT NULL COMMENT '비밀번호',
  auth  TEXT      NOT NULL COMMENT '접근권한',
  PRIMARY KEY (id)
) COMMENT '회원정보';

