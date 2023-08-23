<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
<script src="https://cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>
<title>QC결과조회 (일별)</title>
<link rel="stylesheet" href="./css/qcResult.css">
</head>
<body>
    <div class="header">
        <section>
            <div class="container">
                <div class="check-title">검사일</div>
                <input class="check-inputbox1" type="date" >
                <div class="check-wave"> ~ </div>
                <input class="check-inputbox2" type="date" >
                <input type="radio" name="check-date" value="" id="check-total" >
                <label for="check-total">전체</label>
                <input type="radio" name="check-date" value="I" id="check-inside" checked>
                <label for="check-inside" class="check-inside">내부</label>
                <input class="check-external" type="radio" name="check-date" value="O" id="check-external">
                <label for="check-external">외부</label>
             
            <div class="check-part-title">검사파트</div>
            <select class="check-part-select" id="check-part-select">
                <option value="">(전체)</option>
                <c:forEach var="item" items="${gumsapartList}">
                    <option value="${item}">${item}</option>
                </c:forEach>
            </select>
            <div class="lotno-title">Lot No</div>
            <input type="text" id="lotno-input">
            <div class="level-title">Level</div>
            <select class="level-select" id="level-select">
                <option value="">(전체)</option>
                <c:forEach var="item" items="${levelList}">
                    <option value="${item}">${item}</option>
                </c:forEach>
            </select>
            </div>
            <div class="button-container">
                <button id="export" class="excel-btn">Excel</button>
                <button class="save-btn">저 장</button>
            </div>
        </section>
        <section>
            <div class="container">
                <div class="check-item-title">검사항목</div>
                <input class="check-inputbox" type="text">
                <button class="check-item-button"></button>
                <input type="radio" name="check-item" value="" id="check-item-total" >
                <label for="check-item-total">전체</label>
                <input type="radio" name="check-item" value="accept" id="check-item-accept" checked>
                <label for="check-item-accept">Accept</label>
                <input type="radio" name="check-item" value="reject" id="check-item-reject">
                <label for="check-item-reject">Reject</label>
                <div class="substance-title">물질명</div>
                <select class="substance-select">
                    <option value="">(전체)</option>
                        <c:forEach var="item" items="${qcCodeList}">
                            <option value="${item.item1}">${item.item1}</option>
                        </c:forEach>
                </select>
                <div>QC 코드</div>
                <input style="background-color: #fff;" class="qccode-input" type="text" disabled>
                <div class="check-jangbi-title">검사장비</div>
                <select id="check-jangbi-select" class="check-jangbi-select">
                    <option value="">(전체)</option>
                    <c:forEach var="item" items="${jangbiList}">
                        <option value="${item}">${item}</option>
                    </c:forEach>
                </select>
           </div>
            <div class="button-container">
                <button class="find-btn">조 회</button>
                <button class="delete-btn">삭 제</button>
            </div>
        </section>
    </div>
    <div class="body">
        <table id="list1" ></table>
    </div>
    <div id="footer" class="footer">
        <div class="footer-header">
            <input type="radio" name="graph" id="regular" value="regular" checked>
            <label for="regular">정규그래프</label>
            <input type="radio" name="graph" id="actual" value="actual">
            <label for="actual">실측그래프</label>
            <button onclick="createChartRendering()" class="graph-view">그래프 표시</button>
            <button onclick="onclickPrint()" class="graph-output">그래프 출력</button>
        </div>
        <div class="chart-container" id="chart-container">
            <!-- <canvas id="myChart" style="height: 150px; width:100%;"></canvas> -->
        </div>
        
    </div>
    <!-- <script src="./js/qcResult.js" defer></script> -->
    <script>
        let serverData = [];
        
        $("input[name='check-item']").change(function() {
            object.ruleResult = $(this).val(); // 선택된 라디오 버튼의 값을 갱신
        });

        $("input[name='check-date']").change(function() {
            object.ruleResult = $(this).val(); // 선택된 라디오 버튼의 값을 갱신
        });

        // 저장 처리 로직, 임시
        $('.save-btn').click(function(){
            console.log('저장버튼 눌렀습니다.');
            console.log(serverData);

            if(!confirm("저장하시겠습니까?" + serverData.length + '행이 삭제/변경 됩니다.')) return;


            $.ajax({
                type: 'POST',
                contentType : "application/json; charset=utf-8",
                url: 'http://localhost:8888/qcResultSave.do',
                data: JSON.stringify(serverData),
                success: function(res){ 

                },
                error: function(err){

                }
            })


        })

        // 삭제 처리 로직, 8-22 작업중
        $('.delete-btn').click(function(){
            console.log('삭제버튼 눌렸다');

            var rowIds = $("#list1").getGridParam("selarrrow");
            for(var i = rowIds.length-1; i>=0; i--){
                var selRowData = $("#list1").getRowData(rowIds[i]);
                selRowData.flag = 'D';
                selRowData.no = +rowIds[i];
                $("#list1").delRowData(rowIds[i]);

                
                if (serverData.some(m => m.no === selRowData.no)) {
                    // 이미 해당 no 값이 존재하는 경우, 해당 객체를 대체하거나 다른 작업 수행
                    const index = serverData.findIndex(m =>  m.no === selRowData.no);
                    if (index !== -1) {
                        serverData[index] = selRowData;
                    }
                } else {
                    // 해당 no 값이 존재하지 않는 경우, 새로운 객체 추가
                    serverData.push(selRowData);
                }
                
            }
            console.log(serverData);
        })

        function sendConvertObject(object){

            const $qcInOut = $("input[name='check-date']:checked");
            const $ruleResult = $("input[name='check-item']:checked");
            const $jundalPart = document.getElementById('check-part-select');
            const $lotNo = document.getElementById('lotno-input');
            const $장비명 = document.getElementById('check-jangbi-select');
            const $level = document.getElementById('level-select');



            object.qcInOut = $qcInOut.val();
            object.ruleResult = $ruleResult.val();
            object.jundalPart = $jundalPart.value.substring(1,4);
            object.lotNo = $lotNo.value;
            object.장비명 = $장비명.value;
            object.level = $level.value;
            console.log(object);
            return object;
        }
       
       $('.substance-select').change(function(e){
        //    const 

           console.log(e.target.value);
       });
        

        window.onbeforeprint = function () { 
            

            // 프린트 할 영역 필터링 
            $(".header").css("display", "none"); 
            $(".body").css("display", "none"); 
            // $(".chart-container").css("float", "left"); 
            $(".chart-container").css("overflow", "visible"); 
            $(".chart-container").css("height", "auto");
        }; 

        function onclickPrint() { 
             window.print(); 
        };
        window.onafterprint = function () { 
      
            $(".header").css("display", "block"); 

            $(".body").css("display", "block"); 
            $(".chart-container").css("display", "block"); 
            $(".chart-container").css("overflow", "auto"); 
            $(".chart-container").css("height", "165px");

  };       


        // 체크된 박스의 로우 정보들을 배열로 반환하는 함수
        const multiselectCheckboxChecked = () => {
            var obj = $("#list1");
            var idx = obj.jqGrid('getGridParam', 'selarrrow');
            const arr = new Array();
            for(var i = 0; i < idx.length;i++)
            {
                var rowData = $("#list1").jqGrid("getRowData", idx[i]);
                // console.log(rowData);
                arr.push(rowData);
            }
            return arr;
     }


     function dateConvert(today){
            var year = today.getFullYear();
            var month = String(today.getMonth() + 1).padStart(2, '0'); // 0-based month
            var day = String(today.getDate()).padStart(2, '0');
            var formattedDate = year + '-' + month + '-' + day;
            return formattedDate;
     }

     function dateInit(){
        $checkInputbox1 = document.querySelector('.check-inputbox1');
        $checkInputbox2 = document.querySelector('.check-inputbox2');
        var today = new Date();
        var thirtyDaysAgo = new Date(today);
        thirtyDaysAgo.setDate(today.getDate() - 30);
        $checkInputbox1.value = dateConvert(thirtyDaysAgo);
        $checkInputbox2.value = dateConvert(today);   
     }

     function isDateValid(dateString) {
        // Date 객체 생성 시 유효한 날짜인지 확인
        const date = new Date(dateString);
        return !isNaN(date) && date instanceof Date;
    }



     $('.find-btn').click(function(){
        
        drawJqgrid();
        serverData = [];
     });


     const drawJqgrid = () => {
        
        $('#list1').jqGrid("GridUnload");

        const formData = {
            fromDate : document.querySelector('.check-inputbox1').value,
            toDate : document.querySelector('.check-inputbox2').value
        };
        
        const convertFormData = sendConvertObject(formData);
        console.log('formData입니다 ------------');
        console.log(convertFormData);
        function getTextWidth(text) {
            var canvas = document.createElement("canvas");
            var context = canvas.getContext("2d");
            context.font = "12px Arial"; // 폰트 및 크기를 설정해주어야 정확한 계산이 가능합니다.
            var metrics = context.measureText(text);
            return metrics.width;
        }

        $.ajax({
            type: "POST",
            url: "http://localhost:8888/qcResultFindAll.do",
            dataType: "json",
            contentType : "application/json; charset=utf-8",
            data: JSON.stringify(convertFormData),
            error: function() {
            console.log('통신실패!!');
            },
            success: function(data) {
            console.log("통신데이터 값 : ");
            console.log(data);
            

            var dynamicColumns = Object.keys(data.rows[0]);
            var colNames = ['플래그'].concat(dynamicColumns);
            var colModel = [
                {
                    name: 'iud',
                    index: 'iud',
                    width: '20',
                    align: 'center',
                    hidden: true,
                    formatter: 'select',
                    formatoptions: { value: 'N:불용' },
                    edittype: 'select',
                    editoptions: { value: 'N:불용' }
                }
            ];

            // 동적 컬럼을 컬럼 모델에 추가
            for (var i = 0; i < dynamicColumns.length; i++) {
                var columnWidth = getTextWidth(dynamicColumns[i]) + 10; 
                


                colModel.push({
                    name: dynamicColumns[i],
                    index: dynamicColumns[i],
                    width: columnWidth,
                    align: 'center',
                    hidden: false,
                    // editable : true
                });
            }

            console.log(colNames);
            console.log(colModel);
            // jqGrid 초기화
            $("#list1").jqGrid({
                url: "http://localhost:8888/qcResultFindAll.do",	// 서버주소 
                reordercolNames:true,
                postData:convertFormData, // 보낼 파라미터
                mtype:'POST',	// 전송 타입
                datatype : "json",	// 받는 데이터 형태 
                ajaxGridOptions: { contentType: "application/json; charset=UTF-8" },
                serializeGridData: function (postData) { return JSON.stringify(postData); },
                colNames : colNames,
                colModel : colModel,
                jsonReader: {
                    repeatitems: false,
                    root: 'rows',
                    records: 'records'
                },
                autowidth: false,
                shrinkToFit: false,
                height: 'auto',
                // loadtext: '자료 조회중입니다. 잠시만 기다리세요...',
                emptyrecords: 'Nothing to display',
                rowNum: 10000,
                rownumbers: true,
                gridview: true,
                multiselect: true,
                
                sortable: true,
                loadonce : true,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadComplete: function (data) {
                    console.log(data);
                },
                onSelectRow: function (rowid) {
                    console.log(rowid);
                },
                /* 더블클릭시 수정 가능*/
                ondblClickRow : function (rowid, iRow, iCol){
                
                const colModels = $(this).getGridParam('colModel'); 
                const colName = colModels[iCol].name;
                
                /* prog_id(PK), chkbox 수정불가 */
                if(!(colName=='prog_id'||colName=='chkbox'
                ||colName==='QC물질명' || colName === '검사명' || colName === 'Level' || colName === 'LotNo' 
                ||colName==='CumSD' || colName==='FixedCV' || colName === 'CumMean' ||colName === 'CumCV'
                || isDateValid(colName) ||colName === '장비명'
                )){ 
                    $(this).setColProp(colName, {editable : true}); //gridColModel의 name값을 수정가능하게 해줌 
                    $(this).editCell(iRow, iCol, true); 
                }
                },

                afterSaveCell : function(rowid, cellname, value, iRow, iCol){

                        console.log(value);
                        var selRowData = $("#list1").getRowData(rowid);
                        selRowData[cellname] = value;
                        selRowData.no = +rowid;

                        if(cellname === 'FixedMean'){
                            selRowData.FixedCV = selRowData.FixedSD / value * 100;
                        } else if(cellname === 'FixedSD') {
                            selRowData.FixedCV = value / selRowData.FixedMean * 100; 
                        }                       
                        const roundedNumber = selRowData.FixedCV.toFixed(2);
                        $('#list1').jqGrid('setCell', rowid, 'FixedCV', roundedNumber);
                        $('#list1').jqGrid('saveRow', rowid, true, 'clientArray');
                        $("#list1").trigger("reloadGrid");
                        console.log('------------');
                        console.log(selRowData);
                        if (serverData.some(m => m.no === selRowData.no)) {
                            const index = serverData.findIndex(m =>  m.no === selRowData.no);
                            if (index !== -1) {
                                serverData[index] = selRowData;
                            }
                        } else {
                            // 해당 no 값이 존재하지 않는 경우, 새로운 객체 추가
                            selRowData.flag = 'U';
                            serverData.push(selRowData);
                        }
                    
                    },
                    
    
                });

            //     afterEditCell : function(rowid, cellname, value, iRow, iCol){
                        
            //         var cellValue = $("#list1").getCell(rowid, cellname);
            //         var selectedValue = $(cellValue).val();
                    
            //         var selRowData = $("#list1").getRowData(rowid);
            //         selRowData[cellname] = selectedValue;
            //         selRowData.no = rowid;
            //         if (serverData.some(m => m.no === selRowData.no)) {
            //             const index = serverData.findIndex(m =>  m.no === selRowData.no);
            //             if (index !== -1) {
            //                 serverData[index] = selRowData;
            //             }
            //         } else {
            //             // 해당 no 값이 존재하지 않는 경우, 새로운 객체 추가
            //             selRowData.flag = 'U';
            //             serverData.push(selRowData);
            //         }
                
            //     },
                

            // });
        },
        onSelectRow: function (rowid) {
            console.log(rowid);
            
        }

            
        
        });

        $("#export").click(function() {
            // jqGrid의 데이터 테이블을 선택하여 table2excel 라이브러리 사용
            $("#list1").table2excel({
                name: "Worksheet Name",
                filename: "data", // 내보낼 Excel 파일명
                fileext: ".xlsx" // 파일 확장자
            });
        });
     }

    function init(){
        dateInit();
    }


    


    $(document).ready(function() {
        
        init();
        drawJqgrid();
       
    });




    const createChartRendering = () => {
        const $chartContainer = document.getElementById('chart-container');
        $chartContainer.innerHTML = '';

        const arr = multiselectCheckboxChecked();

        console.log(arr);

        for (let i = 0; i < arr.length; i++) {
            const datatimeRegexp = /[0-9]{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
            const xValues = [];
            const yValues = [];

            for (const [key, value] of Object.entries(arr[i])) {
                if (!datatimeRegexp.test(key)) {
                    continue;
                }
                if(!value) continue;

                xValues.push(key);
                yValues.push(value);
            }
            // console.log(xValues);
            // console.log(yValues);
            const {LotNo, 검사명} = arr[i]; 
            const name = "myChart" + i;
            // console.log(gumsa_name1);
            const chartCanvas = document.createElement('canvas');
            chartCanvas.setAttribute("id", name);
            chartCanvas.style.height = '150px';
            chartCanvas.style.width = '100%';
            $chartContainer.append(chartCanvas);

            const ctx = chartCanvas.getContext('2d');
            new Chart(ctx, {
                type: "line",
                data: {
                    labels: xValues,
                    datasets: [{
                        label: LotNo,
                        fill: false,
                        lineTension: 0,
                        backgroundColor: "rgba(0,0,255,1.0)",
                        borderColor: "rgba(0,0,255,0.1)",
                        data: yValues
                    }]
                },
                options: {
                	plugins: {
                        title: {
                            display: true,
                            text: 검사명,
                            position: 'left'
                        }
                    },
                    legend: { display: false },
                    scales: {
                        yAxes: [{ ticks: { min: 0, max: 450 } }],
                    }
                }
            });
        }
    }

    </script>
</body>
</html>