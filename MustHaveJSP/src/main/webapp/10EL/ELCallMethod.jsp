<%@page import="el.MyELClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld"  %>
<%
MyELClass myClass = new MyELClass();
pageContext.setAttribute("myClass", myClass);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 메서드 호출</title>
	</head>
	<body>
		<h3>영역에 저장 후 메서드 호출하기</h3>
		001225-300000 => ${ myClass.getGender("001225-300000") } <br/>
		001225-200000 => ${ myClass.getGender("001225-200000") } 
	
		<h3>클래스명을 통해 정적 메소드 호출하기</h3>
		${ MyELClass.showGugudan(7) }
		
		<h3>JSP 코드를 통해 메서드 호출하기</h3>
		<%
			out.print(MyELClass.isNumber("백20") ? "숫자임" : "숫자아님");
			out.println("<br/>");			
			
			boolean isNumStr = MyELClass.isNumber("120");
			if(isNumStr == true)
				out.print("숫자입니다.");
			else 
				out.print("숫자가 아닙니다.");				
		%>
		
		<h3>TLD 파일 등록 후 정적 메서드 호출하기</h3>
		<ul>
			<li>mytag:isNumber("100") => ${ mytag:isNumber("100") }</li>
			<li>mytag:isNumber("이백") => ${ mytag:isNumber("이백") }</li>			
		</ul>
	</body>	
</html>