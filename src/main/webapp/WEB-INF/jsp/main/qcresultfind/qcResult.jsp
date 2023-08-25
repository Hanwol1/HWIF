<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <div class="check-container">
                    <div class="check-item-title">검사항목</div>
                    <input class="check-inputbox" type="text">
                    <button class="check-item-button"></button>
                </div>
                <input type="radio" name="check-item" value="" id="check-item-total" >
                <label for="check-item-total">전체</label>
                <input type="radio" name="check-item" value="accept" id="check-item-accept" checked>
                <label for="check-item-accept">Accept</label>
                <input type="radio" name="check-item" value="reject" id="check-item-reject">
                <label for="check-item-reject">Reject</label>
                <div class="substance-title">물질명</div>
                <select class="substance-select">
                    <option value="">(전체)</option>
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
    <div class="modal__background">
        <div class="gumsa-modal">
            <div class="flex gumsa-modal-title">
                <div class="ml">검사 코드</div>
                <div class="ml">검사 항목</div>
            </div>
            <div class="overflow-A gumsa-modal-display" id="gumsaContainer">
                <c:forEach var="item" items="${gumsaList}">
                    <div class="flex cell modal-row">
                        <div class="code ml">${item.code}</div>
                        <div class="item ml">${item.item1}</div>
                    </div>
                </c:forEach>
            </div>
            <div class="gumsa-modal-btn flex space-around">
                <button id="confirmBtn">확인</button>
                <button id="closeBtn">닫기</button>
            </div>
        </div>
    </div>
    <script src="./js/qcResult/qcAjax.js" defer></script>
    <script src="./js/qcResult/qcChart.js" defer></script>
    <script src="./js/qcResult/qcDate.js" defer></script>
    <script src="./js/qcResult/qcEvent.js" defer></script>
    <script src="./js/qcResult/qcInit.js" defer></script>
    <script src="./js/qcResult/qcJqgrid.js" defer></script>
    <script src="./js/qcResult/qcPrint.js" defer></script>
    
</body>
</html>