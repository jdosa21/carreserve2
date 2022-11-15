package kr.co.bumil.car_rs_project.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import kr.co.bumil.car_rs_project.Dto.CarsDto;
import kr.co.bumil.car_rs_project.Entity.CarsEntity;
import kr.co.bumil.car_rs_project.Entity.ReservationsEntity;
import kr.co.bumil.car_rs_project.Repository.CarsRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CarsServiceImpl implements CarsService {
    private final CarsRepository carsRepository;
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public HashMap<String, Object> updateAtCars(String id) {
        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            String nowTime = now.format(formatter);

            CarsEntity car = carsRepository.findByCarId(Long.parseLong(id));
            if (car.getDrivingAt().equals("Y")||car.getDrivingAt().equals("A")) {
                car.setDrivingAt("N");
                String jpql = "UPDATE reservations as r SET r.rsAt = '3', reAt = '1', r.logAt = '1' WHERE r.carId ="
                        + id + " and r.reAt = '0' and (r.rsDate >= '" + nowTime + "' or r.reDate > '" + nowTime + "')";
                entityManager
                        .createQuery(jpql)
                        .executeUpdate();
            } else {
                car.setDrivingAt("Y");
            }
            carsRepository.save(car);
            code = "ok";
            update.put("code", code);

        } catch (Exception e) {
            code = "error";
            update.put("code", code);
            update.put("error", e.toString());

        }

        return update;
    };

    @Override
    @Transactional
    public HashMap<String, Object> accidentCars(String id) {
        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            String nowTime = now.format(formatter);

            CarsEntity car = carsRepository.findByCarId(Long.parseLong(id));
            car.setDrivingAt("A");
            String jpql = "UPDATE reservations as r SET r.rsAt = '3', reAt = '1', r.logAt = '1' WHERE r.carId ="
                        + id + " and r.reAt = '0' and (r.rsDate >= '" + nowTime + "' or r.reDate > '" + nowTime + "')";
                entityManager
                        .createQuery(jpql)
                        .executeUpdate();
            carsRepository.save(car);
            code = "ok";
            update.put("code", code);

        } catch (Exception e) {
            code = "error";
            update.put("code", code);
            update.put("error", e.toString());

        }

        return update;
    };

    @Override
    public HashMap<String, Object> insertCars(CarsDto dto) {
        String code = "";
        HashMap<String, Object> insert = new HashMap<>();

        try {

            final CarsEntity cars = CarsEntity.builder()
                    .carNum(dto.getCarNum())
                    .carType(dto.getCarType())
                    .distance(dto.getDistance())
                    .drivingAt("Y")
                    .build();

            carsRepository.save(cars);

            code = "ok";
            insert.put("code", code);

        } catch (Exception e) {
            System.out.println(e.toString());
            code = "error";
            insert.put("code", code);
            insert.put("error", e.toString());
        }

        return insert;
    };

    @Override
    public HashMap<String, Object> findAllCarsMng() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<CarsEntity> carList = (ArrayList<CarsEntity>) carsRepository.findAll();
            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", carList);

        } catch (Exception e) {

            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findAllCars() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            String jpql = "SELECT c FROM cars c WHERE c.drivingAt = 'Y'";
            ArrayList<CarsEntity> carList = (ArrayList<CarsEntity>) entityManager
                    .createQuery(jpql, CarsEntity.class)
                    .getResultList();

            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", carList);

        } catch (Exception e) {

            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findAllOkCars(String rsDate, String reDate) {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();
        try {
            String jpql = "SELECT r FROM reservations r WHERE ((r.rsDate <= '" + rsDate + "' and r.reDate >= '" + rsDate
                    + "')or(r.rsDate < '" + reDate + "' and r.reDate > '" + reDate + "')) and reAt ='0' group by carId";
            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                    .createQuery(jpql, ReservationsEntity.class)
                    .getResultList();

            jpql = "SELECT c FROM cars c WHERE c.drivingAt = 'Y'";
            ArrayList<CarsEntity> carOkList = (ArrayList<CarsEntity>) entityManager
                    .createQuery(jpql, CarsEntity.class)
                    .getResultList();
            if (rsList != null) {
                for (int i = 0; i < carOkList.size(); i++) {
                    for (int a = 0; a < rsList.size(); a++) {
                        if (carOkList.get(i).getCarId() == rsList.get(a).getCarId()) {
                            carOkList.remove(i);
                        }

                    }
                }
            }

            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", carOkList);

        } catch (Exception e) {
            System.out.println(e.toString());
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findCars(String id) {
        String code = "";
        HashMap<String, Object> findOne = new HashMap<>();

        try {

            code = "ok";
            findOne.put("code", code);
            findOne.put("find", carsRepository.findByCarId(Long.parseLong(id)));

        } catch (Exception e) {

            code = "error";
            findOne.put("code", code);
            findOne.put("error", e.toString());

        }

        return findOne;
    };

    @Override
    public HashMap<String, Object> deleteCars(String id) {

        String code = "";
        HashMap<String, Object> delete = new HashMap<>();

        try {
            final CarsEntity car = CarsEntity.builder()
                    .carId(Long.parseLong(id))
                    .build();
            carsRepository.delete(car);

            code = "ok";
            delete.put("code", code);

        } catch (Exception e) {

            code = "error";
            delete.put("code", code);
            delete.put("error", e.toString());

        }

        return delete;
    };

    @Override
    public HashMap<String, Object> updateCars(CarsDto dto) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {

            final CarsEntity car = CarsEntity.builder()
                    .carId(Long.parseLong(dto.getCarId()))
                    .carNum(dto.getCarNum())
                    .carType(dto.getCarType())
                    .distance(dto.getDistance())
                    .drivingAt(dto.getDrivingAt())
                    .build();
            carsRepository.save(car);

            code = "ok";
            update.put("code", code);

        } catch (Exception e) {
            System.out.println(e.toString());
            code = "error";
            update.put("code", code);
            update.put("error", e.toString());

        }

        return update;
    };

}
