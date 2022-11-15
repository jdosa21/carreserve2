package kr.co.bumil.car_rs_project.Controller;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.bumil.car_rs_project.Dto.ReservationsDto;
import kr.co.bumil.car_rs_project.Service.CarsService;
import kr.co.bumil.car_rs_project.Service.ReservationsService;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

//@RestController // JSON 형태 결과값을 반환해줌 (@ResponseBody가 필요없음) 리액트사용시
@Controller //jsp사용을 위해 어쩔수 없이 불편한 일반 Controller를 사용해야함
@RequiredArgsConstructor // final 객체를 Constructor Injection 해줌. (Autowired 역할)
public class ReservationsController {

    
    
    private final ReservationsService reservationsService;
    private final CarsService carsService;
    
    @GetMapping("/")
    public String reservations() {
            return "Reservations";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        
    }
    @GetMapping("/mng/rs")
    public String findAllMng(Model model) {
        
        HashMap<String, Object> map = reservationsService.findAllRsMng();
        HashMap<String, Object> map1 = carsService.findAllCarsMng();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "MngRs";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

    @GetMapping("rs/updateForm.do")
    public String updateForm(@RequestParam String id, Model model) {
        
        HashMap<String, Object> map = reservationsService.findRs(id);
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("find"));
            model.addAttribute("list1",map.get("findCar"));
        return "ReservationsUpdate"; 
        }
        
    }

    @GetMapping("rs/myFindAll.do")
    public String myFindAll(@RequestParam String id, Model model) {
        HashMap<String, Object> map = reservationsService.findAllMyRs(id);
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            model.addAttribute("list1",map.get("findAllCar"));
            return "MyReservationsInfo";
        }
            
        
    }
    /**
     * 멤버 전체 조회
     * 
     */
    @GetMapping("rs/findAll.do")
    public String findAll(Model model) {
        
        HashMap<String, Object> map = reservationsService.findAllRs();
        HashMap<String, Object> map1 = carsService.findAllCars();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("findAll"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "ReservationsInfo";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }
    @GetMapping("rs/search.do")
    public String searchRs(Model model,String searchWord,String sType) {
        
        HashMap<String, Object> map = reservationsService.searchRs(searchWord,sType);
        HashMap<String, Object> map1 = carsService.findAllCars();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("search"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "ReservationsInfo";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

    @GetMapping("mng/search.do")
    public String searchRsMng(Model model,String searchWord,String sType) {
        
        HashMap<String, Object> map = reservationsService.searchRsMng(searchWord,sType);
        HashMap<String, Object> map1 = carsService.findAllCarsMng();
        
        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            model.addAttribute("list",map.get("search"));
            model.addAttribute("list1",map.get("findAllCar"));
            model.addAttribute("list2",map1.get("findAll"));
            return "MngRs";//model에 jsp에 보낼정보를 넣고 jsp파일 이름을 String으로 리턴
        }
    }

    /**
     * 멤버 조회
     *
     */
    @GetMapping("rs/find.do")
    public String find(@RequestParam String id, Model model) {

        HashMap<String, Object> map = reservationsService.findRs(id);

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
    @PostMapping("rs/insert.do")
    public String insert(ReservationsDto dto) {
      
        HashMap<String, Object> map = reservationsService.insertRs(dto);

        if(map.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../"; 
        }
    }

    /**
     * 회원삭제
     * 
     */
    @GetMapping("rs/delete.do")
    public String deleteRs(@RequestParam String id) {
        
        HashMap<String, Object> map = reservationsService.deleteRs(id);

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
    @GetMapping("rs/return.do")
    public String returnRs(@RequestParam String id,@RequestParam String uId) {

        HashMap<String, Object> mbrMap =  reservationsService.returnRs(id);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../rs/myFindAll.do?id="+uId; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }

    @GetMapping("rs/upReDate.do")
    public String upReDateRs(ReservationsDto dto,HttpServletRequest request) {

        HashMap<String, Object> mbrMap =  reservationsService.updateReDateRs(dto);

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

    @GetMapping("rs/cancle.do")
    public String cancle(@RequestParam String id,@RequestParam String uId) {

        HashMap<String, Object> mbrMap =  reservationsService.cancleRs(id);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../rs/myFindAll.do?id="+uId; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }

    @PostMapping("rs/update.do")
    public String updateRs(ReservationsDto dto) {

        HashMap<String, Object> mbrMap =  reservationsService.updateRs(dto);

        if(mbrMap.get("code").toString().equals("error")){
            return "에러페이지";
        }else{
            return "redirect:../rs/myFindAll.do?id=1"; //CUD의 경우에는 특정페이지로 리다이렉트
        }
    }
}
