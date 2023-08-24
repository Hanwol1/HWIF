package egovframework.d.web;

import java.util.ArrayList;
import java.util.HashMap;
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

import egovframework.d.model.UserDDTO;
import egovframework.d.model.lisc100DTO;
import egovframework.d.model.lisq100DTO;
import egovframework.d.model.lisq110DTO;
import egovframework.d.model.testPartListDTO;
import egovframework.d.service.DService;
import egovframework.util.Sha256;

@Controller
public class DController {
	
	@Resource(name="DService")
	DService dService;
	
	@RequestMapping(value = "/loginD.do")
	public String startPage(Model model) throws Exception {
		return ".login/loginD";
	}
	
	@RequestMapping(value = "/joinUserD.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject singup(@RequestParam Map<String,Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		UserDDTO dto = new UserDDTO();
		
		String id = map.get("id").toString();
		int check = dService.checkUser(id);
		
		// System.out.println(check);
		
		if (check != 1) {
			String pw = Sha256.encrypt(map.get("password").toString());
			dto.setId(id);
			dto.setPassword(pw);
			// 서비스의 조인유저를 실행하라
			int join = dService.joinUser(dto);
			json.put("result", "success");
		} else {
			json.put("result", "error");
		}
		
		return json;
	}
	
	@RequestMapping(value = "/loginUserD.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject login(@RequestParam Map<String,Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		UserDDTO dto = new UserDDTO();
		
		String id = map.get("id").toString();
		String pw = Sha256.encrypt(map.get("password").toString());
		
		dto.setId(id);
		dto.setPassword(pw);
		
		UserDDTO login = dService.loginUser(dto);
		
		if (login == null) {
			json.put("result", "error");
		} else {
			json.put("user", login);
			json.put("result", "success");
		}
		
		return json;
	}
	
	@RequestMapping(value = "/qcManagementGrid.do", method = RequestMethod.GET)
	public String qcManagementGrid(Model model) throws Exception {
		// 페이지 이동 시 model에 데이터를 넣어서 이동
		
		// 검사파트
		List<testPartListDTO> getTestPartList = dService.testPartList();
		// QC물질명
		List<String> getQCNameList = dService.qcNameFindAll();
		
        List<Map> testPartList = new ArrayList();
        
        for (int i=0; i<getTestPartList.size(); i++) {
        	Map<String, String> data = new HashMap<String, String>();
        	
        	data.put("code", getTestPartList.get(i).getCode());
        	data.put("item1", getTestPartList.get(i).getItem1());
        	testPartList.add(data);
        }
        
        model.addAttribute("testPartList", testPartList);
        model.addAttribute("qcNameList", getQCNameList);
        
		return ".main/qcmanagement/QCManagementGrid";
	}
	
	@RequestMapping(value = "/qcNameListByTestPart.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject qcNameListByTestPart(@RequestBody Map<String,String> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		
		String jundalPart = map.get("jundalPart");
		
		try {
			List<String> qcNameList;
			
			// 자바에서 문자열을 비교할 때 '=='는 두 문자열이 동일한 객체인지 비교하고 .equals는 내용을 비교
			if ("all".equals(jundalPart)) { 
				qcNameList = dService.qcNameFindAll();
			} else {
				qcNameList = dService.qcNameListByTestPart(jundalPart);
			}
			
			json.put("result", "success");
			json.put("qcNameList", qcNameList);
		} catch (Exception e) {
			e.printStackTrace();
			
			json.put("result", "error");
		}
		
		return json;
	}
	
