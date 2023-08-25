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