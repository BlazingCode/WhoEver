<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%> 
<%@ page import="java.util.*"%>
<%@ page import="java.util.*, java.sql.*, java.io.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	//���� �޾ƿ���
	String loginId = (String) session.getAttribute("sessionId");
	//status ���� �޾ƿ���
	String status_input = request.getParameter("status_input");
	//db �о����
	String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	Connection con = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName(JDBC_DRIVER);
		con = DriverManager.getConnection("jdbc:mysql://blazingcode.asuscomm.com:6000/whoever?serverTimezone=UTC", "whoever", "Whoever12#");
		String sql;

		sql = " UPDATE user SET status_msg=? WHERE id = '" + loginId+"'";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, status_input);
		int r = pstmt.executeUpdate();
		
		pstmt.close();
		con.close();
		
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
	
	response.sendRedirect("mypage.jsp");
%>