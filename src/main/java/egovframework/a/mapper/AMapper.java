package egovframework.a.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
// org.egovframe.rte.psl.dataaccess.mapper 패키지에서 Mapper 어노테이션을 가져온다.
// 이 어노테이션은 스프링의 @Repository 어노테이션과 유사한 역할을 한다. 즉, 매퍼를 스프링 빈으로 등록하기 위해 사용한다.
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

// userADTO 클래스를 가져온다. 이 클래스는 사용자 데이터의 정보를 담는 DTO이다.
import egovframework.a.model.UserADTO;
import egovframework.a.model.Lisc100DTO;
import egovframework.a.model.Lisc500DTO;
import egovframework.a.model.Lisc501DTO;

// AMapper 라는 이름으로 스프링 빈으로 등록하기 위한 어노테이션이다.
@Mapper("AMapper")
// AMapper 인터페이스를 정의한다. 이 인터페이스는 데이터베이스와의 상호 작용을 담당하는 메서드를 포함한다.
public interface AMapper {
	// joinUserA 메서드를 선언한다. 이 메서드는 사용자 정보를 데이터베이스에 저장하는 역할을 한다. 반환값은 저장 성공 여부를 나타내는 정수이다.
	int joinUserA(UserADTO dto);
	int findOne(String id);
	
	// userADTO 가 사용자의 정보를 담는것인데 findOne으로 찾아오겠다. 데이터의 형태는 String, id를 찾겠다 는 뜻!
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
