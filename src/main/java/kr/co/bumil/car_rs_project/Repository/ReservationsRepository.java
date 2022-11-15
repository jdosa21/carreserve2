package kr.co.bumil.car_rs_project.Repository;

import java.util.ArrayList;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.co.bumil.car_rs_project.Entity.ReservationsEntity;

@Repository
public interface ReservationsRepository extends JpaRepository<ReservationsEntity, Long> {
    ReservationsEntity findByRsId(Long id); 
    ArrayList<ReservationsEntity> findByUserId(Long id,Sort a); 
}
