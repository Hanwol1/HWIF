package egovframework.b.model;

public class QcResultDateDTO {
	private String fromDate;
	private String toDate;

	public QcResultDateDTO() {
	}

	public QcResultDateDTO(String fromDate, String toDate) {
		this.fromDate = fromDate;
		this.toDate = toDate;
	}
	
	// DevI , 브랜치 ... X, 인트라넷 , 30명 () 25개월   LIS(C# 프로그램), 20~25명...
	// 워크샵 재밌음, 부장님 차장님 검토, 시뮬레이션	, C# 35% 병원 장비, 자바, 자바스크립트 65%, 파이썬 가끔
	// 병원 정보는 70~80페이지 분량의 한글파일로 제공, 1개월~ 파견, 10~15분 면접
	// 준규님 피드백 내용 : &{}는 SQL INJECTION 이슈가 있음
	// 자바스크립트 초기화 전역 변수는 init()에 있는 게 좋음
	// evnet처리 함수는 따로 하고 ajax 호출은 따로 함수로 빼는게 좋음
	// Mapper쪽은 코드 정렬을 , , , , 한줄 씩 하는게 좋고 위아래 맞춰주는게 좋음
	// 반환타입 JSONObject가 아닌 DTO로 할 수 있음 @ResponseBody가 자동으로 json타입으로 변환해줌
	

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

}
