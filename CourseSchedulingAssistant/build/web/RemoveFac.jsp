<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
String faculty = request.getParameter("faculty");
try 
{
	Statement st = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "ROOT");
	st = connection.createStatement();
    String query = "Delete from faculty where FacultyName='"+faculty+"'";
    st.execute(query);
    out.println("<script type=\"text/javascript\">");
	out.println("alert('Faculty Removed!! ');");
	 out.println("location='AdminHome.jsp';");
	 out.println("</script>");
}catch(Exception e)
{
	e.printStackTrace();
        	 out.println("location='RemoveFaculty.jsp';");
	System.out.println("Could not delete!");
}
%>