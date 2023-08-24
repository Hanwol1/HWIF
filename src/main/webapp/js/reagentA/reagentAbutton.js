// addListData() 함수 정의, list1 열 추가	
function addListData() {
	
	// jqGrid에 데이터 추가
	var grid = $('#list1');
	
	// 새로운 행의 ID 계산
	var newRowId = grid.jqGrid('getGridParam', 'records') + 1; 
	
	// 빈 객체로 시작
	var newData = {};
	
	// jqGrid에 빈 데이터로 행 추가
	grid.jqGrid('addRowData', newRowId, newData);
	
	// 행을 편집 모드로 변경
	grid.jqGrid('editRow', newRowId, true);
	
	// 새로운 행 선택
	grid.setSelection(newRowId, true);
	
}	


// deleteListData() 함수 정의, list1 열 삭제
function deleteListData() {
	var grid = $('#list1');
	var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	
	if (selectedRowId) {
		// 선택된 행이 있다면 해당 행을 삭제
		grid.jqGrid('delRowData', selectedRowId);
		console.log("Row deleted: ", selectedRowId);
	} else {
		console.log("No row selected for deletion.");
	}
}


// list1 EXCEL 파일
function saveExcel() {
	var grid = $('#list1');
    var rowDataArray = [];

 // 모든 데이터의 row ID 가져오기
    var rowIds = grid.jqGrid('getDataIDs'); 
 
    for (var i = 0; i < rowIds.length; i++) {
        var rowId = rowIds[i];
        
     	// 특정 row의 데이터 가져오기
        var rowData = grid.jqGrid('getRowData', rowId); 
        rowDataArray.push(rowData);
    }

 	// JSON 데이터를 엑셀 시트로 변환
    var worksheet = XLSX.utils.json_to_sheet(rowDataArray); 

 	// 엑셀 워크북 생성
    var wb = XLSX.utils.book_new(); 
 	// 시트를 워크북에 추가
    XLSX.utils.book_append_sheet(wb, worksheet, 'Sheet1'); 

    // 엑셀 파일 생성
    var excelBuffer = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
    var blob = new Blob([excelBuffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });

    // 엑셀 파일 다운로드 링크 생성
    var fileName = "list1.xlsx";
    var downloadLink = document.createElement("a");
    downloadLink.href = URL.createObjectURL(blob);
    downloadLink.download = fileName;
    downloadLink.click();
}




// 빈 배열 선언. 조회된 데이터를 담을 용도로 사용할 것임.
let data = [];

// 조회 기능(클라이언트 측에서만 처리)
function chooseSearch() {
    var selectedPart = $('#part').val();        // 선택된 파트 값 가져오기
    var selectedAccount = $('#acc').val();      // 선택된 거래처 값 가져오기
    var selectedManufacturer = $('#manu').val(); // 선택된 제조사 값 가져오기

    // 기존의 jqGrid 데이터를 가져옴
	// rowDataArray 배열 선언. jqGrid에서 가져온 각 행의 데이터를 담을 용도로 사용.
    var rowDataArray = [];
	var grid = $("#list1"); // jqGrid의 ID를 사용하여 그리드 요소를 저장
	
	var rowIds = grid.jqGrid('getDataIDs'); // 모든 행의 ID를 가져옴
	
	for (var i = 0; i < rowIds.length; i++) {
	    var rowData = grid.jqGrid('getRowData', rowIds[i]); // 각 행의 데이터를 가져옴
	    rowDataArray.push(rowData);
	}
	console.log(rowDataArray);
	
	
	if(data.length==0){
		data = [...rowDataArray];
	}
	console.log('data----');
	console.log(data);

    // 선택된 카테고리에 따라 데이터 필터링
    var filteredData = data.filter(function(item) {
		console.log(item.jejoName);
					
        return (!selectedPart || item.jundalPart === selectedPart) &&
               (!selectedAccount || item.supplierName === selectedAccount) &&
               (!selectedManufacturer || item.jejoName === selectedManufacturer);
    });
	console.log(filteredData);

	// jqGrid의 데이터를 초기화 한다.
    $("#list1").jqGrid("clearGridData");
    // jqGrid의 setGridParam 메서드를 사용하여 데이터를 업데이트하고, 새로운 데이터를 적용하여 그리드를 다시 렌더링 한다.
    $("#list1").jqGrid("setGridParam", {
        datatype: "local",
        data: filteredData
    }).trigger("reloadGrid");
}


