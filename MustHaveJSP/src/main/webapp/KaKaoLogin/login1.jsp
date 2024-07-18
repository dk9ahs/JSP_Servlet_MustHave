<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>Kakao 로그인 #1</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	</head>
	<body>
	
	
	    <a id="kakao-login-btn"></a>
	    <a href="http://developers.kakao.com/logout">로그아웃</a>
	    <script type='text/javascript'>
	      //<![CDATA[
	        Kakao.init('01465db520b2e99e728cdf457607d979');
	        // 카카오 로그인 버튼을 생성합니다.
	        Kakao.Auth.createLoginButton({
	          container: '#kakao-login-btn',
	          success: function(authObj) {
	            alert(JSON.stringify(authObj));
	          },
	          fail: function(err) {
	             alert(JSON.stringify(err));
	          }
	        });
	      //]]>
	    </script>
	    
	</body>
</html>
