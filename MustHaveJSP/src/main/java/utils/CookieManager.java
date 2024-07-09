package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager
{
	public static void makeCookie (HttpServletResponse response, String cName, 
			String cValue, int cTime)
	{
		Cookie cookie = new Cookie(cName, cValue);
		cookie.setPath("/"); // 웹 애플리케이션 전체에서 사용되는 쿠키를 만든다.
		cookie.setMaxAge(cTime);
		response.addCookie(cookie);
	}
	
	public static String readCookie(HttpServletRequest resquest, String cName)
	{
		String cookieValue = "";
		
		Cookie[] cookies = resquest.getCookies();
		if(cookies != null) {
			for (Cookie c : cookies)
			{
				String cookieName = c.getName();
				if(cookieName.equals(cName)) {
					cookieValue = c.getValue();
				}
			}
		}
		return cookieValue;
	}
	
	public static void deleteCookie(HttpServletResponse response, String cName)
	{
		makeCookie(response, cName, "", 0);
	}
}
