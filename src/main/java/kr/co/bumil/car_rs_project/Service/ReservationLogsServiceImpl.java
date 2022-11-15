package kr.co.bumil.car_rs_project.Service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import kr.co.bumil.car_rs_project.Dto.ReservationLogsDto;
import kr.co.bumil.car_rs_project.Entity.CarsEntity;
import kr.co.bumil.car_rs_project.Entity.ReservationLogsEntity;
import kr.co.bumil.car_rs_project.Entity.ReservationsEntity;
import kr.co.bumil.car_rs_project.Repository.ReservationLogsRepository;
import kr.co.bumil.car_rs_project.Repository.ReservationsRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReservationLogsServiceImpl implements ReservationLogsService {
    private final ReservationLogsRepository reservationLogsRepository;
    private final ReservationsRepository reservationsRepository;
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public HashMap<String, Object> insertLogs(ReservationLogsDto dto) {
        String code = "";
        HashMap<String, Object> insert = new HashMap<>();

        try {

            final ReservationLogsEntity log = ReservationLogsEntity.builder()
                    .rsId(Long.parseLong(dto.getRsId()))
                    .rsPurpose(dto.getRsPurpose())
                    .drvDistance(Integer.parseInt(dto.getDrvDistance()))
                    .note(dto.getNote())
                    .build();

            reservationLogsRepository.save(log);

            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(dto.getRsId()));
            rs.setLogAt("1");
            reservationsRepository.save(rs);

            String jpql = "UPDATE cars as c SET c.distance = " + dto.getDrvDistance() + " WHERE c.carId = "
                    + rs.getCarId();
            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

            code = "ok";
            insert.put("code", code);

        } catch (Exception e) {
System.out.println(e);
            code = "error";
            insert.put("code", code);
            insert.put("error", e.toString());
        }

        return insert;
    };

    @Override
    public HashMap<String, Object> findAllLogsMng() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<ReservationLogsEntity> resLogsList = (ArrayList<ReservationLogsEntity>) reservationLogsRepository
                    .findAll(Sort.by(Sort.Direction.DESC, "logId"));

            String jpql = "SELECT c FROM reservation_logs as l left join reservations as r on l.rsId = r.rsId left join cars as c on r.carId = c.carId order by l.logId desc";
            ArrayList<CarsEntity> carList = (ArrayList<CarsEntity>) entityManager
                    .createQuery(jpql, CarsEntity.class)
                    .getResultList();

            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", resLogsList);
            findAll.put("findAllCar", carList);

        } catch (Exception e) {
            System.out.println(e.toString());
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findAllLogsCnt() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<Integer> rsPurposeCnt = new ArrayList<Integer>();
            String purposeList[] = new String[] {"출장","행사","교육"};
            String jpql = "SELECT l FROM reservation_logs as l where l.rsPurpose not like '" + purposeList[0].toString() + "' "+"and l.rsPurpose not like '" + purposeList[1].toString() + "' "+"and l.rsPurpose not like '" + purposeList[2].toString() + "' ";
            
            ArrayList<ReservationLogsEntity> logList = (ArrayList<ReservationLogsEntity>) entityManager
                    .createQuery(jpql, ReservationLogsEntity.class)
                    .getResultList();

            rsPurposeCnt.add(logList.size());
            for (int j = 0; j < 3; j++) {

                jpql = "SELECT l FROM reservation_logs l where l.rsPurpose like '" + purposeList[j] + "' ";
                ArrayList<ReservationLogsEntity> logList1 = (ArrayList<ReservationLogsEntity>) entityManager
                        .createQuery(jpql, ReservationLogsEntity.class)
                        .getResultList();
                if (logList1 != null) {
                    
                    rsPurposeCnt.add(logList1.size());
                    
                } else {
                    rsPurposeCnt.add(0);
                }
            }
            System.out.println(rsPurposeCnt.get(0));
                System.out.println(rsPurposeCnt.get(1));
                System.out.println(rsPurposeCnt.get(2));
                System.out.println(rsPurposeCnt.get(3));
            code = "ok";
            findAll.put("code", code);
            findAll.put("rsPurposeCnt", rsPurposeCnt);

        } catch (Exception e) {
System.out.println(e);
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findAllLogs() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<ReservationLogsEntity> resLogsList = (ArrayList<ReservationLogsEntity>) reservationLogsRepository
                    .findAll();

            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", resLogsList);

        } catch (Exception e) {

            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findLogs(String id) {
        String code = "";
        HashMap<String, Object> findOne = new HashMap<>();

        try {

            code = "ok";
            findOne.put("code", code);
            findOne.put("find", reservationLogsRepository.findByLogId(Long.parseLong(id)));

        } catch (Exception e) {

            code = "error";
            findOne.put("code", code);
            findOne.put("error", e.toString());

        }

        return findOne;
    };

    @Override
    public HashMap<String, Object> deleteLogs(String id) {

        String code = "";
        HashMap<String, Object> delete = new HashMap<>();

        try {
            final ReservationLogsEntity log = ReservationLogsEntity.builder()
                    .logId(Long.parseLong(id))
                    .build();
            reservationLogsRepository.delete(log);

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
    @Transactional
    public HashMap<String, Object> updateLogs(ReservationLogsDto dto) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {

            final ReservationLogsEntity log = ReservationLogsEntity.builder()
                    .logId(Long.parseLong(dto.getLogId()))
                    .rsId(Long.parseLong(dto.getRsId()))
                    .rsPurpose(dto.getRsPurpose())
                    .drvDistance(Integer.parseInt(dto.getDrvDistance()))
                    .note(dto.getNote())
                    .build();
            reservationLogsRepository.save(log);

            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(dto.getRsId()));
            rs.setLogAt("1");
            reservationsRepository.save(rs);
            String jpql = "UPDATE cars as c SET c.distance = " + dto.getDrvDistance() + " WHERE c.carId = "
                    + rs.getCarId();
            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

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

    @Override
    public HashMap<String, Object> searchLogs(String keyWord, String sType) {
        String code = "";
        HashMap<String, Object> search = new HashMap<>();

        try {
            String jpql = "SELECT l FROM reservation_logs l ";
            if ("car".equals(sType)) {
                jpql = jpql
                        + "left join reservations as r on l.rsId = r.rsId left join cars as c on r.carId = c.carId where c.carId = '"
                        + keyWord + "' order by l.logId desc";
            } else {
                jpql = jpql + " order by l.logId";
            }
            ArrayList<ReservationLogsEntity> rsList = (ArrayList<ReservationLogsEntity>) entityManager
                    .createQuery(jpql, ReservationLogsEntity.class)
                    .getResultList();

            if ("car".equals(sType)) {
                jpql = "SELECT c FROM reservation_logs as l left join reservations as r on l.rsId = r.rsId left join cars as c on r.carId = c.carId where c.carId = '"
                        + keyWord + "' order by l.logId desc";
            } else {
                jpql = "SELECT c FROM reservation_logs as l left join reservations as r on l.rsId = r.rsId left join cars as c on r.carId = c.carId order by l.logId desc";
            }

            ArrayList<CarsEntity> carList = (ArrayList<CarsEntity>) entityManager
                    .createQuery(jpql, CarsEntity.class)
                    .getResultList();

            code = "ok";
            search.put("code", code);
            search.put("search", rsList);
            search.put("findAllCar", carList);
        } catch (Exception e) {
            code = "error";
            search.put("code", code);
            search.put("error", e.toString());

        }

        return search;
    }

}
