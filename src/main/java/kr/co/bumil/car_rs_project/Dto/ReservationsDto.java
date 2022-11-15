package kr.co.bumil.car_rs_project.Dto;

import lombok.*;



@Getter // getter 메소드 생성
@Setter
public class ReservationsDto {

    private String rsId;

    private String carId;

    private String userId;

    private String rsDate;

    private String reDate;

    private String destination;

    private String reAt;
    
    private String rsAt;
    
    private String logAt;

    public ReservationsDto(String rsId, String carId,String userId,String rsDate, String reDate,  String destination,String reAt,String rsAt,String logAt) {
        this.rsId = rsId;
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
