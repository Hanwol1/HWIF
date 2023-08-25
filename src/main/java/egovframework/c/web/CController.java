package egovframework.c.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.c.model.UserCDTO;
import egovframework.c.model.lisc001DTO;
import egovframework.c.model.lisc002DTO;
import egovframework.c.model.lisc003DTO;
import egovframework.c.service.CService;
import egovframework.util.Sha256;

@Controller
public class CController {
	
	@Resource(name = "CService")  // 서비스 선언
	CService cService;
	private String dto;
	
	@RequestMapping(value = "/loginC.do")
	public String startPage(Model model) throws Exception {
		return ".login/loginC";
	}
	@RequestMapping(value = "/oneGridPage.do")
	public String oneGridPage(Model model) throws Exception {
		return ".main/oneGridC/oneGridC";
	}
	
	@RequestMapping(value = "/joinUserC.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject exGrid(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		JSONObject json = new JSONObject();
		UserCDTO dto = new UserCDTO();
		String pw = Sha256.encrypt(map.get("password").toString());
		dto.setId(map.get("id").toString());
		dto.setPassword(pw);
		
		int result = cService.userID(dto);  // boolean도 사용 가능. true or false . 서버는 무조건 거쳐야됨.
		if (result == 1) {
			json.put("result", "fail");  // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		}
		else {
		// -- //
		int join = cService.joinUserC(dto);  // 서비스 조인 유저 실행
		json.put("result", "success");  // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		}
		
		return json;
	}
	
	@RequestMapping(value = "/loginID.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject oneGrid(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		JSONObject json = new JSONObject();
		UserCDTO dto = new UserCDTO();
		String pw = Sha256.encrypt(map.get("password").toString());
		dto.setId(map.get("id").toString());
		dto.setPassword(pw);
		
		UserCDTO result = cService.loginID(dto);  // boolean도 사용 가능. true or false
		
		if (result == null) {
			json.put("result", "none");  // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		}
		else {
			json.put("result", "success");  // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		}
		
		return json;
	}
	/*
			 * // search input 시 화면 if("true".equals(map.get("isSearch"))) { // 검색여부 boolean
			 * 값이 true 일 때만 DB 조회[처음 화면 로딩 시 화면 조회 안함] lisc001DTO dto = new lisc001DTO();
			 * //데이터베이스 조회에 사용할 DTO 객체 생성 //검색어가 비어있지 않다면 DTO 객체에 할당
			 * if(!"".equals(map.get("search"))) { dto.setItem1((String)map.get("search"));
			 * } } //데이터베이스 조회결과를 담을 리스트객체 선언 List<lisc001DTO> data = null; data =
			 * CService.lisc001DTO(dto);
			 */
	@RequestMapping(value = "/oneGridC.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject lisc001DTO(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
	HttpServletResponse response, Model model) throws Exception {
		System.out.println(map);
		String searchval = (String) map.get("searchval");
		System.out.println(map.get("searchval"));
		JSONObject json = new JSONObject();
		try {
			if("true".equals(map.get("isSearch"))) {
				List<lisc001DTO> data = cService.searchval(searchval); // dto: 변수명
			    System.out.println(data);
			    JSONArray rowsArray = new JSONArray();
			    for (lisc001DTO item : data) { // 검색 결과 데이터를 순회하면서 JSON 객체로 변환하여 배열에 추가
			        JSONObject row = new JSONObject();
			        row.put("CODE_TYPE", item.getCodeType());
			        row.put("CODE_TYPE_NAME", item.getCodeTypeName());
			        row.put("COMMENTS", item.getComments());
			        // row.put("ITEM1", item.getItem1());
			        // row.put("ITEM2", item.getItem2());
			        // 필요한 다른 필드 추가
			        rowsArray.add(row);
			    }
			    json.put("rows", rowsArray);
			}
			else {
				// 기본 화면
				List<lisc001DTO> data = cService.lisc001list();
			    System.out.println(data);
			    JSONArray rowsArray = new JSONArray();
			    for (lisc001DTO item : data) {
			        JSONObject row = new JSONObject();
			        row.put("CODE_TYPE", item.getCodeType());
			        row.put("CODE_TYPE_NAME", item.getCodeTypeName());
			        row.put("COMMENTS", item.getComments());
			        row.put("ITEM1", item.getItem1());
			        row.put("ITEM2", item.getItem2());
			        // 필요한 다른 필드 추가
			        rowsArray.add(row);
			    }
			    json.put("rows", rowsArray);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	
	
	@RequestMapping(value = "/oneGridC002.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject lisc002DTO(@RequestParam String item1, String type, HttpSession session, HttpServletRequest request,
	HttpServletResponse response, Model model) throws Exception {
		//String codetype = (String) map["type"];
		
		System.out.print(item1);
		String item1Array[] = item1.substring(1, item1.length()-1).split("&quot;,");
		System.out.println(item1Array.length);
		for(int i=0; i<item1Array.length; i++) {
			item1Array[i] = item1Array[i].replace("&quot;", "");
			System.out.println(i + "번째 : " + item1Array[i]);
		}
			
		JSONObject json = new JSONObject();
		try {
		    List<lisc002DTO> data = cService.codetype(type);
		    System.out.println(data);
		    JSONArray rowsArray = new JSONArray();
		    for (lisc002DTO item : data) {
		    	LinkedHashMap<String, Object> row = new LinkedHashMap<>();
		        row.put(item1Array[0], item.getCode());
		        row.put(item1Array[1], item.getItem1());
		        row.put(item1Array[2], item.getItem2());
		        row.put(item1Array[3], item.getItem3());
		        row.put(item1Array[4], item.getItem4());
		        row.put(item1Array[5], item.getItem5());
		        row.put(item1Array[6], item.getRemark1());
		        row.put(item1Array[7], item.getRemark2());
		        row.put("lisc002code", item.getCode());
		        System.out.println(row);
		        // 필요한 다른 필드 추가
		        rowsArray.add(row);
		    }
		    json.put("rows", rowsArray);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value = "/oneGridC003.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject lisc003DTO(@RequestParam String item2, String type, HttpSession session, HttpServletRequest request,
	HttpServletResponse response, Model model) throws Exception {
		System.out.println("-----------");
		System.out.println(type);
		String item2Array[] = item2.substring(1, item2.length()-1).split("&quot;,");
		System.out.println("item2Array길이: " + item2Array.length);
		for(int i=0; i<item2Array.length; i++) {
			item2Array[i] = item2Array[i].replace("&quot;", "");
			System.out.println(i + "번째 : " + item2Array[i]);
		}
		
		JSONObject json = new JSONObject();
		try {
		    List<lisc003DTO> data = cService.code(type);
		    System.out.println(data);
		    JSONArray rowsArray = new JSONArray();
		    for (lisc003DTO item : data) {
		    	LinkedHashMap<String, Object> row = new LinkedHashMap<>();
		        row.put(item2Array[0], item.getCode2());
		        row.put(item2Array[1], item.getItem1());
		        row.put(item2Array[2], item.getItem2());
		        row.put(item2Array[3], item.getItem3());
		        row.put(item2Array[4], item.getItem4());
		        row.put(item2Array[5], item.getItem5());
		        row.put(item2Array[6], item.getRemark1());
		        row.put(item2Array[7], item.getRemark2());
		        // 필요한 다른 필드 추가
		        rowsArray.add(row);
		    }
		    json.put("rows", rowsArray);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return json;
	}
}





