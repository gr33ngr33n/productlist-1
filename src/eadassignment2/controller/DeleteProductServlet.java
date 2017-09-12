package eadassignment2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eadassignment2.model.*;

/**
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductServlet() {
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
		
		/* request.getParameter will get 1 value, request.getParameterValues will get set of values */
		String[] itemSelect = request.getParameterValues("itemSelect");
		
		electronicproductDB delInput = new electronicproductDB();
		int delOutput = delInput.deleteProduct(itemSelect);
		
		if(delOutput>0)
			response.sendRedirect("a1Dashboard.jsp?backFrmDel=yes_number of record deleted: " + delOutput);
		else
			response.sendRedirect("a1Dashboard.jsp?backFrmDel=yes_number of record deleted: " + delOutput);
		
	}

}
