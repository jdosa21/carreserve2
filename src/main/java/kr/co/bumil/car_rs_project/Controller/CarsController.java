package kr.co.bumil.car_rs_project.Controller;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.bumil.car_rs_project.Dto.CarsDto;
import kr.co.bumil.car_rs_project.Service.CarsService;
import kr.co.bumil.car_rs_project.Service.ReservationLogsService;
import kr.co.bumil.car_rs_project.Service.ReservationsService;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

//@RestController // JSON 형태 결과값을 반환해줌 (@ResponseBody가 필요없음) 리액트사용시
@Controller //jsp사용을 위해 어쩔수 없이 불편한 일반 Controller를 사용해야함
@RequiredArgsConstructor // final 객체를 Constructor Injection 해줌. (Autowired 역할)
public class CarsController {

    private final CarsService carsService;
    private final ReservationsService reservationsService;
    private final ReservationLogsService reservationLogsService;

    @GetMapping("/mng/chart")
    public String findAllMngdsdsd(Model model) {
        HashMap<String, Object> map = reservationsService.findAllDaysCnt();
        HashMap<String, Object> map1 = reservationLogsService.findAllLogsCnt();
        HashMap<String, Object> map2 = reservationsService.findAllrsAtCnt();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("days",map.get("days"));
            model.addAttribute("dayCnt",map.get("dayCnt"));
            model.addAttribute("rsPurposeCnt",map1.get("rsPurposeCnt"));
            model.addAttribute("rsAt",map2.get("rsAt"));
            return "MngChart";
        }
        
            
        
    }
    @GetMapping("/mng")
    public String findAllMng(Model model) {
        
        HashMap<String, Object> map = carsService.findAllCarsMng();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            return "MngCars";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }
   
    /**
     * 멤버 전체 조회
     * 
     */
    @GetMapping("car/findAll.do")
    public String findAll(Model model) {
        
        HashMap<String, Object> map = carsService.findAllCars();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            return "test/mbrInsert";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

    /**
     * 멤버 조회
     *
     */
    @GetMapping("car/find.do")
    public String find(@RequestParam String id, Model model) {

        HashMap<String, Object> map = carsService.findCars(id);

        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("find"));
            return "/";
        }
        
    }

    /**
     * 회원가입
     *
     */
    @PostMapping("car/insert.do")
    public String insert(CarsDto dto) {
      
        HashMap<String, Object> map = carsService.insertCars(dto);

        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../mng"; 
        }
    }

    /**
     * 회원삭제
     * 
     */
    @GetMapping("car/delete.do")
    public String deleteMbr(@RequestParam String id) {
        
        HashMap<String, Object> map = carsService.deleteCars(id);

        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return ""; //CUD의 경우에는 특정페이지로 리다이렉트
        }
        
    }

    /**
     * 회원수정
     *
     */
    @GetMapping("car/updateAt.do")
    public String updateAt(@RequestParam String id,HttpServletRequest request) {

        HashMap<String, Object> mbrMap =  carsService.updateAtCars(id);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            String referer = (String)request.getHeader("REFERER");
                if(referer==null){
                    referer = "redirect:/";
                }else{
                    referer = referer.replace("http://localhost:8080","redirect:" );
                }
                return referer; 
        }
    }

    @GetMapping("car/accident.do")
    public String accidentAt(@RequestParam String id,HttpServletRequest request) {

        HashMap<String, Object> mbrMap =  carsService.accidentCars(id);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            String referer = (String)request.getHeader("REFERER");
                if(referer==null){
                    referer = "redirect:/";
                }else{
                    referer = referer.replace("http://localhost:8080","redirect:" );
                }
                return referer; 
        }
    }

    @GetMapping("car/updateAtMng.do")
    public String updateAtMng(@RequestParam String id) {

        HashMap<String, Object> mbrMap =  carsService.updateAtCars(id);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../mng"; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }
    @PostMapping("car/update.do")
    public String updateMbr(CarsDto dto) {

        HashMap<String, Object> mbrMap =  carsService.updateCars(dto);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../mng"; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }
}
