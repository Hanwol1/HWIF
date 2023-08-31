// 초기 값을 0으로 설정하는 부분
var selGrid1Row = 0;
var firstBlur = 0;
	
$('#list1').jqGrid(
		{
			url : "/reagentA.do", // 서버주소 
			reordercolNames : true,
			postData : {
				type : "listData",
			}, // 보낼 파라미터`
			
			
			
			mtype : 'POST', // 전송 타입
			datatype : "json", // 받는 데이터 형태 
			colNames : ['flag', '제품코드', '제품명', '파트', '물품구분', '규격', '입고단위',
					'출고단위', '환산수량', '입고바코드', '출고단위별출력', '창고바코드',
					'창고출고단위', '사용등록바코드', '유효기간', '개봉유효기간', '보관방법',
					'개봉후보관방법', '거래처명', '제조사코드(명)', '바코드', '단가',
					'Lot no', '적용일', '불용일', '병원코드' ], //컬럼명
			colModel : [ 
				{
					name : 'statusV',
					index : 'statusV',
					hidden : true
				},
				
				{
				name : 'testCode',
				index : 'testCode',
				width : '75',
				align : "center",
				hidden : false
			}, {
				name : 'testName',
				index : 'testName',
				width : '100',
				align : "center",
				hidden : false
			}, {
				name : 'jundalPart',
				index : 'jundalPart',
				width : '100',
				align : "center"
			}, {
				name : 'testGubun',
				index : 'testGubun',
				width : '100',
				align : "center",
				editable: false,
				edittype: "text"
			}, {
				name : 'kukuk',
				index : 'kukuk',
				width : '100',
				align : "center",
				editable: false,
				edittype: "text"
			}, {
				name : 'inDanui',
				index : 'inDanui',
				width : '100',
				align : "center"
			}, {
				name : 'outDanui',
				index : 'outDanui',
				width : '100',
				align : "center"
			}, {
				name : 'changeQty',
				index : 'changeQty',
				width : '100',
				align : "center"
			}, {
				name : 'barcodeInYn',
				index : 'barcodeInYn',
				width : '100',
				align : "center",
				formatter: 'checkbox',  // 체크박스 형식으로 표시
		        formatoptions: { disabled: false }, // 처음에 체크박스를 활성화할지 여부
		        edittype: 'checkbox', // 편집 시에도 체크박스를 사용
		        editoptions: { value: 'Y:N' }, // 체크됐을 때의 값과 체크 해제됐을 때의 값
		        sortable: false,  // 정렬 기능 끄기
		        hidden: false
			}, {
				name : 'barcodeDiv',
				index : 'barcodeDiv',
				width : '100',
				align : "center",
				formatter: 'checkbox',  // 체크박스 형식으로 표시
		        formatoptions: { disabled: false }, // 처음에 체크박스를 활성화할지 여부
		        edittype: 'checkbox', // 편집 시에도 체크박스를 사용
		        editoptions: { value: 'Y:N' }, // 체크됐을 때의 값과 체크 해제됐을 때의 값
		        sortable: false,  // 정렬 기능 끄기
		        hidden: false
			}, {
				name : 'barcodeStoreYn',
				index : 'barcodeStoreYn',
				width : '100',
				align : "center",
				formatter: 'checkbox',  // 체크박스 형식으로 표시
		        formatoptions: { disabled: false }, // 처음에 체크박스를 활성화할지 여부
		        edittype: 'checkbox', // 편집 시에도 체크박스를 사용
		        editoptions: { value: 'Y:N' }, // 체크됐을 때의 값과 체크 해제됐을 때의 값
		        sortable: false,  // 정렬 기능 끄기
		        hidden: false
			}, {
				name : 'storeDanui',
				index : 'storeDanui',
				width : '100',
				align : "center"
			}, {
				name : 'barcodeOutYn',
				index : 'barcodeOutYn',
				width : '100',
				align : "center",
				formatter: 'checkbox',  // 체크박스 형식으로 표시
		        formatoptions: { disabled: false }, // 처음에 체크박스를 활성화할지 여부
		        edittype: 'checkbox', // 편집 시에도 체크박스를 사용
		        editoptions: { value: 'Y:N' }, // 체크됐을 때의 값과 체크 해제됐을 때의 값
		        sortable: false,  // 정렬 기능 끄기
		        hidden: false
			}, {
				name : 'expDay',
				index : 'expDay',
				width : '100',
				align : "center"
			}, {
				name : 'expOpenDay',
				index : 'expOpenDay',
				width : '100',
				align : "center"
			}, {
				name : 'keepName',
				index : 'keepName',
				width : '100',
				align : "center"
			}, {
				name : 'keepOpenName',
				index : 'keepOpenName',
				width : '100',
				align : "center"
			}, {
				name : 'supplierName',
				index : 'supplierName',
				width : '100',
				align : "center"
			}, {
				name : 'jejoCode',
				index : 'jejoCode',
				width : '100',
				align : "center"
			}, {
				name : 'barcode',
				index : 'barcode',
				width : '100',
				align : "center"
			}, {
				name : 'danga',
				index : 'danga',
				width : '100',
				align : "center"
			}, {
				name : 'lotNo',
				index : 'lotNo',
				width : '100',
				align : "center"
			}, {
				name : 'startDate',
				index : 'startDate',
				width : '100',
				align : "center"
			}, {
				name : 'endDate',
				index : 'endDate',
				width : '100',
				align : "center"
			}, {
				name : 'hospitalCode',
				index : 'hospitalCode',
				width : '100',
				align : "center"
			} ], //서버에서 받은 데이터 설정
			// 서버에서 받은 데이터 설정
			jsonReader : { // 서버에서 받은 JSON 데이터를 어떻게 읽을 것인지 설정한다. 'root'는 실제 데이터가 들어있는 배열의 이름을 나타낸다.
				repeatitems : false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
				root : 'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
				records : 'records' // 보여지는 데이터 갯수(레코드) totalRecord 
			},
			shrinkToFit : true, // 그리드의 컬럼들을 그리드 너비에 맞게 자동으로 조절할지 여부를 설정한다.
			height : "auto", // Grid의 높이를 자동으로 조정한다.    
			loadtext : "자료 조회중입니다. 잠시만 기다리세요...", // 데이터 로드중일때 표시될 메시지를 설정한다.     
			emptyrecords : "Nothing to display", // 데이터가 없을떄 표시될 메시지를 설정한다.
			rowNum : 5000, // 한 페이지에 보여줄 행의 개수를 설정한다. -1로 설정하면 모든 행을 한번에 보여준다.
			rownumbers : true, // 각 행의 번호를 표시할지 여부를 설정한다.    
			loadonce: true,
			gridview : true, // 그리드를 선표시할지 여부를 설정한다. true/false
			cellsubmit: 'clientArray',
		    /*cellEdit: true,*/
			//더블클릭 이벤트... 더블클릭할 경우 에디트 모드로.
			ondblClickRow: function (rowid, iRow, iCol, e) {
			    console.log('ondblClickRow');

				// 더블 클릭한 열의 정보 추출
	            var $target = $(e.target);
				
				// attr('aria-describedby')을 사용하여 td 요소의 'aria-describedby'속성 값을 가져온다.
	            var colName = $target.closest('td').attr('aria-describedby'); // 더블클릭한 컬럼의 이름을 가져옴

	            // 더블클릭한 컬럼이 특정 컬럼인 경우에만 에디터 모드로 변경
	            if (colName !== undefined && colName !== null) {
	                var colIndex = iCol; // 더블클릭한 컬럼의 인덱스
	                var colModel = $("#list1").jqGrid('getGridParam', 'colModel');
					// 수정한 열을 U 플래그로 설정
					if(rowid<=totalLength){
						$("#list1").jqGrid('setRowData', rowid, { statusV: "U" });	
	                }
	                
	                // 클릭한 컬럼만 에디터 모드로 변경
					// setColProp 함수는 특정 열의 속성을 설정
					// editRow 함수는 특정 행을 편집 모드로 변경함
	                $("#list1").jqGrid('setColProp', colModel[colIndex].name, { editable: true });
	                $("#list1").jqGrid('editRow', rowid, { keys: true });
	                
	            }
	           
			   // 더블클릭한 열의 셀 내부의 input 요소를 찾아 포커스를 주고, 해당 input 요소에서 포커스가 빠져나갈 때 발생하는 blur 이벤트를 처리하는 함수를 등록한다.
               $("input", e.target).focus().blur(function() {
                	console.log("firstBlur >>>" + firstBlur);
					
					// firstBlur 변수를 사용하여 처음 blur 이벤트가 발생했는지를 확인하고, 해당 조건에 따라 행을 복원하거나 firstBlur 값을 업데이트 한다.
                	if(firstBlur > 0){
                		console.log("focus out 000000000000000000000000");
                		$("#list1").jqGrid('restoreRow', iRow);
                	} else {
                		firstBlur = firstBlur+1 ;
                		
                		console.log('first blur !!!' + firstBlur)  
                		
                	}
                });
			},
			
		    onSelectRow : function(rowid) { // 행이 선택될 때 실행될 함수를 설정한다.
				
				var listData =  $('#list1').jqGrid('getRowData', rowid).testCode;
				
				console.log(listData) 
				console.log("Row selected:", rowid);
				
				$("#list2").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
				grid2(listData);
				
			},
			loadComplete : function(data) { // 데이터 로드가 완료되었을 때 실행될 함수를 설정한다. 
				
				console.log(data);
				totalLength = $("#list1").getGridParam("records");
				console.log(totalLength);
			} // loadComplete END   
		});
			var totalLength;

		

		const grid2 = function(data) {$('#list2').jqGrid({
			url : "/reagentA2.do", // 서버주소 
			reordercolNames : true,
			postData : {
				listData : data,
			}, // 보낼 파라미터
			mtype : 'POST', // 전송 타입
			datatype : "json", // 받는 데이터 형태 
			colNames : [ '검사코드', '검사명' ], //컬럼명
			colModel : [ {
				name : 'testCode',
				index : 'testCode',
				width : '20',
				align : "center",
				hidden : false
			}, {
				name : 'gumsaName',
				index : 'gumsaName',
				width : '20',
				align : "center",
				hidden : false
			} ], //서버에서 받은 데이터 설정
			
			// 서버에서 받은 데이터 설정
			jsonReader : { // 서버에서 받은 JSON 데이터를 어떻게 읽을 것인지 설정한다. 'root'는 실제 데이터가 들어있는 배열의 이름을 나타낸다.
				repeatitems : false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
				root : 'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
				records : 'records' // 보여지는 데이터 갯수(레코드) totalRecord 
			},
			multiselect: true, // 체크박스 만들어줌.
			autowidth : true, // 그리드의 너비를 자동으로 조정할지 여부를 설정한다.
			shrinkToFit : true, // 그리드의 컬럼들을 그리드 너비에 맞게 자동으로 조절할지 여부를 설정한다.
			height : "auto", // Grid의 높이를 자동으로 조정한다.    
			loadtext : "자료 조회중입니다. 잠시만 기다리세요...", // 데이터 로드중일때 표시될 메시지를 설정한다.     
			emptyrecords : "Nothing to display", // 데이터가 없을떄 표시될 메시지를 설정한다.
			rowNum : 5000, // 한 페이지에 보여줄 행의 개수를 설정한다. 
			rownumbers : true, // 각 행의 번호를 표시할지 여부를 설정한다.    
			gridview : true, // 그리드를 선표시할지 여부를 설정한다. true/false   
			loadonce:false,
			loadComplete : function(data) { // 데이터 로드가 완료되었을 때 실행될 함수를 설정한다. 
				console.log(data);
			}, // loadComplete END   
			onSelectRow : function(rowid) { // 행이 선택될 때 실행될 함수를 설정한다.
// 				console.log(rowid) // 현재 선택된 행의 ID를 콘솔에 출력하고 있다.
			}

		})
	}

		$('#list3').jqGrid({
			url : "/reagentA3.do", // 서버주소 
			reordercolNames : true, // 열 제목을 재정렬할 수 있는지 여부를 나타낸다.
			postData : {
				type : "C",
			}, // 보낼 파라미터
			mtype : 'POST', // 전송 타입
			datatype : "json", // 받는 데이터 형태 
			colNames : [ '검사코드', '검사명' ], // 그리드의 각 열의 제목을 설정한다.
			colModel : [ {
				name : 'testCode',
				index : 'testCode',
				width : '100',
				align : "center",
				hidden : false
			}, {
				name : 'gumsaName',
				index : 'gumsaName',
				width : '100',
				align : "center",
				hidden : false
			} ],
			
			// 서버에서 받은 데이터 설정
			jsonReader : { // 서버에서 받은 JSON 데이터를 어떻게 읽을 것인지 설정한다. 'root'는 실제 데이터가 들어있는 배열의 이름을 나타낸다.
				repeatitems : false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
				root : 'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
				records : 'records' // 보여지는 데이터 갯수(레코드) totalRecord 
			},
			multiselect: true, // 체크박스 만들어줌.
			autowidth : true, // 그리드의 너비를 자동으로 조정할지 여부를 설정한다.
			shrinkToFit : true, // 그리드의 컬럼들을 그리드 너비에 맞게 자동으로 조절할지 여부를 설정한다.
			height : "auto", // Grid의 높이를 자동으로 조정한다.    
			loadtext : "자료 조회중입니다. 잠시만 기다리세요...", // 데이터 로드중일때 표시될 메시지를 설정한다.     
			emptyrecords : "Nothing to display", // 데이터가 없을떄 표시될 메시지를 설정한다.
			rowNum : 5000, 
			rownumbers : true, // 각 행의 번호를 표시할지 여부를 설정한다.    
			gridview : true, // 그리드를 선표시할지 여부를 설정한다. true/false         
			loadComplete : function(data) { // 데이터 로드가 완료되었을 때 실행될 함수를 설정한다. 
			}, // loadComplete END   
			onSelectRow : function(rowid) { // 행이 선택될 때 실행될 함수를 설정한다.
				console.log(rowid) // 현재 선택된 행의 ID를 콘솔에 출력하고 있다.
			}

		})