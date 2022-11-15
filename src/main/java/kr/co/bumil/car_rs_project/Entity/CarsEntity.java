package kr.co.bumil.car_rs_project.Entity;
import lombok.*;


import javax.persistence.*;

@Getter // getter 메소드 생성
@Setter
@Builder // 빌더를 사용할 수 있게 함
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name="cars") // 테이블 명을 작성
public class CarsEntity {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long carId;

    @Column(name = "car_type", nullable = false, length = 150)
    private String carType;

    @Column(name = "car_num",nullable = false, length = 200)
    private String carNum;

    @Column(nullable = false, length = 200)
    private Integer distance;

    @Column(name = "driving_at",nullable = false, length = 25)
    private String drivingAt;

    public CarsEntity( String carType, String carNum, Integer distance, String drivingAt) {
        this.carType = carType;
        this.carNum = carNum;
        this.distance = distance;
        this.drivingAt = drivingAt;

    }
    
}
