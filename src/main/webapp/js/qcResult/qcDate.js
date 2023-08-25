function dateConvert(today) {
    var year = today.getFullYear();
    var month = String(today.getMonth() + 1).padStart(2, '0'); // 0-based month
    var day = String(today.getDate()).padStart(2, '0');
    var formattedDate = year + '-' + month + '-' + day;
    return formattedDate;
}

function dateInit() {
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