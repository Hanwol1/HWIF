// addListData() 함수 정의, list1 열 추가	
function addListData() {
	// jqGrid에 데이터 추가
	var grid = $('#list1');
	// 새로운 행의 ID 계산
	var newRowId = grid.jqGrid('getGridParam', 'records') + 1; 
	// 빈 객체로 시작
	var newData = { statusV: "I" , jundalPart : 0, changeQty: 0, danga: 0 };  // I 플래그로 설정
	// jqGrid에 빈 데이터로 행 추가
	grid.jqGrid('addRowData', newRowId, newData);
	// 행을 편집 모드로 변경
	grid.jqGrid('editRow', newRowId, true);
	// 새로운 행 선택
	grid.setSelection(newRowId, true);
}	


// list1DataSave() 함수 정의
function list1DataSave() {
	var grid = $('#list1');
    var rowDataArray = grid.jqGrid('getRowData');
    
	console.log(rowDataArray);
	
	var modifiedData = [];

    rowDataArray.forEach(function(rowData) {
        if (rowData.statusV === "I" || rowData.statusV === "U") {
            modifiedData.push(rowData);
        }
    });
    // modifiedData 배열에는 추가 및 수정된 데이터가 들어 있음
    console.log("Modified Data:", modifiedData);

    $.ajax({
        type: "POST",
        url: "/reagentAsave.do",
        data: JSON.stringify(modifiedData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            console.log("Data sent successfully:", response);
            // 성공적으로 서버로 전송된 후의 동작을 정의할 수 있습니다.
        },
        error: function(error) {
            console.error("Error sending data:", error);
            // 서버로 전송 중 에러 발생 시의 동작을 정의할 수 있습니다.
        }
    });
}


