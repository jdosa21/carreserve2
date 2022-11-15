package kr.co.bumil.car_rs_project.Entity;
import lombok.*;


import javax.persistence.*;

@Getter // getter 메소드 생성
@Setter
@Builder // 빌더를 사용할 수 있게 함
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name="reservation_logs") // 테이블 명을 작성
public class ReservationLogsEntity {

    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long logId;

    @Column(name = "rs_id",nullable = false, length = 150)
    private Long rsId;

    @Column(name = "rs_purpose",nullable = false, length = 200)
    private String rsPurpose;

    @Column(name = "drv_distance",nullable = false, length = 200)
    private Integer drvDistance;

    @Column(nullable = false, length = 25)
    private String note;

    public ReservationLogsEntity(Long rsId, String rsPurpose, Integer drvDistance, String note) {
        this.rsId = rsId;
        this.rsPurpose = rsPurpose;
        this.drvDistance = drvDistance;
        this.note = note;

    }
    
}
