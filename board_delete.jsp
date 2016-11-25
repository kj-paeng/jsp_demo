<%@ page import="javacan.board.*" %>
<%@ page import="javacan.member.*" %>
<%@ page errorPage="/error/board_error.jsp" %>
<%
	MemberBean mb = (MemberBean)session.getAttribute("member.login");
	if (mb == null) {  %>
	<jsp:forward page="/error/not_login.jsp" />
<%
	}  
	String no = request.getParameter("no");
	
	BoardMgr bMgr = BoardMgr.getInstance();
	bMgr.deleteBoardData("bbs", Integer.parseInt(no));
%>
<html>
<head>
<title>JavaCan의 Web 어플리케이션 개발 두번째 판</title>
</head>
<body>
<jsp:include page="/module/header.jsp" flush="true" />

<br>
<center>
지정한 글을 삭제하였습니다.
<br>
<a href="board_list.jsp?page=<%=request.getParameter("page")%>">[글목록보기]</a>
</center>
<br>

<jsp:include page="/module/footer.jsp" flush="true" />

</body>
</html>
