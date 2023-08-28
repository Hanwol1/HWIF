function sendConvertObject(object) {

    const $qcInOut = $("input[name='check-date']:checked");
    const $ruleResult = $("input[name='check-item']:checked");
    const $jundalPart = document.getElementById('check-part-select');
    const $lotNo = document.getElementById('lotno-input');
    const $장비명 = document.getElementById('check-jangbi-select');
    const $level = document.getElementById('level-select');
    const $물질명 = $('.substance-select');
    const $검사항목 = $('.check-inputbox');

    object.qcInOut = $qcInOut.val();
    object.ruleResult = $ruleResult.val();
    object.jundalPart = $jundalPart
        .value
        .substring(1, 4);
    object.lotNo = $lotNo.value;
    object.장비명 = $장비명.value;
    object.level = $level.value;
    object.물질명 = $물질명.val();
    object.검사항목 = $검사항목.val();
    return object;
}

// 체크된 박스의 로우 정보들을 배열로 반환하는 함수
const multiselectCheckboxChecked = () => {
    var obj = $("#list1");
    var idx = obj.jqGrid('getGridParam', 'selarrrow');
    const arr = new Array();
    for (var i = 0; i < idx.length; i++) {
        var rowData = $("#list1").jqGrid("getRowData", idx[i]);
        arr.push(rowData);
    }
    return arr;
}

const drawJqgrid = () => {

    $('#list1').jqGrid("GridUnload");

    const formData = {
        fromDate: document
            .querySelector('.check-inputbox1')
            .value,
        toDate: document
            .querySelector('.check-inputbox2')
            .value
    };

    const convertFormData = sendConvertObject(formData);


    function getTextWidth(text) {
        var canvas = document.createElement("canvas");
        var context = canvas.getContext("2d");
        context.font = "12px Arial"; // 폰트 및 크기를 설정해주어야 정확한 계산이 가능합니다.
        var metrics = context.measureText(text);
        return metrics.width;
    }

    $.ajax({
        type: "POST",
        url: "/qcResultFindAll.do",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(convertFormData),
        error: function () {
        },
        success: function (data) {

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
                    formatoptions: {
                        value: 'N:불용'
                    },
                    edittype: 'select',
                    editoptions: {
                        value: 'N:불용'
                    }
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

            // jqGrid 초기화
            $("#list1").jqGrid({
                url: "/qcResultFindAll.do", // 서버주소
                reordercolNames: true,
                postData: convertFormData, // 보낼 파라미터
                mtype: 'POST', // 전송 타입
                datatype: "json", // 받는 데이터 형태
                ajaxGridOptions: {
                    contentType: "application/json; charset=UTF-8"
                },
                serializeGridData: function (postData) {
                    return JSON.stringify(postData);
                },
                colNames: colNames,
                colModel: colModel,
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
                loadonce: true,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadComplete: function (data) {
              
                },
                onSelectRow: function (rowid) {
                  
                },
                /* 더블클릭시 수정 가능*/
                ondblClickRow: function (rowid, iRow, iCol) {

                    const colModels = $(this).getGridParam('colModel');
                    const colName = colModels[iCol].name;

                    /* prog_id(PK), chkbox 수정불가 */
                    if (!(colName == 'prog_id' || colName == 'chkbox' || colName === 'QC물질명' || colName === '검사명' || colName === 'Level' || colName === 'LotNo' || colName === 'CumSD' || colName === 'FixedCV' || colName === 'CumMean' || colName === 'CumCV' || isDateValid(colName) || colName === '장비명')) {
                        $(this).setColProp(colName, {editable: true}); //gridColModel의 name값을 수정가능하게 해줌
                        $(this).editCell(iRow, iCol, true);
                    }
                },

                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    var selRowData = $("#list1").getRowData(rowid);
                    selRowData[cellname] = value;
                    selRowData.no = +rowid;

                    if (cellname === 'FixedMean') {
                        selRowData.FixedCV = selRowData.FixedSD / value * 100;
                    } else if (cellname === 'FixedSD') {
                        selRowData.FixedCV = value / selRowData.FixedMean * 100;
                    }
                    const roundedNumber = selRowData
                        .FixedCV
                        .toFixed(2);
                    $('#list1').jqGrid('setCell', rowid, 'FixedCV', roundedNumber);
                    $('#list1').jqGrid('saveRow', rowid, true, 'clientArray');
                    $("#list1").trigger("reloadGrid");
                    if (serverData.some(m => m.no === selRowData.no)) {
                        const index = serverData.findIndex(m => m.no === selRowData.no);
                        if (index !== -1) {
                            serverData[index] = selRowData;
                        }
                    } else {
                        // 해당 no 값이 존재하지 않는 경우, 새로운 객체 추가
                        selRowData.flag = 'U';
                        serverData.push(selRowData);
                    }

                }
            });
        },
        onSelectRow: function (rowid) {
        }

    });

    $("#export").click(function () {
        // jqGrid의 데이터 테이블을 선택하여 table2excel 라이브러리 사용
        $("#list1").table2excel({
            name: "Worksheet Name", filename: "data", // 내보낼 Excel 파일명
            fileext: ".xlsx" // 파일 확장자
        });
    });
}
