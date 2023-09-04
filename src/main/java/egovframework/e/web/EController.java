package egovframework.e.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.e.model.UserEDTO;
import egovframework.e.model.grid1DTO;
import egovframework.e.model.grid2DTO;
import egovframework.e.service.EService;
import egovframework.util.Sha256;

@Controller
public class EController {
	@Resource(name="EService")
	EService eService;
	
	@RequestMapping(value = "/loginE.do")
	public String startPage(Model model) throws Exception {
		return ".login/loginE";
	}
	
	
	@RequestMapping(value= "/loginProcessE.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject login(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception{
		
		JSONObject json = new JSONObject();
		String id = map.get("id").toString();
		String password = map.get("password").toString();
		
		UserEDTO userEDTO = eService.findOne(id);
		
		if(userEDTO.getId() == null) {
			json.put("result", "none");
			json.put("id", id);
			return json;
		}
		
		if( id.equals(userEDTO.getId()) && 
				Sha256.encrypt(password).equals(userEDTO.getPassword())) {
			
			json.put("result", "success");
			
			
		} else {
			json.put("result", "fail");
		}
		
		return json;
	
	}
	
	@RequestMapping(value = "/joinUserE.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject exGrid(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		System.out.println(map);
		JSONObject json = new JSONObject();
		
		UserEDTO dto = new UserEDTO(); // ctrl + shift + o	import
		// 패스워드 암호화, 보안상의 문제가 생길 수 있음
		String pw = Sha256.encrypt(map.get("password").toString());
		
		dto.setId(map.get("id").toString());
		dto.setPassword(pw);
		
		boolean isDuplicateId = eService.duplicate(dto);
		System.out.print(isDuplicateId);
		if(isDuplicateId) {
			json.put("result",  "fail");
		} else {
			json.put("result",  "success");
			int join = eService.joinUser(dto);		
		}
				
		return json;
	}
	
	 
	@RequestMapping(value = "/DCListGrid.do")
	public String dcListGrid(Model model) throws Exception {
		return ".main/dclist/DCListGrid";
	}
	
	//grid1
	@RequestMapping(value = "/dcListGrid100.do") //해당 URL로의 요청이 이 메서드에 매핑되도록 설정
	@ResponseBody //이 어노테이션은 메서드가 반환하는 데이터를 HTTP 응답의 본문(body)으로 사용하도록 지정, 반환되는 데이터를 JSON 형식으로 변환하여 클라이언트에게 전달
	
