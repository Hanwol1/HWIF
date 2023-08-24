let open = false;

function handleOpen () {
    open = true;
    let modal = document.getElementById('myModal');
    modal.style.display = 'block'; /* 모달 창을 보이도록 설정합니다. */
};
  
  function handleClose() {
    open = false;
    let modal = document.getElementById('myModal');
    modal.style.display = 'none'; /* 모달 창을 숨깁니다. */
  }

$("#joinBtn").on("click", function(){
	   var id = $('#userId').val();
	   var password = $('#userPw').val();
	   var repassword = $('#userPwConfirm').val();
	   if(id =="" || id == null) {
	      alert("아이디를 입력하세요.");
	      return;
	   } else if(password == "" || password == null) {
	      alert("비밀번호를 입력하세요.");
	      return;
	   } else if(repassword == "" || repassword == null){
	      alert("비밀번호 확인이 필요합니다.");
	      return;
	   }
	   if(password != repassword) {
	      alert("비밀번호가 다릅니다.");
	      return;
	   }
	   
	   $.ajax({
	      type : "post",
	      url : "/joinUserA.do",
	      data: {
	         id: id,
	         password: password
	      },
	      dataType: "json",
	      error: function(){
	         alert("에러발생");
	      },
	      success: function(data){
	    	  console.log(data);
	         if (data.result === "success") alert("회원가입 성공");
	         else if (data.result === "none")
	         alert("이미 있는 아이디 입니다.");
	         location.reload();
	      }
	   })
	})
  	   
  	   
		$('#loginBtn').on("click", function(){
	  		 var loginId = $("#loginId").val();
	 	     var loginPassword = $("#loginPw").val();
	   
		$.ajax({
		   type : "post",
		   url: "/loginUserA.do",
		   data: {
			 id: loginId,
		     password: loginPassword
		   },
		   dataType: "json",
		   error: function(){
		      alert("에러발생");
		   },
		   success: function(data){
		      if (data.result === "success") {
		    	  alert("로그인 성공");
		    	  location.href="http://localhost:8080/reagentA.do";
		      }else if (data.result === "fail"){
		    	  alert("없는 정보 입니다.");  
		      }
	      }
	   })
	})