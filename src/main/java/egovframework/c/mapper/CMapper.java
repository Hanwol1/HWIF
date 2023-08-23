package egovframework.c.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.c.model.UserCDTO;
import egovframework.c.model.lisc001DTO;
import egovframework.c.model.lisc002DTO;
import egovframework.c.model.lisc003DTO;

@Mapper("CMapper")
public interface CMapper {
	int joinUserC(UserCDTO dto);  //db랑만 통신. 조회
	int userID(UserCDTO dto); // 회원가입 id 조회 후 개수 반환
	UserCDTO loginID(UserCDTO dto); // 로그인 id 조회 후 개수 반환
	List<lisc001DTO> lisc001list();
	List<lisc002DTO> lisc002list();
	List<lisc002DTO> codetype(String type);
	List<lisc003DTO> code(String type);
	List<lisc001DTO> searchval(String searchval);
}