// deleteListData() 함수 정의, list1 열 삭제
function deleteListData() {
	var grid = $('#list1');
	var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	
	if (selectedRowId) {
		// 선택된 행이 있다면 해당 행을 삭제
		var rowData = grid.jqGrid('getRowData', selectedRowId);
		// 행의 statusV 값을 D로 설정
        rowData.statusV = "D";
        grid.jqGrid('setRowData', selectedRowId, rowData);
        // 해당 행을 삭제하고 수정된 데이터로 업데이트
        grid.jqGrid('delRowData', selectedRowId);

		console.log("Row deleted and flagged as 'D':", selectedRowId);
        console.log(rowData);
	} else {
		console.log("No row selected for deletion.");
	}
	
	$.ajax({
        type: "POST",
        url: "/reagentAdel.do",
        data: JSON.stringify(rowData),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            console.log("Data sent successfully:", response);
            // 성공적으로 서버로 전송된 후의 동작을 정의할 수 있습니다.
        },
        error: function(error) {
            console.error("Error sending data:", error);
            // 서버로 전송 중 에러 발생 시의 동작을 정의할 수 있습니다.
        }
    });
	
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

	
// 조회 기능(클라이언트 측에서만 처리)
function chooseSearch() {
    var selectedPart = $('#part').val();        // 선택된 파트 값 가져오기
    var selectedAccount = $('#acc').val();      // 선택된 거래처 값 가져오기
    var selectedManufacturer = $('#manu').val(); // 선택된 제조사 값 가져오기

	// 빈 배열 선언. 조회된 데이터를 담을 용도로 사용할 것임.
	let data = [];

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


// 검색 기능
const searchGrid = function(value, grid) {
	$("#" + grid).jqGrid("setGridParam", {
		datatype: "json", 
		page: 1
	}).trigger("reloadGrid");
	
	$("#" + grid).jqGrid("setGridParam", {
		beforeProcessing: function(data) {
			if (value === "") {
				return;
			}
			
			var filteredData = [];
			
			for (var i = 0; i < data.rows.length; i++) {
				var rowData = data.rows[i];
				var matched = false;
				
				for (var key in rowData) {
					var cellValue = rowData[key];
					
					if (cellValue && cellValue.toString().replace(/\s+/g, "").toLowerCase().includes(value)) {
						matched = true;
						break;
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

// lisc500 검색
$("#lisc500Item").on("input", function() {
	var inputValue = $(this).val().replace(/\s+/g, "").toLowerCase();
	
	searchGrid(inputValue, "list1");
});

// lisc100 검색
$("#lisc100Item").on("input", function() {
	var inputValue = $(this).val().replace(/\s+/g, "").toLowerCase();
	
	searchGrid(inputValue, "list3");
});

// lisc500 검색 버튼
$("#searchLisc500Btn").on("click", function() {
	var inputValue = $("#lisc500Item").val().replace(/\s+/g, "").toLowerCase();
	
	searchGrid(inputValue, "list1");
});

// lisc100 검색 버튼
$("#searchLisc100Btn").on("click", function() {
	var inputValue = $("#lisc100Item").val().replace(/\s+/g, "").toLowerCase();
	
	searchGrid(inputValue, "list3");
});


// lisc500 Clear 버튼
$("#clearLisc500Btn").on("click", function() {
	$("#lisc500Item").val("");
	
	searchGrid("", "list1");
});

// lisc100 Clear 버튼
$("#clearLisc100Btn").on("click", function() {
	$("#lisc100Item").val("");
	
	searchGrid("", "list3");
});

// saveListDataLisc501() 함수 정의
function saveListDataLisc501() {

	// list3에서 체크된 행의 ID(인덱스) 배열을 가져온다.
	var selectedRows = $('#list3').jqGrid('getGridParam', 'selarrrow');
	
	var listData = [];
	
	var invRowId = $("#list1").getGridParam("selrow");
	var invRowData = $("#list1").getRowData(invRowId);
	
	// 가져온 행 데이터를 list2 jqGrid에 추가
	for (var i = 0; i < selectedRows.length; i++) {
		
		// selectedRows[i] => 현재 선택된 행의 ID를 가져온다.
		var rowId = selectedRows[i];
		
		// list3에서 해당 행의 데이터를 가져온다. 가져온 데이터는 'rowData' 변수에 저장된다.
		var rowData = $('#list3').jqGrid('getRowData', rowId);
		
		// 'addRowData'함수는 새로운 행을 그리드에 추가하는 함수
		// rowData의 내용이 새로운 행으로 추가된다.
		$('#list2').jqGrid('addRowData', undefined, rowData);
		
		console.log(invRowData);
		console.log(invRowData.testCode);
		
		rowData = {"testCode": rowData.testCode, "invCode": invRowData.testCode};
		console.log(rowData);
		listData.push(rowData);
	}
	
	
	console.log(listData);
		
	$.ajax({
		type: 'POST',
		url: '/reagentA2Data.do',
		contentType: 'application/json', // 데이터 타입 설정
		dataType: "json",
		data: JSON.stringify(listData),
        success: function(result) {
            console.log('Data sent successfully:', result);
            // 성공 시 처리할 로직 추가
        },
        error: function(error) {
            console.log('Error sending data:', error);
            // 에러 시 처리할 로직 추가
    	}
	});
}


// deleteListDataLisc501() 함수 정의, list2,3 내용 삭제
function deleteListDataLisc501() {
	// list2 에서 체크된 행의 ID(인덱스) 배열을 가져온다.
	var selectedRows = $('#list2').jqGrid('getGridParam', 'selarrrow');
	
	var listData = [];

    var invRowId = $("#list1").getGridParam("selrow");
    var invRowData = $("#list1").getRowData(invRowId);
	
	// 가져온 행 데이터를 list2 jqGrid에서 삭제
	for (var i = 0; i < selectedRows.length; i++) {
		// selectedRows[i] => 현재 선택된 행의 ID를 가져온다.
		var rowId = selectedRows[i];
		var rowData = $('#list2').jqGrid('getRowData', rowId);
		
		// list1의 testCode를 invCode로 바꾸어서 데이터를 준비한다.
        rowData = {"testCode": rowData.testCode, "invCode": invRowData.testCode}; // 여기서 testCode를 invCode로 변경
        listData.push(rowData);
		
		// list2 에서 해당 행을 삭제한다.
		$('#list2').jqGrid('delRowData', rowId);
	}
	console.log(listData);
	
	$.ajax({
        type: 'POST',
        url: '/reagentA2DataDelete.do', // 수정된 URL
        data: JSON.stringify(listData),
        contentType: 'application/json', // 데이터 타입 설정
		dataType: "json",
        success: function(response) {
            console.log('Data deleted successfully:', response);
            // 성공 시 처리할 로직 추가
        },
        error: function(error) {
            console.error('Error deleting data:', error);
            // 에러 시 처리할 로직 추가
        }
    });
}


