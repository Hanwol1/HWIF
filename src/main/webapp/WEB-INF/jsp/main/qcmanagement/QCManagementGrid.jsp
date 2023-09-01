<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="/css/QCManagementGrid.css" /></head
  >
  <body>
    <!-- 상단 조회바 -->
    <nav class="nav">
      <!-- 조회구분, 검사파트/QC물질명 조회 -->
      <div class="flex-box">
        <!-- 조회구분 -->
        <div class="flex-box search-division-box">
          <p class="nav-division-title">조회구분</p>

          <div class="flex-box-column">
            <div class="radio-container">
              <input type="radio" name="use" id="useAll" value="all" />
              <label class="search-radio-label" for="useAll">전체</label>
              <input type="radio" name="use" id="use" checked value="use" />
              <label class="search-radio-label" for="use">사용</label>
              <input type="radio" name="use" id="useNot" value="useNot" />
              <label class="search-radio-label" for="useNot">폐기</label>
            </div>

            <div class="radio-container">
              <input type="radio" name="inOut" id="inOutAll" checked value="all" />
              <label class="search-radio-label" for="inOutAll">전체</label>
              <input type="radio" name="inOut" id="inside" value="I" />
              <label class="search-radio-label" for="inside">내부</label>
              <input type="radio" name="inOut" id="outside" value="O" />
              <label class="search-radio-label" for="outside">외부</label>
            </div>
          </div>
        </div>

        <!-- 검사파트/QC물질명 조회 -->
        <div class="flex-box">
          <div class="inspection-select-container">
            <div class="inspection-select-box check-part-select">
              <label class="inspection-label" for="inspectionPart">검사파트</label>
              <select
                class="inspection-select"
                name="inspectionParts"
                id="inspectionPart"
              >
              	<option value="all">(전체)</option>
              	<c:forEach items="${testPartList}" var="data">
              	  <option value="${data.code}">[${data.code}] ${data.item1}</option>
              	</c:forEach>
              </select>
            </div>

            <div class="inspection-select-box">
              <label class="inspection-label" for="qcMaterial">QC물질명</label>
              <select
                class="inspection-select"
                name="qcMaterials"
                id="qcMaterial"
              >
                <option value="all">(전체)</option>
                <c:forEach items="${qcNameList}" var="data">
              	  <option value="${data}">${data}</option>
              	</c:forEach>
              </select>
            </div>
          </div>
          
          <div class="search-box">
            <button class="btn btn-big check-btn" id="searchBtn">조회</button>
          </div>
        </div>
      </div>

      <!-- 검사항목 조회용 파트 -->
      <div class="inspection-item-container">
        <label class="inspection-item-label" for="inspectionItemPart">검사항목 조회용 파트</label>
        <select
          class="inspection-items"
          name="inspectionItemParts"
          id="inspectionItemPart"
        >
          <option value="all">(전체)</option>
      	  <c:forEach items="${testPartList}" var="data">
      	    <option value="${data.code}">[${data.code}] ${data.item1}</option>
      	  </c:forEach>
        </select>
      </div>
    </nav>

    <!-- 그리드 -->
    <div class="search-container">
      <div class="search-left-box">
        <div class="search-grid-top">
          <p class="search-grid-title">QC품질 검사항목관리 1.0</p>
          <div class="search-select-container">
            <input
              class="qcQuality-select-box"
              name="qcQualityItems"
              id="qcQualityItem"
              type="text"
              placeholder="Enter text to search..."
            />

            <button id="qcQualitySearchBtn" class="btn btn-small search-btn">검색</button>
            <button id="qcQualityClearBtn" class="btn btn-small clear-btn">Clear</button>
          </div>
        </div>
        
        <div class="grid-container">
          <table id="list1" ></table>
        </div>
      </div>

      <div class="search-right-box">
        <div class="search-grid-top">
          <p class="search-grid-title">검사항목 리스트</p>
          <div class="search-select-container">
            <input
              class="inspectionList-select-box"
              name="inspectionLists"
              id="inspectionList"
              type="text"
              placeholder="Enter text to search..."
            />

            <button id="inspectionListSearchBtn" class="btn btn-small search-btn">검색</button>
            <button id="inspectionListClearBtn" class="btn btn-small clear-btn">Clear</button>
          </div>
        </div>
        
        <div class="grid-container">
          <table id="list2" ></table>
        </div>
      </div>
    </div>

    <div class="result-container">
      <p class="result-title">QC품질별 검사항목 설정</p>
      <div class="result-top-box">
        <div class="result-subtop-box">
          <div class="result-option-container">
            <label class="result-label" for="qcCode">QC코드</label>
            <input
              class="result-input qcCode-input"
              id="qcCodeSelectInput"
              type="text"
              disabled
            />

            <label class="result-label" for="qcMaterialName">QC물질명</label>
            <input
              class="result-input qcMaterial-input"
              id="qcNameSelectInput"
              type="text"
              disabled
            />

            <label class="result-label" for="startDate">시작일</label>
            <input
              class="result-input date"
              id="startDateSelectInput"
              type="text"
              disabled
            />

            <div class="must-option">
              <input
                type="checkbox"
                name="lowHighMeanSDCheck"
                id="lowHighMeanSDCheck"
              />
              <label for="lowHighMeanSDCheck"
                >Low,High 값입력, Mean,SD 계산</label
              >
            </div>
          </div>

          <div class="flex-box result-check-container">
            <input type="checkbox" name="result-check-option" id="3SDRange" />
            <label for="3SDRange">3SD범위 사용</label>

            <input type="checkbox" name="result-check-option" id="rule12SCheckbox" />
            <label for="rule12SCheckbox">1_2S</label>

            <input type="checkbox" name="result-check-option" id="rule13SCheckbox" />
            <label for="rule13SCheckbox">1_3S</label>

            <input type="checkbox" name="result-check-option" id="rule22SCheckbox" />
            <label for="rule22SCheckbox">2_2S</label>

            <input type="checkbox" name="result-check-option" id="ruleR4SCheckbox" />
            <label for="ruleR4SCheckbox">R_4S</label>

            <input type="checkbox" name="result-check-option" id="rule41SCheckbox" />
            <label for="rule41SCheckbox">4_1S</label>

            <input type="checkbox" name="result-check-option" id="rule10XCheckbox" />
            <label for="rule10XCheckbox">10X</label>
          </div>
        </div>

        <div class="result-btn-container">
          <button id="addBtn" class="btn btn-mid item-btn item-add-btn">항목추가</button>
          <button id="saveBtn" class="btn btn-mid item-btn item-save-btn">항목저장</button>
          <button id="delBtn" class="btn btn-mid item-btn item-delete-btn">항목삭제</button>
        </div>
      </div>
      
      <div class="grid-3">
        <table id="list3" ></table>
      </div>
    </div>
    
