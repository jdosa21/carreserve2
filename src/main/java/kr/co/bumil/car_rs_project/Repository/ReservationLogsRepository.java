package kr.co.bumil.car_rs_project.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.co.bumil.car_rs_project.Entity.ReservationLogsEntity;

@Repository
public interface ReservationLogsRepository extends JpaRepository<ReservationLogsEntity, Long> {
    ReservationLogsEntity findByLogId(Long id); 
}
