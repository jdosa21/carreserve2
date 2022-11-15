package kr.co.bumil.car_rs_project.Service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import kr.co.bumil.car_rs_project.Dto.ReservationsDto;
import kr.co.bumil.car_rs_project.Entity.CarsEntity;
import kr.co.bumil.car_rs_project.Entity.ReservationsEntity;
import kr.co.bumil.car_rs_project.Repository.CarsRepository;
import kr.co.bumil.car_rs_project.Repository.ReservationsRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReservationsServiceImpl implements ReservationsService {
    private final ReservationsRepository reservationsRepository;
    private final CarsRepository carsRepository;
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public HashMap<String, Object> insertRs(ReservationsDto dto) {
        String code = "";
        HashMap<String, Object> insert = new HashMap<>();

        try {
            String rsDateDto = dto.getRsDate();
            String reDateDto = dto.getReDate();
            String rsSpl[] = rsDateDto.split("-");
            String reSpl[] = reDateDto.split("-");
            if (Integer.parseInt(rsSpl[1]) < 10) {

                rsDateDto = rsSpl[0] + "-0" + rsSpl[1] + "-" + rsSpl[2];
            }
            if (Integer.parseInt(reSpl[1]) < 10) {

                reDateDto = reSpl[0] + "-0" + reSpl[1] + "-" + reSpl[2];
            }
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date rsDateDate = dateFormat.parse(rsDateDto);
            Timestamp rsDate = new java.sql.Timestamp(rsDateDate.getTime());
            Date reDateDate = dateFormat.parse(reDateDto);
            Timestamp reDate = new java.sql.Timestamp(reDateDate.getTime());
            System.out.println(rsDateDate);
            System.out.println(reDateDate);
            System.out.println(rsDate);
            System.out.println(reDate);
            final ReservationsEntity rs = ReservationsEntity.builder()
                    .carId(Long.parseLong(dto.getCarId()))
                    .userId(Long.parseLong(dto.getUserId()))
                    .rsDate(rsDate)
                    .reDate(reDate)
                    .destination(dto.getDestination())
                    .reAt("0")
                    .rsAt("0")
                    .logAt("0")
                    .build();

            reservationsRepository.save(rs);

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
    public HashMap<String, Object> findAllRsMng() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) reservationsRepository.findAll();
            ArrayList<CarsEntity> carList = new ArrayList<>();

            for (ReservationsEntity rs : rsList) {
                carList.add(carsRepository.findByCarId(rs.getCarId()));
            }
            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", rsList);
            findAll.put("findAllCar", carList);

        } catch (Exception e) {

            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    @Transactional
    public HashMap<String, Object> findAllRs() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            String jpql = "UPDATE reservations as r SET r.rsAt = CASE WHEN r.rsDate <=  now() and r.rsAt = '0' THEN '1' ELSE r.rsAt END";

            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

            jpql = "UPDATE reservations as r SET r.reAt = CASE WHEN r.reDate <=  now() and r.reAt = '0'  THEN '1' ELSE r.reAt END";
            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

            jpql = "SELECT r FROM reservations r WHERE r.reAt = '0'";
            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                    .createQuery(jpql, ReservationsEntity.class)
                    .getResultList();
            ArrayList<CarsEntity> carList = new ArrayList<>();

            for (ReservationsEntity rs : rsList) {
                carList.add(carsRepository.findByCarId(rs.getCarId()));
            }
            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", rsList);
            findAll.put("findAllCar", carList);

        } catch (Exception e) {
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    @Transactional
    public HashMap<String, Object> findAllMyRs(String id) {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            String jpql = "UPDATE reservations as r SET r.rsAt = CASE WHEN r.rsDate <=  now() and r.rsAt = '0' THEN '1' ELSE r.rsAt END WHERE r.userId = "
                    + id;

            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

            jpql = "UPDATE reservations as r SET r.reAt = CASE WHEN r.reDate <=  now() and r.reAt = '0'  THEN '1' ELSE r.reAt END WHERE r.userId = "
                    + id;
            entityManager
                    .createQuery(jpql)
                    .executeUpdate();

            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) reservationsRepository
                    .findByUserId(Long.parseLong(id), Sort.by(Sort.Direction.DESC, "rsId"));
            ArrayList<CarsEntity> carList = new ArrayList<>();

            for (ReservationsEntity rs : rsList) {
                carList.add(carsRepository.findByCarId(rs.getCarId()));
            }

            code = "ok";
            findAll.put("code", code);
            findAll.put("findAll", rsList);
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
    public HashMap<String, Object> findAllDaysCnt() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<String> days = new ArrayList<String>();
            ArrayList<Integer> dayCnt = new ArrayList<Integer>();

            for (int i = 0; i < 6; i++) {
                LocalDate now = LocalDate.now().minusDays(i);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                days.add(now.format(formatter));
            }

            for (int j = 0; j < 6; j++) {

                String jpql = "SELECT r FROM reservations r where r.rsDate >= '" + days.get(j) +" 00:00"+ "' and r.rsDate <= '" + days.get(j) +" 23:59"+"'";
                System.out.println(jpql);
                ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                        .createQuery(jpql, ReservationsEntity.class)
                        .getResultList();
                if (rsList != null) {
                    dayCnt.add(rsList.size());
                } else {
                    dayCnt.add(0);
                }

            }
            code = "ok";
            findAll.put("code", code);
            findAll.put("days", days);
            findAll.put("dayCnt", dayCnt);

        } catch (Exception e) {
            System.out.println(e);
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    
    @Override
    public HashMap<String, Object> findAllrsAtCnt() {
        String code = "";
        HashMap<String, Object> findAll = new HashMap<>();

        try {
            ArrayList<Integer> rsAt = new ArrayList<Integer>();
            String rsAtList[] = new String[] {"1","2","3","4"};
         
            for (int j = 0; j < 4; j++) {

                String jpql = "SELECT r FROM reservations r where r.rsAt = '" + rsAtList[j] + "'";
                ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                        .createQuery(jpql, ReservationsEntity.class)
                        .getResultList();
                if (rsList != null) {
                    rsAt.add(rsList.size());
                } else {
                    rsAt.add(0);
                }

            }
            code = "ok";
            findAll.put("code", code);
            findAll.put("rsAt", rsAt);

        } catch (Exception e) {
            System.out.println(e);
            code = "error";
            findAll.put("code", code);
            findAll.put("error", e.toString());

        }

        return findAll;
    };

    @Override
    public HashMap<String, Object> findRs(String id) {
        String code = "";
        HashMap<String, Object> findOne = new HashMap<>();

        try {
            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(id));
            CarsEntity car = carsRepository.findByCarId(rs.getCarId());
            code = "ok";
            findOne.put("code", code);
            findOne.put("find", rs);
            findOne.put("findCar", car);

        } catch (Exception e) {

            code = "error";
            findOne.put("code", code);
            findOne.put("error", e.toString());

        }

        return findOne;
    };

    @Override
    public HashMap<String, Object> deleteRs(String id) {

        String code = "";
        HashMap<String, Object> delete = new HashMap<>();

        try {
            final ReservationsEntity rs = ReservationsEntity.builder()
                    .rsId(Long.parseLong(id))
                    .build();
            reservationsRepository.delete(rs);

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
    public HashMap<String, Object> updateReDateRs(ReservationsDto dto) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            String reDateDto = dto.getReDate();
            String reSpl[] = reDateDto.split("-");
            if (Integer.parseInt(reSpl[1]) < 10) {

                reDateDto = reSpl[0] + "-0" + reSpl[1] + "-" + reSpl[2];
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date reDateDate = dateFormat.parse(reDateDto);
            Timestamp reDate = new java.sql.Timestamp(reDateDate.getTime());

            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(dto.getRsId()));
            rs.setReDate(reDate);
            String jpql = "UPDATE reservations as r SET r.rsAt = '4', reAt = '1', r.logAt = '1' WHERE r.carId ="
                    + rs.getCarId() + " and (r.rsDate < '" + dto.getReDate() + "' and r.rsDate > '" + dto.getRsDate()
                    + "')";
            entityManager
                    .createQuery(jpql)
                    .executeUpdate();
            reservationsRepository.save(rs);

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
    public HashMap<String, Object> returnRs(String id) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"); // 포맷 적용 String formatedNow =
            // now.format(formatter); // 결과 출력
            // System.out.println(formatedNow);
            // // 2021/12/02
            String formatedNow = now.format(formatter);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date reDateDate = dateFormat.parse(formatedNow);
            Timestamp reDate = new java.sql.Timestamp(reDateDate.getTime());

            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(id));
            rs.setReAt("1");
            rs.setReDate(reDate);
            reservationsRepository.save(rs);

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
    public HashMap<String, Object> cancleRs(String id) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            ReservationsEntity rs = reservationsRepository.findByRsId(Long.parseLong(id));
            rs.setRsAt("2");
            rs.setReAt("1");
            rs.setLogAt("1");
            reservationsRepository.save(rs);
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
    public HashMap<String, Object> updateRs(ReservationsDto dto) {

        String code = "";
        HashMap<String, Object> update = new HashMap<>();

        try {
            String rsDateDto = dto.getRsDate();
            String reDateDto = dto.getReDate();
            String rsSpl[] = rsDateDto.split("-");
            String reSpl[] = reDateDto.split("-");
            if (Integer.parseInt(rsSpl[1]) < 10) {

                rsDateDto = rsSpl[0] + "-0" + rsSpl[1] + "-" + rsSpl[2];
            }
            if (Integer.parseInt(reSpl[1]) < 10) {

                reDateDto = reSpl[0] + "-0" + reSpl[1] + "-" + reSpl[2];
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date rsDateDate = dateFormat.parse(rsDateDto);
            Timestamp rsDate = new java.sql.Timestamp(rsDateDate.getTime());
            Date reDateDate = dateFormat.parse(reDateDto);
            Timestamp reDate = new java.sql.Timestamp(reDateDate.getTime());

            final ReservationsEntity rs = ReservationsEntity.builder()
                    .rsId(Long.parseLong(dto.getRsId()))
                    .carId(Long.parseLong(dto.getCarId()))
                    .userId(Long.parseLong(dto.getUserId()))
                    .rsDate(rsDate)
                    .reDate(reDate)
                    .destination(dto.getDestination())
                    .reAt("0")
                    .rsAt("0")
                    .logAt("0")
                    .build();
            reservationsRepository.save(rs);

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
    public HashMap<String, Object> searchRs(String keyWord, String sType) {
        String code = "";
        HashMap<String, Object> search = new HashMap<>();

        try {
            String jpql = "SELECT r FROM reservations as r join cars as c on r.carId=c.carId ";
            if ("all".equals(sType)) {
                jpql = jpql + "WHERE (c.carType like '%" + keyWord + "%' or r.destination like '%" + keyWord
                        + "%') and r.reAt = '0'";
            } else if ("car".equals(sType)) {
                jpql = jpql + "WHERE r.carId = " + keyWord + " and r.reAt = '0'";
            } else if ("date".equals(sType)) {
                String rsDate = keyWord.split("~")[0];
                String reDate = keyWord.split("~")[1];
                System.out.println(rsDate);
                System.out.println(reDate);
                jpql = jpql + "WHERE ((r.rsDate >= '" + rsDate + "' and r.rsDate <= '" + reDate + "')or(r.reDate > '"
                        + rsDate + "' and r.reDate < '" + reDate + "'))and r.reAt = '0'";
            } else if ("place".equals(sType)) {
                jpql = jpql + "WHERE r.destination = '" + keyWord + "' and r.reAt = '0'";
            } else {
                jpql = jpql + "WHERE r.reAt = '0'";
            }
            jpql = jpql + " order by r.rsId";
            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                    .createQuery(jpql, ReservationsEntity.class)
                    .getResultList();

            ArrayList<CarsEntity> carList = new ArrayList<>();

            for (ReservationsEntity rs : rsList) {
                carList.add(carsRepository.findByCarId(rs.getCarId()));
            }

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

    @Override
    public HashMap<String, Object> searchRsMng(String keyWord, String sType) {
        String code = "";
        HashMap<String, Object> search = new HashMap<>();

        try {
            String jpql = "SELECT r FROM reservations as r LEFT join cars as c on r.carId=c.carId ";

            if ("all".equals(sType)) {
                jpql = jpql + "WHERE (c.carType like '%" + keyWord + "%' or r.destination like '%" + keyWord + "%')";
            } else if ("car".equals(sType)) {
                jpql = jpql + "WHERE r.carId = " + keyWord;
            } else if ("date".equals(sType)) {
                String rsDate = keyWord.split("~")[0];
                String reDate = keyWord.split("~")[1];
                System.out.println(rsDate);
                System.out.println(reDate);
                jpql = jpql + "WHERE ((r.rsDate >= '" + rsDate + "' and r.rsDate <= '" + reDate + "')or(r.reDate > '"
                        + rsDate + "' and r.reDate < '" + reDate + "'))";
                System.out.println(jpql);
            } else if ("place".equals(sType)) {
                jpql = jpql + "WHERE r.destination = '" + keyWord + "'";
            }
            jpql = jpql + " order by r.rsId";

            ArrayList<ReservationsEntity> rsList = (ArrayList<ReservationsEntity>) entityManager
                    .createQuery(jpql, ReservationsEntity.class)
                    .getResultList();

            ArrayList<CarsEntity> carList = new ArrayList<>();

            for (ReservationsEntity rs : rsList) {
                carList.add(carsRepository.findByCarId(rs.getCarId()));
            }

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
