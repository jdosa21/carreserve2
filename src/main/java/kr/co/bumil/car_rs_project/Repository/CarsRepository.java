package kr.co.bumil.car_rs_project.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.co.bumil.car_rs_project.Entity.CarsEntity;

@Repository
public interface CarsRepository extends JpaRepository<CarsEntity, Long> {
    CarsEntity findByCarId(Long id); 
    
}
