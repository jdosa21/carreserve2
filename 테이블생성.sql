
DROP TABLE car2.reservation_logs;
DROP TABLE car2.reservations;
DROP TABLE car2.cars;
DROP TABLE car2.users;


CREATE TABLE IF NOT EXISTS `car2`.cars
(
  car_id     BIGINT       NOT NULL AUTO_INCREMENT COMMENT 'PK',
  car_type   VARCHAR(100) NOT NULL COMMENT '차종',
  car_num    VARCHAR(20)  NOT NULL COMMENT '차량번호',
  distance   INTEGER      NOT NULL COMMENT '주행거리',
  driving_at CHAR         NOT NULL COMMENT '주행여부',
  PRIMARY KEY (car_id)
) COMMENT '차량';

CREATE TABLE IF NOT EXISTS `car2`.users
(
  user_id    BIGINT      NOT NULL AUTO_INCREMENT COMMENT 'PK',
  pw         VARCHAR(20) NOT NULL,
  id         VARCHAR(15) NOT NULL,
  name       VARCHAR(20) NOT NULL,
  email      VARCHAR(50) NOT NULL,
  manager_at CHAR        NOT NULL DEFAULT '0' COMMENT '관리자여부',
  PRIMARY KEY (user_id)
) COMMENT '회원';

CREATE TABLE IF NOT EXISTS `car2`.reservations
(
  rs_id       BIGINT       NOT NULL AUTO_INCREMENT COMMENT 'PK',
  car_id      BIGINT       NOT NULL COMMENT 'FK',
  user_id     BIGINT       NOT NULL COMMENT 'FK',
  rs_date     DATETIME     NOT NULL COMMENT '예약일시',
  re_date     DATETIME     NOT NULL COMMENT '반납일시',
  destination VARCHAR(200) NOT NULL COMMENT '목적지',
  re_at       CHAR         NOT NULL COMMENT '반납여부',
  log_at      CHAR         NOT NULL COMMENT '일지작성 여부',
  rs_at       CHAR         NOT NULL COMMENT '예약여부',
  PRIMARY KEY (rs_id),
  FOREIGN KEY (car_id) REFERENCES cars (car_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
) COMMENT '예약';



CREATE TABLE IF NOT EXISTS `car2`.reservation_logs
(
  log_id       BIGINT        NOT NULL AUTO_INCREMENT COMMENT 'PK',
  rs_id        BIGINT        NOT NULL COMMENT 'FK',
  rs_purpose   VARCHAR(1000) NOT NULL COMMENT '예약목적',
  drv_distance INTEGER       NOT NULL COMMENT '운행거리',
  note         VARCHAR(1000) NULL     COMMENT '비고',
  PRIMARY KEY (log_id),
  FOREIGN KEY (rs_id) REFERENCES reservations (rs_id)
) COMMENT '예약일지';

