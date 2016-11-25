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
<title>JavaCan�� Web ���ø����̼� ���� �ι�° ��</title>
</head>
<body>
<jsp:include page="/module/header.jsp" flush="true" />

<br>
<center>
������ ���� �����Ͽ����ϴ�.
<br>
<a href="board_list.jsp?page=<%=request.getParameter("page")%>">[�۸�Ϻ���]</a>
</center>
<br>

<jsp:include page="/module/footer.jsp" flush="true" />

</body>
</html>