	@RequestMapping(value = "/qcManagementLisq100.do")
	@ResponseBody
	public JSONObject qcManagementLisq100(@RequestParam Map<String,Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		
		String endDate = map.get("endDate").toString();
		String qcInOut = map.get("qcInOut").toString();
        String jundalPart = map.get("jundalPart").toString();
        String qcName = map.get("qcName").toString();
        
        Map<String, String> paramMap = new HashMap<>();
        
        paramMap.put("endDate", endDate);
        paramMap.put("qcInOut", qcInOut);
        paramMap.put("jundalPart", jundalPart);
        paramMap.put("qcName", qcName);
		
		List<lisq100DTO> data = dService.lisq100(paramMap);
		List<Map> dataList = new ArrayList();
		
		for(int i=0; i<data.size(); i++) {
			Map<String,Object> map2 = new HashMap<String,Object>();
			// 'QC 코드','QC물질명','Lot No', 'Level', '검사파트', '시작일', '종료일', '고정검체번호',
			map2.put("qcCode", data.get(i).getQcCode());
			map2.put("qcName", data.get(i).getQcName());
			map2.put("lotNo", data.get(i).getLotNo());
			map2.put("qcLevel", data.get(i).getQcLevel());
			map2.put("testPart", data.get(i).getItem1());
			map2.put("startDate", data.get(i).getStartDate());
			map2.put("endDate", data.get(i).getEndDate());
			map2.put("qcSpecimenSer", data.get(i).getQcSpecimenSer());
			dataList.add(map2);
		}
		
		json.put("rows", dataList);
		
		return json;
	}
	
	@RequestMapping(value = "/qcManagementLisq110.do")
	@ResponseBody
	public JSONObject qcManagementLisq110(@RequestParam Map<String,String> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		
		List<lisq110DTO> data = dService.lisq110(map.get("qcCode"));
		List<Map> dataList = new ArrayList();
		
		for(int i=0; i<data.size(); i++) {
			Map<String,Object> map1 = new HashMap<String,Object>();
			// '검사코드', '검사명', '검사파트', 'Mean', 'SD', 'CV', '허용(L)', '허용(H)', '서술형', '단위', '시작일', '종료일', 
	    	// '1(2S)', '판정(1_2S)', '1(3S)', '판정(1_3S)', '2(2S)', '판정(2_2S)', 'R(4S)', '판정(R_4S)', '4(1S)', '판정(4_1S)', '10X', '판정(10X)', '순번', '그래프'
			map1.put("testCode", data.get(i).getTestCode());
			map1.put("gumsaName", data.get(i).getGumsaName1());
			map1.put("jundalPart", data.get(i).getItem1());
			map1.put("meanValue", data.get(i).getMeanValue());
			map1.put("sdValue", data.get(i).getSdValue());
			map1.put("cvValue", data.get(i).getCvValue());
			map1.put("lowValue", data.get(i).getLowValue());
			map1.put("highValue", data.get(i).getHighValue());
			map1.put("susulValue", data.get(i).getSusulValue());
			map1.put("danui", data.get(i).getDanui());
			map1.put("startDate", data.get(i).getStartDate());
			map1.put("endDate", data.get(i).getEndDate());
			map1.put("rule12S", data.get(i).getRule12S());
			map1.put("gubun12S", data.get(i).getGubun12S());
			map1.put("rule13S", data.get(i).getRule13S());
			map1.put("gubun13S", data.get(i).getGubun13S());
			map1.put("rule22S", data.get(i).getRule22S());
			map1.put("gubun22S", data.get(i).getGubun22S());
			map1.put("ruleR4S", data.get(i).getRuleR4S());
			map1.put("gubunR4S", data.get(i).getGubunR4S());
			map1.put("rule41S", data.get(i).getRule41S());
			map1.put("gubun41S", data.get(i).getGubun41S());
			map1.put("rule10X", data.get(i).getRule10X());
			map1.put("gubun10X", data.get(i).getGubun10X());
			map1.put("testCodeSeq", data.get(i).getTestCodeSeq());
			map1.put("graphYN", data.get(i).getGraphYN());
			
			// pk 값을 위해
			map1.put("qcCode", data.get(i).getQcCode());
			map1.put("qcLevel", data.get(i).getQcLevel());
			map1.put("lotNo", data.get(i).getLotNo());
			map1.put("fkStartDate", data.get(i).getFkStartDate());
			map1.put("fkQcStartDate", data.get(i).getFkQcStartDate());
			dataList.add(map1);
		}
		
		json.put("rows", dataList);
		
		return json;
	}
	
