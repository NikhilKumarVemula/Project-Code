<!-- This page displays the user interface for the removal faculty. It queries the database for the data to populate in the UI fields -->
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
    </head>
    <body>
        <div id="remove" class="tabcontent">
<h3>Remove Faculty!</h3>
<form name=add action="RemoveFac.jsp" method=POST>
<p>Faculty : <select id=faculty name=faculty>
<option>--Select Faculty--</option>
  <%
  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "ROOT");
  	Statement st = connection.createStatement();
  	String QueryString = "Select FacultyName from faculty";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p>
<input type=submit value="Remove">
</form>
</div>
    </body>
</html>
