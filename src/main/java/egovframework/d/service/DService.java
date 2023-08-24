package egovframework.d.service;

import java.util.List;
import java.util.Map;

import egovframework.d.model.UserDDTO;
import egovframework.d.model.lisc100DTO;
import egovframework.d.model.lisq100DTO;
import egovframework.d.model.lisq110DTO;
import egovframework.d.model.testPartListDTO;

public interface DService {
	int joinUser(UserDDTO dto);
	int checkUser(String id);
	UserDDTO loginUser(UserDDTO dto);
	List<lisq100DTO> lisq100(Map<String,String> map);
	List<lisq110DTO> lisq110(String qcCode);
	List<lisc100DTO> lisc100(String jundalPart);
	List<testPartListDTO> testPartList();
	List<String> qcNameFindAll();
	List<String> qcNameListByTestPart(String jundalPart);
	int addData(lisq110DTO dto);
	int updateData(lisq110DTO dto);
	String getJundalPart(String jundalPart);
}
