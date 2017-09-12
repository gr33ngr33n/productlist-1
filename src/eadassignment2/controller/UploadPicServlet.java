package eadassignment2.controller;

import java.io.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UploadPicServlet
 */
@WebServlet("/UploadPicServlet")
public class UploadPicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadPicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String[] itemEditUpload = new String[2]; //String array to store value of itemEdit & editProductPicName to forward to ViewEditProductServlet
		String itemEdit = new String();
		String editProductPicName = new String();
		String contentType = request.getContentType();
		
		try{
			DataInputStream dis = new DataInputStream(request.getInputStream());
			
			int contentLength = request.getContentLength();
			byte[] contentBuffer = new byte[contentLength];
		
			int ttlRead=0;
			int contentRead=0;
			
			while(ttlRead<contentLength){
				contentRead = dis.read(contentBuffer, ttlRead, contentLength);
				ttlRead += contentRead;
			}
			
			String contentBufferString = new String(contentBuffer);
			
			/* the following is to get itemEdit/product_id value so that when it returns to a1EditProduct.jsp,
			all initial value of fields will be maintained */
			itemEdit = contentBufferString.substring(contentBufferString.indexOf("name=\"passItemEdit\"")+20); /* current pointer at \n */
			//out.println(itemEdit.indexOf("\n")); /* index of \n is 0 */
			itemEdit = itemEdit.substring(itemEdit.indexOf("\n")+2); /* current pointer at \n */
			//out.println(itemEdit.indexOf("\n")); /* index of \n is 0 */
			itemEdit = itemEdit.substring(itemEdit.indexOf("\n")+1); /* current pointer at 1st number of the itemEdit or product_id */
			//out.println(itemEdit.indexOf("\n")); 
			itemEdit = itemEdit.substring(0,itemEdit.indexOf("\n")-1); /* -1 is because there is 1 unknown character before \n. This applies to the above 3 lines as well */
			
			
			/* the following is to get the uploaded image file and save it in the local client machine & \web folder.
			After the whole saving file process is completed, pass the value of both itemEdit (which indicate product_id to maintain
			initial values of all related fields) & editPicName (which will replace the old picture filename & refresh the pic preview) */
			editProductPicName = contentBufferString.substring(contentBufferString.indexOf("filename=\"")+10);
			editProductPicName = editProductPicName.substring(0, editProductPicName.indexOf("\n"));
			editProductPicName = editProductPicName.substring(editProductPicName.indexOf("\\")+1, editProductPicName.indexOf("\""));
			
			String fileContentBoundary = contentType.substring(contentType.indexOf("=")+1,contentType.length());
			
			int fileContentBeginPos;
			fileContentBeginPos = contentBufferString.indexOf("filename=\"");
			fileContentBeginPos = contentBufferString.indexOf("\n", fileContentBeginPos)+1;
			fileContentBeginPos = contentBufferString.indexOf("\n", fileContentBeginPos)+1;
			fileContentBeginPos = contentBufferString.indexOf("\n", fileContentBeginPos)+1;
			
			int fileContentEndPos;
			fileContentEndPos = contentBufferString.indexOf(fileContentBoundary, fileContentBeginPos)-4;
			
			int fileHeaderLength = (contentBufferString.substring(0, fileContentBeginPos).getBytes()).length;
			int wholeFileLength = (contentBufferString.substring(0, fileContentEndPos).getBytes()).length;
			
			String localPicLocation = getServletContext().getRealPath("/").replace("\\", "/");
			
			File productPicFile = new File(localPicLocation.substring(0, localPicLocation.lastIndexOf(".metadata")-1) +
					request.getContextPath() + "/WebContent/img/" + editProductPicName); /*copy files to local client machine*/
			File productPicFileWeb = new File(getServletContext().getRealPath("/img/" + editProductPicName).replace("\\", "/"));
			
			try{
				FileOutputStream productPicFileOut = new FileOutputStream(productPicFile); /* to local client machine */
				FileOutputStream productPicFileWebOut = new FileOutputStream(productPicFileWeb); /* to /web folder */
				
				productPicFileOut.write(contentBuffer, fileHeaderLength, (wholeFileLength-fileHeaderLength)); /* to local client machine */
				productPicFileWebOut.write(contentBuffer, fileHeaderLength, (wholeFileLength-fileHeaderLength)); /* to /web folder */
				
				productPicFileOut.flush(); /* to local client machine */
				productPicFileWebOut.flush(); /* to /web folder */
				
				productPicFileOut.close(); /* to local client machine */
				productPicFileWebOut.close(); /* to /web folder */
				
			}catch(Exception err){
				System.out.println(err.getMessage());
			}
			
			/* double check value of itemEdit & editProductPicName */
			System.out.println("initial value of itemEdit passed frm a1EditProduct.jsp is "+itemEdit);
			System.out.println("newly selected filename to be passed back to a1EditProduct.jsp is "+editProductPicName);
			
			/*store value of itemEdit & editProductPicName*/
			itemEditUpload[0]=itemEdit;
			itemEditUpload[1]=editProductPicName;
			
			/*send back the String array (with stored value of itemEdit & editProductPicName) to ViewEditProductServlet*/
			request.setAttribute("itemEditUpload", itemEditUpload);
			RequestDispatcher rd = request.getRequestDispatcher("ViewEditProductServlet");
			rd.forward(request, response);			
			
		}catch(Exception err){
			err.getMessage();
		}
		
		
	}

}
