package egovframework.a.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.a.model.Lisc501updateDTO;
import egovframework.a.model.UserADTO;
import egovframework.a.model.Lisc100DTO;
import egovframework.a.model.Lisc500DTO;
import egovframework.a.model.Lisc501DTO;
import egovframework.a.service.AService;
import egovframework.util.Sha256;


// 이 클래스가 스프링의 컨트롤러임을 나타내는 어노테이션이다.
@Controller
public class AController {
	
	// AService 라는 이름으로 등록된 빈(Bean)을 주입받기 위한 어노테이션.
	@Resource(name="AService")
	AService aService;
	
	// "/loginA.do"라는 경로로 들어온 요청에 대한 처리를 위한 메서드를 정의.
	@RequestMapping(value = "/loginA.do")
	public String startPage(Model model) throws Exception {
		
		// '.login/loginA'뷰 페이지를 반환한다.
		return ".login/loginA";
	}
	
	// "/loginA.do"라는 경로로 들어온 요청에 대한 처리를 위한 메서드를 정의.
		@RequestMapping(value = "/reagentA.do")
		public String reagentA(Model model) throws Exception {
			
			// '.login/loginA'뷰 페이지를 반환한다.
			return ".main/reagent/reagentA";
		}
	
	
	// 회원가입 로직
	@RequestMapping(value = "/joinUserA.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject join(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		JSONObject json = new JSONObject();
		
		// 'userADTO' 클래스의 객체를 생성한다. 이 클래스는 사용자 데이터의 정보를 담는 DTO(Data Transfer Object)이다.
		UserADTO dto = new UserADTO();
		
		// id와 pw 값을 어떻게 받을지 정의
		String id = map.get("id").toString();
		// 입력으로 받은 비밀번호를 SHA-256 해시로 암호화한다. 'Sha256.encrypt()' 메서드는 비밀번호를 해시화한 문자열을 반환한다.
		String pw = Sha256.encrypt(map.get("password").toString());
		
				// DTO 객체에 아이디와 암호화된 비밀번호를 설정한다.
				dto.setId(id);
				dto.setPassword(pw);
			
		// aService를 사용하여 해당 아이디에 대한 사용자 정보를 데이터베이스에서 조회한다.
	    int checkId = aService.findOne(id);
		 		
	    // 같은 아이디의 값이 있으면 result로 jsp에 none 값을 보냄.
		if (checkId == 1) {
			json.put("result", "none");
		}
		
		if (checkId != 1) {
			// aService를 통해 'joinUser' 메서드를 호출하여 사용자 정보를 데이터베이스에 저장한다.
			int join = aService.joinUserA(dto);
			json.put("result", "success"); 
		}
		
			
		// JSON 객체를 반환하여 클라이언트에 응답한다.
		return json;
	}
	
	// 로그인 로직
	@RequestMapping(value = "/loginUserA.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject login(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
	    JSONObject json = new JSONObject();
	    
	    // 요청 파라미터로부터 아이디와 비밀번호를 가져온다.
	    String id = map.get("id").toString();
	    // 입력으로 받은 비밀번호를 SHA-256 해시로 암호화한다. 'Sha256.encrypt()' 메서드는 비밀번호를 해시화한 문자열을 반환한다.
 		String pw = Sha256.encrypt(map.get("password").toString());
 		
 		// 'userADTO' 클래스의 객체를 생성한다. 이 클래스는 사용자 데이터의 정보를 담는 DTO(Data Transfer Object)이다.
 		UserADTO dto = new UserADTO();
 		
		// DTO 객체에 아이디와 암호화된 비밀번호를 설정한다.
		dto.setId(map.get("id").toString());
		dto.setPassword(pw);

	    // aService를 사용하여 해당 아이디에 대한 사용자 정보를 데이터베이스에서 조회한다.
	    UserADTO userADTO = aService.loginA(dto);
	    
	    // 조회한 사용자가 없는 경우, "none" 결과를 반환한다.
	    if(userADTO == null ) {
			json.put("result", "none");  // 결과 키: "none"
			json.put("id", id);  // 조회한 아이디도 함께 반환
			return json;  // JSON 형태의 응답을 반환
		}
	    
	    if (userADTO != null) {
			json.put("result", "success"); 
		}
		
		return json;  // JSON 형태의 응답을 반환
	}
	
	
	// jqGrid list1
	@RequestMapping(value = "/reagentA.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject reagentA(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		for(String key : map.keySet()) {
			System.out.println(key + ":" + map.get(key));
		}
		JSONObject json = new JSONObject();
		
		List<Lisc500DTO> data = aService.lisc500();
		List<Map> dataList = new ArrayList();
		
