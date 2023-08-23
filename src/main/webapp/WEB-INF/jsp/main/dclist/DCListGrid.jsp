<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/DCListGrid.css">
</head>

<body>
	<!-- 상단바(조회,입력,삭제,저장) -->
	<div class="up-bar">
		<div>
			<button class="btn-sec check" id="searchBtn">
				<span class="img4"></span> 조 회
			</button>
			<button class="btn-sec input" id="addRow">
				<span class="img8"></span> 입 력
			</button>
			<button class="btn-sec delete" id="deleteGrid1Row">
				<span class="img5"></span> 삭 제
			</button>
			<button class="btn-sec save">
				<span class="img6"></span> 저 장
			</button>
			<input type="checkbox" id="includeExpired" /> <label
				for="includeExpired">사용종료 포함</label>
			<button class="btn-sec close" style="float: right">
				<span class="img9"></span> 닫 기
			</button>
		</div>
	</div>

	<!-- 검색바(검색창,찾기,지우기) 및 그리드1 -->
	<div class="down-bar">
		<div class="container" style="width: 49%;">
			<div class="search-container-l">
				<div class="search-bar">
					<input type="text" id="searchInput" class="search-input"
						placeholder="검색어를 입력하세요">
					<div class="search-buttons">
						<button class="btn-sec check" id="findBtn">
							<span class="img"></span> 찾기
						</button>
						<button class="btn-sec check">
							<span class="img3"></span> 지우기
						</button>
					</div>
				</div>
			</div>

			<div class="grid1">
				<table id="list1"></table>
				<div id="pager1"></div>
			</div>
		</div>

		<!-- 탭 및 검색바(찾기,지우기,사용등록/종료) 그리드2 -->
		<div class="container" style="width: 49%;">
			<div class="tabs">
				<div class="tab">문서목록</div>
				<div class="tab">파일등록</div>
			</div>

			<div class="search-container-r">
				<div class="search-bar">
					<input type="text" id="searchInput2" class="search-input"
						placeholder="검색어를 입력하세요">
					<div class="search-buttons">
						<button class="btn-sec check" id="findBtn2">
							<span class="img"></span> 찾기
						</button>
						<button class="btn-sec check">
							<span class="img3"></span> 지우기
						</button>
						<button class="btn-sec input" id="updateGrid2Row">
							<span class="img2"></span> 사용등록
						</button>
						<button class="btn-sec input" id="deleteGrid2Row">
							<span class="img7"></span> 사용종료
						</button>
					</div>
				</div>
			</div>

			<div class="grid2">
				<table id="list2"></table>
				<div id="pager2"></div>
			</div>
		</div>
	</div>

	<!-- 푸터 -->
	<div class="footer">
		<p>
			a) 담당자, 과장, 실장 : 보고서에 싸인이 들어감<br> 여러명이 담당인경우(예:CVR보고서)는 공란, 로그인
			ID 자동입력됨
		</p>
		<p>b) 문서형식인 PDF, EXL, DOC, HTML 4가지중 하나로 입력</p>
	</div>

	<!--grid1 -->
	<script type="text/javascript">
		var selGrid1Row = 0;
		
		//html -> japGrid 로 변환 및 그리드 설정 정의
		$('#list1').jqGrid({ 
			url            : "/dcListGrid100.do", // 서버주소
			reordercolNames: true,
			postData: { 
				type     : "DCList",
				isSearch : "false", // 화면 처음 로딩 시 검색여부 boolean 값(=false)
			}, // 보낼 파라미터
			mtype    : 'POST', // 전송 타입
			datatype : "json", // 받는 데이터 형태
			colNames : ['일자', '사용자계정', '최종수정일', '문서타입', '문서코드', '문서명', '최종문서체크', '담당자', '실장', '과장','문서형식','비고','코멘트'], // 컬럼명
			colModel : [
							{
								name: 'sys_date', index: 'sys_date', width: '60', align: "center",hidden: true //일자
							},
							{
								name: 'user_id', index: 'user_id', width: '60', align: 'center', hidden: true //사용자계정
							},
							{
								name: 'upd_date', index: 'upd_date', width: '60', align: 'center', hidden: true //최종수정일
							},
							{
								name: 'code_type', index: 'code_type', width: '60', align: 'center', hidden: true //문서타입
							},
							{
								name: 'code', index: 'code', width: '60', align: "center",hidden: false //문서코드
							},
							{
								name: 'item1', index: 'item1', width: '60', align: "center" //문서명
							},
							{
								name: 'item2', index: 'item2', width: '50', align: "center", //최종문서 체크박스
								formatter: "checkbox", formatoptions: { disabled: true },
							},
							{
								name: 'item3', index: 'item3', width: '60', align: "center" //담당자
							},
							{
								name: 'item4', index: 'item4', width: '60', align: "center" //실장
							},
							{
								name: 'item5', index: 'item5', width: '60', align: "center" //과장
							},
							{
								name: 'remark1', index: 'remark1', width: '60', align: "center" //문서형식
							},
							{
								name: 'remark2', index: 'remark2', width: '60', align: "center" //비고란
							},
							{
								name: 'comments', index: 'comments', width: '60', align: "center", hidden: true //코멘트
							}
						],
			
			autowidth   : true, //그리드 너비 자동설정
			shrinkToFit : true, //컬럼 너비 그리드에 맞게 조절
			height      : "auto", // 테이블의 세로 크기, Grid의 높이
			loadtext    : "자료를 조회중이니 잠시만 기다려주십시오...", // 데이터 로드중일 때
			emptyrecords: "Nothing to display", // 데이터 없을 때
			rowNum      : -1, //한 번에 보여줄 행의 개수를 지정, -1=모든행을 보여줌
			rownumbers  : true, //각 행에 번호를 부여하는 표시옵션
			gridview    : true, // 그리드 랜더링시 성능을 향상시키는 옵션
			loadComplete: function (data) {
				//console.log("loadComplete >>>");
			}, // loadComplete END
			gridComplete : function (data) {
				console.log("gridComplete >>>");
				$("#list1").jqGrid('setSelection', "1", true); // 그리드 생성 및 촉화 후 호출되는 함수 정의 + 그리드1의 첫번째 행을 디폴트로 선택하는 이벤트
			},
			//그리드1 선택행으로 그리드2 화면 갱신 로직
			onSelectRow: function (rowid) {
				var params = {} //피라미터를 담을 객체생성
				params.isSearch2 = "true"; // 검색여부를 true로 세팅
				params.code = $('#list1').getRowData(rowid).code; // 선택행의 값을 params.code 에 설정 -> 그리드1의 선택값을 그리드2에서 사용하기위함
				selGrid1Row = $('#list1').getRowData(rowid).code; // 전역변수인 selGrid1Row에도 선택된 행의 코드값을 저장
				
				$("#list2").clearGridData();//그리드2의 데이터 초기화 -> 선택행에따라 새로운 데이터로 갱신
				
				//그리드2 파라미터 설정 , reloadGrid 이벤트를 트리거해서 그리드를 다시 로드
				$("#list2").setGridParam({
					datatype : "json",
					postData : params ,
					loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
					function(postData){} 
				}).trigger("reloadGrid");
			}
		});

		/**
		그리드1,2 조회('조회'버튼)
		*/
		$("#searchBtn").click(function(){
			getGridList();
		});
		
		
		/**
		그리드 행추가(grid1/'입력'버튼)
		*/	
		//입력버튼 클릭시 함수호출
		$("#addRow").click(function(){
			setAddRows();
		});
		
		//setAddRows 함수 정의
		function setAddRows(){
			var data = {code:'', item1:"", item2:"", item3:"", item4:'', item5:'', remark1:'', remark2:''};
			rowId    = $("#list1").getGridParam("reccount"); // 현재 그리드의 행 개수를 가져와 rowId 변수에 할당
			$("#list1").jqGrid("addRowData", rowId+1, data, 'last'); // list1에 새로운 행 데이터 data 추가 , rowId+1=새로운 행의 iD , last = 새 행을 마지막 위치에 추가
		}
		
		
		/**
		그리드 '삭제' 버튼 클릭
		*/
		$("#deleteGrid1Row").click(function(){
			var params   = {} // 파라미터를 담을 변수 선언
			var isAll    = this.id == 'deleteGrid1Row' ? 'true' : 'false'; // deleteGrid1Row를 누르면 isAll(상하위 전부삭제) , 그렇지않은 경우 false(하위만 삭제)
			var gridObj  = isAll == 'true' ? 'list1' : 'list2'; // isAll 인경우 list1 할당 , 아닌경우 list2 할당
			var selIdx   = $('#'+gridObj).getGridParam('selrow');  // 선택한 그리드에서 선택된 행의 인덱스 가져오기
			
			if(selIdx == null){
				alert("그리드에서 삭제할 행을 선택해주세요");
			}else{
				var code = $('#'+gridObj).getRowData(selIdx).code; // 선택한 그리드의 선택된 행에서 code 값 가져옴
				var code_no  = $('#'+gridObj).getRowData(selIdx).code_no; // 선택한 그리드의 선택된 행에서 code_no 값 가져옴
		
				params.isAll    = isAll; // 상위테이블 여부 파라미터 세팅[true일 경우 상위/하위 테이블의 데이터를 가팅 삭제 / false일 경우 하위 테입르의 데이터만 삭제]
				params.code = code;  // code 파라미터 세팅
				params.code_no  = code_no; // code_no 파라미터 세팅
		
				setDeleteData(params); // ajax 삭제 함수 호출
			}
		});

		/**
		    선택한 그리드 데이터 삭제
		*/
		function setDeleteData(params){
			$.ajax({
	            type: "post",
	            url : "/dcListDelete.do",
	            data: {
	            	  isAll : params.isAll
	            	, code : params.code
	            	, code_no : params.code_no
	            },
	            dataType : "json",
	            error: function(data){
	                console.log('error');
	                alert("error");
	            },
	            success: function(data){
	            	//console.log("data >>>" + JSON.stringify(data));
	                if(data.result == '1'){
	                    alert('데이터를 삭제 하였습니다.');
	                    if(params.isAll = 'true'){
	                    	getGridList(); // 그리드1 조회
	                    	getGridList2(); // 그리드2 조회
	                    }else{
	                    	getGridList2();  // 그리드2 조회
	                    }
	                } else {
	                    alert('삭제중 오류가 발생하였습니다.');
	                }
	            }
	        })
		}
		
		
		// '사용종료 포함' 체크박스 변경 이벤트 리스너 등록
		$("#includeExpired").change(function() {
		    var includeExpired = $(this).prop("checked"); // 체크박스의 체크 여부 가져오기

		    // 그리드2 데이터 필터링 및 다시 로드
		    filterAndReloadGrid2(includeExpired);
		});
			
		
		/**
		그리드1 검색('찾기'버튼)
		*/
		$("#findBtn").click(function(){
			getGridList();
		});
		
		/**
			그리드1의 데이터 조회
		*/
		function getGridList(isFirst){ // isFirst : 함수호출시 전달될값, 첫번째 검색인지 여부를 나타냄
			isFirst = (typeof isFirst == "undefined") ? 'fasle' : isFirst; // 첫번째 검색 여부 변수세팅(undefined는 false로 세팅해서 전체검색 하도록함)
			var params = {}

			params.isSearch    = "true"; // 검색여부를 true로 세팅
			params.isFirst     = isFirst; // 첫검색 여부
			params.searchInput = $('#searchInput').val(); // 검색어 
			console.log(JSON.stringify(params));

			$("#list1").clearGridData(); //그리드1 데이터 초기화
			
			//그리드1의 파라미터 설정 & 그리드1 재로드
			$("#list1").setGridParam({ 
				datatype : "json",
				postData : params ,
				loadComplete: 
				function(postData){
					//getGridList2(); // 그리드 2조회	
				} // 그리드 재조회 
			}).trigger("reloadGrid");
		}
		
		

	$('#list2').jqGrid({
		url            : "/dcListGrid200.do", // 서버주소(데이터 요청)
		reordercolNames: true, //컬럼명을 드래그하여 재정렬할 수 있는 기능을 활성화
		postData: { 
			type     : "DCList2", //그리드 데이터를 요청할때 함께 보낼 파라미터 설정
			isSearch : "false", // 화면 처음 로딩 시 검색여부 boolean 값(=false)
		}, // 보낼 파라미터
		mtype    : 'POST', // 전송 타입
		datatype : "json", // 받는 데이터 형태
		colNames : 
		['일자', '사용자계정', '최종수정일', '문서타입', '문서코드','문서번호','파일명','등록일','등록자','종료일','파일서버경로','담당','실장','과장','담당확인일자','실장확인일자','과장확인일자','코멘트'], // 컬럼명
		colModel : [
						{
							name: 'sys_date', index: 'sys_date', width: '60', align: "center",hidden: true //일자
						},
						{
							name: 'user_id', index: 'user_id', width: '60', align: 'center', hidden: true //사용자계정
						},
						{
							name: 'upd_date', index: 'upd_date', width: '60', align: 'center', hidden: true //최종수정일
						},
						{
							name: 'code_type', index: 'code_type', width: '60', align: 'center', hidden: true //문서타입
						},
						{
							name: 'code', index: 'code', width: '60', align: "center",hidden: true //문서코드
						},
						{
							name: 'code_no', index: 'code_no', width: '120', align: "center",hidden: false //문서번호
						},
						{
							name: 'file_name', index: 'file_name', width: '130', align: "center" //파일명
						},					
						{
							name: 'file_date', index: 'file_date', width: '110', align: "center", //등록일
							formatter: 'date', // 날짜 포맷터 사용
					        formatoptions: {
					            srcformat: 'Y-m-d H:i:s', // 입력된 날짜 형식
					            newformat: 'Y-m-d H:i:s'  // 출력할 날짜 형식
					        }
						},
						{
							name: 'file_user', index: 'file_user', width: '60', align: "center" //등록자
						},
						{
							name: 'file_enddt', index: 'file_enddt', width: '110', align: "center", //종료일자
							formatter: 'date', // 날짜 포맷터 사용
					        formatoptions: {
					            srcformat: 'Y-m-d H:i:s', // 입력된 날짜 형식
					            newformat: 'Y-m-d H:i:s'  // 출력할 날짜 형식
					        }
						},
						{
							name: 'file_path', index: 'file_path', width: '60', align: "center", hidden: true //파일서버경로
						},
						{
							name: 'id1', index: 'id1', width: '60', align: "center" //담당
						},
						{
							name: 'id2', index: 'id2', width: '60', align: "center" //실장
						},
						{
							name: 'id3', index: 'id3', width: '60', align: "center" //과장
						},
						{
							name: 'id1_date', index: 'id1_date', width: '60', align: "center", hidden: true, //담당확인일자
							formatter: 'date',
					        formatoptions: {
					            srcformat: 'Y-m-d',
					            newformat: 'Y-m-d'
					        }
						},
						{
							name: 'id2_date', index: 'id2_date', width: '60', align: "center", hidden: true, //실장확인일자
							formatter: 'date',
					        formatoptions: {
					            srcformat: 'Y-m-d',
					            newformat: 'Y-m-d'
					        }
						},
						{
							name: 'id3_date', index: 'id3_date', width: '60', align: "center", hidden: true, //과장확인일자
							formatter: 'date', // 날짜 포맷터 사용
					        formatoptions: {
					            srcformat: 'Y-m-d', // 입력된 날짜 형식
					            newformat: 'Y-m-d'  // 출력할 날짜 형식
					        }
						},
						{
							name: 'comments', index: 'comments', width: '60', align: "center", hidden: true //코멘트
						}
					],
		
		autowidth   : true, //컬럼 너비 자동 조정
		shrinkToFit : true, //그리드 전체가 너비보다 작을 경우 컬럼을 축소
		height      : "auto", // 테이블의 세로 크기, Grid의 높이
		loadtext    : "자료를 조회중이니 잠시만 기다려주십시오...", // 데이터 로드중일 때
		emptyrecords: "Nothing to display", // 데이터 없을 때
		rowNum      : -1,
		rownumbers  : true, //각 행 앞에 순번을 표시
		gridview    : true, // 그리드 뷰 활성화
		loadComplete: function (data) {
		
		}, // 데이터 로딩이 완료된 후 실행할 함수설정
		onSelectRow: function (rowid) {
			//행이 선택될 떄 실행할 함수를 설정
		}
		});
	
	/**
	그리드 찾기 버튼 클릭(grid2)
	*/
	$("#findBtn2").click(function(){
		getGridList2();
	});
	
	function getGridList2(){
		var params = {}
		params.isSearch2 = "true"; // 검색여부를 true로 세팅
		params.searchInput2 = $('#searchInput2').val(); // 검색어를 파라미터 searchInput2에 할당, 검색어=searchInput2 ID 를 가진 입력란의 값
		params.code = selGrid1Row;

		console.log("getGridList2 >>>" + JSON.stringify(params));

		$("#list2").clearGridData(); //그리드2 데이터 초기화
		$("#list2").setGridParam({
			datatype : "json",
			postData : params ,
			loadComplete: 
			function(postData){} 
		}).trigger("reloadGrid"); //그리드1 파라미터 업데이트 & 그리드 재조회
	}
	
	
	/**
	 * 그리드 사용등록 버튼 클릭(grid2 / 클릭시 등록일자 오늘날짜로 변경 & 종료일자가 있다면 종료일자는 비우기)
	 */
	$("#updateGrid2Row").click(function() {
	    var selIdx = $('#list2').getGridParam('selrow'); // 선택한 행의 인덱스 가져오기
	    
	    if (selIdx == null) {
	        alert("사용등록할 파일을 선택해주세요");
	    } else {
	        var currentDate = new Date().toISOString().split('T')[0]; // 현재 날짜를 YYYY-MM-DD 형식으로 가져옴
	        var gridObj = $('#list2');
	        var rowData = gridObj.getRowData(selIdx); // 선택한 행의 데이터 가져오기

	        $.ajax({
	            url: "/updateGrid2Row.do", // 사용등록 엔드포인트로 변경
	            method: "POST",
	            data: {
	                code: rowData.code,
	                codeNo: rowData.code_no
	            },
	            dataType : "json", // 서버에서 리턴 받는 데이터 타입
	            success: function(response) {
	            	console.log("response >>>" + JSON.stringify(response));
	            	//alert("response >>>" + response.result);
	                if (response.result === "success") {
	                    rowData.file_date = currentDate;
	                    if (rowData.file_enddt) {
	                        // 종료일자가 있다면 종료일자 데이터를 비움
	                        rowData.file_enddt = ''; 
	                    }
	                    gridObj.setRowData(selIdx, rowData);
	                    alert("사용등록이 완료되었습니다");
	                    getGridList2();
	                } else {
	                    alert("사용등록 실패");
	                }
	            },
	            error: function() {
	                alert("사용등록 실패");
	            }
	        });
	    }
	});
	
	
	/**
	 * 그리드 사용종료 버튼 클릭(grid2 / 클릭시 종료일자 현재날짜로 변경)
	 */
	$("#deleteGrid2Row").click(function() {
	    var selIdx = $('#list2').getGridParam('selrow'); // 선택한 행의 인덱스 가져오기
	    
	    if (selIdx == null) {
	        alert("사용종료할 파일을 선택해주세요");
	    } else {
	        var currentDate = new Date().toISOString().split('T')[0]; // 현재 날짜를 YYYY-MM-DD 형식으로 가져옴
	        var gridObj = $('#list2');
	        var rowData = gridObj.getRowData(selIdx); // 선택한 행의 데이터 가져오기

	        $.ajax({
	            url: "/deleteGrid2Row.do", // 사용종료 엔드포인트로 변경
	            method: "POST",
	            data: {
	                code: rowData.code,
	                codeNo: rowData.code_no
	            },
	            dataType : "json", // 서버에서 리턴 받는 데이터 타입
	            success: function(response) {
	            	console.log("response >>>" + JSON.stringify(response));
	            	//alert("response >>>" + response.result);
	                if (response.result === "success") {
	                    rowData.file_date = currentDate;	                    
	                    gridObj.setRowData(selIdx, rowData);
	                    alert("사용종료가 완료되었습니다");
	                    getGridList2();
	                } else {
	                    alert("사용종료 실패");
	                }
	            },
	            error: function() {
	                alert("사용종료 실패");
	            }
	        });
	    }
	});


    // 탭 버튼 클릭 시 활성화 클래스 추가 및 제거
    document.addEventListener("DOMContentLoaded", function() {
        const tabs = document.querySelectorAll(".tab");

        tabs.forEach(tab => {
            tab.addEventListener("click", function() {
                tabs.forEach(t => t.classList.remove("active"));
                this.classList.add("active");
            });
        });
    });
       
    
    window.onload = function(){
    	getGridList("true"); // 그리드1 데이터 조회
    }
</script>


</body>
</html>