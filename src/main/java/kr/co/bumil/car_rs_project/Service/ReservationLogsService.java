package kr.co.bumil.car_rs_project.Service;

import java.util.HashMap;

import kr.co.bumil.car_rs_project.Dto.ReservationLogsDto;

public interface ReservationLogsService {
    public HashMap<String,Object> insertLogs(ReservationLogsDto dto);
    public HashMap<String,Object> deleteLogs(String id);
    public HashMap<String,Object> updateLogs(ReservationLogsDto dto);
    public HashMap<String,Object> findAllLogs();
    public HashMap<String,Object> findAllLogsMng();
    public HashMap<String,Object> findAllLogsCnt();
    public HashMap<String,Object> findLogs(String id);
    public HashMap<String,Object> searchLogs(String keyWord,String sType);
}
