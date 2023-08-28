package egovframework.a.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
// org.egovframe.rte.psl.dataaccess.mapper 패키지에서 Mapper 어노테이션을 가져온다.
// 이 어노테이션은 스프링의 @Repository 어노테이션과 유사한 역할을 한다. 즉, 매퍼를 스프링 빈으로 등록하기 위해 사용한다.
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

// userADTO 클래스를 가져온다. 이 클래스는 사용자 데이터의 정보를 담는 DTO이다.
import egovframework.a.model.UserADTO;
import egovframework.a.model.lisc100DTO;
import egovframework.a.model.lisc500DTO;
import egovframework.a.model.lisc501DTO;

/*
 * 데이터베이스와의 상호작용을 처리하는 매퍼 인터페이스로, 
 * 실제로는 이 인터페이스를 구현한 클래스가 데이터베이스 연동을 위한 SQL 쿼리와 연결하여 데이터를 처리하게 된다.
 */

// AMapper 라는 이름으로 스프링 빈으로 등록하기 위한 어노테이션이다.
@Mapper("AMapper")
// AMapper 인터페이스를 정의한다. 이 인터페이스는 데이터베이스와의 상호 작용을 담당하는 메서드를 포함한다.
public interface AMapper {
	// joinUserA 메서드를 선언한다. 이 메서드는 사용자 정보를 데이터베이스에 저장하는 역할을 한다. 반환값은 저장 성공 여부를 나타내는 정수이다.
	int joinUserA(UserADTO dto);
	
	// userADTO dto 이 매개변수는 사용자 정보(userADTO)를 나타낸다.
	// 이 객체에서 아이디 정보를 가져와서 중복 여부를 확인할 때 사용된다.
	// int 이 메서드는 정수(int) 값을 반환한다.
	// 반환되는 값은 중복된 아이디가 존재하면 1, 중복된 아이디가 존재하지 않으면 0이다.
	int findOne(String id);
		
	// String id 이 매개변수는 조회하려는 사용자의 아이디를 나타낸다.
	// userADTO 이 메서드는 userADTO 객체를 반환한다. 이 객체는 데이터베이스에서 조회한 사용자 정보의 데이터를 담고 있는 DTO이다.
	// 만약 해당 아이디에 대한 사용자 정보가 존재하지 않으면, 'null'이 반환된다.
	
	// userADTO 가 사용자의 정보를 담는것인데 findOne으로 찾아오겠다. 데이터의 형태는 String, id를 찾겠다 는 뜻!
	UserADTO loginA(UserADTO dto);
	
	List<lisc500DTO> lisc500();
	List<lisc100DTO> lisc100();
	List<lisc501DTO> lisc501(String data);
	Object lisc501SaveData(@Param("testCode") String testCode, @Param("invCode") String invCode);
	Object lisc501DeleteData(@Param("testCode") String testCode, @Param("invCode") String invCode);
}