	// 메서드 정의 , 요청 파라미터와 세션,요청,응답 등을 받아 처리하는 역할
	public JSONObject dcListGrid100(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {

		System.out.println("map >>>" + map);
	    JSONObject json = new JSONObject();//json형식의 데이터를 담을 객체를 생성

	    try {
		    if("true".equals(map.get("isSearch"))) { // 검색여부 boolean 값이 true 일 때만 DB 조회[처음 화면 로딩 시 화면 조회 안함]
		    	grid1DTO grid1DTO = new grid1DTO(); //데이터베이스 조회에 사용할 DTO 객체 생성
		    	
		    	//검색어가 비어있지 않다면 DTO 객체에 할당
		    	if(!"".equals(map.get("searchInput"))) {
		    		grid1DTO.setItem1((String)map.get("searchInput"));
		    	}
		    	
		    	System.out.println("grid1DTO >>>" + grid1DTO + "\tsearchInput >>>" + grid1DTO.getItem1());
		    	
		    	//데이터베이스 조회결과를 담을 리스트객체 선언
		    	List<grid1DTO> data = null;
		    	if("true".equals(map.get("isFirst"))) { // 첫 검색은 6개 데이터만 검색
		    		data = eService.grid1First(grid1DTO);
		    	}else { // 첫검색이 아니면 전체 데이터(검색어 포함)검색
		    		data = eService.grid1(grid1DTO);
		    	}
		    	
		    	//조회된 데이터를 JSON 배열 형태로 담을 객체를 생성 & for ~ 데이터베이스에서 조회한 결과를 반복하여 JSON 객체로 변환
			    JSONArray rowsArray = new JSONArray();
			    for (grid1DTO item : data) {
			        JSONObject row = new JSONObject();
			        row.put("code", item.getCode()); //문서코드
			        row.put("item1", item.getItem1()); //문서명
			        row.put("item2", item.getItem2()); //최종문서체크
			        row.put("item3", item.getItem3()); //담당자
			        row.put("item4", item.getItem4()); //실장
			        row.put("item5", item.getItem5()); //과장
			        row.put("remark1", item.getReMark1()); //문서형식
			        row.put("remark2", item.getReMark2()); //비고
			        // 필요한 다른 필드 추가
			        rowsArray.add(row);
			    }
		
			    //System.out.println("rowsArray >>>" + rowsArray);
			    json.put("rows", rowsArray); //최종적으로 JSON 배열을 JSON 객체에 "rows"라는 키로 넣어준다
		    }
	    }catch(Exception ex) {
	    	ex.printStackTrace();
	    }
		//System.out.println("========rows==================");
	    return json; //JSON 객체를 반환하여 클라이언트로 전송
	}
	
	/**
	 * 그리드의 선택한 행 데이터를 삭제
	 * @param map
	 * @param session
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dcListDelete.do")
	@ResponseBody
	public JSONObject dcListDelete(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {
		JSONObject json = new JSONObject();
		System.out.println("dcListDelete map >>>" + map);
	    
		int rusule = eService.setDcListDelete(map);
	    
		System.out.println("rusule >>>" + rusule);
	    
	
	    json.put("result", rusule);
		//System.out.println("========rows==================");
	    return json;
	}
	
	
	
	//grid2
	@RequestMapping(value = "/dcListGrid200.do")
	@ResponseBody
	public JSONObject dcListGrid200(@RequestParam Map<String, Object> map, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {
			System.out.println("map >>>" + map);
		    JSONObject json = new JSONObject();
		 try {
	
		    if("true".equals(map.get("isSearch2"))) { // 검색여부 boolean 값이 true 일 때만 DB 조회[처음 화면 로딩 시 화면 조회 안함]
		    	grid2DTO grid2DTO = new grid2DTO();
		    	if(!"".equals(map.get("searchInput2"))) {
		    		grid2DTO.setFileName((String)map.get("searchInput2"));
		    	}
		    	if(!"".equals(map.get("code"))) {
		    		grid2DTO.setCode((String)map.get("code"));
		    	}
		    	grid2DTO.setIncludeExpired((String)map.get("includeExpired"));
		    	
	    		System.out.println("grid2DTO >>>" + grid2DTO);
		    	
		  			
		    	List<grid2DTO> data = eService.grid2(grid2DTO);
		    	
			    JSONArray rowsArray = new JSONArray();
			    for (grid2DTO item : data) {
			        JSONObject row = new JSONObject();
			        row.put("code", item.getCode()); //문서코드
			        row.put("code_no", item.getCodeNo()); //문서번호
			        row.put("file_name", item.getFileName()); //파일명
			        row.put("file_date", item.getFileDate()); //등록일
			        row.put("file_user", item.getFileUser()); //등록자
			        row.put("file_enddt", item.getFileEnddt()); //사용종료일
			        row.put("id1", item.getId1()); //담당
			        row.put("id2", item.getId2()); //실장
			        row.put("id3", item.getId3()); //과장
			        // 필요한 다른 필드 추가
			        rowsArray.add(row);
			    }
		
			    //System.out.println("rowsArray >>>" + rowsArray);
			    json.put("rows", rowsArray);
		    }
		}catch(Exception e) {
			e.printStackTrace();
		}
		//System.out.println("========rows==================");
	    return json;
	}
	
	
	//grid2 사용등록
	@RequestMapping(value = "/updateGrid2Row.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateGrid2Row(@RequestParam Map<String, Object> map) {
	    JSONObject json = new JSONObject();

	    String code = (String) map.get("code");
	    String codeNo = (String) map.get("codeNo");

	    Map<String, Object> updateMap = new HashMap<>();
	    updateMap.put("code", code);
	    updateMap.put("codeNo", codeNo);

	    try {
	        // 등록일자 업데이트를 위한 코드 추가
	        Date currentDate = new Date();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        String formattedDate = dateFormat.format(currentDate);
	        updateMap.put("file_date", formattedDate);

	        // eService에서 종료일자 삭제하는 메서드 호출
	        //eService.clearDcListFileEndDate(updateMap); 

	        int result = eService.updateGrid2Row(updateMap); 

	        if (result > 0) {
	            json.put("result", "success");
	        } else {
	            json.put("result", "fail");
	        }
	    } catch (Exception e) {
	        json.put("result", "fail");
	    }

	    return json;
	}
	
	
	//grid2 사용종료
		@RequestMapping(value = "/deleteGrid2Row.do", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject deleteGrid2Row(@RequestParam Map<String, Object> map) {
		    JSONObject json = new JSONObject();

		    String code = (String) map.get("code");
		    String codeNo = (String) map.get("codeNo");

		    Map<String, Object> updateMap = new HashMap<>();
		    updateMap.put("code", code);
		    updateMap.put("codeNo", codeNo);

		    try {
		        // 종료일자 업데이트를 위한 코드 추가
		        Date currentDate = new Date();
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		        String formattedDate = dateFormat.format(currentDate);
		        updateMap.put("file_enddt", formattedDate);

		        // eService에서 종료일자를 업데이트하는 메서드 호출	
		        
		        int result = eService.deleteGrid2Row(updateMap); 

		        if (result > 0) {
		            json.put("result", "success");
		        } 
		    } catch (Exception e) {
		        json.put("result", "fail");
		    }

		    return json;
		}
		
		//그리드1 셀입력 수정&입력
		@RequestMapping(value = "/saveGrid1.do", method = RequestMethod.POST , produces = "application/json")
		@ResponseBody
		public JSONObject saveGrid1( @RequestParam Map<String, Object> map) {
			int resultIdx = 0;
			JSONObject result = new JSONObject();
			
			try {
				JSONParser jsonParse = new JSONParser();
				String newCode = map.get("code").toString();
				newCode = newCode.replaceAll("&quot;", "\"").replaceAll("&gt;", ">").replaceAll("&lt;", "<").replaceAll("&amp;", "&").replaceAll("\r", "<br>").replaceAll("<p>", "\n").replaceAll("&apos", "'"); // xss 관련 처리;
				
				String jsonData = map.get("data").toString();
				jsonParse = new JSONParser();
				jsonData = jsonData.replaceAll("&quot;", "\"").replaceAll("&gt;", ">").replaceAll("&lt;", "<").replaceAll("&amp;", "&").replaceAll("\r", "<br>").replaceAll("<p>", "\n").replaceAll("&apos", "'"); // xss 관련 처리;
				System.out.println("jsonData >>>" + jsonData);
	            JSONArray jsonArray = (JSONArray) jsonParse.parse(jsonData);
	            System.out.println("jsonObj >>>" + jsonArray.size()); //
	            
	            for(Object data : jsonArray) {
	            	Map paramData = (HashMap)data; 
	            	Object code = paramData.get("code");
	            	System.out.println("code >>>" + code);
	            	if("".equals(code)) { // 등록
	            		resultIdx = eService.insertGrid1Row(paramData);
	            	}else { // 수정
	            		resultIdx = eService.updateGrid1Row(paramData);
	            	}
	            }
	            
			}catch(Exception e) {
				e.printStackTrace();
				result.put("result", "false");
			}

			result.put("result", "true");
			    
			return result;
		}
		
		//그리드2 셀입력 수정&입력
		@RequestMapping(value = "/saveGrid2.do", method = RequestMethod.POST , produces = "application/json")
		@ResponseBody
		public JSONObject saveGrid2( @RequestParam Map<String, Object> map) {
			int resultIdx = 0;
			JSONObject result = new JSONObject();
			
			try {
				JSONParser jsonParse = new JSONParser();
				String newCode_no = map.get("code_no").toString();
				newCode_no = newCode_no.replaceAll("&quot;", "\"");
				
				String jsonData = map.get("data").toString();
				jsonParse = new JSONParser();
				jsonData = jsonData.replaceAll("&quot;", "\"");
				System.out.println("jsonData >>>" + jsonData);
	            JSONArray jsonArray = (JSONArray) jsonParse.parse(jsonData);
	            System.out.println("jsonObj >>>" + jsonArray.size()); //
	            
	            for(Object data : jsonArray) {
	            	Map paramData = (HashMap)data; 
	            	Object code_no = paramData.get("code_no");
	            	if("".equals(code_no)) { // 등록
	            		resultIdx = eService.insertGrid2Row(paramData);
	            	}else { // 수정
	            		resultIdx = eService.updateGrid2Rows(paramData);
	            	}
	            }
	            
			}catch(Exception e) {
				e.printStackTrace();
				result.put("result", "false");
			}

			result.put("result", "true");
			    
			return result;
		}
		
		
		//그리드1 코멘트 입력 & 저장
		@RequestMapping(value = "/saveComment.do", method = RequestMethod.POST , produces = "application/json")
		@ResponseBody
		public JSONObject saveComment( @RequestParam Map<String, Object> map) {
			int resultIdx = 0;
			JSONObject result = new JSONObject();
			System.out.println("map >>>" + map);
			
			try {
				JSONParser jsonParse = new JSONParser();
				String remark2 = map.get("remark2").toString();
				remark2 = remark2.replaceAll("&quot;", "\"").replaceAll("&gt;", ">").replaceAll("&lt;", "<").replaceAll("&amp;", "&").replaceAll("\r", "<br>").replaceAll("<p>", "\n").replaceAll("&apos", "'"); // xss 관련 처리
				System.out.println("remark2 >>>" + remark2);
				
        		resultIdx = eService.updateComment((String)map.get("code") , remark2);
	            
			}catch(Exception e) {
				e.printStackTrace();
				result.put("result", 0);
			}

			result.put("result", resultIdx);
			    
			return result;
		}


	
	



}

