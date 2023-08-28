

// 저장 처리 로직, 임시
$('.save-btn').click(function () {
    saveGrid();
})

// 삭제 처리 로직, 8-22 작업중
$('.delete-btn').click(function () {
    deleteGrid();
})

// 검사파트 변경했을 때 하위 셀렉트 렌더링
$('.check-part-select').change(function (e) {
    checkPartChangeRendering(e);
})


$('.substance-select').change(function (e) {
    substanceChangeRendering(e);
});

$('.check-item-button').click(function (e) {
    $modal.addClass("open-modal");
});

$(document).mouseup(function (e) {

    if ($modal.has(e.target).length === 0) {
        $modal.removeClass("open-modal");
    }
});

$(".cell").on("click", function () {
    // Remove 'selected' class from previously selected cell
    if (selectedCell) {
        selectedCell.removeClass("selected");
    }

    selectedCell = $(this);
    selectedCell.addClass("selected");
});

$("#confirmBtn").on("click", function () {
    if (selectedCell) {
        const code = selectedCell
            .find(".code")
            .text();
        const item = selectedCell
            .find(".item")
            .text();
        selectedCell.removeClass("selected");
        selectedCell = null;
        const $checkInputbox = document.querySelector('.check-inputbox');
        $checkInputbox.value = item;
        $modal.removeClass("open-modal");
    } else {
        alert('선택해주세요');
    }
});

$("#closeBtn").on("click", function () {
    if (selectedCell) {
        selectedCell.removeClass("selected");
        selectedCell = null;
    }
    $modal.removeClass("open-modal");
});

$("input[name='check-item']").change(function () {
    object.ruleResult = $(this).val(); // 선택된 라디오 버튼의 값을 갱신
});

$("input[name='check-date']").change(function () {
    object.ruleResult = $(this).val(); // 선택된 라디오 버튼의 값을 갱신
});

$('.find-btn').click(function () {

    drawJqgrid();
    serverData = [];
});