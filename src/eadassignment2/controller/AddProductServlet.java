package eadassignment2.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eadassignment2.model.*;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		/*String addPrice = "188abc''.',abc,'.'";
		int count = 0;
		
		PrintWriter out = response.getWriter();
		
		if(addPrice.matches("[0-9a-z,'.]"))
			count+=1;
		
		
		if(count<=0){
			out.println("Invalid");
			return;
		}
		else
			out.println("Valid");
		out.close();

		out.println("TEsting");*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

		String addName = request.getParameter("addName");
		String addType = request.getParameter("addType");
		String addPicName = request.getParameter("addPicName");
		String addBrand = request.getParameter("addBrand");
		String addPrice = request.getParameter("addPrice");
		String addDesc = request.getParameter("addDesc");
		
		int addTypeValid = 0;
		int addPriceValid = 0;
		String addValidPrice = "";
		int addNameBrandDescValid = 0;
		
		//validate value of product type(droplist) bfr submission to DB
		producttypeDB dropListInput = new producttypeDB();
		ArrayList<producttype> dropListOutput = dropListInput.dropListProductTypeName();
		for(producttype obj: dropListOutput){
			if(addType.equalsIgnoreCase(""+obj.getType_id())){
				addTypeValid+=1;
			}
		}
		
		//validate value of product price bfr submission to DB
		if(addPrice.matches("\\d+.\\d+")){
			addPriceValid+=1;
			addValidPrice = "" + (int)Double.parseDouble(addPrice);			
		}
		
		//validate value of product name
		if(addName.matches("[a-z0-9',. ]+")){
			addNameBrandDescValid+=1;
		}
		
		//validate value of product brand
		if(addBrand.matches("[a-z0-9',. ]+")){
			addNameBrandDescValid+=1;
		}
		
		//validate value of product description
		if(addDesc.matches("[a-z0-9',. ]+")){
			addNameBrandDescValid+=1;
		}
		
		//if validation fails, back to a1AddProduct.jsp with error message, else proceed to DB
		if((addTypeValid<=0)||(addPriceValid<=0)||(addNameBrandDescValid<3)){
			response.sendRedirect("a1AddProduct.jsp?addOutput=Input is Invalid!");
		}else{
			electronicproductDB addInput = new electronicproductDB();
			int addOutput = addInput.addProduct(addName, addType, addPicName, addBrand, addValidPrice, addDesc);
			
			if(addOutput>0){
				response.sendRedirect("a1AddProduct.jsp?addOutput=Number of Record Added: " + addOutput);
			}
		}
		
	}

}
