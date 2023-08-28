package egovframework.a.model;

public class Lisc501updateDTO {
	private String sysDate;
	private String userId;
	private String updDate;
	private String invCode;    // 제품코드
	private String testCode;   // 검사코드
	
	
	public String getSysDate() {
		return sysDate;
	}
	public void setSysDate(String sysDate) {
		this.sysDate = sysDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUpdDate() {
		return updDate;
	}
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	public String getInvCode() {
		return invCode;
	}
	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}
	public String getTestCode() {
		return testCode;
	}
	public void setTestCode(String testCode) {
		this.testCode = testCode;
	}
}
