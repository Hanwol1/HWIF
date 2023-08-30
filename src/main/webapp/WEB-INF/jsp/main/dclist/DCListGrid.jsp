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
						<button class="btn-sec check" id="deleteBtn">
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
						<button class="btn-sec check" id="deleteBtn2">
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
	<div class="footer" style="text-align: left; padding-down: 20px;">
		<p>
			a) 담당자, 과장, 실장 : 보고서에 싸인이 들어감<br> 여러명이 담당인경우(예:CVR보고서)는 공란, 로그인
			ID 자동입력됨
		</p>
		<p>b) 문서형식인 PDF, EXL, DOC, HTML 4가지중 하나로 입력</p>
	</div>

	<div id="popLayer" style="display:none;" class="custom-comment-form">
		<div>
			<textarea rows="4" cols="50" id="remart2Area"></textarea>
		</div>
		<div style="text-align:right;margin-top:5px;">				
<!-- 			<input style="margin-right: 5px;" type="button" id="Save" value="Save" onclick="setRemark2();" > -->
		</div>
	</div>
		
		<!-- 
        <textarea class="comment-textarea" rows="4" cols="40" placeholder="코멘트를 입력하세요..."></textarea>
        <button class="comment-submit-button" onclick="setRemark2();">저장</button>
        <button class="comment-cancel-button" onclick="$('#popLayer').hide();">취소</button>
		-->

	<!--grid1 -->
	<script type="text/javascript">
		jQuery.fn.center = function () {
		    this.css("position","absolute");
		    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 4) + $(window).scrollTop()) + "px");
		    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 4) + $(window).scrollLeft()) + "px");
		    return this;
		}
		var selGrid1Row = 0;
		var firstBlur = 0;
		var selRowId = ""; // 더블클릭으로 선택한 행 id
		var editableCells = ['item1', 'item3', 'item4', 'item5', 'remark1', 'remark2', 'comments']
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
			colNames : ['일자', '사용자계정', '최종수정일', '문서타입', '문서코드', '문서명', '최종문서체크', '담당자', '실장', '과장','문서형식','비고', '비고이미지','코멘트'], // 컬럼명
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
								name: 'code', index: 'code', width: '60', align: "center",hidden: false//문서코드
							},
							{
								name: 'item1', index: 'item1', width: '60', align: "center", editable : false //문서명
							},
							{
								name: 'item2', index: 'item2', width: '50', align: "center", //최종문서 체크박스
								formatter: "checkbox", formatoptions: { disabled: false },editable : true, edittype: 'checkbox', 
								editoptions: { value: "true:false", defaultValue :"true"} 
							},
							{
								name: 'item3', index: 'item3', width: '60', align: "center", editable : false //담당자
							},
							{
								name: 'item4', index: 'item4', width: '60', align: "center", editable : false //실장
							},
							{
								name: 'item5', index: 'item5', width: '60', align: "center", editable : false //과장
							},
							{
								name: 'remark1', index: 'remark1', width: '60', align: "center", editable : false //문서형식
							},
							{
								name: 'remark2', index: 'remark2', width: '60', align: "center", editable : false,hidden: true //비고
							},
							 {
					            name: 'remark2Image', width: 60,
					            sortable: false, resizable: false,
					            search: false, align: "center",
					            formatter: function (cellvalue, options, rowObject) {
					                return "<img src='/images/icons/bigo.png.png' onclick=showPopup("+options.rowId+"); alt='문서 이미지' style='width: 16px; height: 16px; cursor: pointer;' class='modal-trigger' data-rowid='" + options.rowId + "' />";
					            }
					        },



							{
								name: 'comments', index: 'comments', width: '60', align: "center", hidden: true, editable : false //코멘트
							}
						],
						
			multiselect: true, //그리드에서 여러 행을 선택할 수 있도록 하는 다중 선택 옵션 활성화
			autowidth   : true, //그리드 너비 자동설정
			shrinkToFit : true, //컬럼 너비 그리드에 맞게 조절
			height      : "auto", // 테이블의 세로 크기, Grid의 높이
			loadtext    : "자료를 조회중이니 잠시만 기다려주십시오...", // 데이터 로드중일 때
			emptyrecords: "Nothing to display", // 데이터 없을 때
			rowNum      : -1, //한 번에 보여줄 행의 개수를 지정, -1=모든행을 보여줌
			rownumbers  : true, //각 행에 번호를 부여하는 표시옵션
			gridview    : true, // 그리드 랜더링시 성능을 향상시키는 옵션
			cellEdit    : true,
            cellsubmit  : 'clientArray', //변경된 셀 데이터는 클라이언트 측에서만 처리하도록 해주는 옵션        
			loadComplete: function (data) {
			}, // loadComplete END
			gridComplete : function (data) {
				$("#list1").jqGrid('setSelection', "1", true); // 그리드 생성 및 촉화 후 호출되는 함수 정의 + 그리드1의 첫번째 행을 디폴트로 선택하는 이벤트
				$('#list1').jqGrid('setSelection', '1').prop('checkbox', false); // 1번째 체크박스 선택 해제
			},
			//특정 행을 더블 클릭할 때 실행되는 함수를 정의 & 행을 편집 가능하도록 설정하고 편집 모드로 변경
	        ondblClickRow: function (rowid, iRow, iCol) {
	            var colModels = $(this).getGridParam('colModel');
	            var colName = colModels[iCol].name;

	            if (editableCells.indexOf(colName) >= 0) {
	                $(this).setColProp(colName, { editable: true });
	                $(this).editCell(iRow, iCol, true);
	            }
	        },
			//그리드1 선택행으로 그리드2 화면 갱신 로직
			onSelectRow: function (rowid, iRow, iCol) {
				var params = {} //피라미터를 담을 객체생성
				params.isSearch2 = "true"; // 검색여부를 true로 세팅
				params.code = $('#list1').getRowData(rowid).code; // 선택행의 값을 params.code 에 설정 -> 그리드1의 선택값을 그리드2에서 사용하기위함
				params.includeExpired = $('#includeExpired').is(':checked');
				selGrid1Row = $('#list1').getRowData(rowid).code; // 전역변수인 selGrid1Row에도 선택된 행의 코드값을 저장
				
				$("#list2").clearGridData();//그리드2의 데이터 초기화 -> 선택행에따라 새로운 데이터로 갱신
				//그리드2 파라미터 설정 , reloadGrid 이벤트를 트리거해서 그리드를 다시 로드
				$("#list2").setGridParam({
					datatype : "json",
					postData : params ,
					loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
					function(postData){} 
				}).trigger("reloadGrid");
			},
			//셀을 선택했을 때 실행되는 함수를 정의 & 선택된 행의 값을 활용하여 그리드2의 데이터를 새로 로드하고 갱신
			onCellSelect: function (rowid) {
				console.log("onCellSelect rowid >>> " + rowid);
				var params            = {} //피라미터를 담을 객체생성
				params.isSearch2      = "true"; // 검색여부를 true로 세팅
				params.code           = $('#list1').getRowData(rowid).code; // 선택행의 값을 params.code 에 설정 -> 그리드1의 선택값을 그리드2에서 사용하기위함
				params.includeExpired = $('#includeExpired').is(':checked');
				selGrid1Row           = $('#list1').getRowData(rowid).code; // 전역변수인 selGrid1Row에도 선택된 행의 코드값을 저장
				
				$("#list2").clearGridData();//그리드2의 데이터 초기화 -> 선택행에따라 새로운 데이터로 갱신
				
				//그리드2 파라미터 설정 , reloadGrid 이벤트를 트리거해서 그리드를 다시 로드
				$("#list2").setGridParam({
					datatype : "json",
					postData : params ,
					loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
					function(postData){} 
				}).trigger("reloadGrid");
			},
			
			
			//셀이 편집된 후 실행되는 함수를 정의
			afterEditCell: function(id,name,val,iRow,iCol){
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
			var params   = {} // 삭제 작업에 필요한 파라미터를 저장할 빈 객체를 생성
			var isAll    = this.id == 'deleteGrid1Row' ? 'true' : 'false'; // deleteGrid1Row를 누르면 isAll(상하위 전부삭제) , 그렇지않은 경우 false(하위만 삭제)
			var gridObj  = isAll == 'true' ? 'list1' : 'list2'; // 변수 값에 따라 어떤 그리드(list1 또는 list2)에서 데이터를 삭제할지 결정
			var selIdx   = $('#'+gridObj).getGridParam('selrow');  // 선택한 그리드에서 선택된 행의 인덱스 가져오기
			
			if(selIdx == null){
				alert("그리드에서 삭제할 행을 선택해주세요");
			}else{
				var code     = $('#'+gridObj).getRowData(selIdx).code; // 선택한 그리드의 선택된 행에서 code 값 가져옴
				var code_no  = $('#'+gridObj).getRowData(selIdx).code_no; // 선택한 그리드의 선택된 행에서 code_no 값 가져옴
		
				params.isAll    = isAll; // 상위테이블 여부 파라미터 세팅[true일 경우 상위/하위 테이블의 데이터를 가팅 삭제 / false일 경우 하위 테입르의 데이터만 삭제]
				params.code     = code;  // code 파라미터 세팅
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
	            //서버로 보낼 데이터 객체, params 객체에 저장된 값을 전달
	            data: {
	            	  isAll   : params.isAll
	            	, code    : params.code
	            	, code_no : params.code_no
	            },
	            dataType : "json",
	            error: function(data){
	                console.log('error');
	                alert("오류가 발생했습니다.");
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

		/**
		그리드1 검색('찾기'버튼)
		*/
		$("#findBtn").click(function(){
			getGridList();
		});
		
		
		$(document).ready(function() {
		    const list1 = $("#list1");
		    const searchInput = $("#searchInput");

		    // 초기 데이터를 originalData에 저장해 둡니다.
		    const originalData = list1.jqGrid("getGridParam", "data");

		    searchInput.on("input", function() {
		        const searchText = $(this).val().toLowerCase(); // 입력한 검색어를 소문자로 변환하여 저장

		        // 필터링된 데이터를 저장할 배열
		        const filteredData = [];

		        // 검색어에 해당하는 데이터를 filteredData에 추가
		        $.each(originalData, function(index, rowData) {
		            if (rowData.item1.toLowerCase().includes(searchText)) {
		                filteredData.push(rowData);
		            }
		        });

		        // 그리드 데이터를 초기화하고, 필터링된 데이터로 채웁니다.
		        list1.jqGrid("clearGridData");
		        list1.jqGrid("setGridParam", { data: filteredData });
		        list1.trigger("reloadGrid");
		    });

		    // 초기 화면 로딩 시 검색어가 있는 경우 필터링 수행
		    const initialSearchText = searchInput.val().toLowerCase();
		    if (initialSearchText) {
		        searchInput.trigger("input");
		    }
		});






		
		/**
		그리드 지우기 버튼 클릭(grid1)
		*/
		document.addEventListener("DOMContentLoaded", function() {
		    // '지우기' 버튼 클릭 이벤트 처리
		    document.getElementById("deleteBtn").addEventListener("click", function() {
		        // 검색창 내용을 지우기
		        document.getElementById("searchInput").value = "";
		    });
		});
		
		// 이미지 클릭 이벤트에 코멘트 입력 폼 생성
		$(document).on('click', '.modal-trigger', function(event) {
		    event.stopPropagation(); // 이미지 클릭 시 부모 이벤트 전파 차단
		    var rowId = $(this).data('rowid'); // 클릭한 이미지의 data-rowid 값 가져오기

		    var imageOffset = $(this).offset();
		    var imageWidth = $(this).width();
		    var imageHeight = $(this).height();
		    var formLeft = imageOffset.left + imageWidth + 10; // 오른쪽으로 10px 간격
		    var formTop = imageOffset.top;

		    // 기존에 열린 폼이 있다면 닫기
		    /* $('.custom-comment-form').remove();

		    // 코멘트 입력 폼 생성 및 위치 조정
		    var formContent = `
		        <div class="custom-comment-form" style="position: absolute; left: ${formLeft}px; top: ${formTop}px;">
		            <textarea class="comment-textarea" rows="4" cols="40" placeholder="코멘트를 입력하세요..."></textarea>
		            <button class="comment-submit-button">저장</button>
		            <button class="comment-cancel-button">취소</button>
		        </div>
		    `;

		    // 클릭한 위치에 코멘트 입력 폼 추가
		    $('body').append(formContent); */
		});

	
		// 코멘트 입력 저장 버튼 클릭 이벤트
		$(document).on('click', '.comment-submit-button', function() {
		    var comment = $('.comment-textarea').val(); // 입력된 코멘트 가져오기
		 // 수정된 데이터 가져오기
		    var editedData = $("#list1").getChangedCells('all');
		    console.log("그리드1 수정된 데이터 >>> " + JSON.stringify(editedData));
		    
		    $.each(data, function( key, value ){
	    		var rowid = value.id; // 수정된 행 rowid
	    		var code = $('#list1').getRowData(rowid).code; // 키값 세팅[DB 업데이트 기준컬럼]
	    		value.code = code;
	    	});
		    
		    $.ajax({
	    	    url    : "/saveComment.do",      // 전송 URL
	    	    type   : 'POST',                // GET or POST 방식
	    	    traditional : true,
	    	    dataType : 'JSON',
	    	    data : {"data" : JSON.stringify(data), "code" : "H_202308"}, //  ***** $('#list1').getRowData(selRowId).code <<< 와 같이 들어가야 하지만 키값 세팅이 정의되지 않아서 일단 하드코딩(쿼리에서 하드코딩) :: 화면 또는 서버단에서 키값을 세팅해줘야함. 
	    	    success : function(data){
	    	        if(data.result == 'true'){
	                    alert('코멘트 작성이 완료되었습니다');
	                    getGridList("false"); // 그리드1 데이터 조회
	    	        }
	    	    },
	    	    error : function(jqXHR, textStatus, errorThrown){
	    	        console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
	    	        alert('오류가 발생했습니다. 확인 후 다시 시도해주세요');
	    	    }
	    	}); 
	    });

		/**
			그리드1의 데이터 조회
		*/
		function getGridList(isFirst){ // isFirst : 함수호출시 전달될값, 첫번째 검색인지 여부를 나타냄
			//isFirst = (typeof isFirst == "undefined") ? 'false' : isFirst; // 첫번째 검색 여부 변수세팅(undefined는 false로 세팅해서 전체검색 하도록함)
			isFirst = "true";
			var params = {}

			params.isSearch    = "true"; // 검색여부를 true로 세팅
			params.isFirst     = isFirst; // 첫검색 여부
			params.searchInput = $('#searchInput').val(); // 검색어 
			console.log("getGridList params >>>" + JSON.stringify(params));

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
		

		<!--grid2 -->
		var selGrid2Row = 0;
		var firstBlur = 0;
		var selRowId = ""; // 더블클릭으로 선택한 행 id
		var editableCells2 = ['file_name', 'file_user', 'id1', 'id2', 'id3']
		//html -> japGrid 로 변환 및 그리드 설정 정의
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
								name: 'code_no', index: 'code_no', width: '120', align: "center",hidden: false, editable : false //문서번호
							},
							{
								name: 'file_name', index: 'file_name', width: '130', align: "center", editable : false //파일명
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
								name: 'file_user', index: 'file_user', width: '60', align: "center",editable : false //등록자
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
								name: 'id1', index: 'id1', width: '60', align: "center",editable : false //담당
							},
							{
								name: 'id2', index: 'id2', width: '60', align: "center",editable : false //실장
							},
							{
								name: 'id3', index: 'id3', width: '60', align: "center",editable : false //과장
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
								name: 'comments', index: 'comments', width: '60', align: "center", hidden: true, editable : false //코멘트
							}
						],
			multiselect : true,
			autowidth   : true, //컬럼 너비 자동 조정
			shrinkToFit : true, //그리드 전체가 너비보다 작을 경우 컬럼을 축소
			height      : "auto", // 테이블의 세로 크기, Grid의 높이
			loadtext    : "자료를 조회중이니 잠시만 기다려주십시오...", // 데이터 로드중일 때
			emptyrecords: "Nothing to display", // 데이터 없을 때
			rowNum      : -1,
			rownumbers  : true, //각 행 앞에 순번을 표시
			gridview    : true, // 그리드 뷰 활성화
			cellEdit: true,
	        cellsubmit: 'clientArray', 
			loadComplete: function (data) {
			
			}, // 데이터 로딩이 완료된 후 실행할 함수설정
			
	        ondblClickRow: function (rowid, iRow, iCol) {
	            var colModels = $(this).getGridParam('colModel');
	            var colName = colModels[iCol].name;

	            if (editableCells2.indexOf(colName) >= 0) {
	                $(this).setColProp(colName, { editable: true });
	                $(this).editCell(iRow, iCol, true);
	            }
	        }
					
		});
	
		/**
		그리드 찾기 버튼 클릭(grid2)
		*/
		$("#findBtn2").click(function(){
			getGridList2();
		});
		
		/**
		그리드 지우기 버튼 클릭(grid2)
		*/
		document.addEventListener("DOMContentLoaded", function() {
		    // '지우기' 버튼 클릭 이벤트 처리
		    document.getElementById("deleteBtn2").addEventListener("click", function() {
		        // 검색창 내용을 지우기
		        document.getElementById("searchInput2").value = "";
		    });
		});
		
		// 그리드2를 조회한다.
		function getGridList2(){
			var params = {}
			params.isSearch2 = "true"; // 검색여부를 true로 세팅
			params.searchInput2 = $('#searchInput2').val(); // 검색어를 파라미터 searchInput2에 할당, 검색어=searchInput2 ID 를 가진 입력란의 값
			params.code = selGrid1Row;
			
			params.includeExpired = $('#includeExpired').is(':checked');
	
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
		
		/*'사용종료 포함'체크박스 */
		$("#includeExpired").click(function() {
			var params = {} //피라미터를 담을 객체생성
			var rowid   = $('#list1').getGridParam('selrow');  // 선택한 그리드에서 선택된 행의 인덱스 가져오기
	
			params.isSearch2      = "true"; // 검색여부를 true로 세팅
			params.code           = $('#list1').getRowData(rowid).code; // 선택행의 값을 params.code 에 설정 -> 그리드1의 선택값을 그리드2에서 사용하기위함
			params.includeExpired = $('#includeExpired').is(':checked');
			selGrid1Row           = $('#list1').getRowData(rowid).code; // 전역변수인 selGrid1Row에도 선택된 행의 코드값을 저장
			
			$("#list2").clearGridData(); //그리드2의 데이터 초기화 -> 선택행에따라 새로운 데이터로 갱신
			
			//그리드2 파라미터 설정 , reloadGrid 이벤트를 트리거해서 그리드를 다시 로드
			$("#list2").setGridParam({
				datatype : "json",
				postData : params ,
				loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
				function(postData){} 
			}).trigger("reloadGrid");
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
	    
	    
	    
	    /**
	    	그리드1에서 행추가/수정 후 '저정' 버튼 클릭 시
	    	그리드1의 데이터 등록/수정을 한다.
	    */
	    $(".btn-sec.save").click(function(){
// 	    	var data = $('#list1').getChangedCells('all'); // 수정된 셀 데이터 // $('#list1').getChangedCells('all');
	    	var data = $("#list1").getRowData();
	    	console.log("그리드 내 수정된 데이터 >>>" +JSON.stringify(data));
	    	
	    	// 수정된 로우만 가져왔을 때
// 	    	$.each(data, function( key, value ){
// 	    		var rowid = value.id; // 수정된 행 rowid
// 	    		var code = $('#list1').getRowData(rowid).code; // 키값 세팅[DB 업데이트 기준컬럼]
// 	    		alert("key >>>" + key + "\tvalue >>>" + value + "\tcode >>>" + code);
// 	    		value.code = code;
// 	    	});

	    	$.ajax({
	    	    url    : "/saveGrid1.do",                    // 전송 URL
	    	    type   : 'POST',                // GET or POST 방식
	    	    traditional : true,
	    	    dataType : 'JSON',
	    	    data : {"data" : JSON.stringify(data), "code" : "H_202308"}, //  ***** $('#list1').getRowData(selRowId).code <<< 와 같이 들어가야 하지만 키값 세팅이 정의되지 않아서 일단 하드코딩(쿼리에서 하드코딩) :: 화면 또는 서버단에서 키값을 세팅해줘야함. 
	    	    success : function(data){
	    	        if(data.result == 'true'){
	                    alert('데이터를 저장/수정 하였습니다.111');
	                    getGridList("false"); // 그리드1 데이터 조회
	    	        }
	    	    },
	    	    error : function(jqXHR, textStatus, errorThrown){
	    	        console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
	    	        alert('오류가 발생했습니다. 확인 후 다시 시도해주세요');
	    	    }
	    	}); 
	    });
	    
	    

	    /**
    	그리드2에서 행추가/수정 후 '저정' 버튼 클릭 시
    	그리드2의 데이터 등록/수정을 한다.
	    */
	    $(".btn-sec.save").click(function(){
	    	var data = $('#list2').getChangedCells('all'); // 수정된 셀 데이터 // $('#list2').getChangedCells('all');
	    	console.log("그리드 내 수정된 데이터 >>>" +JSON.stringify(data));
	    	
	    	$.each(data, function( key, value ){
	    		var rowid = value.id; // 수정된 행 rowid
	    		var code_no = $('#list2').getRowData(rowid).code_no; // 키값 세팅[DB 업데이트 기준컬럼]
	    		value.code_no = code_no;
	    	});
	    	
	    	$.ajax({
	    	    url    : "/saveGrid2.do",                    // 전송 URL
	    	    type   : 'POST',                // GET or POST 방식
	    	    traditional : true,
	    	    dataType : 'JSON',
	    	    data : {"data" : JSON.stringify(data), "code_no" : "H_201901_190618165846"}, //  ***** $('#list2').getRowData(selRowId).code_no <<< 와 같이 들어가야 하지만 키값 세팅이 정의되지 않아서 일단 하드코딩(쿼리에서 하드코딩) :: 화면 또는 서버단에서 키값을 세팅해줘야함. 
	    	    success : function(data){
	    	        if(data.result == 'true'){
	                    alert('데이터를 저장/수정 하였습니다.222');
	                    getGridList("false"); // 그리드2 데이터 조회
	    	        }
	    	    },
	    	    error : function(jqXHR, textStatus, errorThrown){
	    	        console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
	    	        alert('오류가 발생했습니다. 확인 후 다시 시도해주세요');
	    	    }
	    	}); 
	    });

		// 팝업창 보이기
	    showPopup = function(rowid) {
	    	console.log("rowid >>>" + rowid);
	    	var remart2Val = $('#list1').getRowData(rowid).remark2;
	    	selRowId = rowid;
	    	$('#remart2Area').val(remart2Val);; // 팝업의 textarea 값에 선택한 그리드 행의 '비고' 값을 세팅한다. UPDATA 대상값
	    	$("#popLayer").show();
	    	$("#popLayer").center();
	    }
		
		$('#remart2Area').keydown(function(e){
			if(e.keyCode==13){
				var replaceVal = $('#remart2Area').val().replace(/(?:\r\n|\r|\n)/g, '');

				$('#remart2Area').val(replaceVal);
				$("#popLayer").hide();
				$("#list1").setCell(selRowId, "remark2", replaceVal);
		    	
			}
    	})
		
		/**
			코멘트(비고) 저장버튼 - 미사용
		*/
	    setRemark2 = function() {
	    	$.ajax({
	            type: "post",
	            url : "/saveComment.do", // 저장하는 contorller
	            data: {
	            	  code     : selGrid1Row // 키값
	            	, remark2  : $('#remart2Area').val()
	            },
	            dataType : "json",
	            error: function(data){
	                console.log('error');
	                alert("수정중 오류가 발생했습니다.");
	            },
	            success: function(data){
	            	//console.log("data >>>" + JSON.stringify(data));
	                if(data.result > 0){
	                    alert('코멘트 작성을 완료하였습니다');
	                    $("#popLayer").hide();	
	                    getGridList(); // 그리드1 조회
	                } else {
	                    alert('수정중 오류가 발생하였습니다.');
	                }
	            }
	        })
	    	
	    }
	    
	    $('.down-bar .container .grid1').click(function(e) {
	    	console.log('html e.target  >>>' + e.target + "\ne.target name >>>" + e.target.name);
    	   if (!$(e.target).parents("#popLayer").length && !$(e.target).is('#popLayer') && typeof e.target.name == 'undefined'){
    	     var isShow = $('#popLayer').is(':visible'); // 팝업창 shoew 여부
    	     if(isShow){
    	    	 console.log('popLayer hide');
	    	     $("#popLayer").hide();
    	     }else{
    	    	 console.log('팝업창 없음');
    	     }
    	   }
    	});

	    /**
	    화면 로딩 후 그리드1의 데이터를 조회한다.(전체 조회 아님)
	    */
	    window.onload = function(){
	    	getGridList("true"); // 그리드1 데이터 조회
	    }
	    
	    
	</script>
	
	
</body>
</html>