// 빈 배열 선언. 조회된 데이터를 담을 용도로 사용할 것임.
let data1 = [];

// list1 검색기능
function wantSearch1() {
	// 입력한 검색어 가져오기
	var keyword = $('input[name="search_name"]').val();
	
	// 키워드가 없을 때
	if (!keyword) {
		showAllData1('#list1');
		return;  // 검색 로직 종요
	} 
	
	// jqGrid의 ID를 사용하여 그리드 요소를 선택
	var grid = $('#list1');
	
	// 모든 행의 ID를 가져온다
	var rowIds = grid.jqGrid('getDataIDs');
	
	var filteredData = [];
	
	// 만약 data1 배열이 비어있다면, 원본 데이터를 data1 배열에 저장
	if (data1.length === 0 ) {
		for (var i = 0; i < rowIds.length; i++) {
			var rowData = grid.jqGrid('getRowData', rowIds[i]);
			data1.push(rowData);
		}
	}
	
	// data 배열의 각 원소(각 행의 데이터)에 대해 검색어를 확인하여 필터링
	for (var i = 0; i < data1.length; i++) {
		var rowData = data1[i];
		
		// 각 열의 데이터 내용에서 검색어가 포함된 경우 filteredData 배열에 추가
		// 각 열(column)의 데이터에서 검색어가 포함되어 있는지를 includes() 함수를 사용하여 확인
		if (
			rowData.testCode.includes(keyword) ||
			rowData.testName.includes(keyword) ||
			rowData.jundalPart.includes(keyword) ||
			rowData.testGubun.includes(keyword) ||
			rowData.kukuk.includes(keyword) ||
			rowData.inDanui.includes(keyword) ||
			rowData.outDanui.includes(keyword) ||
			rowData.changeQty.includes(keyword) ||
			rowData.barcodeInYn.includes(keyword) ||
			rowData.barcodeDiv.includes(keyword) ||
			rowData.barcodeStoreYn.includes(keyword) ||
			rowData.storeDanui.includes(keyword) ||
			rowData.barcodeOutYn.includes(keyword) ||
			rowData.expDay.includes(keyword) ||
			rowData.expOpenDay.includes(keyword) ||
			rowData.keepName.includes(keyword) ||
			rowData.KeepOpenName.includes(keyword) ||
			rowData.supplierName.includes(keyword) ||
			rowData.jejoName.includes(keyword) ||
			rowData.barcode.includes(keyword) ||
			rowData.danga.includes(keyword) ||
			rowData.lotNo.includes(keyword) ||
			rowData.startDate.includes(keyword) ||
			rowData.endDate.includes(keyword) ||
			rowData.hospitalCode.includes(keyword)
		) {
			filteredData.push(rowData);
		}
	}
	// grid에 표시되는 내용을 모두 지우고 비어있는 상태로 만든다. 새로운 데이터를 추가하지 전에 내용을 비우는 작업을 한다.
	grid.jqGrid("clearGridData");
	// jqGrid의 setGridParam 메서드를 사용하여 데이터를 업데이트
	grid.jqGrid("setGridParam", {
		datatype: "local",
		data: filteredData
		// grid의 내용을 새로고침하고 현재 데이터로 다시 grid를 그려준다.
	}).trigger("reloadGrid");
}


// 빈 배열 선언. 조회된 데이터를 담을 용도로 사용할 것임.
let data3 = [];


