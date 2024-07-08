<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - errorPage, isErrorPage 속성</title>
	</head>
	<body>
	<%
	try
	{
		// 에러페이지 처리 방법 1 try-catch
		int myAge = Integer.parseInt(request.getParameter("age")) + 10; // 에러 발생
		out.println("10년 후 당신의 나이는 " + myAge + "입니다."); 
	}
	catch(Exception e)
	{
		out.println("예외 발생 : 매개변수 age가 null 입니다.");
	}
	%>		
	</body>
</html>