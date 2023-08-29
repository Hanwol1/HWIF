package egovframework.a.service.impl;

import java.util.List;

// javax.annotation 패키지에서 'Resource'어노테이션을 가져온다. 이 어노테이션은  의존성 주입(Dependency Injection)을 위해 사용된다.
import javax.annotation.Resource;

// org.springframework.stereotype 패키지에서 Service 어노테이션을 가져온다. 이 어노테이션은 이 클래스가 스프링의 서비스 구현 클래스임을 나타내는 역할을 한다.
import org.springframework.stereotype.Service;

// AMapper 클래스를 가져온다. 이 클래스는 데이터베이스와의 상호작용을 담당하는 매퍼(Mapper)이다.
import egovframework.a.mapper.AMapper;
// userADTO 클래스를 가져온다. 이 클래스는 사용자 데이터의 정보를 담는 DTO(Data Transfer Object)이다.
import egovframework.a.model.UserADTO;
import egovframework.a.model.lisc100DTO;
import egovframework.a.model.lisc500DTO;
import egovframework.a.model.lisc501DTO;
// AService 인터페이스를 가져온다. 이 인터페이스는 서비스 계층의 역할을 정의한 것이다.
import egovframework.a.service.AService;

/*
 * 스프링의 서비스 구현 클래스로, 서비스 인터페이스에 정의된 메서드를 실제로 구현하여 비즈니스 로직을 처리하고 데이터베이스와의 상호작용을 담당한다.
 * */

// AService 라는 이름으로 스프링 빈으로 등록하기 위한 이노테이션이다.
@Service("AService")
public class AServiceImpl implements AService{
		
		// AMapper 라는 이름으로 등록된 빈(Bean)을 주입받기 위한 어노테이션이다. AMapper는 데이터베이스와의 상호작용을 담당하는 매퍼 클래스이다.
		@Resource(name="AMapper")
		// AMapper 클래스의 인스턴스를 멤버 변수로 선언한다. 이를 통해 매퍼의 메서드를 호춣할 수 있다.
		private AMapper aMapper;

		// AService 인터페이스의 joinUser 메서드를 구현한다. 이 메서드는 매퍼의 joinUser 메서드를 호출하여 사용자 데이터를 데이터베이스에 저장한다.
		@Override
		public int joinUserA(UserADTO dto) {
			// TODO Auto-generated method stub
			// 매퍼의 joinUser 메서드를 호출하여 사용자 데이터를 데이터베이스에 저장하고, 저장 성공 여부를 정수 형태로 반환한다.
			return aMapper.joinUserA(dto);
		}

		@Override
		public int findOne(String id) {
			
			// aMapper 인터페이스의 duplicate 메서드를 호출하여 데이터베이스에서 중복 여부를 확인한다.
			// 이때, 반환되는 'result' 값은 중복 여부에 따라 0 또는 1이다.
			int result = aMapper.findOne(id);
			System.out.println("=====result=====" + result);
			// result 값이 1인 경우, 중복된 아이디가 있다는 의미. 따라서 true를 반환하여 중복 아이디임을 알려준다.
			if(result == 1) return 1;
			// result 값이 0인 경우, 중복된 아이디가 없다는 의미. 따라서 false를 반환하여 중복 아이디가 아님을 알려준다.
			return 0;
		}

		// 이 메서드는 입력으로 받은 아이디에 해당하는 사용자 정보를 데이터베이스에서 조회하는 역할을 한다.
		@Override
		public UserADTO loginA(UserADTO dto) {
			
			// aMapper 인스턴스를 통해 aMapper인터페이스의 findOne 메서드를 호출하여
			// 데이터베이스에서 해당 아이디에 해당하는 사용자 정보를 조회한다. 이 정보를 userADTO 형태로 반환한다.
			return aMapper.loginA(dto);
		}
		
		@Override
		public List<lisc500DTO> lisc500() {
			return aMapper.lisc500();
		}
		
		@Override
		public List<lisc100DTO> lisc100() {
			return aMapper.lisc100();
		}
		
		@Override
		public List<lisc501DTO> lisc501(String data) {
			return aMapper.lisc501(data);
		}
		
		@Override
	    public int lisc501SaveData(String testCode, String invCode) {
	        // 예시: Mapper를 통해 데이터베이스에 저장
			return aMapper.lisc501SaveData(testCode, invCode);
	    }
		
		@Override
	    public int lisc501DeleteData(String testCode, String invCode) {
	        // 예시: Mapper를 통해 데이터베이스에 저장
			return aMapper.lisc501DeleteData(testCode, invCode);
	    }
		
		@Override
	    public int lisc500addData(lisc500DTO dto) {
	        // 신규 추가 로직을 수행하고 데이터베이스에 저장
			return aMapper.lisc500addData(dto); 
	    }
		
		@Override
	    public int lisc500updateData(lisc500DTO dto) {	
	        // 수정 로직을 수행하고 데이터베이스를 업데이트
			return aMapper.lisc500updateData(dto);       
	    }
		
		@Override
		public int lisc500delData(lisc500DTO dto) {
			return aMapper.lisc500delData(dto);
		}
	}
