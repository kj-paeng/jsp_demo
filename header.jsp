<%@ page import = "javacan.member.MemberBean" %>
<%  MemberBean mb = (MemberBean)session.getAttribute("member.login");  %>
<style>
A.menu:link {color: red}
A.menu:visited {color: red}
A.menu:active {color: bbb}
A.menu:inactive {color: black}
</style>
<center>
<table width="650" border="0" cellpadding="2" cellspacing="0">
<tr>
	<td bgcolor="#6A70BA">
	<font color="#ffffff">
	<b>Let's be HAPPY!!</b>
	<br><small>JSP Demo Web Application</small>
	</font>
	</td>
</tr>
<tr>
	<td bgcolor="#e0e0e0">
	| <a class="menu" href="/jsp_demo/index.jsp">HOME</a>
	| <a class="menu" href="/jsp_demo/board/board_list.jsp">BBS</a>
	| <a class="menu" href="/jsp_demo/pds/pds_list.jsp">Download</a> 
	| <a class="menu" href="/jsp_demo/guest/guestbook_list.jsp">Visitors</a>
	| <a class="menu" href="/jsp_demo/notice/notice_list.jsp">Notice</a>
<%  if (mb == null) { /* 로그인을 하지 않은 경우 */ %>
	| <a class="menu" href="/jsp_demo/register?command=form">Registration</a>
<%  } else { /* 로그인을 한 경우 */ %>
	| <a class="menu" href="/jsp_demo/user/updateinfo_form.jsp">Change User Information</a>
	| <a class="menu" href="/jsp_demo/login?command=logout">Logout</a>
<%  }  %>
	|
</tr>
</table>
</center>
