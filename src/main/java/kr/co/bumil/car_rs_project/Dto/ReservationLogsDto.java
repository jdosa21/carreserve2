package kr.co.bumil.car_rs_project.Dto;
import lombok.*;



@Getter // getter 메소드 생성
@Setter
public class ReservationLogsDto {

    private String logId;

    private String rsId;

    private String rsPurpose;

    private String drvDistance;

    private String note;

    public ReservationLogsDto(String logId, String rsId, String rsPurpose, String drvDistance, String note) {
        this.logId = logId;
        this.rsId = rsId;
        this.rsPurpose = rsPurpose;
        this.drvDistance = drvDistance;
        this.note = note;

    }
}
