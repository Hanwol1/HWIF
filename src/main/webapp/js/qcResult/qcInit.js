let serverData = [];
let selectedCell = null;
const $modal = $(".modal__background");

function init() {
    dateInit();
}
$(document).ready(function () {

    init();
    drawJqgrid();

});