<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 첫번째줄은 JSP 페이지의 지시어이다. 이것은 해당 JSP 페이지의 속성을 설정한다. language 속성은 페이지에서 사용할 Java 언어를 정의하며, contentType은 출력되는 콘텐츠의 유형과 문자 인코딩을 설정한다. -->
<!-- 두번째줄은 JSP 페이지에서 JSTL(Core JSP Standard Tag Library)을 사용하기 위한 태그 라이브러리를 선언하는 부분이다. JSTL은 JSP 페이지에서 반복문, 조건문 등과 같은 일반적인 로직을 처리하기 위한 태그들을 제공한다. -->
<!-- prefix는 사용할 태그의 접두사를 정의하고, uri 는 해당 태그 라이브러리의 위치를 지정한다. -->


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <link rel="stylesheet" type="text/css" href="/css/loginA.css" />
</head>
<body>
  <div class="loginHome">
    <div class="loginInput">
    <div class="loginbox">
      <div class="loginHead">
        <h1>로그인</h1>
      </div>
      <div class="loginIdBox">
        <input type="text" class="IdBox" placeholder="ID" id="loginId">
      </div>
      <div class="loginPwBox">
        <input type="password" class="IdBox" placeholder="PW" id="loginPw">
      </div>
      <div class="loginIdPw">
        <div>
          <input type="checkbox" aria-label="Checkbox demo" /> 아이디 저장
        </div>
        <div><a href="http://naver.com">비밀번호 찾기</a></div>
      </div>
      <div id="loginButton">
        <button class="btn-icon-l btn-p" id="loginBtn">
          로그인
        </button>
      </div>
      <div id="userJoin">
        <button class="btn-icon-l btn-dk" onclick="handleOpen()">
          회원가입
        </button>
      </div>
      </div>
    </div>
    <div class="loginRightImg"></div>
  </div>

  <!-- Modal  -->
  <div class="modal" id="myModal">
    <div class="boxAll">
      
      <div class="divAll">
        <div class="divUp">
          <h2 class="modal-modal-title">회원가입</h2>
          <div class="divUpOne">
            <div class="divUpOneUserId">아이디</div>
            <input type="text" class="filled-basic" placeholder="ID" id="userId">
          </div>
          <div class="divUpTwo">
            <div class="divUpTwoPassword">비밀번호</div>
            <input type="password" class="filled-basic" placeholder="비밀번호" id="userPw">
          </div>
          <div class="divUpThree">
            <div class="divUpThreePassCheck">비밀번호 확인</div>
            <input type="password" class="filled-basic" placeholder="비밀번호 확인" id="userPwConfirm">
          </div>
          
          <div class="divUpButton">
            <div class="divUpButtonSave">
              <button class="divUpButtonSave1" id="joinBtn">회원가입</button>
            </div>
            <div class="divUpButtonClose">
  				<button class="divUpButtonClose1" onclick="handleClose()">나가기</button>
			</div>
          </div>
        </div>
        <div class="divDown">192.168.0.80</div>
      </div>
    </div>
  </div>
   <script src="/js/loginA.js"></script>
</body>
</html>


