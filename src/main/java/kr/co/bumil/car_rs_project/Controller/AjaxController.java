package kr.co.bumil.car_rs_project.Controller;

import lombok.RequiredArgsConstructor;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.co.bumil.car_rs_project.Entity.CarsEntity;
import kr.co.bumil.car_rs_project.Service.CarsService;

import java.util.ArrayList;
import java.util.HashMap;

//@RestController // JSON 형태 결과값을 반환해줌 (@ResponseBody가 필요없음) 리액트사용시
@Controller // jsp사용을 위해 어쩔수 없이 불편한 일반 Controller를 사용해야함
@RequiredArgsConstructor // final 객체를 Constructor Injection 해줌. (Autowired 역할)
public class AjaxController {

    private final CarsService carsService;
    @GetMapping(value = "/carCk.do", produces = "application/text;charset=UTF-8")
    @ResponseBody
    public String rsCheck(@RequestParam("rsDate") String rsDate,@RequestParam("reDate") String reDate) {

        JSONObject jsonObj = new JSONObject();

        int res = 0;
        
        HashMap<String, Object> checkMap = carsService.findAllOkCars(rsDate,reDate);
        ArrayList<CarsEntity> carList = (ArrayList<CarsEntity>)checkMap.get("findAll");
       
        if (carList.isEmpty()) {

            res = 1;

        }
        try {
            JSONArray jArray = new JSONArray();//배열이 필요할때     
            if(carList != null){
                           
            for (int i = 0; i < carList.size(); i++)//배열                    
            {                        
                JSONObject sObject = new JSONObject();//배열 내에 들어갈 json                        
                sObject.put("carId", carList.get(i).getCarId());                        
                sObject.put("carType", carList.get(i).getCarType());                        
                sObject.put("carNum", carList.get(i).getCarNum());                        
                sObject.put("distance", carList.get(i).getDistance());        
                sObject.put("drivingAt", carList.get(i).getDrivingAt());                     
                jArray.put(sObject);                    
            }
        }
            jsonObj.put("res", res);
            jsonObj.put("carList", jArray);

        } catch (JSONException e) {
            System.out.println(e.toString());
            return null;

        }
        String jsonOut = jsonObj.toString();
        return jsonOut;

    }
/*
    private final MembersService membersService;
    private final ResumesService resumesService;
    private final PostingsService postingsService;
    private final ApplicationsService applicationsService;
    private final OffersService offersService;

	
    @GetMapping(value = "member/idCk.do", produces = "application/text;charset=UTF-8")
    @ResponseBody
    public String mberIdCheck(@RequestParam("mberId") String mberId) {

        JSONObject jsonObj = new JSONObject();

        int res = 0;
        
        HashMap<String, Object> checkMap = membersService.findMemberId(mberId);
        MembersEntity mDto = (MembersEntity)checkMap.get("checkDto");

        if (mDto == null) {

            res = 1;

        }
        try {
            jsonObj.put("mberIdCkRes", res);

        } catch (JSONException e) {
            return null;

        }
        String jsonOut = jsonObj.toString();
        return jsonOut;

    }

    @GetMapping(value = "app/ck.do", produces = "application/text;charset=UTF-8")
    @ResponseBody
    public String appCheck(@RequestParam("mbrId")  String mbrId,
                           @RequestParam("postId") String postId) {

        JSONObject jsonObj = new JSONObject();

        int res = 0;
        HashMap<String, Object> resMap = resumesService.findResByMbrId(Long.parseLong(mbrId));
        ResumesEntity resEnt = (ResumesEntity)resMap.get("resByMbr");

        HashMap<String, Object> checkMap = applicationsService.appCheck(resEnt.getResId(),Long.parseLong(postId));

        ApplicationsEntity appEntity = (ApplicationsEntity)checkMap.get("appEntity");

        if (appEntity == null) {

            res = 1;

        }
        try {
            jsonObj.put("ckRes", res);

        } catch (JSONException e) {
            return null;
        }
        String jsonOut = jsonObj.toString();
        return jsonOut;

    }

    
    @GetMapping(value = "offer/ck.do", produces = "application/text;charset=UTF-8")
    @ResponseBody
    public String offerCheck(@RequestParam("resId")  String resId,
                             @RequestParam("compyId") String compyId) {

        JSONObject jsonObj = new JSONObject();

        int res = 0;

        HashMap<String, Object> postMap = postingsService.findByCompyId(Long.parseLong(compyId));
        
        ArrayList<PostingsEntity> postList = (ArrayList<PostingsEntity>)postMap.get("postByCompy");

        HashMap<String, Object> checkMap = offersService.offerCheck(Long.parseLong(resId),postList.get(0).getPostId());

        OffersEntity offerEntity = (OffersEntity)checkMap.get("offerEntity");

        if (offerEntity == null) {

            res = 1;

        }
        try {
            jsonObj.put("ckRes", res);

        } catch (JSONException e) {
            return null;
        }
        String jsonOut = jsonObj.toString();
        return jsonOut;

    }
 */
}

