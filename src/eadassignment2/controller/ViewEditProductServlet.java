package eadassignment2.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eadassignment2.model.*;

/**
 * Servlet implementation class ViewEditProductServlet
 */
@WebServlet("/ViewEditProductServlet")
public class ViewEditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewEditProductServlet() {
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
		
		String itemEdit = new String();
		String editProductPicName = new String();
		String[] itemEditUpload = new String[2];  //to temporary get value forwarded frm UploadPicServlet
		
		/*if entry comes frm a1Dashboard.jsp, get the value of itemEdit
		if entry comes frm UploadPicServlet(a1EditProduct.jsp-->UploadPicServlet), get the value of the array (itemEdit & editProductPicName)*/
		if((itemEdit=request.getParameter("itemEdit"))!=null){
			editProductPicName = null;
			
			System.out.println("value submitted by a1Dashboard.jsp is itemEdit: "+itemEdit);
		}
		else{
			itemEditUpload=(String[])request.getAttribute("itemEditUpload");
			itemEdit=itemEditUpload[0]; //store itemEdit value forwarded frm UploadPicServlet
			editProductPicName=itemEditUpload[1]; //store editProductPicName value forwarded frm UploadPicServlet
			
			System.out.println("value submitted by UploadPicServlet are itemEdit: "+itemEdit+" & editProductPicName: "+ editProductPicName);
		}
		
		/*pass the value to model*/
		electronicproductDB viewEditInput = new electronicproductDB();
		electronicproduct viewEditOutput = viewEditInput.viewEditProduct(itemEdit, editProductPicName);
		
		/*print out to console for checking*/
		System.out.println("value that will be forwarded to a1EditProduct.jsp is itemEdit: "+viewEditOutput.getProduct_id());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editName: "+viewEditOutput.getName());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editType: "+viewEditOutput.getType_id());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editPicName: "+viewEditOutput.getPicture_name());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editBrand: "+viewEditOutput.getBrand());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editPrice: "+viewEditOutput.getPrice());
		System.out.println("value that will be forwarded to a1EditProduct.jsp is editDesc: "+viewEditOutput.getDescription());
		
		/*forward to a1EditProduct.jsp*/
		request.setAttribute("viewEditOutput", viewEditOutput);
		RequestDispatcher rd = request.getRequestDispatcher("a1EditProduct.jsp");
		rd.forward(request, response);
		
	}

}
