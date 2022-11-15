package kr.co.bumil.car_rs_project.Service;

import java.util.HashMap;

import kr.co.bumil.car_rs_project.Dto.CarsDto;

public interface CarsService {
    public HashMap<String,Object> insertCars(CarsDto dto);
    public HashMap<String,Object> deleteCars(String id);
    public HashMap<String,Object> updateCars(CarsDto dto);
    public HashMap<String,Object> updateAtCars(String id);
    public HashMap<String, Object> accidentCars(String id);
    public HashMap<String,Object> findAllCars();
    public HashMap<String,Object> findAllCarsMng();
    public HashMap<String, Object> findAllOkCars(String rsDate,String reDate);
    public HashMap<String,Object> findCars(String id);
    
}
