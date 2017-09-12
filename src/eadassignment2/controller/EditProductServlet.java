package eadassignment2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eadassignment2.model.*;

/**
 * Servlet implementation class EditProductServlet
 */
@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProductServlet() {
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
		
		//get selected item product_id passed by a1EditProduct.jsp(when btnEditSubmit is executed)
		String itemEdit = request.getParameter("itemEdit");
		//get all values of selected item passed frm a1EditProduct.jsp(when btnEditSubmit is executed)
		String editName = request.getParameter("editName");
		String editType = request.getParameter("editType");
		String editPicName = request.getParameter("editPicName");
		String editBrand = request.getParameter("editBrand");
		String editPrice = request.getParameter("editPrice");
		String editDesc = request.getParameter("editDesc");
		
		System.out.println("itemEdit to be edited is "+itemEdit);
		
		electronicproductDB editInput = new electronicproductDB();
		int editOutput = editInput.editProduct(itemEdit, editName, editType, editPicName, editBrand, editPrice, editDesc);
		
		if(editOutput>0)
			response.sendRedirect("a1Dashboard.jsp?backFrmEdit=yes_number of record edited: " + editOutput);

		
	}

}
