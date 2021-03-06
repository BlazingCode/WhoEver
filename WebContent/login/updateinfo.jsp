<!doctype html>
<html>
<head>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css " />
<link rel="stylesheet" href="../resources/css/card.css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../resources/js/bootstrap.js"></script>

<style>
.parent {
	width: 70%;
	margin: 10% auto;
}

.update_container {
	float: left;
	margin: 0 auto;
	width: 100%;
	min-height: 682px;
	background-color: #fff;
	border-radius: 40px;
	box-shadow: 0 2px 4px 0 rgba(0, 0, 0, .2);
}

.member_input_box {
	position: relative;
	z-index: 10;
	border: 0;
	padding: 0;
	background-color: transparent;
	outline: 0;
	font-weight: 400;
	font-size: 16px;
	line-height: 19px;
	width: 100%;
	margin: 10 0 10 10;
	border-bottom: 1px solid #bcbcbc;
}

.member_button_update {
	position: relative;
	text-align: center;
	font-weight: 700;
	line-height: 56px;
	padding: 0 20px;
	background-color: #dddfe4 !important;
	cursor: default !important;
	font-size: 16px;
	border-radius: 3px;
	display: inline-block;
	text-decoration: none;
	color: #fff;
	border: 0;
	height: 56px;
	margin-top: 40px;
	width: 100%;
	font: 400 13.3333px;
}
</style>


<%
	request.setCharacterEncoding("UTF-8");
	//세션 받아오기
	String loginId = (String) session.getAttribute("sessionId");
	String loginUserId = (String) session.getAttribute("sessionUserId"); //user 인덱스번호
	
	//로그인 필요한 서비스의 경우
	if(loginId==null ||loginUserId==null){
		out.println("<script> alert(\"로그인이 필요합니다.\"); window.location= \"login.jsp\"; </script>");
	}
	String name=null;
	String email=null;
	String password=null;
	//db 읽어오기
	String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	Connection con = null;
	Statement state = null;

	try {
		Class.forName(JDBC_DRIVER);
		con = DriverManager.getConnection("jdbc:mysql://blazingcode.asuscomm.com:6000/whoever?serverTimezone=UTC", "whoever", "Whoever12#");
		state = con.createStatement();
		ResultSet rs;
		String sql;

		sql = " SELECT name, password, email FROM user WHERE id = '" + loginId+"'";

		rs = state.executeQuery(sql);

		while (rs.next()) {
			name = rs.getString("name");
			name = rs.getString("password");
			email = rs.getString("email");
		}

		rs.close();
		state.close();
		con.close();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (state != null)
				state.close();
		} catch (SQLException ex1) {

		}
		try {
			if (con != null)
				con.close();
		} catch (SQLException ex1) {

		}
	}
%>
<script>
function checkMember() {
	var exppwd = /^[A-Za-z0-9]{8,16}$/;
	
	//이름 입력을 안할경우 null값 전송
	
	//패스퉈드 입력여부 확인
	if ($.trim($("#update_password_old").val()) == '') {
		alert("패스워드를 입력해주세요.");
		document.update_info.update_password_old.focus();
		return false;
		//예전 패스워드가 맞나 확인
	} else if (exppwd.test($.trim($("#update_password_new").val())) == false) {//비밀번호 형식	
		alert("패스워드 형식이 올바르지 않습니다.");
		document.update_info.update_password_new.focus();
		return false;
	}
	if ($.trim($("#update_password_new").val()) != $.trim($("#update_password_re").val())) {
		alert("패스워드 값이 일치하지 않습니다.");
		document.update_info.update_password_re.focus();
		return false;
	}
	document.update_info.submit();
}//checkmember end

function reMypage(){
	location.href="mypage.jsp"
}
</script>



<title>WHOEVER MMPAGE</title>
<jsp:include page="../header.jsp" />
</head>

<body style="background: #f3f5f7">
	<div class="parent">
		<div class="update_container">
			<p>
				아이디 :
				<%out.println(loginId); %>
			</p>
			 
			<form action="updateinfo_process.jsp" method="post" name="update_info">
			
				<p>이름</p>
				<input id="update_name" class="member_input_box" type="text"name="update_name" placeholder="이름" maxlength="50">
				
				
				<p>기존 패스워드</p>
				<input id="update_password_old" class="member_input_box" type="text"name="update_password_old" placeholder="기존 패스워드" maxlength="50">
				<p>새로운 패스워드</p>
				<input id="update_password_new" class="member_input_box" type="text"name="update_password_new" placeholder="새로운 패스워드" maxlength="50">
				<p>패스워드 확인</p>
				<input id="update_password_re" class="member_input_box" type="text"name="update_password_re" placeholder="패스워드 확인" maxlength="50">
				
				<button type="button" class="member_button_update" onClick="checkMember()"><strong>수정</strong></button>
			</form>
			<input type="button" class="member_button_update" value="닫기" onclick="reMypage()">
			
			
			
		</div>
	</div>
</body>
</html>
