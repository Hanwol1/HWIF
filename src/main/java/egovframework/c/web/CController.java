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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.c.model.UserCDTO;
import egovframework.c.model.lisc001DTO;
import egovframework.c.model.lisc002DTO;
import egovframework.c.model.lisc003DTO;
import egovframework.c.model.liscAllDTO;
import egovframework.c.service.CService;
import egovframework.d.model.lisq110DTO;
import egovframework.util.Sha256;

@Controller
public class CController {

	@Resource(name = "CService") // 서비스 선언
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

		int result = cService.userID(dto); // boolean도 사용 가능. true or false . 서버는 무조건 거쳐야됨.
		if (result == 1) {
			json.put("result", "fail"); // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		} else {
			// -- //
			int join = cService.joinUserC(dto); // 서비스 조인 유저 실행
			json.put("result", "success"); // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
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

		UserCDTO result = cService.loginID(dto); // boolean도 사용 가능. true or false

		if (result == null) {
			json.put("result", "none"); // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
		} else {
			json.put("result", "success"); // 서비스에서 가져온걸 리턴. 거의 값 전달만 해줌.
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
			if ("true".equals(map.get("isSearch"))) {
				List<lisc001DTO> data = cService.searchval(searchval); // dto: 변수명
				System.out.println(data);
				JSONArray rowsArray = new JSONArray();
				for (lisc001DTO item : data) { // 검색 결과 데이터를 순회하면서 JSON 객체로 변환하여 배열에 추가
					JSONObject row = new JSONObject();
					row.put("codeType", item.getCodeType());
					row.put("codeTypeName", item.getCodeTypeName());
					row.put("comments", item.getComments());
					row.put("item1", item.getItem1());
					row.put("item2", item.getItem2());
					// 필요한 다른 필드 추가
					rowsArray.add(row);
				}
				json.put("rows", rowsArray);
			} else {
				// 기본 화면
				List<lisc001DTO> data = cService.lisc001list();
				System.out.println(data);
				JSONArray rowsArray = new JSONArray();
				for (lisc001DTO item : data) { // 검색 결과 데이터를 순회하면서 JSON 객체로 변환하여 배열에 추가
					JSONObject row = new JSONObject();
					row.put("codeType", item.getCodeType());
					row.put("codeTypeName", item.getCodeTypeName());
					row.put("comments", item.getComments());
					row.put("item1", item.getItem1());
					row.put("item2", item.getItem2());
					// 필요한 다른 필드 추가
					rowsArray.add(row);
				}
				json.put("rows", rowsArray);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

	@RequestMapping(value = "/oneGridC002.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject lisc002DTO(@RequestParam String item1, String type, HttpSession session,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		// String codetype = (String) map["type"];

		System.out.print(item1);
		String item1Array[] = item1.substring(1, item1.length() - 1).split("&quot;,");
		//System.out.println(item1Array.length);
		for (int i = 0; i < item1Array.length; i++) {
			item1Array[i] = item1Array[i].replace("&quot;", "");
			//System.out.println(i + "번째 : " + item1Array[i]);
		}

		JSONObject json = new JSONObject();
		try {
			List<lisc002DTO> data = cService.codetype(type);
			System.out.println(data);
			JSONArray rowsArray = new JSONArray();
			for (lisc002DTO item : data) {
				LinkedHashMap<String, Object> row = new LinkedHashMap<>();
				row.put("code", item.getCode());
				row.put("item1", item.getItem1());
				row.put("item2", item.getItem2());
				row.put("item3", item.getItem3());
				row.put("item4", item.getItem4());
				row.put("item5", item.getItem5());
				row.put("remark1", item.getRemark1());
				row.put("remark2", item.getRemark2());
				row.put("codeType", item.getCodeType());
				System.out.println(row);
				// 필요한 다른 필드 추가
				rowsArray.add(row);
			}
			json.put("rows", rowsArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

	@RequestMapping(value = "/oneGridC003.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject lisc003DTO(@RequestParam String item2, String type, HttpSession session,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		System.out.println("-----------");
		System.out.println(type);
		String item2Array[] = item2.substring(1, item2.length() - 1).split("&quot;,");
		for (int i = 0; i < item2Array.length; i++) {
			item2Array[i] = item2Array[i].replace("&quot;", "");
		}

		JSONObject json = new JSONObject();
		try {
			List<lisc003DTO> data = cService.code(type);
			System.out.println(data);
			JSONArray rowsArray = new JSONArray();
			for (lisc003DTO item : data) {
				LinkedHashMap<String, Object> row = new LinkedHashMap<>();
				row.put("code2", item.getCode2());
				row.put("item1", item.getItem1());
				row.put("item2", item.getItem2());
				row.put("item3", item.getItem3());
				row.put("item4", item.getItem4());
				row.put("item5", item.getItem5());
				row.put("remark1", item.getRemark1());
				row.put("remark2", item.getRemark2());
				row.put("code", item.getCode());
				row.put("codeType", item.getCodeType());
				// 필요한 다른 필드 추가
				rowsArray.add(row);
			}
			json.put("rows", rowsArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}

	// ---------------------------------------------------------------------------------saveBtn
	 @RequestMapping(value = "/saveBtn.do", method = RequestMethod.POST)
	 @ResponseBody public JSONObject saveData( @RequestBody liscAllDTO data, HttpSession session, 
		HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		 
		 JSONObject json = new JSONObject();
		 
		 List<lisc001DTO> lisc001Data = data.getLisc001Data();
		 List<lisc002DTO> lisc002Data = data.getLisc002Data();
		 List<lisc003DTO> lisc003Data = data.getLisc003Data();
		 System.out.println("-----------------saveBTN");
		 System.out.println(lisc001Data);
		 // ------------------------------------------------------------------------001 
		 for (lisc001DTO dto : lisc001Data) {
			//System.out.println("001 dto.getCodeType() : " + dto.getCodeType());
			//System.out.println("001 dto.CodeTypeName() : " + dto.getCodeTypeName());
	        String flag = dto.getFlag();
	        //System.out.println("001 flag : " + flag);
	        int result = 0;
	        switch (flag) {
	            case "U":
	            	result = cService.update001Data(dto);
	                break;
	            case "I":
	            	result = cService.add001Data(dto);
	                break;
                default:
                	continue;
	        }
	        if (result < 1) {
	            json.put("result", "error");
	            return json;
	        }
	    }
		 // ------------------------------------------------------------------------002
		 for (lisc002DTO dto : lisc002Data) {		        
	        String flag = dto.getFlag();
	        int result = 0;
	        switch (flag) {
	            case "U":
	                result = cService.update002Data(dto);
	                break;
	            case "I":
	            	result = cService.add002Data(dto);
	                break;
                default:
                	continue;
	        }
	        if (result < 1) {
	            json.put("result", "error");
	            return json;
	        }
	    }
		// ------------------------------------------------------------------------003
		 for (lisc003DTO dto : lisc003Data) {	
			String flag = dto.getFlag();
			System.out.println("003flag : " + flag);
	        int result = 0;
	        switch (flag) {
	            case "U":
	            	result = cService.update003Data(dto);
	                break;
	            case "I":
	            	result = cService.add003Data(dto);
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
	 
	 
}
