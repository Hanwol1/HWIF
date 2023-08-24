package egovframework.b.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.b.model.QcResultDTO;
import egovframework.b.model.QcResultDateDTO;
import egovframework.b.model.QcResultGumsaResponseDTO;
import egovframework.b.model.QcResultRequestDTO;
import egovframework.b.model.UserBDTO;
import egovframework.b.model.QcCodeDTO;
import egovframework.b.service.BService;
import egovframework.util.Sha256;

@Controller
public class BController {
	@Resource(name="BService")
	private BService bService;
	
	
	@RequestMapping(value = "/loginB.do")
	public String startPage(Model model) throws Exception {
		
		return ".login/loginB";
	}
	
	
	@RequestMapping(value= "/qcResultSave.do", method= RequestMethod.POST)
	@ResponseBody
	public JSONObject qcResultSave(@RequestBody List<Map<String, Object>> list, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		System.out.println("서버 저장");
		JSONObject json = new JSONObject();
		  try {
		        bService.save(list);

		        // 응답 데이터 추가
		        json.put("status", "success");
		        json.put("message", "Data successfully processed.");

		    } catch (Exception e) {
		        json.put("status", "error");
		        json.put("message", "An error occurred during data processing.");
		    }

		
		return json;	
	}
	
	@RequestMapping(value = "/qcResult.do")
	public String qcResultPage(Model model) throws Exception {
		List<String> gumsapartList = bService.gumsapartList();
		List<String> jangbiList = bService.jangbiFindAll();
		List<String> levelList = bService.levelList();
		// List<QcCodeDTO> qcCodeList = bService.qcCodeList();
		List<QcResultGumsaResponseDTO> gumsaList = bService.findGumsa();
		
//		for(QcCodeDTO test : qcCodeList) {
//			System.out.println(test.getItem1() + " " + test.getCode());
//		}
		
		model.addAttribute("gumsapartList", gumsapartList);
		model.addAttribute("jangbiList", jangbiList);
		model.addAttribute("levelList", levelList);
		model.addAttribute("gumsaList", gumsaList);
		// model.addAttribute("qcCodeList", qcCodeList);
		return ".main/qcresultfind/qcResult";
	}
	
	
	@RequestMapping(value = "/findOneQcCode.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject findOneQcCode(@RequestBody String data, Model model) throws Exception{
		JSONObject json = new JSONObject();
		System.out.println("findoNeqcCOde----1");
		String qcCode = bService.qcCodeFindOne(data);

		System.out.println("findoNeqcCOde----2");
		json.put("success", "성공");
		json.put("qcCode", qcCode);
		return json;
	}
	
	
	@RequestMapping(value = "/qcCode.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject findQcCode(@RequestBody String data, Model model) throws Exception{
		JSONObject json = new JSONObject();
		
		List<QcCodeDTO> qcCodeList = bService.qcCodeList(data);
		
		json.put("success", "성공");
		json.put("qcCodeList", qcCodeList);
		model.addAttribute("qcCodeList", qcCodeList);
		return json;
	}
	
	@RequestMapping(value= "/qcResultFindAll.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject qcResultfindAll(@RequestBody Map<String, Object> requestMap, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception{	
		
	
		
		String fromDate = String.valueOf(requestMap.get("fromDate"));
		String toDate = String.valueOf(requestMap.get("toDate"));
		
		System.out.println(fromDate);
		System.out.println(toDate);
		QcResultDateDTO qcResultDateDTO = new QcResultDateDTO(fromDate, toDate); 
		
		JSONObject json = new JSONObject();
		
		List<String> dateList = bService.qcResultDate(qcResultDateDTO);
		
//		for(String date : dateList ) {
//			System.out.println(date);
//		}
		System.out.println("mmmmmmmmmmmmmmmm");
		QcResultRequestDTO qcResultDTO = QcResultRequestDTO.builder()
				.lotNo(String.valueOf(requestMap.get("lotNo")))
				.qcInOut(String.valueOf(requestMap.get("qcInOut")))
				.ruleResult(String.valueOf(requestMap.get("ruleResult")))
				.jundalPart(String.valueOf(requestMap.get("jundalPart")))
				.jangbi(String.valueOf(requestMap.get("장비명")))
				.level(String.valueOf(requestMap.get("level")))
				.muljil(String.valueOf(requestMap.get("물질명")))
				.gumsa(String.valueOf(requestMap.get("검사항목")))
				.dateList(dateList)
				.build();
				
		
		
		System.out.println(qcResultDTO);

		List<Map<String, Object>> list = bService.qcResultFindHashMap(qcResultDTO);
		System.out.println("kkkkkkkkkkkkkkk");
		List<Map> dataList = new ArrayList();
		
		for(Map<String, Object> listMap : list) {
			
			Map<String,Object> map = new LinkedHashMap<String,Object>();
			
			for(String key : listMap.keySet()) {
//				System.out.println(key);
				map.put(key, listMap.get(key));
			}
			dataList.add(map);
			
		}
		
		
	
		json.put("rows",dataList);
				
		return json;
	}
	
	
	
	@RequestMapping(value= "/loginProcess.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject login(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception{
		
		JSONObject json = new JSONObject();
		String id = map.get("id").toString();
		String password = map.get("password").toString();
		
		UserBDTO userBDTO = bService.findOne(id);
		
		if(userBDTO.getId() == null) {
			json.put("result", "none");
			json.put("id", id);
			return json;
		}
		
		if( id.equals(userBDTO.getId()) && 
				Sha256.encrypt(password).equals(userBDTO.getPassword())) {
			
			json.put("result", "success");
			
			
		} else {
			json.put("result", "fail");
		}
		
		
		
		return json;
	}
	
	@RequestMapping(value = "/joinUserB.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject exGrid(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		System.out.println(map);
		JSONObject json = new JSONObject();
		
		UserBDTO dto = new UserBDTO(); // ctrl + shift + o	import
		// 패스워드 암호화, 보안상의 문제가 생길 수 있음
		String pw = Sha256.encrypt(map.get("password").toString());
		
		dto.setId(map.get("id").toString());
		dto.setPassword(pw);
		
		boolean isDuplicateId = bService.duplicate(dto);
		System.out.print(isDuplicateId);
		if(isDuplicateId) {
			json.put("result",  "fail");
		} else {
			json.put("result",  "success");
			int join = bService.joinUser(dto);
			
		}
		
		
		
		
		return json;
	}
}
