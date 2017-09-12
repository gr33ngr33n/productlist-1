package eadassignment2.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eadassignment2.model.*;

/**
 * Servlet implementation class a2SearchProduct
 */
@WebServlet("/a2SearchProduct")
public class SearchProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchProductServlet() {
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
		
		//search product variables
		String searchName = request.getParameter("searchName");
		String searchBrand = request.getParameter("searchBrand");
		String searchType = request.getParameter("searchType");
		String searchMaxPrice = request.getParameter("searchMaxPrice");
		
		electronicproductDB searchInput = new electronicproductDB();
		ArrayList<electronicproduct> searchOutput = new ArrayList<electronicproduct>();
		searchOutput = searchInput.viewProduct(searchName, searchBrand, searchType, searchMaxPrice);
		
		request.setAttribute("searchOutput", searchOutput);
		RequestDispatcher rd = request.getRequestDispatcher("a2Dashboard.jsp");
		rd.forward(request, response);
		
	}

}