// list3 검색기능
function wantSearch2() {
	// 입력한 검색어 가져오기
	var keyword3 = $('input[name="search_name1"]').val();
	console.log(keyword3);
	
	// 키워드가 없을 때 
	if (!keyword3) {
		showAllData3('#list3');
		return;  // 검색 로직 종료
	} 
	
	
	// jqGrid의 ID를 사용하여 그리드 요소를 선택
	var grid = $('#list3');
	
	// 모든 행의 ID를 가져온다
	var rowIds = grid.jqGrid('getDataIDs');
	
	var filteredData = [];
	
	// 만약 data3 배열이 비어있다면, 원본 데이터를 data3 배열에 저장
	if (data3.length === 0 ) {
		for (var i = 0; i < rowIds.length; i++) {
			var rowData = grid.jqGrid('getRowData', rowIds[i]);
			data3.push(rowData);
		}
	}
	
	// data 배열의 각 원소(각 행의 데이터)에 대해 검색어를 확인하여 필터링
	for (var i = 0; i < data3.length; i++) {
		var rowData = data3[i];
		console.log(rowData);
		
		// 각 열의 데이터 내용에서 검색어가 포함된 경우 filteredData 배열에 추가
		// 각 열(column)의 데이터에서 검색어가 포함되어 있는지를 includes() 함수를 사용하여 확인
		if (
			rowData.testCode.includes(keyword3) ||
			rowData.gumsaName.includes(keyword3)
		) {
			filteredData.push(rowData);
		}
	}
	// grid에 표시되는 내용을 모두 지우고 비어있는 상태로 만든다. 새로운 데이터를 추가하지 전에 내용을 비우는 작업을 한다.
	grid.jqGrid("clearGridData");
	// jqGrid의 setGridParam 메서드를 사용하여 데이터를 업데이트
	grid.jqGrid("setGridParam", {
		datatype: "local",
		data: filteredData
		// grid의 내용을 새로고침하고 현재 데이터로 다시 grid를 그려준다.
	}).trigger("reloadGrid");
}


// list1 전체 데이터를 그리드에 보여주는 함수
function showAllData1() {
    var grid = $('#list1');
    grid.jqGrid("clearGridData");
    grid.jqGrid("setGridParam", {
        datatype: "local",
        data: data1 // 원본 데이터를 그대로 표시
    }).trigger("reloadGrid");
}


// list3 전체 데이터를 그리드에 보여주는 함수
function showAllData3() {
    var grid = $('#list3');
    grid.jqGrid("clearGridData");
    grid.jqGrid("setGridParam", {
        datatype: "local",
        data: data3 // 원본 데이터를 그대로 표시
    }).trigger("reloadGrid");
}

// clearInput1 클리어
function clearInput1() {
	// 검색어를 입력한 input 요소 선택
	var inputElement = $('input[name="search_name"]');
	
	// 입력한 내용을 지움
	inputElement.val('');
}

// clearInput3 클리어
function clearInput3() {
	// 검색어를 입력한 input 요소 선택
	var inputElement = $('input[name="search_name1"]');
	
	// 입력한 내용을 지움
	inputElement.val('');
}


// saveListData() 함수 정의
function saveListData() {

	// list3에서 체크된 행의 ID(인덱스) 배열을 가져온다.
	var selectedRows = $('#list3').jqGrid('getGridParam', 'selarrrow');
	
	// 가져온 행 데이터를 list2 jqGrid에 추가
	for (var i = 0; i < selectedRows.length; i++) {
		
		// selectedRows[i] => 현재 선택된 행의 ID를 가져온다.
		var rowId = selectedRows[i];
		
		// list3에서 해당 행의 데이터를 가져온다. 가져온 데이터는 'rowData' 변수에 저장된다.
		var rowData = $('#list3').jqGrid('getRowData', rowId);

		// list2에 가져온 데이터를 추가한다.
		// 'addRowData'함수는 새로운 행을 그리드에 추가하는 함수
		// rowData의 내용이 새로운 행으로 추가된다.
		$('#list2').jqGrid('addRowData', undefined, rowData);
	}
}

// deleteListData2() 함수 정의, list2,3 내용 삭제
function deleteListData2() {
	// list2 에서 체크된 행의 ID(인덱스) 배열을 가져온다.
	var selectedRows = $('#list2').jqGrid('getGridParam', 'selarrrow');
	
	// 가져온 행 데이터를 list2 jqGrid에서 삭제
	for (var i = 0; i < selectedRows.length; i++) {
		// selectedRows[i] => 현재 선택된 행의 ID를 가져온다.
		var rowId = selectedRows[i];
		
		// list2 에서 해당 행을 삭제한다.
		$('#list2').jqGrid('delRowData', rowId);
	}
}