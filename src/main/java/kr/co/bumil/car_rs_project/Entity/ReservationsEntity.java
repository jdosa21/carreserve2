package kr.co.bumil.car_rs_project.Entity;
import lombok.*;

import java.sql.Timestamp;

import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@Getter // getter 메소드 생성
@Setter
@Builder // 빌더를 사용할 수 있게 함
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name="reservations") // 테이블 명을 작성
public class ReservationsEntity {

    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long rsId;

    @Column(name = "car_id",nullable = false, length = 150)
    private Long carId;

    @Column(name = "user_id",nullable = false, length = 150)
    private Long userId;

    @DateTimeFormat(pattern = "yyyy/MM/dd HH:mm")
    @Column(name = "rs_date",nullable = false, length = 150)
    private Timestamp rsDate;

    @DateTimeFormat(pattern = "yyyy/MM/dd HH:mm")
    @Column(name = "re_date",nullable = false, length = 150)
    private Timestamp reDate;

    @Column(name = "destination",nullable = false, length = 150)
    private String destination;

    @Column(name = "re_at",nullable = false, length = 150)
    private String reAt;
    
    @Column(name = "rs_at",nullable = false, length = 150)
    private String rsAt;
    
    @Column(name = "log_at",nullable = false, length = 150)
    private String logAt;

    public ReservationsEntity(Long carId,Long userId,Timestamp rsDate, Timestamp reDate,  String destination,String reAt,String rsAt,String logAt) {
        
        this.carId = carId;
        this.userId = userId;
        this.rsDate = rsDate;
        this.reDate = reDate;
        this.destination = destination;
        this.reAt = reAt;
        this.rsAt = rsAt;
        this.logAt = logAt;

    }
    
}
