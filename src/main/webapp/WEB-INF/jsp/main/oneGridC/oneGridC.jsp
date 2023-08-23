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
			<button class="btn"><img src="/images/search.png" class="icon">조회</button>
			<button class="btn"><img src="/images/save.png" class="icon">저장</button>
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
				<input type="text" id="search"  placeholder="Enter text to search..."></input>
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
						<button class="btn" onclick="handleOpen(modal1)" id="coulmn"><img src="/images/settings.png" class="icon">컬럼설정</button>
						<!-- Modal  -->
						<div class="modal" id="myModal">
							<div class="box">
								<div class="modalText">코드 (30자리) <input type="text" name="" class="modalInput" id="code" ></div>
								<div class="modalText">항목 1 (80자리) <input type="text" name="" class="modalInput" id="item1" ></div>
								<div class="modalText">항목 2 (80자리) <input type="text" name="" class="modalInput" id="item2" ></div>
								<div class="modalText">항목 3 (80자리) <input type="text" name="" class="modalInput" id="item3" ></div>
								<div class="modalText">항목 4 (80자리) <input type="text" name="" class="modalInput" id="item4" ></div>
								<div class="modalText">항목 5 (80자리) <input type="text" name="" class="modalInput" id="item5" ></div>
								<div class="modalText">서술형 1 (4000자리) <input type="text" name="" class="modalInput" id="remark1" ></div>
								<div class="modalText">서술형 2 (4000자리) <input type="text" name="" class="modalInput" id="remark2" ></div>
							</div>
						</div>
					</div>
					
				</div>
				<div style="height: 30vh; overflow: auto;" onclick="handleClose(modal2)" class="gridbox"> <table id="lisc002DTO"></table></div>
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
								<div class="modalText">코드 (30자리) <input type="text" name="" class="modalInput" id="code" ></div>
								<div class="modalText">항목 1 (80자리) <input type="text" name="" class="modalInput" id="item1" ></div>
								<div class="modalText">항목 2 (80자리) <input type="text" name="" class="modalInput" id="item2" ></div>
								<div class="modalText">항목 3 (80자리) <input type="text" name="" class="modalInput" id="item3" ></div>
								<div class="modalText">항목 4 (80자리) <input type="text" name="" class="modalInput" id="item4" ></div>
								<div class="modalText">항목 5 (80자리) <input type="text" name="" class="modalInput" id="item5" ></div>
								<div class="modalText">서술형 1 (4000자리) <input type="text" name="" class="modalInput" id="remark1" ></div>
								<div class="modalText">서술형 2 (4000자리) <input type="text" name="" class="modalInput" id="remark2" ></div>
							</div>
						</div>
					</div>

				</div>
				<div style="height: 37vh; overflow: auto;" onclick="handleClose(modal2)" class="gridbox"><table id="lisc003DTO"></table></div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	<script>
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
    	  		$('#lisc001DTO').getRowData(rowid);
    	     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
    	     	var rowid, codetype;
    	     	rowid  = $("#lisc001DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
    	        codetype = $("#lisc001DTO").jqGrid('getRowData', rowid).CODE_TYPE;   // 선택한 열중에서 grid내의 정보를 가져온다.
    	        console.log(codetype);
    	        $("#lisc002DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
    	        $('#lisc002DTO').jqGrid({
    	        	url: "/oneGridC002.do",	// 서버주소 
    	    	    reordercolNames:true,
    	    	    postData : { type: codetype }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    	    mtype:'POST',	// 전송 타입
    	    	    datatype : "json",	// 받는 데이터 형태 
    	    	    colNames:['CODE_TYPE','CODE', 'ITEM1', 'ITEM2', 'ITEM3', 'ITEM4', 'ITEM5', 'REMARK1', 'REMARK2', 'COMMENTS'],	//컬럼명
    	    	    colModel:
    	    	    [
    	    	   	 	 { name: 'CODE_TYPE', index: 'CODE_TYPE', width: '10', align:"center"},
    	    		     { name: 'CODE', index: 'CODE', width: '10', align:"center"},
    	    		     { name: 'ITEM1', index: 'ITEM1', width: '10', align: "center" },
    	    		     { name: 'ITEM2', index: 'ITEM2', width: '10', align: "center" },
    	    		     { name: 'ITEM3', index: 'ITEM3', width: '10', align: "center" },
    	    		     { name: 'ITEM4', index: 'ITEM4', width: '10', align: "center" },
    	    		     { name: 'ITEM5', index: 'ITEM5', width: '10', align: "center" },
    	    		     { name: 'REMARK1', index: 'REMARK1', width: '10', align: "center" },
    	    		     { name: 'REMARK2', index: 'REMARK2', width: '10', align: "center" },
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
    	    	      jQuery('#lisc002DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
    	    	  	},	// loadComplete END   
    	    	  	
    	    	  	
    	    	  	
    	    		// Grid3
    	    	  	onSelectRow: function(rowid){
    	    	  		$('#lisc002DTO').getRowData(rowid);
    	    	     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
    	    	     	var rowid, code;
    	    	     	rowid  = $("#lisc002DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
    	    	        code = $("#lisc002DTO").jqGrid('getRowData', rowid).CODE;   // 선택한 열중에서 grid내의 정보를 가져온다.
    	    	        console.log(code);
    	    	        $("#lisc003DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
    	    	        $('#lisc003DTO').jqGrid({
    	    	        	url: "/oneGridC003.do",	// 서버주소 
    	    	    	    reordercolNames:true,
    	    	    	    postData : { type: code }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
    	    	    	    mtype:'POST',	// 전송 타입
    	    	    	    datatype : "json",	// 받는 데이터 형태 
    	    	    	    colNames:['CODE_TYPE','CODE', 'ITEM1', 'ITEM2', 'ITEM3', 'ITEM4', 'ITEM5', 'REMARK1', 'REMARK2', 'COMMENTS'],	//컬럼명
    	    	    	    colModel:
    	    	    	    [
    	    	    	   	 	 { name: 'CODE_TYPE', index: 'CODE_TYPE', width: '10', align:"center"},
    	    	    		     { name: 'CODE', index: 'CODE', width: '10', align:"center"},
    	    	    		     { name: 'ITEM1', index: 'ITEM1', width: '10', align: "center" },
    	    	    		     { name: 'ITEM2', index: 'ITEM2', width: '10', align: "center" },
    	    	    		     { name: 'ITEM3', index: 'ITEM3', width: '10', align: "center" },
    	    	    		     { name: 'ITEM4', index: 'ITEM4', width: '10', align: "center" },
    	    	    		     { name: 'ITEM5', index: 'ITEM5', width: '10', align: "center" },
    	    	    		     { name: 'REMARK1', index: 'REMARK1', width: '10', align: "center" },
    	    	    		     { name: 'REMARK2', index: 'REMARK2', width: '10', align: "center" },
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
    	    	    	  	}	// loadComplete END   
    	  				})
    	    	  	}

    	    	})	        
    	  	}
    	  	
		});	
    }
	$("#search").change(function(){ searchGrid(); }) // searchGrid 함수 호출
	
	
	$("#btn_search").on("click",function(){ searchGrid(); }) // searchGrid 함수 호출
	
	
	// Grid1 lisc001DTO
	function lisc001(){
		$("#lisc001DTO").jqGrid("GridUnload");
		$('#lisc001DTO').jqGrid({  // id
		    url: "/oneGridC.do",	// 서버주소 
		    reordercolNames:true,
		    postData : { type:"A" }, // 보낼 파라미터
		    mtype:'POST',	// 전송 타입
		    datatype : "json",	// 받는 데이터 형태 
		    colNames:['코드','코드명', '비고'],	//컬럼명
		    colModel:
		    [
		   	 	 { name: 'CODE_TYPE', index: 'CODE_TYPE', width: '40', align:"center"},
			     { name: 'CODE_TYPE_NAME', index: 'CODE_TYPE_NAME', width: '40', align:"center"},
			     { name: 'COMMENTS', index: 'COMMENTS', width: '10', align: "center"/* , type: "textarea", editable: true, editoptions: {rows:"2",cols:"10"} */}
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
		  		$('#lisc001DTO').getRowData(rowid);
		     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
		     	var rowid, codetype;
		     	rowid  = $("#lisc001DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
		        codetype = $("#lisc001DTO").jqGrid('getRowData', rowid).CODE_TYPE;   // 선택한 열중에서 grid내의 정보를 가져온다.
		        console.log(codetype);
		        $("#lisc002DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
		        $('#lisc002DTO').jqGrid({
		        	url: "/oneGridC002.do",	// 서버주소 
		    	    reordercolNames:true,
		    	    postData : { type: codetype }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
		    	    mtype:'POST',	// 전송 타입
		    	    datatype : "json",	// 받는 데이터 형태 
		    	    colNames:['CODE_TYPE','CODE', 'ITEM1', 'ITEM2', 'ITEM3', 'ITEM4', 'ITEM5', 'REMARK1', 'REMARK2', 'COMMENTS'],	//컬럼명
		    	    colModel:
		    	    [
		    	   	 	 { name: 'CODE_TYPE', index: 'CODE_TYPE', width: '10', align:"center"},
		    		     { name: 'CODE', index: 'CODE', width: '10', align:"center"},
		    		     { name: 'ITEM1', index: 'ITEM1', width: '10', align: "center" },
		    		     { name: 'ITEM2', index: 'ITEM2', width: '10', align: "center" },
		    		     { name: 'ITEM3', index: 'ITEM3', width: '10', align: "center" },
		    		     { name: 'ITEM4', index: 'ITEM4', width: '10', align: "center" },
		    		     { name: 'ITEM5', index: 'ITEM5', width: '10', align: "center" },
		    		     { name: 'REMARK1', index: 'REMARK1', width: '10', align: "center" },
		    		     { name: 'REMARK2', index: 'REMARK2', width: '10', align: "center" },
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
		    	      jQuery('#lisc002DTO').jqGrid('setSelection','1');  // jqgrid의 로드가 완료되면 1번째 row를 선택
		    	  	},	// loadComplete END   
		    	  	
		    	  	
		    	  	
		    		// Grid3
		    	  	onSelectRow: function(rowid){
		    	  		$('#lisc002DTO').getRowData(rowid);
		    	     	//선택한 열의 데이터 가져오기  -  var selRowData = $("#lisc001DTO").getRowData(rowid);
		    	     	var rowid, code;
		    	     	rowid  = $("#lisc002DTO").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값
		    	        code = $("#lisc002DTO").jqGrid('getRowData', rowid).CODE;   // 선택한 열중에서 grid내의 정보를 가져온다.
		    	        console.log(code);
		    	        $("#lisc003DTO").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
		    	        $('#lisc003DTO').jqGrid({
		    	        	url: "/oneGridC003.do",	// 서버주소 
		    	    	    reordercolNames:true,
		    	    	    postData : { type: code }, // 보낼 파라미터. 로그인 했던것처럼 파라미터값 가져오기
		    	    	    mtype:'POST',	// 전송 타입
		    	    	    datatype : "json",	// 받는 데이터 형태 
		    	    	    colNames:['CODE_TYPE','CODE', 'ITEM1', 'ITEM2', 'ITEM3', 'ITEM4', 'ITEM5', 'REMARK1', 'REMARK2', 'COMMENTS'],	//컬럼명
		    	    	    colModel:
		    	    	    [
		    	    	   	 	 { name: 'CODE_TYPE', index: 'CODE_TYPE', width: '10', align:"center"},
		    	    		     { name: 'CODE', index: 'CODE', width: '10', align:"center"},
		    	    		     { name: 'ITEM1', index: 'ITEM1', width: '10', align: "center" },
		    	    		     { name: 'ITEM2', index: 'ITEM2', width: '10', align: "center" },
		    	    		     { name: 'ITEM3', index: 'ITEM3', width: '10', align: "center" },
		    	    		     { name: 'ITEM4', index: 'ITEM4', width: '10', align: "center" },
		    	    		     { name: 'ITEM5', index: 'ITEM5', width: '10', align: "center" },
		    	    		     { name: 'REMARK1', index: 'REMARK1', width: '10', align: "center" },
		    	    		     { name: 'REMARK2', index: 'REMARK2', width: '10', align: "center" },
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
		    	    	  	}	// loadComplete END   
		  				})
		    	  	}

		    	})	        
		  	}
		 
		})
	}
	
	lisc001();
	
		

	// addrow, deleterow
    $("#btn_add_row").click(function(){
        var newRowData = {};
        var grid = $("#lisc001DTO");
        var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
        grid.jqGrid("addRowData", newRowId, newRowData, "first");
    })  
	const btnDeleteRow = document.getElementById('btn_delete_row');
	btnDeleteRow.addEventListener('click', function() {
    	var grid = $("#lisc001DTO");
    	var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
    	if (selectedRowId) {grid.jqGrid('delRowData', selectedRowId);
    	} else {alert('Please select a row to delete.');}
	});

    $("#btn_add_row2").click(function(){
        var newRowData = {};
        var grid = $("#lisc002DTO");
        var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
        grid.jqGrid("addRowData", newRowId, newRowData, "first");
    })  
  	const btnDeleteRow2 = document.getElementById('btn_delete_row2');
	btnDeleteRow2.addEventListener('click', function() {
    	var grid = $("#lisc002DTO");
    	var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
    	if (selectedRowId) {grid.jqGrid('delRowData', selectedRowId);
    	} else {alert('Please select a row to delete.');}
	});
    
    $("#btn_add_row3").click(function(){
         var newRowData = {};
         var grid = $("#lisc003DTO");
         var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
         grid.jqGrid("addRowData", newRowId, newRowData, "first");
    })  
	const btnDeleteRow3 = document.getElementById('btn_delete_row3');
	btnDeleteRow3.addEventListener('click', function() {
    	var grid = $("#lisc003DTO");
    	var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
    	if (selectedRowId) {grid.jqGrid('delRowData', selectedRowId);
    	} else {alert('Please select a row to delete.');}
	});
	
	//clear
	$("#clear").on("click", function() {
        // #search input 상자의 내용을 지움
        $("#search").val("");
        // #lisc001DTO 그리드를 초기화하고 데이터 리로드
        console.log('a');
        lisc001();
    });
	
	
	// modal
	const modal1 = document.getElementById('myModal');
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
	
	
	
	</script>
</body>
</html>