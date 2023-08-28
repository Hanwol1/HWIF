package egovframework.d.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.d.model.UserDDTO;
import egovframework.d.model.lisc100DTO;
import egovframework.d.model.lisq100DTO;
import egovframework.d.model.lisq110DTO;
import egovframework.d.model.testPartListDTO;

@Mapper("DMapper")
public interface DMapper {
	int joinUser(UserDDTO dto);
	int checkUser(String id);
	UserDDTO loginUser(UserDDTO dto);
	List<lisq100DTO> lisq100(Map<String,String> map);
	List<lisq110DTO> lisq110(Map<String,String> map);
	List<lisc100DTO> lisc100(String jundalPart);
	List<testPartListDTO> testPartList();
	List<String> qcNameFindAll();
	List<String> qcNameListByTestPart(String jundalPart);
	int addData(lisq110DTO dto);
	int updateData(lisq110DTO dto);
	int delData(lisq100DTO dto);
	String getJundalPart(String jundalPart);
}
