package egovframework.a.service;

import java.util.List;

//userADTO 클래스를 가져온다. 이 클래스는 사용자 데이터의 정보를 담는 DTO(Data Transfer Object)이다.
import egovframework.a.model.UserADTO;
import egovframework.a.model.Lisc100DTO;
import egovframework.a.model.Lisc500DTO;
import egovframework.a.model.Lisc501DTO;

// AService 인터페이스를 정의한다. 이 인터페이스는 서비스 계층의 역할을 담당한다.
public interface AService {
	// joinUserA 메서드를 선언한다. 이 메서드는 사용자 정보를 입력받아 데이터베이스에 저장하는 역할을 수행한다.
	int joinUserA(UserADTO dto);
	
	// 사용자의 아이디 중복 여부를 확인하기 위해 사용한다.
	int findOne(String id);
	
	// 또 다른 AService 인터페이스에서 선언된 메서드이다. 이 메서드는 특정 아이디에 해당하는 사용자 정보를 조회하기 위해 사용된다.
	UserADTO loginA(UserADTO dto);
	
	List<Lisc500DTO> lisc500();
	List<Lisc100DTO> lisc100();
	List<Lisc501DTO> lisc501(String data);
	int lisc501SaveData(String testCode, String invCode);
	int lisc501DeleteData(String testCode, String invCode);
	int lisc500addData(Lisc500DTO dto);
	int lisc500updateData(Lisc500DTO dto);
	int lisc500delData(Lisc500DTO dto);
}
