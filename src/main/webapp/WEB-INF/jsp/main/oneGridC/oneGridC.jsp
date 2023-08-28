<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/oneGridC.css" />
</head>
<body>
	<!-- 위 -->
	<div class="up">
		<div class="up-btn">
			<button class="btn" onclick="Grid1()"><img src="/images/search.png" class="icon">조회</button>
			<button class="btn" id="saveBtn"><img src="/images/save.png" class="icon">저장</button>
		</div>
	</div>
	<!-- 아래 -->
	<div class="down">
		<div class="down-left">
			<!-- 아래.왼쪽 -->
			<div class="down-left-btn">
				<!-- 아래.왼쪽.위.버튼 -->
				<button class="btn" id="btn_add_row"><img src="/images/search.png" class="icon">입력</button>
				<button class="btn" id="btn_delete_row"><img src="/images/delete.png" class="icon-x">삭제</button>
			</div>
			<div class="down-left-text">
				<input type="text" id="search" placeholder="Enter text to search..."></input>
				<button class="FC-btn" id="btn_search"><img src="/images/search.png" class="icon">Find</button>
				<button class="FC-btn" id="clear"><img src="/images/clear.png" class="icon">Clear</button>
			</div>
			<div style="height: auto; overflow: auto;" onclick="handleClose(modal2)" class="gridbox"><table id="lisc001DTO"></table></div>
		</div>
		<div class="down-right">
			<!-- 아래.오른쪽 -->
			<div class="down-right-up">
				<!-- 아래.오른쪽.위 -->
				<div class="down-right-btn">
					<!-- 아래.오른쪽.위.버튼 -->
					<button class="btn" id="btn_add_row2"><img src="/images/search.png" class="icon">입력</button>
					<button class="btn" id="btn_delete_row2"><img src="/images/delete.png" class="icon-x">삭제</button>
					<div class="modalall">
						<button class="btn" onclick="handleOpen(modal1)" id="coulmn1"><img src="/images/settings.png" class="icon">컬럼설정</button>
						<!-- Modal  -->
						<div class="modal" id="myModal1">
							<div class="box">
								<div class="modalText">코드 (30자리) <input type="text" name="" class="modalInput" id="code"></div>
								<div class="modalText">항목 1 (80자리) <input type="text" name="" class="modalInput" id="item1"></div>
								<div class="modalText">항목 2 (80자리) <input type="text" name="" class="modalInput" id="item2"></div>
								<div class="modalText">항목 3 (80자리) <input type="text" name="" class="modalInput" id="item3"></div>
								<div class="modalText">항목 4 (80자리) <input type="text" name="" class="modalInput" id="item4"></div>
								<div class="modalText">항목 5 (80자리) <input type="text" name="" class="modalInput" id="item5"></div>
								<div class="modalText">서술형 1 (4000자리) <input type="text" name="" class="modalInput" id="remark1"></div>
								<div class="modalText">서술형 2 (4000자리) <input type="text" name="" class="modalInput" id="remark2"></div>
								<button id = "coulmnBtn1">확인</button>
							</div>
						</div>
					</div>
				</div>
				<div style="height: 30vh; overflow: auto;" onclick="handleClose(modal2)" class="gridbox"><table id="lisc002DTO"></table></div>
			</div>
			<div class="down-right-down">
				<!-- 아래.오른쪽.아래 -->
				<div class="down-right-btn2">
					<!-- 아래.오른쪽.아래.버튼 -->
					<button class="btn" id="btn_add_row3"><img src="/images/search.png" class="icon">입력</button>
					<button class="btn" id="btn_delete_row3"><img src="/images/delete.png" class="icon-x">삭제</button>
					<div class="modalall">
						<button class="btn" onclick="handleOpen(modal2)" id="coulmn2"><img src="/images/settings.png" class="icon">컬럼설정</button>
						<!-- Modal  -->
						<div class="modal" id="myModal2">
							<div class="box">
								<div class="modalText">코드 (30자리) <input type="text" name="" class="modalInput" id="code"></div>
								<div class="modalText">항목 1 (80자리) <input type="text" name="" class="modalInput" id="item1"></div>
								<div class="modalText">항목 2 (80자리) <input type="text" name="" class="modalInput" id="item2"></div>
								<div class="modalText">항목 3 (80자리) <input type="text" name="" class="modalInput" id="item3"></div>
								<div class="modalText">항목 4 (80자리) <input type="text" name="" class="modalInput" id="item4"></div>
								<div class="modalText">항목 5 (80자리) <input type="text" name="" class="modalInput" id="item5"></div>
								<div class="modalText">서술형 1 (4000자리) <input type="text" name="" class="modalInput" id="remark1"></div>
								<div class="modalText">서술형 2 (4000자리) <input type="text" name="" class="modalInput" id="remark2"></div>
								<button id = "coulmnBtn2">확인</button>
							</div>
						</div>
					</div>
				</div>
				<div style="height: 37vh; overflow: auto;" onclick="handleClose(modal2)" class="gridbox"><table id="lisc003DTO"></table></div>
			</div>
		</div>
	</div>


	<script>
	// Grid --------------------------------------------------------------------------------------------------
	// Grid1
	function Grid1(){
		$("#lisc001DTO").jqGrid("GridUnload");
		$('#lisc001DTO').jqGrid({  // id
		    url: "/oneGridC.do",	// 서버주소 
		    reordercolNames:true,
		    postData : { type:"A" }, // 보낼 파라미터
		    mtype:'POST',	// 전송 타입
		    datatype : "json",	// 받는 데이터 형태 
		    colNames:['flag', '코드','코드명', '비고', 'ITEM1', 'ITEM2'],	//컬럼명
		    colModel:
		    [
		    	{ name: 'flag', index: 'flag', hidden: true},
		    	{ name: 'CODE_TYPE', index: 'CODE_TYPE', width: '40', align:"center"},
		   	 	{ name: 'CODE_TYPE_NAME', index: 'CODE_TYPE_NAME', width: '40', align: "center", editable : false},
			    {
			        name: 'COMMENTS',
			        index: 'COMMENTS',
			        width: '10',
			        align: 'center',
			        editable: true, // 편집 가능한 상태로 설정
			        edittype: 'textarea', // 편집 타입을 textarea로 설정
			        editoptions: {
			           rows: 3, // textarea의 높이를 설정 (행 수)
			           cols: 30 // textarea의 너비를 설정 (문자 수)
		         	}
			     },
			     { name: 'ITEM1', index: 'ITEM1', width: '40', align:"center", hidden: true},
			     { name: 'ITEM2', index: 'ITEM2', width: '40', align:"center", hidden: true}
			], //서버에서 받은 데이터 설정
		    jsonReader: 
		    {
			     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
			     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
			     records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
		    },
		    autowidth: true,
		  	rownumbers: true,         
		  	gridview : false,  // 선표시 true/false  
			shrinkToFit: true,
		    height: "auto",//테이블의 세로 크기, Grid의 높이         
		  	loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
		  	emptyrecords: "Nothing to display",  // 데이터없을떄
		  	rowNum:-1, 
		  	/* cellEdit: true,
            cellsubmit: 'clientArray',  */
		  	loadComplete: function(data)
		  	{  
		      console.log(data);
		      jQuery('#lisc001DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
		  	},	// loadComplete END   
		  	
			// Grid2
		  	onSelectRow: function(rowid) {
		  		Grid2();
		  	} 
		})
	}
	Grid1();
	
	
	// Grid2
	function Grid2(){
		$('#lisc001DTO').getRowData(rowid);
     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
     	var rowid, codetype, item1;
     	rowid  = $("#lisc001DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
        codetype = $("#lisc001DTO").jqGrid('getRowData', rowid).CODE_TYPE;   // 선택한 열중에서 grid내의 정보를 가져온다.
        item1 = $("#lisc001DTO").jqGrid('getRowData', rowid).ITEM1;
        
        var item1Array = item1.split(";"); // ';'로 분리하여 배열로 저장
		if (item1Array.length === 1 && item1Array[0] === "") {
		    // 만약 ;으로 분리한 결과가 빈 배열이라면 빈칸을 추가
		    item1Array = ["", "", "", "", "", "", "", ""];
		} else {
		    // 아닌 경우에는 기존의 값을 그대로 사용
		    while (item1Array.length < 8) {
		        // 배열의 길이가 8보다 작을 경우 빈칸으로 채우기
		        item1Array.push("");
		    }
		}
        item1Array = [...item1Array, "flag", "lisc002code"];
        console.log("item1Array: ", item1Array); // 배열 출력
        
        $("#myModal1 input#code").val(item1Array[0] || '');
        $("#myModal1 input#item1").val(item1Array[1] || '');
        $("#myModal1 input#item2").val(item1Array[2] || '');
        $("#myModal1 input#item3").val(item1Array[3] || '');
        $("#myModal1 input#item4").val(item1Array[4] || '');
        $("#myModal1 input#item5").val(item1Array[5] || '');
        $("#myModal1 input#remark1").val(item1Array[6] || '');
        $("#myModal1 input#remark2").val(item1Array[7] || '');
        
        $("#lisc002DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
        $('#lisc002DTO').jqGrid({
        	url: "/oneGridC002.do",	// 서버주소 
    	    reordercolNames:true,
    	    postData : { 
    	    	item1 : JSON.stringify(item1Array),
    	    	type: codetype 
    	    }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    mtype:'POST',	// 전송 타입
    	    datatype : "json",	// 받는 데이터 형태 
    	    colNames:item1Array,	//컬럼명 item1Array로 바꾸기
    	    colModel:
    	    [		
    		    { name: item1Array[0], index: item1Array[0], width: '10', align:"center", hidden: item1Array[0] === ""},
    		    { name: item1Array[1], index: item1Array[1], width: '10', align: "center", hidden: item1Array[1] === ""},
    		    { name: item1Array[2], index: item1Array[2], width: '10', align: "center", hidden: item1Array[2] === "" },
    		    { name: item1Array[3], index: item1Array[3], width: '10', align: "center", hidden: item1Array[3] === ""},
    		    { name: item1Array[4], index: item1Array[4], width: '10', align: "center", hidden: item1Array[4] === ""},
    		    { name: item1Array[5], index: item1Array[5], width: '10', align: "center", hidden: item1Array[5] === ""},
    		    { name: item1Array[6], index: item1Array[6], width: '10', align: "center", hidden: item1Array[6] === ""},
    		    { name: item1Array[7], index: item1Array[7], width: '10', align: "center", hidden: item1Array[7] === ""},
    		    { name: "lisc002code", index: "lisc002code", hidden : true},
    		    { name: 'flag', index: 'flag', hidden: true}
    		], //서버에서 받은 데이터 설정
    	    jsonReader: 
    	    {
    		     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
    		     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
    		     records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
    	    },
    	    autowidth: true,
    	  	rownumbers: true,         
    	  	gridview : false,  // 선표시 true/false  
    		shrinkToFit: true,
    	    height: "auto",//테이블의 세로 크기, Grid의 높이         
    	  	loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
    	  	emptyrecords: "Nothing to display",  // 데이터없을떄
    	  	rowNum:-1, 
    	  	loadComplete: function(data)
    	  	{  
    	      console.log(data);
    	      $('#lisc002DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
    	  	},	// loadComplete END   
    	  	
    	  	// Grid3
    	  	onSelectRow: function(rowid) {
                $('#lisc002DTO').getRowData(rowid);
                Grid3(); // Grid3 함수 호출
            }
    	})	        
	}
	
	
	// Grid3
	function Grid3(){
     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
     	var rowid, code, item2;
     	rowid  = $("#lisc002DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
     	console.log($("#lisc002DTO").jqGrid('getRowData', rowid));
        code = $("#lisc002DTO").jqGrid('getRowData', rowid).lisc002code;   // 선택한 열중에서 grid내의 정보를 가져온다.
		console.log("Rowid", rowid, "Grid3", code);
        // 컬럼 명 item2로 바꾸기 ---------------------------------------------------------------
		rowitem2id  = $("#lisc001DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
		item2 = $("#lisc001DTO").jqGrid('getRowData', rowitem2id).ITEM2;   // 001의 ITEM2 값을 가져옴
		
		var item2Array = item2.split(";"); // 일단 ;으로 분리
		if (item2Array.length === 1 && item2Array[0] === "") {
		    // 만약 ;으로 분리한 결과가 빈 배열이라면 빈칸을 추가
		    item2Array = ["", "", "", "", "", "", "", ""];
		} else {
		    // 아닌 경우에는 기존의 값을 그대로 사용
		    while (item2Array.length < 8) {
		        // 배열의 길이가 8보다 작을 경우 빈칸으로 채우기
		        item2Array.push("");
		    }
		}
		item2Array = [...item2Array, "flag"];
        console.log("item2Array: ", item2Array); // 배열 출력
        
        $("#myModal2 input#code").val(item2Array[0] || '');
        $("#myModal2 input#item1").val(item2Array[1] || '');
        $("#myModal2 input#item2").val(item2Array[2] || '');
        $("#myModal2 input#item3").val(item2Array[3] || '');
        $("#myModal2 input#item4").val(item2Array[4] || '');
        $("#myModal2 input#item5").val(item2Array[5] || '');
        $("#myModal2 input#remark1").val(item2Array[6] || '');
        $("#myModal2 input#remark2").val(item2Array[7] || '');
        
        
        $("#lisc003DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
        $('#lisc003DTO').jqGrid({
        	url: "/oneGridC003.do",	// 서버주소 
    	    reordercolNames:true,
    	    postData : { 
    	    	item2 : JSON.stringify(item2Array),
    	    	type: code
    	    }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    mtype:'POST',	// 전송 타입
    	    datatype : "json",	// 받는 데이터 형태 
    	    colNames:item2Array,	//컬럼명
    	    colModel:
    	    [
       		   	{ name: item2Array[0], index: item2Array[0], width: '10', align:"center", hidden: item2Array[0] === ""},
       		    { name: item2Array[1], index: item2Array[1], width: '10', align: "center", hidden: item2Array[1] === ""},
       		    { name: item2Array[2], index: item2Array[2], width: '10', align: "center", hidden: item2Array[2] === ""},
       		    { name: item2Array[3], index: item2Array[3], width: '10', align: "center", hidden: item2Array[3] === ""},
       		    { name: item2Array[4], index: item2Array[4], width: '10', align: "center", hidden: item2Array[4] === ""},
       		    { name: item2Array[5], index: item2Array[5], width: '10', align: "center", hidden: item2Array[5] === ""},
       		    { name: item2Array[6], index: item2Array[6], width: '10', align: "center", hidden: item2Array[6] === ""},
       		    { name: item2Array[7], index: item2Array[7], width: '10', align: "center", hidden: item2Array[7] === ""},
       		 	{ name: 'flag', index: 'flag', hidden: true}
       		], //서버에서 받은 데이터 설정
    	    jsonReader: 
    	    {
    		    repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
    		    root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
    		    records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
    	    },
    	    autowidth: true,
    	  	rownumbers: false,         
    	  	gridview : false,  // 선표시 true/false  
    		shrinkToFit: true,
    	    height: "auto",//테이블의 세로 크기, Grid의 높이         
    	  	loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
    	  	emptyrecords: "Nothing to display",  // 데이터없을떄
    	  	rowNum:-1, 
    	  	loadComplete: function(data)
    	  	{  
    	      console.log(data);
    	  	}	// loadComplete END   
		})
	}
	
	// btn --------------------------------------------------------------------------------------------------------
	// search lisc001DTO
	function searchGrid(){ 
		var searchval = $('#search').val(); // 검색어 
       	//그리드1의 파라미터 설정 & 그리드1 재로드	
       	$("#lisc001DTO").jqGrid("GridUnload");
       	$('#lisc001DTO').jqGrid({
        	url: "/oneGridC.do",	// 서버주소 
    	    reordercolNames:true,
    	    postData : { searchval: searchval, isSearch: "true" }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    mtype:'POST',	// 전송 타입
    	    datatype : "json",	// 받는 데이터 형태 
    	    colNames:['코드','코드명', '비고'],	//컬럼명
    	    colModel:
    	    [
    	    	{ name: 'CODE_TYPE', index: 'CODE_TYPE', width: '40', align:"center"},
   		     	{ name: 'CODE_TYPE_NAME', index: 'CODE_TYPE_NAME', width: '40', align:"center"},
   		     	{ name: 'COMMENTS', index: 'COMMENTS', width: '10', align: "center" }
    		], //서버에서 받은 데이터 설정
    	    jsonReader: 
    	    {
    		     repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
    		     root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
    		     records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
    	    },
    	    autowidth: true,
    	  	rownumbers: true,         
    	  	gridview : false,  // 선표시 true/false  
    		shrinkToFit: true,
    	    height: "auto",//테이블의 세로 크기, Grid의 높이         
    	  	loadtext : "자료 조회중입니다. 잠시만 기다리세요..." ,   // 데이터 로드중일때      
    	  	emptyrecords: "Nothing to display",  // 데이터없을떄
    	  	rowNum:-1, 
    	  	loadComplete: function(data)
    	  	{  
    	      console.log(data);
    	      jQuery('#lisc001DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
    	  	},	// loadComplete END   
    	  	
    	 	// Grid2
		  	onSelectRow: function(rowid) {
		  		Grid2();
		  	}
    	  	
		});	
    }
	$("#search").change(function(){ searchGrid(); }) // searchGrid 함수 호출
	$("#btn_search").on("click",function(){ searchGrid(); }) // searchGrid 함수 호출
		

	
	
	// addrow, deleterow 	
	function addRow(gridId) {
	    var newRowData = {};
	    var grid = $(gridId);
	    var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
	    newRowData.flag = 'I';
	    grid.jqGrid("addRowData", newRowId, newRowData, "first");
	}
	function deleterow(gridId) {
	    var grid = $(gridId);
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    if (selectedRowId) { grid.jqGrid('delRowData', selectedRowId);
	    } else { alert('Please select a row to delete.'); }
	}
	$("#saveBtn").click(function(){
		console.log($("#lisc001DTO").getRowData());
		console.log($("#lisc002DTO").getRowData());
	})
	$("#btn_add_row").click(function(){ 
		const newRowData = { /* Data for new row */ };
		addRow('#lisc001DTO');
	});
	const btnDeleteRow = document.getElementById('btn_delete_row');
	btnDeleteRow.addEventListener('click', function(){ deleterow('#lisc001DTO'); });

    $("#btn_add_row2").click(function(){
		addRow('#lisc002DTO');
			
    });
  	const btnDeleteRow2 = document.getElementById('btn_delete_row2');
	btnDeleteRow2.addEventListener('click', function(){ deleterow('#lisc002DTO'); });
    
    $("#btn_add_row3").click(function(){ addRow('#lisc003DTO'); });
	const btnDeleteRow3 = document.getElementById('btn_delete_row3');
	btnDeleteRow3.addEventListener('click', function(){ deleterow('#lisc003DTO'); });
	
	
	//clear
	$("#clear").on("click", function() {
        // #search input 상자의 내용을 지움
        $("#search").val("");
        // #lisc001DTO 그리드를 초기화하고 데이터 리로드
        console.log('a');
        Grid1();
    });
	
	
	// modal
	const modal1 = document.getElementById('myModal1');
	const modal2 = document.getElementById('myModal2');
	function handleOpen (modal) {
		handleClose(modal1);
		handleClose(modal2);
	    modal.style.display = 'block'; /* 모달 창을 보이도록 설정합니다. */
	    
	// item 값 불러오기
	};
	function handleClose(modal) {
	    modal.style.display = 'none'; /* 모달 창을 숨깁니다. */
	};
	$(".gridbox").on("click", function() {
		handleClose(modal1);
		handleClose(modal2);
	})

	
	
	
	
	
	
	
	
	</script>
</body>
</html>