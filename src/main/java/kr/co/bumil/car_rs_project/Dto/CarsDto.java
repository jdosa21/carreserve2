package kr.co.bumil.car_rs_project.Dto;
import lombok.*;



@Getter // getter 메소드 생성
@Setter
public class CarsDto {
    
    private String carId;

    private String carType;

    private String carNum;

    private Integer distance;

    private String drivingAt;

    public CarsDto(String carId, String carType, String carNum, Integer distance, String drivingAt) {
        this.carId = carId;
        this.carType = carType;
        this.carNum = carNum;
        this.distance = distance;
        this.drivingAt = drivingAt;

    }
    
}
