package egovframework.a.service;

import java.util.List;

//userADTO 클래스를 가져온다. 이 클래스는 사용자 데이터의 정보를 담는 DTO(Data Transfer Object)이다.
import egovframework.a.model.UserADTO;
import egovframework.a.model.lisc100DTO;
import egovframework.a.model.lisc500DTO;
import egovframework.a.model.lisc501DTO;


/*
 * 스프링의 서비스 계층을 구현하기 위한 인터페이스로, 비즈니스 로직을 정의하고 컨트롤러와 데이터베이스 계층 간의 중재 역할을 수행하는 역할을 한다. 
 * 이 인터페이스를 구현하는 클래스에서는 실제 비즈니스 로직을 구현하여 사용자 데이터를 데이터베이스에 저장하게 될 것이다.
 */

// AService 인터페이스를 정의한다. 이 인터페이스는 서비스 계층의 역할을 담당한다.
public interface AService {
	// joinUserA 메서드를 선언한다. 이 메서드는 사용자 정보를 입력받아 데이터베이스에 저장하는 역할을 수행한다.
	// 반환값은 저장 성공 여부를 나타내는 정수(0,1)이다.
	int joinUserA(UserADTO dto);
	
	// 사용자의 아이디 중복 여부를 확인하기 위해 사용한다.
	// userADTO dto 이 매개변수는 userADTO 객체를 받는다. 이 객체는 사용자 정보의 데이터를 담고 있는 DTO 이다.
	// boolean 이 메서드는 boolean 값을 반환한다. 중복된 아이디가 있을 경우 'true'를 중복된 아이디가 없을 경우 'false'를 반환한다.
	int findOne(String id);
	
	// 또 다른 AService 인터페이스에서 선언된 메서드이다. 이 메서드는 특정 아이디에 해당하는 사용자 정보를 조회하기 위해 사용된다.
	// String id 이 매개변수는 조회하려는 사용자의 아이디를 나타낸다.
	// userADTO 이 메서드는 'userADTO' 객체를 반환한다. 이 객체는 조회된 사용자 정보의 데이터를 담고 있는 DTO이다.
	// 만약 해당 아이디에 대한 사용자 정보가 존재하지 않으면, 'null'이 반환된다.
	UserADTO loginA(UserADTO dto);
	
	/*
	 * 이 두 가지 메서드는 서비스 계층에서 중요한 역할을 한다. 
	 * duplicate 메서드는 회원가입 시 입력한 아이디가 이미 사용 중인지 중복 여부를 확인하는 역할을 하며, 
	 * findOne 메서드는 로그인 시 입력한 아이디에 해당하는 사용자 정보를 조회하는 역할을 한다.
	 */
	List<lisc500DTO> lisc500();
	List<lisc100DTO> lisc100();
	List<lisc501DTO> lisc501(String data);
	int lisc501SaveData(String testCode, String invCode);
	int lisc501DeleteData(String testCode, String invCode);
	int lisc500addData(lisc500DTO dto);
	int lisc500updateData(lisc500DTO dto);
	int lisc500delData(lisc500DTO dto);
}
