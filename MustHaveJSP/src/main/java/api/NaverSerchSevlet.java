package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.xml.utils.URI.MalformedURIException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/NaverSearchAPI.do")
public class NaverSerchSevlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		String clientId = "UxFc98KqkqRo5fYzkh8i";
		String clientSecret = "7scNyebQ_S";
		
		int startNum = 0;
		String text = null;
		try
		{
			startNum = Integer.parseInt(req.getParameter("startNum"));
			String searchText = req.getParameter("keyword");
			text = URLEncoder.encode(searchText, "UTF-8");
		} catch (UnsupportedEncodingException e)
		{
			throw new RuntimeException("검색어 인코딩 실패", e);
		}
		
		String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text
				+"$display=10&start=" + startNum;
		
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders);
		
		System.out.println(responseBody);
		
		resp.setContentType("text/html;charset=utf-8");
		resp.getWriter().write(responseBody);
	}
	
	public static String get(String apiUrl, Map<String, String> requestHeaders)
	{
		HttpsURLConnection con = connect(apiUrl);
		try
		{
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header: requestHeaders.entrySet())
			{
				con.setRequestProperty(header.getKey(), header.getValue());
			}
			
			int recponseCode = con.getResponseCode();
			if(recponseCode == HttpsURLConnection.HTTP_OK) {
				return readBody(con.getInputStream());
			}
			else {
				return readBody(con.getErrorStream());
			}			
		} 
		catch (IOException e)
		{
			throw new RuntimeException("API 요청과 응답 실패", e);
		}
		finally 
		{
			con.disconnect();
		}
	}
	
	private static HttpsURLConnection connect(String apiurl)
	{
		try
		{
			URL url = new URL(apiurl);
			return (HttpsURLConnection)url.openConnection();
		} catch (MalformedURIException  e)
		{
			throw new RuntimeException("API URL이 잘못되었습니다.: " + apiurl , e);
		}
		catch (IOException e)
		{
			throw new RuntimeException("연결이 실패했습니다. : " + apiurl, e);
		}
	}
	
	private static String readBody(InputStream	body)
	{
		InputStreamReader streamReader = new InputStreamReader(body);
		
		try(BufferedReader lineReader = new BufferedReader(streamReader))
		{
			StringBuilder responseBody = new StringBuilder();
			
			String line;
			while( (line = lineReader.readLine()) != null)
			{
				responseBody.append(line);
			}
			return responseBody.toString();
			
		} catch (IOException e)
		{
			throw new RuntimeException("API 응답을 읽는데 실패했습니다." , e);
		}
	}

}
