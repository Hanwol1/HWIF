package egovframework.e.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.e.model.UserEDTO;
import egovframework.e.service.EService;
import egovframework.util.Sha256;

@Controller
public class EController {
	@Resource(name="EService")
	private EService eService;
	
	@RequestMapping(value = "/loginE.do")
	public String startPage(Model model) throws Exception {
		return ".login/loginE";
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
		
		json.put("result",  "success");
		int join = eService.joinUser(dto);
		
		
		
		
		
		
		return json;
	}
}