		for(int i=0;i<data.size();i++) {
			Map<String,Object> map1 = new HashMap<String,Object>();
			map1.put("testCode", data.get(i).getTestCode());
			map1.put("testName", data.get(i).getTestName());
			map1.put("jundalPart", data.get(i).getJundalPart());
			map1.put("testGubun", data.get(i).getTestGubun());
			map1.put("kukuk", data.get(i).getKukuk());
			map1.put("inDanui", data.get(i).getInDanui());
			map1.put("outDanui", data.get(i).getOutDanui());
			map1.put("changeQty", data.get(i).getChangeQty());
			map1.put("barcodeInYn", data.get(i).getBarcodeInYn());
			map1.put("barcodeDiv", data.get(i).getBarcodeDiv());
			map1.put("barcodeStoreYn", data.get(i).getBarcodeStoreYn());
			map1.put("storeDanui", data.get(i).getStoreDanui());
			map1.put("barcodeOutYn", data.get(i).getBarcodeOutYn());
			map1.put("expDay", data.get(i).getExpDay());
			map1.put("expOpenDay", data.get(i).getExpOpenDay());
			map1.put("keepName", data.get(i).getKeepName());
			map1.put("keepOpenName", data.get(i).getKeepOpenName());
			map1.put("supplierName", data.get(i).getSupplierName());
			map1.put("jejoCode", data.get(i).getJejoCode());
			map1.put("barcode", data.get(i).getBarcode());
			map1.put("danga", data.get(i).getDanga());
			map1.put("lotNo", data.get(i).getLotNo());
			map1.put("startDate", data.get(i).getStartDate());
			map1.put("endDate", data.get(i).getEndDate());
			map1.put("hospitalCode", data.get(i).getHospitalCode());
			
			dataList.add(map1);		
		}
		json.put("rows", dataList);
		
		return json;
	}
	
	
	// jqGrid list2
	@RequestMapping(value = "/reagentA2.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject reagentA2(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		JSONObject json = new JSONObject();
		
		String data = map.get("listData").toString();
				
		List<Lisc501DTO> data2 = aService.lisc501(data);
		List<Map> dataList2 = new ArrayList();
		
		for(int i=0;i<data2.size();i++) {
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("testCode", data2.get(i).getTestCode());
			map2.put("gumsaName", data2.get(i).getGumsaName1());
			
			dataList2.add(map2);
		}
		json.put("rows", dataList2);
		
		return json;
	}
	
	
	
	// jqGrid list3
		@RequestMapping(value = "/reagentA3.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject reagentA3(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
				HttpServletResponse response, Model model) throws Exception {
			
			JSONObject json = new JSONObject();
			
			List<Lisc100DTO> data3 = aService.lisc100();
			List<Map> dataList3 = new ArrayList();
			
			for(int i=0;i<data3.size();i++) {
				Map<String,Object> map3 = new HashMap<String,Object>();
				map3.put("testCode", data3.get(i).getTestCode());
				map3.put("gumsaName", data3.get(i).getGumsaName1());
				
				dataList3.add(map3);				
			}
			json.put("rows", dataList3);
			
			return json;
		}
		
		
		// jqGrid list2
		@RequestMapping(value = "/reagentA2Data.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject receiveData(@RequestBody List<Lisc501updateDTO> data) {
			
			JSONObject json = new JSONObject();
			
			for (Lisc501updateDTO item : data) {

	            int result = 0;
	            
	            result = aService.lisc501SaveData(item);
	            
	            if (result < 1) {
	            	json.put("result", "error");
	            	return json;
	            }
	        }
			
			json.put("result", "success");
			return json;
		}
		
		
		// jqGrid list2 Delete
		@RequestMapping(value = "/reagentA2DataDelete.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject receiveData1(@RequestBody List<Lisc501updateDTO> data) {
			
			JSONObject json = new JSONObject();
			
			for (Lisc501updateDTO item : data) {
	            
	            int result = 0;
	            
	            result = aService.lisc501DeleteData(item);
	        } 
			return json;
		}
		
		
		// jqGrid list1 Save and Update
		@RequestMapping(value = "/reagentAsave.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject saveData(@RequestBody List<Lisc500DTO> modifiedData, HttpSession session,
		                        HttpServletRequest request, HttpServletResponse response, Model model) {
			
			JSONObject json = new JSONObject();
		   
		        for (Lisc500DTO dto : modifiedData) {
		            String statusV = dto.getStatusV();
		     
		            int result = 0;
		            
		            switch (statusV) {
		                case "I":
	                    // 신규 추가 로직 처리
		                	result = aService.lisc500addData(dto);
		                    break;
		                case "U":
		                    // 수정 로직 처리
		                    result = aService.lisc500updateData(dto);
		                    break;
		                default:
		                    continue;
		            }
		            if (result < 1) {
		            	json.put("result", "error");
		            	return json;
		            }
		        }
		        json.put("result", "success");
			    return json;
			}
		
		
		// jqGrid list1 Delete
		@RequestMapping(value = "/reagentAdel.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject delData(@RequestBody Lisc500DTO dto) {
			
			JSONObject json = new JSONObject();
			
				int result = 0;
				
				result = aService.lisc500delData(dto);
			
			return json;
		}
}
