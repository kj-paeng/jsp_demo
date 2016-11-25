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
<title>JavaCan의 Web 어플리케이션 개발 두번째 판</title>
</head>
<body>
<jsp:include page="/module/header.jsp" flush="true" />
<br>
<center><b><font size="4">게시판 목록</font></b></center>
<br>
<center>
<table width="650" cellspacing="1">
<tr bgcolor="#6A70BA" align="center">
	<td width="10%"><font color="white">번호</font></td>
	<td width="20%"><font color="white">글쓴이</font></td>
	<td width="20%"><font color="white">날짜</font></td>
	<td width="40%"><font color="white">제목</font></td>
	<td width="10%"><font color="white">조회수</font></td>
</tr>
<%
	// 읽어올 페이지를 구한다.
	String reqPage = request.getParameter("page");
	int reqPageNo = 0; // 사용자가 요청한 페이지 번호
	
	try {
		reqPageNo = Integer.parseInt(reqPage);
	} catch(Exception ex) {}
	
	BoardMgr mgr = BoardMgr.getInstance();
	int pageCount = mgr.getPageCount("bbs"); // 총 페이지 개수 구함
	
	if (pageCount == 0) { /* 페이지 개수가 0인 경우 */ %>
<tr bgcolor="#e0e0e0">
	<td colspan="5" align="center">저장된 글이 없습니다.</td>
</tr>
<%
	} else { /* 페이지 개수가 0이 아닌 경우 */
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
	<a href="board_write_form.jsp?page=<%=reqPageNo%>">글쓰기</a> |
<%
	if (reqPageNo > 1 && pageCount != 0) {  %>
	<a href="board_list.jsp?page=<%=(reqPageNo-1)%>">이전목록</a> |
<%
	} else if (reqPageNo < pageCount ) {  %>
	<a href="board_list.jsp?page=<%=(reqPageNo+1)%>">다음목록</a> |
<%
	}  %>
	<a href="board_list.jsp">처음으로</a>
	</td>
</tr>
</table>
</center>

<jsp:include page="/module/footer.jsp" flush="true" />

</body>
</html>
