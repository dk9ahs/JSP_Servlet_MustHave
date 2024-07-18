package fileupload;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/13FileUpload/UploadProcess.do")
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)

public class UploadProcess extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		try
		{
			String saveDirectory = getServletContext().getRealPath("/Uploads");
			
			String originalFileName = 
					FileUtil.uploadFile(req, saveDirectory);
			
			String savedFileNeme = 
					FileUtil.renameFile(saveDirectory, originalFileName);
			
			insertMyFile(req, originalFileName, savedFileNeme);
			
			resp.sendRedirect("FileList.jsp");
			
		} 
		catch (Exception e)
		{
			e.printStackTrace();
			req.setAttribute("errorMessage", "파일 업로드 오류");
			req.getRequestDispatcher("FileUploadMain.jsp").forward(req, resp);
		}
	}
	
	private void insertMyFile(HttpServletRequest req, String oFileNmae, String sFileName)
	{
		String title = req.getParameter("title");
		String[] cateArray = req.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();
		if(cateArray == null) {
			cateBuf.append("선택 항목 없음");
		}
		else {
			for (String s : cateArray) {
				cateBuf.append(s + ", ");
			}
		}
		System.out.println("파일외폼값 : " + title + "\n" + cateBuf);
		
		MyFileDTO dto = new MyFileDTO();
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(oFileNmae);
		dto.setSfile(sFileName);
		
		MyFileDAO dao = new MyFileDAO();
		dao.insertFile(dto);
		dao.close();
		
	}
}
