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
			<button class="btn" id="reloadBtn"><img src="/images/search.png" class="icon">조회</button>
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
		    postData : { type: 'update' }, // 보낼 파라미터
		    mtype:'POST',	// 전송 타입
		    datatype : "json",	// 받는 데이터 형태 
		    colNames:['flag', '코드','코드명', '비고', 'ITEM1', 'ITEM2'],	//컬럼명
		    colModel:
		    [
		    	{ name: 'flag', index: 'flag', hidden: true},
		    	{ name: 'codeType', index: 'codeType', width: '40', align:"center"},
		   	 	{ name: 'codeTypeName', index: 'codeTypeName', width: '40', align: "center", editable : true, edittype : "text"},
			    { name: 'comments', index: 'comments', width: '10', align: 'center' },
			    { name: 'item1', index: 'item1', width: '40', align:"center", hidden: true},
			    { name: 'item2', index: 'item2', width: '40', align:"center", hidden: true}
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
		  	cellEdit: true,
            cellsubmit: 'clientArray',
            beforeSubmitCell: function (rowid, celname, value, iRow, iCol) {
                if (celname === 'codeTypeName' || celname === 'comments') {
                    var rowData = $('#lisc001DTO').jqGrid('getRowData', rowid);
                    if (rowData.flag !== 'I') {  // 'flag'가 'I'가 아닌 경우 (삽입을 나타냄)
                        rowData.flag = 'U';  // 'flag'를 'U'로 설정하여 업데이트를 나타냄
                        $('#lisc001DTO').jqGrid('setRowData', rowid, rowData);
                    }
                }
                return value;
            },
		  	loadComplete: function(data)
		  	{  
		      	console.log(data);
		      //jQuery('#lisc001DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
		  	},	// loadComplete END   
		  	
			// Grid2
		  	onCellSelect: function(rowid, iCol, cellcontent, e) {
		  		$('#lisc001DTO').jqGrid('setSelection',rowid);
		  		Grid2();
		  		$("#lisc003DTO").jqGrid("clearGridData", true);
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
        codetype = $("#lisc001DTO").jqGrid('getRowData', rowid).codeType;   // 선택한 열중에서 grid내의 정보를 가져온다.
        item1 = $("#lisc001DTO").jqGrid('getRowData', rowid).item1;
        
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
        item1Array = [...item1Array, "flag", "codeType", "Del"];
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
    	    colNames:item1Array,	//컬럼명 item1Array로 바꾸기 // 보여지는 값
    	    colModel:
    	    [		
    		    { name: 'code', index: 'code', width: '12', align:"center", hidden: item1Array[0] === ""},
    		    { name: 'item1', index: 'item1', width: '12', align: "center", hidden: item1Array[1] === "", editable : true, edittype : "text"},
    		    { name: 'item2', index: 'item2', width: '12', align: "center", hidden: item1Array[2] === "", editable : true, edittype : "text"},
    		    { name: 'item3', index: 'item3', width: '12', align: "center", hidden: item1Array[3] === "", editable : true, edittype : "text"},
    		    { name: 'item4', index: 'item4', width: '12', align: "center", hidden: item1Array[4] === "", editable : true, edittype : "text"},
    		    { name: 'item5', index: 'item5', width: '12', align: "center", hidden: item1Array[5] === "", editable : true, edittype : "text"},
    		    { name: 'remark1', index: 'remark1', width: '12', align: "center", hidden: item1Array[6] === "", editable : true, edittype : "text"},
    		    { name: 'remark2', index: 'remark2', width: '12', align: "center", hidden: item1Array[7] === "", editable : true, edittype : "text"},
    		    { name: 'flag', index: 'flag', hidden: true},
    		    { name: 'codeType', index: 'codeType', hidden: true},
    		    { name: 'Del', index: 'Del', width: '4', align: 'center'}
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
    	  	cellEdit: true,
            cellsubmit: 'clientArray',
            beforeSubmitCell: function(rowid, celname, value, iRow, iCol) {
            	if (item1Array[iCol] !== 'flag' && item1Array[iCol] !== 'code') {
                    var rowData = $('#lisc002DTO').jqGrid('getRowData', rowid);
                    if (rowData.flag !== 'I') {  // 'flag'가 'I'가 아닌 경우 (삽입을 나타냄)
	                    rowData.flag = 'U';
	                    $('#lisc002DTO').jqGrid('setRowData', rowid, rowData);
                    }
                }
                return value;
            },
    	  	loadComplete: function(data)
    	  	{  
    	      console.log(data);
    	     // $('#lisc002DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
    	  	},	// loadComplete END   
    	  	
    	  	// Grid3
    	  	onCellSelect: function(rowid, iCol, cellcontent, e) {
                $('#lisc002DTO').jqGrid('setSelection',rowid);
                Grid3(); // Grid3 함수 호출
            }
    	})	        
	}
	
	
	// Grid3
	function Grid3(){
     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
     	var rowid, code, item2;
     	rowid  = $("#lisc002DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
        code = $("#lisc002DTO").jqGrid('getRowData', rowid).code;   // 선택한 열중에서 grid내의 정보를 가져온다.
        codetype2 = $("#lisc002DTO").jqGrid('getRowData', rowid).codeType;
     	console.log($("#lisc002DTO").jqGrid('getRowData', rowid));
        // 컬럼 명 item2로 바꾸기 ---------------------------------------------------------------
		rowitem2id  = $("#lisc001DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
		item2 = $("#lisc001DTO").jqGrid('getRowData', rowitem2id).item2;   // 001의 ITEM2 값을 가져옴
		
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
		item2Array = [...item2Array, "flag", "code", "codeType", "Del"];
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
    	    	type: code,
    	    	type2: codetype2
    	    }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    mtype:'POST',	// 전송 타입
    	    datatype : "json",	// 받는 데이터 형태 
    	    colNames:item2Array,	//컬럼명
    	    colModel:
    	    [
       		   	{ name: 'code2', index: 'code2', width: '12', align:"center", hidden: item2Array[0] === ""},
       		    { name: 'item1', index: 'item1', width: '12', align: "center", hidden: item2Array[1] === "", editable : true, edittype : "text"},
       		    { name: 'item2', index: 'item2', width: '12', align: "center", hidden: item2Array[2] === "", editable : true, edittype : "text"},
       		    { name: 'item3', index: 'item3', width: '12', align: "center", hidden: item2Array[3] === "", editable : true, edittype : "text"},
       		    { name: 'item4', index: 'item4', width: '12', align: "center", hidden: item2Array[4] === "", editable : true, edittype : "text"},
       		    { name: 'item5', index: 'item5', width: '12', align: "center", hidden: item2Array[5] === "", editable : true, edittype : "text"},
       		    { name: 'remark1', index: 'remark1', width: '12', align: "center", hidden: item2Array[6] === "", editable : true, edittype : "text"},
       		    { name: 'remark2', index: 'remark2', width: '12', align: "center", hidden: item2Array[7] === "", editable : true, edittype : "text"},
       		 	{ name: 'flag', index: 'flag', hidden: true},
       		 	{ name: 'code', index: 'code', hidden: true},
       		 	{ name: 'codeType', index: 'codeType', hidden: true},
       		 	{ name: 'Del', index: 'Del', width: '4', align: 'center'}
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
    	  	cellEdit: true,
            cellsubmit: 'clientArray',
            beforeSubmitCell: function(rowid, celname, value, iRow, iCol) {
            	if (item2Array[iCol] !== 'flag') {
                    var rowData = $('#lisc003DTO').jqGrid('getRowData', rowid);
                    if (rowData.flag !== 'I') {  // 'flag'가 'I'가 아닌 경우 (삽입을 나타냄)
                    	rowData.flag = 'U';
                    	$('#lisc003DTO').jqGrid('setRowData', rowid, rowData);
                    }
                }
                return value;
            },
    	  	loadComplete: function(data)
    	  	{  
    	      console.log(data);
    	  	}	// loadComplete END   
		})
	}
	
	// search lisc001DTO --------------------------------------------------------------------------------------------------------
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
		    colNames:['flag', '코드','코드명', '비고', 'ITEM1', 'ITEM2'],	//컬럼명
		    colModel:
		    [
		    	{ name: 'flag', index: 'flag', hidden: true},
		    	{ name: 'codeType', index: 'codeType', width: '40', align:"center"},
		   	 	{ name: 'codeTypeName', index: 'codeTypeName', width: '40', align: "center", editable : true, edittype : "text"},
			    { name: 'comments', index: 'comments', width: '10', align: 'center' },
			    { name: 'item1', index: 'item1', width: '40', align:"center", hidden: true},
			    { name: 'item2', index: 'item2', width: '40', align:"center", hidden: true}
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
		  	cellEdit: true,
            cellsubmit: 'clientArray',
            beforeSubmitCell: function (rowid, celname, value, iRow, iCol) {
                if (celname === 'codeTypeName' || celname === 'comments') {
                    var rowData = $('#lisc001DTO').jqGrid('getRowData', rowid);
                    if (rowData.flag !== 'I') {  // 'flag'가 'I'가 아닌 경우 (삽입을 나타냄)
                        rowData.flag = 'U';  // 'flag'를 'U'로 설정하여 업데이트를 나타냄
                        $('#lisc001DTO').jqGrid('setRowData', rowid, rowData);
                    }
                }
                return value;
            },
		  	loadComplete: function(data)
		  	{  
		      console.log(data);
		      //jQuery('#lisc001DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
		  	},	// loadComplete END   
		  	
			// Grid2
		  	onCellSelect: function(rowid, iCol, cellcontent, e) {
		  		$('#lisc001DTO').jqGrid('setSelection',rowid);
		  		Grid2();
		  	} 
		});	
    }
	$("#search").change(function(){ searchGrid(); }) // searchGrid 함수 호출
	$("#btn_search").on("click",function(){ searchGrid(); }) // searchGrid 함수 호출
		

	//Btn------------------------------------------------------------------------------------------------------
	// reloadBtn(조회)
	$("#reloadBtn").click(function(){
		Grid1();
        $("#lisc002DTO").jqGrid("clearGridData", true);
        $("#lisc003DTO").jqGrid("clearGridData", true);
	})
	
	// saveBtn(저장)
	$("#saveBtn").click(function(){
		// lisc002DTO 데이터 전송
		var lisc001Data = $("#lisc001DTO").getRowData();
		var lisc002Data = $("#lisc002DTO").getRowData();
		var lisc003Data = $("#lisc003DTO").getRowData();
		
		var data = {"lisc001Data": lisc001Data, "lisc002Data": lisc002Data, "lisc003Data": lisc003Data};

		console.log("001 데이터 : ", lisc001Data);
		//console.log("002 데이터 : ", lisc002Data);
		//console.log("003 데이터 : ", lisc003Data);
		//console.log(JSON.stringify({"lisc001Data": lisc001Data, "lisc002Data": lisc002Data, "lisc003Data": lisc003Data}));
		
		$.ajax({
		    type : 'post',           // 타입 (get, post, put 등등)
		    url : '/saveBtn.do',           // 요청할 서버url
		    contentType: 'application/json; charset=UTF-8' , // 클라이언트에서 JSON 형식으로 보내기
		    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
		    data : JSON.stringify(data),// JSON.stringify({"lisc001Data": lisc001Data, "lisc002Data": lisc002Data, "lisc003Data": lisc003Data}),
		    success : function(result) { // 결과 성공 콜백함수
		        console.log(result);
		    },
		    error : function(error) { // 결과 에러 콜백함수
		        console.log(error)
		    }
		});
		
		// 그리드1 플래그 제거
	    for (const data of lisc001Data) {
	    	data.flag = '';
	    }
	    for (const data of lisc002Data) {
	    	data.flag = '';
	    }
	    for (const data of lisc003Data) {
	    	data.flag = '';
	    }
	})
	
	// addrow, deleterow----------------------------------------001 	
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
	$("#btn_add_row").click(function(){ 
		addRow('#lisc001DTO');
	});
	$("#btn_delete_row").click(function(){
		var grid = $('#lisc001DTO');
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var rowData = grid.jqGrid('getRowData', selectedRowId);
	    rowData.comments = 'D';
	    rowData.flag = 'D';
		console.log("001 데이터 : ", rowData);
		grid.jqGrid('setRowData', selectedRowId, rowData);
	});
	// ---------------------------------------------------------002
    $("#btn_add_row2").click(function(){ 
    	var newRowData = {};
	    var grid = $("#lisc001DTO");
	    var newRowId = $("#lisc002DTO").jqGrid("getGridParam", "reccount") + 1;
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var RowData = grid.jqGrid('getRowData', selectedRowId);
	    
	    newRowData.flag = 'I';
	    newRowData.codeType = RowData.codeType;
	    $("#lisc002DTO").jqGrid("addRowData", newRowId, newRowData, "first");
    });
    $("#btn_delete_row2").click(function(){
    	var grid = $('#lisc002DTO');
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var rowData = grid.jqGrid('getRowData', selectedRowId);
	    rowData.Del = 'D';
	    rowData.flag = 'D';
		console.log("002 데이터 : ", rowData);
		grid.jqGrid('setRowData', selectedRowId, rowData);
    });
    //----------------------------------------------------------003
    $("#btn_add_row3").click(function(){ 
    	var newRowData = {};
	    var grid = $("#lisc002DTO");
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow'); // 그리드2의 rowid를 가져옴
	    var RowData = grid.jqGrid('getRowData', selectedRowId);
	    var newRowId = $("#lisc003DTO").jqGrid("getGridParam", "reccount") + 1;
	    console.log("003 데이터 : ", newRowData);
	    newRowData.flag = 'I';
	    newRowData.codeType = RowData.codeType;  // 새로운 row의 codeType은 그리드2의 codeType
	    newRowData.code = RowData.code;  // 새로운 row의 code는 그리드2의 code
	    $("#lisc003DTO").jqGrid("addRowData", newRowId, newRowData, "first");
    });
    $("#btn_delete_row3").click(function(){
    	var grid = $('#lisc003DTO');
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var rowData = grid.jqGrid('getRowData', selectedRowId);
	    rowData.Del = 'D';
	    rowData.flag = 'D';
		console.log("003 데이터 : ", rowData);
		grid.jqGrid('setRowData', selectedRowId, rowData);
    });
	
	//---------------------------------------------------------clear
	$("#clear").on("click", function() {
        // #search input 상자의 내용을 지움
        $("#search").val("");
        // #lisc001DTO 그리드를 초기화하고 데이터 리로드
        Grid1();
        $("#lisc002DTO").jqGrid("clearGridData", true);
        $("#lisc003DTO").jqGrid("clearGridData", true);
    });
	
	// --------------------------------------------------------modal
	const modal1 = document.getElementById('myModal1');
	const modal2 = document.getElementById('myModal2');
	function handleOpen (modal) {
		handleClose(modal1);
		handleClose(modal2);
	    modal.style.display = 'block'; /* 모달 창을 보이도록 설정합니다. */
	};
	function handleClose(modal) {
	    modal.style.display = 'none'; /* 모달 창을 숨깁니다. */
	};
	$(".gridbox").on("click", function() {
		handleClose(modal1);
		handleClose(modal2);
	})
	
	
	//---------------------------------------------------------coulmnBtn1
	$("#coulmnBtn1").on("click", function() {
		handleClose(modal1);
		var code = $("#myModal1 #code").val();
        var item1 = $("#myModal1 #item1").val();
        var item2 = $("#myModal1 #item2").val();
        var item3 = $("#myModal1 #item3").val();
        var item4 = $("#myModal1 #item4").val();
        var item5 = $("#myModal1 #item5").val();
        var remark1 = $("#myModal1 #remark1").val();
        var remark2 = $("#myModal1 #remark2").val();
        
        var modal1String = code + ";" + item1 + ";" + item2 + ";" + item3 + ";" + item4 + ";" + item5 + ";" + remark1 + ";" + remark2;
        console.log("modal1String : ", modal1String);
        
        var grid = $('#lisc001DTO');
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var rowData = grid.jqGrid('getRowData', selectedRowId);
	    rowData.flag = 'U';
	    rowData.item1 = modal1String;
	    grid.jqGrid('setRowData', selectedRowId, rowData);
	    console.log("item1 : ", rowData.item1);
	    console.log("001 데이터 : ", rowData);
    });
	$("#coulmnBtn2").on("click", function() {
		handleClose(modal2);
		var code = $("#myModal2 #code").val();
        var item1 = $("#myModal2 #item1").val();
        var item2 = $("#myModal2 #item2").val();
        var item3 = $("#myModal2 #item3").val();
        var item4 = $("#myModal2 #item4").val();
        var item5 = $("#myModal2 #item5").val();
        var remark1 = $("#myModal2 #remark1").val();
        var remark2 = $("#myModal2 #remark2").val();
        
        var modal2String = code + ";" + item1 + ";" + item2 + ";" + item3 + ";" + item4 + ";" + item5 + ";" + remark1 + ";" + remark2;
        console.log("modal2String : ", modal2String);
        
        var grid = $('#lisc001DTO');
	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
	    var rowData = grid.jqGrid('getRowData', selectedRowId);
	    rowData.flag = 'U';
	    rowData.item2 = modal2String;
	    grid.jqGrid('setRowData', selectedRowId, rowData);
	    console.log("item2 : ", rowData.item2);
	    console.log("002 데이터 : ", rowData);
    });
	
	</script>
</body>
</html>