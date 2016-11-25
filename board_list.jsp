<%@ page import="javacan.board.*" %>
<%@ page import="javacan.member.*" %>
<%
	MemberBean mb = (MemberBean)session.getAttribute("member.login");
	if (mb == null) {  %>
	<jsp:forward page="/error/not_login.jsp" />
<%
	}
%>
<html>
<head>
<title>JavaCan�� Web ���ø����̼� ���� �ι�° ��</title>
</head>
<body>
<jsp:include page="/module/header.jsp" flush="true" />
<br>
<center><b><font size="4">�Խ��� ���</font></b></center>
<br>
<center>
<table width="650" cellspacing="1">
<tr bgcolor="#6A70BA" align="center">
	<td width="10%"><font color="white">��ȣ</font></td>
	<td width="20%"><font color="white">�۾���</font></td>
	<td width="20%"><font color="white">��¥</font></td>
	<td width="40%"><font color="white">����</font></td>
	<td width="10%"><font color="white">��ȸ��</font></td>
</tr>
<%
	// �о�� �������� ���Ѵ�.
	String reqPage = request.getParameter("page");
	int reqPageNo = 0; // ����ڰ� ��û�� ������ ��ȣ
	
	try {
		reqPageNo = Integer.parseInt(reqPage);
	} catch(Exception ex) {}
	
	BoardMgr mgr = BoardMgr.getInstance();
	int pageCount = mgr.getPageCount("bbs"); // �� ������ ���� ����
	
	if (pageCount == 0) { /* ������ ������ 0�� ��� */ %>
<tr bgcolor="#e0e0e0">
	<td colspan="5" align="center">����� ���� �����ϴ�.</td>
</tr>
<%
	} else { /* ������ ������ 0�� �ƴ� ��� */
		if (pageCount < reqPageNo || reqPageNo <= 0) reqPageNo = 1;
		BoardData[] data = mgr.selectBoardDataList("bbs", reqPageNo);
		java.text.SimpleDateFormat dateFormatter = 
					 new java.text.SimpleDateFormat("yyyy.MM.dd");
		for (int i = 0 ; i < data.length ; i++) {  %>
<tr>
	<td bgcolor="#e0e0e0" align="center">
	<%= (data[i].getNested() == 0) ? Integer.toString(data[i].getGroup()) : "" %>
	</td>
	<td bgcolor="#e0e0e0" align="center">
	<%= data[i].getId() %>(<%=data[i].getName()%>)
	</td>
	<td bgcolor="#e0e0e0" align="center">
	<%= dateFormatter.format(data[i].getRegisterDate()) %>
	</td>
	<td bgcolor="#e0e0e0">
<%
	if (data[i].getNested() > 0 ) { %>
	<img src="empty.gif" width="<%= data[i].getNested()*10%>">
	<img src="arrow.gif">
<%
	}  %>
	<a href="board_read.jsp?page=<%=reqPageNo%>&no=<%=data[i].getNo()%>">
	<%= data[i].getTitle() %>
	</a></td>
	<td bgcolor="#e0e0e0" align="center"><%= data[i].getReadNo() %></td>
</tr>	
<%
		}
	}	%>
<tr>
	<td colspan="5" align="center">
	<a href="board_write_form.jsp?page=<%=reqPageNo%>">�۾���</a> |
<%
	if (reqPageNo > 1 && pageCount != 0) {  %>
	<a href="board_list.jsp?page=<%=(reqPageNo-1)%>">�������</a> |
<%
	} else if (reqPageNo < pageCount ) {  %>
	<a href="board_list.jsp?page=<%=(reqPageNo+1)%>">�������</a> |
<%
	}  %>
	<a href="board_list.jsp">ó������</a>
	</td>
</tr>
</table>
</center>

<jsp:include page="/module/footer.jsp" flush="true" />

</body>
</html>
