package egovframework.c.service;

import java.util.List;

import egovframework.c.model.UserCDTO;
import egovframework.c.model.lisc001DTO;
import egovframework.c.model.lisc002DTO;
import egovframework.c.model.lisc003DTO;

public interface CService {  // 매퍼에서 가져온 다음에 가공 주로 여기에 작성
	int joinUserC(UserCDTO dto);
	// UserCDTO selectUser ,,,로 사용
	int userID(UserCDTO dto); // 
	UserCDTO loginID(UserCDTO dto);
	List<lisc001DTO> lisc001list();
	List<lisc002DTO> lisc002list();
	List<lisc002DTO> codetype(String type);
	List<lisc003DTO> code(String type);
	List<lisc003DTO> codetype2(String type2);
	List<lisc001DTO> searchval(String searchval);
	int update001Data(lisc001DTO dto);
	int update002Data(lisc002DTO dto);
	int update003Data(lisc003DTO dto);
	int add001Data(lisc001DTO dto);
	int add002Data(lisc002DTO dto);
	int add003Data(lisc003DTO dto);
	int delete001Data(lisc001DTO dto);
	int delete002Data(lisc002DTO dto);
	int delete003Data(lisc003DTO dto);
}
