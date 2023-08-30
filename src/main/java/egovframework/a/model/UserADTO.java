package egovframework.a.model;

// userADTO 클래스를 정의한다. 이 클래스는 사용자 정보를 담는 DTO 역할을 한다.
public class UserADTO {
	
	private String id;	// 사용자ID
	private String password;  // 사용자 패스워드
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
