
const saveGrid = function(){
    if (!confirm("저장하시겠습니까?" + serverData.length + '행이 삭제/변경 됩니다.')) 
        return;
    
    $.ajax({
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        url: '/qcResultSave.do',
        data: JSON.stringify(serverData),
        success: function (res) {},
        error: function (err) {}
    })
}

const deleteGrid = function(){
    var rowIds = $("#list1").getGridParam("selarrrow");
    for (var i = rowIds.length - 1; i >= 0; i--) {
        var selRowData = $("#list1").getRowData(rowIds[i]);
        selRowData.flag = 'D';
        selRowData.no = +rowIds[i];
        $("#list1").delRowData(rowIds[i]);

        if (serverData.some(m => m.no === selRowData.no)) {
            // 이미 해당 no 값이 존재하는 경우, 해당 객체를 대체하거나 다른 작업 수행
            const index = serverData.findIndex(m => m.no === selRowData.no);
            if (index !== -1) {
                serverData[index] = selRowData;
            }
        } else {
            // 해당 no 값이 존재하지 않는 경우, 새로운 객체 추가
            serverData.push(selRowData);
        }
    }
}

const checkPartChangeRendering = function(e){
    const data = e
        .target
        .value
        .substring(1, 4);
    var $qccodeInput = document.querySelector(".qccode-input");
    $qccodeInput.value = '';
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        url: '/qcCode.do',

        success: function (res) {
            var selectElement = document.querySelector(".substance-select");

            // Clear existing options
            selectElement.innerHTML = '<option value="">(전체)</option>';

            // Populate options using the received JSON data
            res
                .qcCodeList
                .forEach(function (item) {
                    var option = document.createElement("option");
                    option.value = item.item1;
                    option.textContent = item.item1;
                    selectElement.appendChild(option);
                });
        },
        error: function (err) {}
    })
}


const substanceChangeRendering = function(e){
    const data = e.target.value;
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        url: '/findOneQcCode.do',

        success: function (res) {
            var $qccodeInput = document.querySelector(".qccode-input");

            $qccodeInput.value = res.qcCode;

        },
        error: function (err) {}
    })
}