<script>
//검사파트 변경 시 QC물질명 리스트 변경
const changeQCNameList = function(jundalPart) {
	$.ajax({
	    type : 'post',           // 타입 (get, post, put 등등)
	    url : '/qcNameListByTestPart.do',           // 요청할 서버url
	    contentType: 'application/json', // 클라이언트에서 JSON 형식으로 보내기
	    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
	    data : JSON.stringify({  // 보낼 데이터 (Object , String, Array)
	      "jundalPart" : jundalPart,
	    }),
	    success : function(result) { // 결과 성공 콜백함수
	        console.log(result.qcNameList);
	    	
	    	// select 태그에 option으로 추가
	    	var selectElement = $("#qcMaterial");
	    	
	    	selectElement.empty();
	    	selectElement.append($("<option>").val("all").text("(전체)"));
	    	
	    	// result 자체가 Object여서 result 안에 qcNameList로 들어가야 함
	    	result.qcNameList.forEach(function(item) {
	    		var option = $("<option>").val(item).text(item);
	    		selectElement.append(option);
	    	})
	    },
	    error : function(error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	})
};

//lisq100 그리드 작성 함수
const printGridlisq100 = function() {
	const endDate = $('input:radio[name=use]:checked').val();
	const qcInOut = $('input:radio[name=inOut]:checked').val();
	const jundalPart = $('#inspectionPart').val();
	const qcName = $('#qcMaterial').val();
	
	$("#list1").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
	$('#list1').jqGrid({
	    url: "/qcManagementLisq100.do",	// 서버주소 
	    reordercolNames:true,
	    postData : { 
	    	endDate: endDate,
	        qcInOut: qcInOut,
	        jundalPart: jundalPart,
	        qcName: qcName
		}, // 보낼 파라미터
	    mtype:'POST',	// 전송 타입
	    datatype : "json",	// 받는 데이터 형태 
	    colNames:['플래그', 'QC 코드', 'QC물질명', 'Lot No', 'Level', '검사파트', '시작일', '종료일', '고정검체번호',],	//컬럼명
	    colModel:[
			{ name: 'flag',				index: 'flag',			hidden: true, },
			{ name: 'qcCode', 			index: 'qcCode',		width: '40', 	align: "left" },
			{ name: 'qcName', 			index: 'qcName',		width: '80', 	align: "left" },
			{ name: 'lotNo', 			index: 'lotNo',			width: '50', 	align: "left" },
			{ name: 'qcLevel',			index: 'qcLevel',		width: '20', 	align: "left" },
			{ name: 'testPart',			index: 'testPart',		width: '60', 	align: "left" },
			{ name: 'startDate',		index: 'startDate',		width: '40', 	align: "left" },
			{ name: 'endDate',			index: 'endDate',		width: '40', 	align: "left" },
			{ name: 'qcSpecimenSer',	index: 'qcSpecimenSer',	width: '40', 	align: "left" },
	    ], //서버에서 startDate 데이터 설정
	    jsonReader: {
		     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
		     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
		     records:'records'  // 보여지는 데이터 개수(레코드) totalRecord 
	    },
	    autowidth: true,
	    autoheight: true,
		loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
		emptyrecords: "Nothing to display",  // 데이터 없을때
		rowNum: 2000, 
		rownumbers: false,  
		gridview : true,  // 선 표시 true/false
		sortable: true,
		loadComplete: function(data){  
			console.log(data);
		},	// loadComplete END   
		beforeSelectRow: function(rowid, e) {  // 하나의 행만 체크
			$("#list1").jqGrid('resetSelection');
			return(true);
		},
		onSelectRow: function(rowid) {
			console.log($("#list1").getRowData(rowid));
			var selectRowData = $("#list1").getRowData(rowid);
			
			$("#qcCodeSelectInput").val(selectRowData.qcCode);
			$("#qcNameSelectInput").val(selectRowData.qcName);
			$("#startDateSelectInput").val(selectRowData.startDate);
			
			printGridlisc100();
			printGridlisq110();
		}
	});
};

//lisq110 그리드 작성 함수
const printGridlisq110 = function() {
	const rowid = $("#list1").getGridParam("selrow");
	const selectRow = $("#list1").getRowData(rowid);
	const endDate = $('input:radio[name=use]:checked').val();
	const lotNo = selectRow.lotNo;
	const qcCode = selectRow.qcCode;
	
	$("#list3").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
	$('#list3').jqGrid({
	    url: "/qcManagementLisq110.do",	// 서버주소 
	    reordercolNames:true,
	    postData : { 
	    	endDate: endDate,
	        lotNo: lotNo,
	        qcCode: qcCode
		}, // 보낼 파라미터
	    mtype:'POST',	// 전송 타입
	    datatype : "json",	// 받는 데이터 형태 
	    colNames:['플래그', '검사코드', '검사명', '검사파트', 'Mean', 'SD', 'CV', '허용(L)', '허용(H)', '서술형', '단위', '시작일', '종료일', '1(2S)', '판정(1_2S)', '1(3S)', '판정(1_3S)', '2(2S)', '판정(2_2S)',
	    	'R(4S)', '판정(R_4S)', '4(1S)', '판정(4_1S)', '10X', '판정(10X)', '순번', '그래프', 
	    	'QC 물질명', 'LEVEL', 'lotno', 'fkstartdate', 'fkqcstartdate'
	    ],	//컬럼명
	    colModel:[
			{ name: 'flag',				index: 'flag',			hidden: true, },
			{ name: 'testCode',			index: 'testCode',		width: '60', 	align: "left" },
			{ name: 'gumsaName',		index: 'gumsaName',		width: '180', 	align: "left" },
			{ name: 'item1',			index: 'item1',	width: '80', 	align: "left" },
			{ name: 'meanValue',		index: 'meanValue',		width: '70', 	align: "left",   editable: true, edittype: 'text' },
			{ name: 'sdValue',			index: 'sdValue',		width: '60', 	align: "left",   editable: true, edittype: 'text' },
			{ name: 'cvValue',			index: 'cvValue',		width: '60', 	align: "left" },
			{ name: 'lowValue',			index: 'lowValue',		width: '60', 	align: "left",   editable: false, edittype: 'text' },
			{ name: 'highValue',		index: 'highValue',		width: '60', 	align: "left",   editable: false, edittype: 'text' },
			{ name: 'susulValue',		index: 'susulValue',	width: '60', 	align: "left",   editable: true, edittype: 'text' },
			{ name: 'danui',			index: 'danui',			width: '60', 	align: "left" },
			{ name: 'startDate',		index: 'startDate',		width: '90', 	align: "left", 	 editable: true, edittype: 'text', 
				editoptions: {
					dataInit: function(e) {
						var rowData = $(this).jqGrid("getLocalRow", $(this).closest("tr").prop("id"));
						var savedDate = rowData.dateColumn; // 저장된 데이터 가져오기
						
						$(e).datepicker({
							dateFormat: 'yy-mm-dd', // 원하는 날짜 포맷
							// 기타 datepicker 옵션들 설정
							defaultDate: savedDate // 저장된 데이터를 초기 값으로 설정
						});
					}
				} 
			},
			{ name: 'endDate',			index: 'endDate',		width: '90', 	align: "left", 	 editable: true, edittype: 'text',
				editoptions: {
					dataInit: function(e) {
						var rowData = $(this).jqGrid("getLocalRow", $(this).closest("tr").prop("id"));
						var savedDate = rowData.dateColumn; // 저장된 데이터 가져오기
						
						$(e).datepicker({
							dateFormat: 'yy-mm-dd', // 원하는 날짜 포맷
							// 기타 datepicker 옵션들 설정
							defaultDate: savedDate // 저장된 데이터를 초기 값으로 설정
						});
					}
				} 
			},
			{ name: 'rule12S',			index: 'rule12S',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubun12S',			index: 'gubun12S',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'rule13S',			index: 'rule13S',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubun13S',			index: 'gubun13S',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'rule22S',			index: 'rule22S',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubun22S',			index: 'gubun22S',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'ruleR4S',			index: 'ruleR4S',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubunR4S',			index: 'gubunR4S',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'rule41S',			index: 'rule41S',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubun41S',			index: 'gubun41S',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'rule10X',			index: 'rule10X',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			{ name: 'gubun10X',			index: 'gubun10X',		width: '70', 	align: "left",	 editable: true, edittype: 'select', editoptions: {value: {Reject: 'Reject', Warning: 'Warning'}} },
			{ name: 'testCodeSeq',		index: 'testCodeSeq',	width: '40', 	align: "right" },
			{ name: 'graphYN',			index: 'graphYN',		width: '40', 	align: "center", editable: true, formatter: checkboxFormatter, unformat: checkboxUnformatter, edittype: 'checkbox', editoptions: { value: 'Y:N' } },
			
			{ name: 'qcCode',			index: 'qcCode',		hidden: true, },
			{ name: 'qcLevel',			index: 'qcLevel',		hidden: true, },
			{ name: 'lotNo',			index: 'lotNo',			hidden: true, },
			{ name: 'fkStartDate',		index: 'fkStartDate',	hidden: true, },
			{ name: 'fkQcStartDate',	index: 'fkQcStartDate',	hidden: true, },
	    ], //서버에서 startDate 데이터 설정
	    jsonReader: {
		     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
		     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
		     records:'records'  // 보여지는 데이터 개수(레코드) totalRecord 
	    },
	    width: '100%',
	    height: '80%',
		loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
		emptyrecords: "Nothing to display",  // 데이터 없을때
		rowNum: 2000, 
		rownumbers: false,  
		multiselect: true,  // 체크 박스 생성
		multiselectWidth: 30, // 체크 박스 크기
		gridview : true,  // 선 표시 true/false 
		sortable: true,
		cellEdit: true,
		cellsubmit: 'clientArray',
		loadComplete: function(data){  
			console.log(data);
		},	// loadComplete END   
		onSelectRow: function(rowid) {
			console.log($("#list3").getRowData());
//			$('#list3').jqGrid('editRow', rowid); // 선택하면 바로 수정모드
		},
		beforeSaveCell: function(rowid, cellname, value, iRow, iCol) {
			var rowData = $('#list3').getRowData(rowid);
			
			if (rowData.flag === '') {
				rowData.flag = 'U';
			}
			rowData[cellname] = value;
			
			$('#list3').setRowData(rowid, rowData);
		},
		afterSaveCell: function(rowid, cellname, value, iRow, iCol) {
			var rowData = $("#list3").getRowData(rowid);
			var sdRange = ($("#3SDRange").is(":checked")) ? 3 : 2;
			
			if (cellname === "meanValue") {
				rowData.cvValue = (parseFloat(rowData.sdValue) / parseFloat(value) * 100).toFixed(2);
				rowData.lowValue = (parseFloat(value) - (sdRange * parseFloat(rowData.sdValue))).toFixed(2);
				rowData.highValue = (parseFloat(value) + (sdRange * parseFloat(rowData.sdValue))).toFixed(2);
			} else if (cellname === "sdValue") {
				rowData.cvValue = ((parseFloat(value) / parseFloat(rowData.meanValue)) * 100).toFixed(2);
				rowData.lowValue = (parseFloat(rowData.meanValue) - (sdRange * parseFloat(value))).toFixed(2);
				rowData.highValue = (parseFloat(rowData.meanValue) + (sdRange * parseFloat(value))).toFixed(2);
			} else if (cellname === "lowValue") {
				rowData.meanValue = ((parseFloat(value) + parseFloat(rowData.highValue)) / sdRange).toFixed(2);
				rowData.sdValue = ((parseFloat(rowData.highValue) - parseFloat(value)) / 2 * sdRange).toFixed(2);
				rowData.cvValue = (parseFloat(rowData.sdValue) / parseFloat(rowData.meanValue) * 100).toFixed(2);
			} else if (cellname === "highValue") {
				rowData.meanValue = ((parseFloat(rowData.lowValue) + parseFloat(value)) / sdRange).toFixed(2);
				rowData.sdValue = ((parseFloat(value) - parseFloat(rowData.lowValue)) / 2 * sdRange).toFixed(2);
				rowData.cvValue = (parseFloat(rowData.sdValue) / parseFloat(rowData.meanValue) * 100).toFixed(2);
			}
			
			$('#list3').setRowData(rowid, rowData);
		}
	});
	
	// 데이터에 따라 체크 박스 체크 여부 설정
	function checkboxFormatter(cellValue, options, rowObject) {
	    return '<input type="checkbox" ' + (cellValue === 'Y' ? 'checked="checked"' : '') + '>';
	};

	// 체크 박스 값 데이터로 바뿌기
	function checkboxUnformatter(cellValue, options, cell) {
	    return $(cell).find('input[type=checkbox]').prop('checked') ? 'Y' : 'N';
	};

	// 셀 값 업데이트
	function updateCellValue(rowId, newValue) {
		$("#list3").jqGrid("setCell", rowId, "value", newValue); // 새로운 값 넣기
		
		console.log($("#list3").getRowData(rowId));
	};

	// 체크 박스 변경 시 데이터 변경 및 플래그 변경
	$("#list3").on("change", "input[type=checkbox]", function() {
		const rowId = $(this).closest("tr.jqgrow").attr("id"); // 체크된 셀의 rowId 가져오기
		const newValue = $(this).prop("checked") ? "Y" : "N"; // 체크되면 Y, 안되면 N
		const rowData = $("#list3").getRowData(rowId);

		if (rowData.flag === '') {
			rowData.flag = 'U';
		}
		
		updateCellValue(rowId, newValue);
		$('#list3').setRowData(rowId, rowData);
	});
	
	// Low,High 값입력, Mean,SD 계산 체크 박스 변경
	$("#lowHighMeanSDCheck").on("change", function() {
		if ($("#lowHighMeanSDCheck").is(":checked")) {
			$("#list3").jqGrid('setColProp', "meanValue", { editable: false });
			$("#list3").jqGrid('setColProp', "sdValue", { editable: false });
			$("#list3").jqGrid('setColProp', "lowValue", { editable: true });
			$("#list3").jqGrid('setColProp', "highValue", { editable: true });
		} else {
			$("#list3").jqGrid('setColProp', "meanValue", { editable: true });
			$("#list3").jqGrid('setColProp', "sdValue", { editable: true });
			$("#list3").jqGrid('setColProp', "lowValue", { editable: false });
			$("#list3").jqGrid('setColProp', "highValue", { editable: false });
		}
	});
	
	// 체크 박스로 모든 행 체크하기
	function allCheck(checkboxName) {
	    console.log(checkboxName);

	    var rows = $("#list3").jqGrid("getDataIDs"); // 행 ID들 가져오기
	    var tf = $("#" + checkboxName + "Checkbox").is(":checked") ? "Y" : "N"; // 체크 여부

	    // 모든 행 체크하기
	    for (var i = 0; i < rows.length; i++) {
	        var rowId = rows[i];
	        $("#list3").jqGrid("setCell", rowId, checkboxName, tf);
	    }
	};
	
	// 체크 박스 변경 시 함수 호출
	$("#rule12SCheckbox").on("change", function() {
		allCheck("rule12S");
	});
	$("#rule13SCheckbox").on("change", function() {
		allCheck("rule13S");
	});
	$("#rule22SCheckbox").on("change", function() {
		allCheck("rule22S");
	});
	$("#ruleR4SCheckbox").on("change", function() {
		allCheck("ruleR4S");
	});
	$("#rule41SCheckbox").on("change", function() {
		allCheck("rule41S");
	});
	$("#rule10XCheckbox").on("change", function() {
		allCheck("rule10X");
	});
};

//lisc100 그리드 작성 함수
const printGridlisc100 = function() {
	const jundalPart = $('#inspectionItemPart').val();
	
	$("#list2").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
	$('#list2').jqGrid({
	    url: "/qcManagementLisc100.do",	// 서버주소 
	    reordercolNames:true,
	    postData : { 
	    	jundalPart: jundalPart,
		}, // 보낼 파라미터
	    mtype:'POST',	// 전송 타입
	    datatype : "json",	// 받는 데이터 형태 
	    colNames:['플래그', '검사코드', '검사명', '단위', '검사파트'],	//컬럼명
	    colModel:[
			{ name: 'flag',				index: 'flag',			hidden: true, },
			{ name: 'testCode',			index: 'testCode',		width: '40', 	align: "left" },
			{ name: 'gumsaName',		index: 'gumsaName',		width: '60', 	align: "left" },
			{ name: 'resultDanui',		index: 'resultDanui',	width: '40', 	align: "left" },
			{ name: 'item1',			index: 'item1',			hidden: true },
	    ], //서버에서 startDate 데이터 설정
	    jsonReader: {
		     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
		     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
		     records:'records'  // 보여지는 데이터 개수(레코드) totalRecord 
	    },
	    autowidth: true,
	    autoheight: true,
		loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
		emptyrecords: "Nothing to display",  // 데이터 없을때
		rowNum: 2000, 
		rownumbers: false,  
		multiselect: true,  // 체크 박스 생성
		multiselectWidth: 30, // 체크 박스 크기
		gridview : true,  // 선 표시 true/false      
		sortable: true,
		loadComplete: function(data){  
			console.log(data);
		},	// loadComplete END   
		onSelectRow: function(rowId) {
			console.log(rowId);
		}
	});
};

//검색 함수
const searchInGrid = function(value, grid) {
	$("#" + grid).jqGrid("setGridParam", {
   datatype: "json", // 데이터 유형을 변경하여 새 데이터로 다시 로드
   page: 1 // 페이지를 처음부터 로드
}).trigger("reloadGrid");
	
	$("#" + grid).jqGrid("setGridParam", {
	    beforeProcessing: function(data) {
       // inputValue가 빈 값인 경우 모든 행 보존
	        if (value === "") {
	            return;
	        }
	 	    
	        var filteredData = []; // 필터된 데이터
	        
	        for (var i = 0; i < data.rows.length; i++) {
	            var rowData = data.rows[i];
	            var matched = false;
	            
	            // rowData의 모든 value 값과 inputValue 비교
	            for (var key in rowData) {
					var cellValue = rowData[key];
					if (cellValue && cellValue.toString().replace(/\s+/g, "").toLowerCase().includes(value)) {
					    matched = true;
					    break; // 일치하는 컬럼이 하나라도 있으면 검색 중단
					}
	            }
	
	            if (matched) {
	                filteredData.push(rowData);
	            }
	        }
	        data.rows = filteredData;
	    }
	});
};


//첫 페이지 로드
$(document).ready(function() {
	printGridlisq100();
	printGridlisc100();
});

// 조회구분 전체/사용/폐기 변경
var lisq100SelectUse = $('input:radio[name=use]:checked').val();

$('input:radio[name=use]').on("change", function() {
	lisq100SelectUse = $('input:radio[name=use]:checked').val();
	
	printGridlisq100();
	$("#list3").jqGrid("clearGridData", true);
});

// 조회구분 전체/내부/외부 변경
var lisq100SelectIO = $('input:radio[name=inOut]:checked').val();

$('input:radio[name=inOut]').on("change", function() {
	lisq100SelectIO = $('input:radio[name=inOut]:checked').val();
	
	printGridlisq100();
	$("#list3").jqGrid("clearGridData", true);
});

// 검사파트 변경 시 검사항목 조회용 파트 변경
$('#inspectionPart').on("change", function() {
	const testPart = $('#inspectionPart').val();
	
	$('#inspectionItemPart').val(testPart);
	
	changeQCNameList(testPart);
	
	printGridlisq100();
	$("#list3").jqGrid("clearGridData", true);
});

//QC물질명 변경 시 그리드 다시 그리기
$('#qcMaterial').on("change", function() {
	printGridlisq100();
	$("#list3").jqGrid("clearGridData", true);
});

// 검사항목 조회용 파트 변경시 검사항목 리스트 변경
$('#inspectionItemPart').on("change", function() {
	printGridlisc100();
});


// 항목추가 버튼
$("#addBtn").on("click", function() {
	var selectedRowIds = $("#list2").getGridParam("selarrrow");
	// lisq110의 모든 데이터
	var otherGridData = $("#list3").jqGrid("getRowData");
	
	for (var i=0; i<selectedRowIds.length; i++) {
		// lisc100에서 선택된 행의 데이터
		var rowId = selectedRowIds[i];
		var selectedRowData = $("#list2").getRowData(rowId);
		
		// lisq100에서 선택된 행의 데이터
		var lisq100SelectedRowId = $("#list1").getGridParam("selrow");
		var lisq100SelectedRowData = $("#list1").getRowData(lisq100SelectedRowId);
		
		var newRowData = {
			flag:"A",
			testCode: selectedRowData.testCode,
			gumsaName: selectedRowData.gumsaName,
			item1: selectedRowData.item1,
			danui: selectedRowData.resultDanui,
			startDate: lisq100SelectedRowData.startDate,
			endDate: lisq100SelectedRowData.endDate,
			meanValue: 0,
			sdValue: 0,
			cvValue: 0,
			lowValue: 0,
			highValue: 0,
			rule12S: "N",
			gubun12S:"Reject",
			rule13S: "N",
			gubun13S: "Reject",
			rule22S: "N",
			gubun22S: "Reject",
			ruleR4S: "N",
			gubunR4S: "Reject",
			rule41S: "N",
			gubun41S: "Reject",
			rule10X: "N",
			gubun10X:"Reject",
			testCodeSeq: 0,
			graphYN:"N",
			qcCode: lisq100SelectedRowData.qcCode,
			qcLevel: lisq100SelectedRowData.qcLevel,
			lotNo: lisq100SelectedRowData.lotNo
		};
		
		// lisq110에 데이터 누적
		otherGridData.push(newRowData);
	}
		
	// lisc100에서 데이터 삭제
	for (var i=selectedRowIds.length-1; i>=0; i--) {
		var rowId = selectedRowIds[i];
		console.log(rowId);
		$("#list2").jqGrid("delRowData", rowId);
	}
	
	// 새로고침
	$("#list3").jqGrid("clearGridData");
	for (var i = 0; i < otherGridData.length; i++) {
		$("#list3").jqGrid("addRowData", i + 1, otherGridData[i]);
	}
});

// 항목저장 버튼
$("#saveBtn").on("click", function () {
	// lisq100 데이터 전송
	var lisq100GridData = $("#list1").getRowData();
	
	$.ajax({
	    type : 'post',           // 타입 (get, post, put 등등)
	    url : '/delData.do',           // 요청할 서버url
	    contentType: 'application/json', // 클라이언트에서 JSON 형식으로 보내기
	    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
	    data : JSON.stringify(lisq100GridData),
	    success : function(result) { // 결과 성공 콜백함수
	        console.log(result);
	    },
	    error : function(error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	});
	
	// lisq110 데이터 전송
	var lisq110GridData = $("#list3").getRowData();
	
	$.ajax({
	    type : 'post',           // 타입 (get, post, put 등등)
	    url : '/saveData.do',           // 요청할 서버url
	    contentType: 'application/json', // 클라이언트에서 JSON 형식으로 보내기
	    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
	    data : JSON.stringify(lisq110GridData),
	    success : function(result) { // 결과 성공 콜백함수
	        console.log(result);
	    },
	    error : function(error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	});
	
	printGridlisq100();
	$("#list3").jqGrid("clearGridData", true);
});

// 항목삭제 버튼
$("#delBtn").on("click", function() {
	// 어제 날짜 설정
	var delday = new Date();
	delday.setDate(delday.getDate() - 1);
	var yyyy = delday.getFullYear().toString();
    var mm = (delday.getMonth() + 1).toString();
    var dd = delday.getDate().toString();
    var deldate = yyyy + '-' + (mm[1] ? mm : '0'+mm[0]) + '-' + (dd[1] ? dd : '0'+dd[0]);
    
	// lisq100 선택된 행 플래그 D, 종료일 변경
	var lisq100SelectedRowId = $("#list1").getGridParam("selrow");
	var lisq100SelectedRowData = $("#list1").getRowData(lisq100SelectedRowId);
	
	lisq100SelectedRowData.flag = 'D';
	lisq100SelectedRowData.endDate = deldate;
	
	$("#list1").setRowData(lisq100SelectedRowId, lisq100SelectedRowData);
	
	// lisq110 모든 행
	var lisq110RowIds = $("#list3").getDataIDs();
	
	for (var i=0; i<lisq110RowIds.length; i++) {
		// lisc100 행의 데이터
		var lisq110RowData = $("#list3").getRowData(lisq110RowIds[i]);
		
		if (lisq110RowData.flag === '') {
			lisq110RowData.flag = 'U';
			lisq110RowData.endDate = deldate;
		} else {
			lisq110RowData.endDate = deldate;
		}
		
		$("#list3").setRowData(lisq110RowIds[i], lisq110RowData);
	}
});

// 조회 버튼 클릭
$("#searchBtn").on("click", function() {
	printGridlisq100();
	printGridlisc100();
});

// QC품질 검사항목관리 검색
$("#qcQualityItem").on("input", function() {
	var inputValue = $(this).val().replace(/\s+/g, "").toLowerCase();
	
	searchInGrid(inputValue, "list1");
});

// 검사항목 리스트 검색
$("#inspectionList").on("input", function() {
	var inputValue = $(this).val().replace(/\s+/g, "").toLowerCase();
	
	searchInGrid(inputValue, "list2");
});

// QC품질 검사항목관리 검색 버튼
$("#qcQualitySearchBtn").on("click", function() {
	var inputValue = $("#qcQualityItem").val().replace(/\s+/g, "").toLowerCase();
	
	searchInGrid(inputValue, "list1");
});

// 검사항목 리스트 검색 버튼
$("#inspectionListSearchBtn").on("click", function() {
	var inputValue = $("#inspectionList").val().replace(/\s+/g, "").toLowerCase();
	
	searchInGrid(inputValue, "list2");
});

// QC품질 검사항목관리 Clear 버튼
$("#qcQualityClearBtn").on("click", function() {
	$("#qcQualityItem").val("");
	
	searchInGrid("", "list1");
});

// 검사항목 리스트 Clear 버튼
$("#inspectionListClearBtn").on("click", function() {
	$("#inspectionList").val("");
	
	searchInGrid("", "list2");
});

</script>
  </body>
</html>
