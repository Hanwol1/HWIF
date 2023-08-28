<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 첫번째줄은 JSP 페이지의 지시어이다. 이것은 해당 JSP 페이지의 속성을 설정한다. language 속성은 페이지에서 사용할 Java 언어를 정의하며, contentType은 출력되는 콘텐츠의 유형과 문자 인코딩을 설정한다. -->
<!-- 두번째줄은 JSP 페이지에서 JSTL(Core JSP Standard Tag Library)을 사용하기 위한 태그 라이브러리를 선언하는 부분이다. JSTL은 JSP 페이지에서 반복문, 조건문 등과 같은 일반적인 로직을 처리하기 위한 태그들을 제공한다. -->
<!-- prefix는 사용할 태그의 접두사를 정의하고, uri 는 해당 태그 라이브러리의 위치를 지정한다. -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="/css/reagent.css" />
<!-- 아래 스크립트는 SheetJS 라이브러리를 로드합니다 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.3/xlsx.full.min.js"></script>
</head>
<body>

	<div class="divAll">

		<div class="divUp">
			<div class="divUpLeft">
				<label class="topButton" for="part">파트</label> 
				<select id="part" name="reagentPart">
					<option value="">전체</option>
					<option value="220">창고</option>
					<option value="230">테스트</option>
					<option value="240">일반혈액</option>
					<option value="250">생화학</option>
					<option value="210">임상화학부(주간)</option>
					<option value="260">임상화학부(야간)</option>
				</select> 
				
				<label class="topButton" for="acc">거래처</label> 
				<select id="acc" name="account">
					<option value="">전체</option>
					<option value="account1">20971</option>
				</select> 
				
				<label class="topButton" for="manu">제조사</label> 
				<select id="manu" name="manufacturer">
					<option value="">전체</option>
				</select>
				
			</div>
			<div class="divUpRight">
				<button class="btn-sec check" onclick="chooseSearch()">
					<img src="/images/icons/searchsearch.png" class="img"> 조 회
				</button>
				<button class="btn-sec input" onclick="addListData()">
					<img src="/images/icons/printer.png" class="img">입 력
				</button>
				<button class="btn-sec save" onclick="list1DataSave()">
					<img src="/images/icons/save.png" class="img"> 저 장
				</button>
				<button class="btn-sec delete" onclick="deleteListData()">
					<img src="/images/icons/delete.png" class="img2">삭 제
				</button>
				<button class="btn-sec excel" onclick="saveExcel()">
					<img src="/images/icons/excel.png" class="img">EXCEL
				</button>
			</div>
		</div>

		<div class="divDown">
			<div class="divDownLeft">
				<div class="divDownLeftUpButton">
					<input type="text" name="search_name" class="optionSearch"
						placeholder="Enter text to search"></input>
					<button class="btn-pir" onclick="wantSearch1()">검 색</button>
					<button class="btn-pir" onclick="clearInput1()">클리어</button>
				</div>
				<div class="divDownLeftList" style="">
					<table id="list1"></table>
				</div>
			</div>

			<div class="divDownRight">
				<div class="divDownRightUp">
					<div class="divDownRightUpList">
						<div class="divDownRightUpListUp">시약별 검사코드 관리</div>
						<div class="divDownRightUpListDown">
							<table id="list2"></table>
						</div>
					</div>
					<div class="divDownRightUpButton">
						<button class="btn-thr" onclick="saveListData2()">
							<img src="/images/icons/up.png" class="img1">등 록
						</button>
						<button class="btn-thr" onclick="deleteListData2()">
							<img src="/images/icons/down.png" class="img1">제 외
						</button>
					</div>
				</div>

				<div class="divDownRightDown">
					<div class="divDownRightDownButton">
						<input type="text" name="search_name1" class="optionSearchRight"
							placeholder="Enter text to search"></input>
						<button class="btn-pir" onclick="wantSearch2()">검 색</button>
						<button class="btn-pir" onclick="clearInput3()">클리어</button>
					</div>
					<div class="divDownRightDownList">
						<table id="list3"></table>
					</div>
				</div>
			</div>
		</div> 

	</div>
	<script src="/js/reagentA/reagentAlist.js"></script>
	<script src="/js/reagentA/reagentAbutton.js"></script>
</body>
</html>


