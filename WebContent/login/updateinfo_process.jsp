<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	//���� �޾ƿ���
	String loginId = (String) session.getAttribute("sessionId");
	//status ���� �޾ƿ���
	String name = request.getParameter("update_name");
	String oldpw = request.getParameter("update_password_old");
	String newpw = request.getParameter("update_password_new");
	String pw_re = request.getParameter("update_password_re");



	//�� ���� null�̸� �ʱ�ȭ ��ư Ŭ��
	if(loginId==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	String checkpw=null;
	//db �о����
	String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	Connection con = null;
	Statement state = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName(JDBC_DRIVER);
		con = DriverManager.getConnection("jdbc:mysql://blazingcode.asuscomm.com:6000/whoever?serverTimezone=UTC", "whoever", "Whoever12#");
		String sql;
		
		//1. ���� ��й�ȣ ��ġ�ϴ��� Ȯ��
		state = con.createStatement();
		ResultSet rs;
		
		sql = " SELECT password FROM user WHERE id = '" + loginId+"'";
		rs = state.executeQuery(sql);
		while (rs.next()) {
			checkpw=rs.getString("password");
		}
		
		
		if(!checkpw.equals(oldpw)){
			response.sendRedirect("mypage.jsp");
		}else{
			//2. ��ġ�� ��쿡�� ���� ����
			if("null".equals(name)){
			//3. name �Է°� �������, �̸�, ��й�ȣ �Ѵ� ����
				sql = " UPDATE user SET name=?, password=? WHERE id = '" + loginId+"'";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, newpw);
				int r = pstmt.executeUpdate();
				pstmt.close();
			}else{
			//4. name �Է°� ������� ��й�ȣ�� ����
				sql = " UPDATE user SET password=? WHERE id = '" + loginId+"'";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, newpw);
				int r = pstmt.executeUpdate();
				pstmt.close();	
			}
		}
		
		rs.close();
		state.close();
		con.close();
		response.sendRedirect("mypage.jsp");
		
	}catch (SQLException e) {
		System.out.println("[SQL Error : " + e.getMessage() + "]");
	} catch (ClassNotFoundException e1) {
		System.out.println("[JDBC Connector Driver ���� : " + e1.getMessage() + "]");
	} finally {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
%>