	@RequestMapping(value = "/qcManagementLisc100.do")
	@ResponseBody
	public JSONObject qcManagementLisc100(@RequestParam Map<String,String> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		
		List<lisc100DTO> data = dService.lisc100(map.get("jundalPart"));
		List<Map> dataList = new ArrayList();
		
		for(int i=0; i<data.size(); i++) {
			Map<String,Object> map1 = new HashMap<String,Object>();
			// '검사코드', '검사명', '단위'
			map1.put("testCode", data.get(i).getTestCode());
			map1.put("gumsaName", data.get(i).getGumsaName1());
			map1.put("resultDanui", data.get(i).getResultDanui());
			map1.put("item1", data.get(i).getItem1());
			dataList.add(map1);
		}
		
		json.put("rows", dataList);
		
		return json;
	}
	
	@RequestMapping(value = "/saveData.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject saveData(@RequestBody List<Map<String,String>> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {		
		JSONObject json = new JSONObject();
		
//		System.out.println(map);
		
		for (int i=0; i<map.size(); i++) {
			Map<String, String> data = new HashMap<>(map.get(i));
			System.out.println(data);
			lisq110DTO dto = new lisq110DTO();
			
			String testCode = data.get("testCode").toString();
			String gumsaName = data.get("gumsaName").toString();
			String item1 = data.get("jundalPart").toString();
			String jundalPart = dService.getJundalPart(item1);
			String meanValue = data.get("meanValue").toString();
			String sdValue = data.get("sdValue").toString();
			String cvValue = data.get("cvValue").toString();
			String lowValue = data.get("lowValue").toString();
			String highValue = data.get("highValue").toString();
			String susulValue = data.get("susulValue").toString();
			String danui = data.get("danui").toString();
			String startDate = data.get("startDate").toString();
			String endDate = data.get("endDate").toString();
			String gubun10X = data.get("gubun10X").toString();
			String gubun12S = data.get("gubun12S").toString();
			String gubun13S = data.get("gubun13S").toString();
			String gubun22S = data.get("gubun22S").toString();
			String gubun41S = data.get("gubun41S").toString();
			String gubunR4S = data.get("gubunR4S").toString();
			String rule10X = data.get("rule10X").toString();
			String rule12S = data.get("rule12S").toString();
			String rule13S = data.get("rule13S").toString();
			String rule22S = data.get("rule22S").toString();
			String rule41S = data.get("rule41S").toString();
			String ruleR4S = data.get("ruleR4S").toString();
			String testCodeSeq = data.get("testCodeSeq").toString();
			String graphYN = data.get("graphYN").toString();
			String qcCode = data.get("qcCode").toString();
			String qcLevel = data.get("qcLevel").toString();
			String lotNo = data.get("lotNo").toString();
			String fkStartDate = data.get("fkStartDate").toString();
			String fkQcStartDate = data.get("fkQcStartDate").toString();
			
			dto.setTestCode(testCode);
			dto.setGumsaName(gumsaName);
			dto.setItem1(jundalPart);
			dto.setMeanValue(meanValue);
			dto.setSdValue(sdValue);
			dto.setCvValue(cvValue);
			dto.setLowValue(lowValue);
			dto.setHighValue(highValue);
			dto.setSusulValue(susulValue);
			dto.setDanui(danui);
			dto.setStartDate(startDate);
			dto.setEndDate(endDate);
			dto.setRule12S(rule12S);
			dto.setGubun12S(gubun12S);
			dto.setRule13S(rule13S);
			dto.setGubun13S(gubun13S);
			dto.setRule22S(rule22S);
			dto.setGubun22S(gubun22S);
			dto.setRuleR4S(ruleR4S);
			dto.setGubunR4S(gubunR4S);
			dto.setRule41S(rule41S);
			dto.setGubun41S(gubun41S);
			dto.setRule10X(rule10X);
			dto.setGubun10X(gubun10X);
			dto.setTestCodeSeq(testCodeSeq);
			dto.setGraphYN(graphYN);
			
			dto.setQcCode(qcCode);
			dto.setQcLevel(qcLevel);
			dto.setLotNo(lotNo);
			dto.setFkStartDate(fkStartDate);
			dto.setFkQcStartDate(fkQcStartDate);
			
			if ("U".equals(data.get("flag"))) {
				int result = dService.updateData(dto);
				
				if (result == 1) {
					json.put("result", "success");
				} else {
					json.put("result", "error");
				}
			} else if ("A".equals(data.get("flag"))) {
				
			}
		}
		
		return json;
	}
}
