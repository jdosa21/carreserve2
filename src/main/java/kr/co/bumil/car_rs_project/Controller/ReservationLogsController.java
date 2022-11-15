package kr.co.bumil.car_rs_project.Controller;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.bumil.car_rs_project.Dto.ReservationLogsDto;
import kr.co.bumil.car_rs_project.Service.CarsService;
import kr.co.bumil.car_rs_project.Service.ReservationLogsService;
import kr.co.bumil.car_rs_project.Service.ReservationsService;

import java.util.HashMap;

//@RestController // JSON 형태 결과값을 반환해줌 (@ResponseBody가 필요없음) 리액트사용시
@Controller //jsp사용을 위해 어쩔수 없이 불편한 일반 Controller를 사용해야함
@RequiredArgsConstructor // final 객체를 Constructor Injection 해줌. (Autowired 역할)
public class ReservationLogsController {

    private final ReservationLogsService reservationLogsService;
    private final ReservationsService reservationsService;
    private final CarsService carsService;
    
    /**
     * 멤버 전체 조회
     * 
     */

    @GetMapping("mng/logs")
    public String findAllMng(Model model) {
        
        HashMap<String, Object> map = reservationLogsService.findAllLogsMng();
        HashMap<String, Object> map1 = carsService.findAllCarsMng();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "MngLogs";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

   
    @GetMapping("log/findAll.do")
    public String findAll(Model model) {
        
        HashMap<String, Object> map = reservationLogsService.findAllLogs();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            return "test/mbrInsert";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

    @GetMapping("log/search.do")
    public String searchRs(Model model,String searchWord,String sType) {
        
        HashMap<String, Object> map = reservationLogsService.searchLogs(searchWord,sType);
        HashMap<String, Object> map1 = carsService.findAllCarsMng();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("search"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "MngLogs";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }
    /**
     * 멤버 조회
     *
     */
    @GetMapping("log/find.do")
    public String find(@RequestParam String id, Model model) {

        HashMap<String, Object> map = reservationLogsService.findLogs(id);

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
    @GetMapping("log/insertForm.do")
    public String insertForm(@RequestParam String id, Model model) {
        HashMap<String, Object> map = reservationsService.findRs(id);
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findCar"));
            model.addAttribute("id",id);
            return "ReservationsLog";
        }
    }

    @PostMapping("log/insert.do")
    public String insert(@RequestParam String id,ReservationLogsDto dto) {
      
        HashMap<String, Object> map = reservationLogsService.insertLogs(dto);

        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            
            return "redirect:../rs/myFindAll.do?id="+id; 
        }
    }


    /**
     * 회원삭제
     * 
     */
    @GetMapping("log/delete.do")
    public String deleteMbr(@RequestParam String id) {
        
        HashMap<String, Object> map = reservationLogsService.deleteLogs(id);

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
    @PostMapping("log/update.do")
    public String updateMbr(ReservationLogsDto dto) {

        HashMap<String, Object> mbrMap =  reservationLogsService.updateLogs(dto);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../mng/logs"; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }
}
