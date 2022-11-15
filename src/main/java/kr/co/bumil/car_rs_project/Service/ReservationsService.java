package kr.co.bumil.car_rs_project.Service;

import java.util.HashMap;

import kr.co.bumil.car_rs_project.Dto.ReservationsDto;

public interface ReservationsService {
    public HashMap<String,Object> insertRs(ReservationsDto dto);
    public HashMap<String,Object> deleteRs(String id);
    public HashMap<String,Object> updateRs(ReservationsDto dto);
    public HashMap<String,Object> updateReDateRs(ReservationsDto dto);
    public HashMap<String,Object> returnRs(String id);
    public HashMap<String,Object> cancleRs(String id);
    public HashMap<String,Object> findAllRs();
    public HashMap<String, Object> findAllRsMng();
    public HashMap<String,Object> findAllMyRs(String id);
    public HashMap<String,Object> findAllDaysCnt();
    public HashMap<String,Object> findAllrsAtCnt();
    public HashMap<String,Object> findRs(String id);
    public HashMap<String,Object> searchRs(String keyWord,String sType);
    public HashMap<String,Object> searchRsMng(String keyWord,String sType);
}
