package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletContext;

public class JDBConnect
{
	public Connection con;  // 데이터 베이스와 연결을 담당
	public Statement stmt; // 정적 쿼리문
	public PreparedStatement psmt; // 동적 쿼리문
 	public ResultSet rs; // select 쿼리문 결과를 저장할때 사용
	
	public JDBConnect()
	{
		try
		{
			Class.forName("oracle.jdbc.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "musthave";
			String pwd = "1234";
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(기본 생성자)");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void close()
	{
		try
		{
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public JDBConnect(String driver, String url, String id, String pwd) 
	{
		try
		{
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println(" DB 연결 성공 (인수 생성자1)");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public JDBConnect(ServletContext application) {
		try
		{
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println(" DB 연결 성공 (인수 생성자2)");
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
