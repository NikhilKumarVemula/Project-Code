package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class AdminHome_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("<!DOCTYPE HTML>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("  <title>Home</title>\r\n");
      out.write("  <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" />\r\n");
      out.write("  <link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />\r\n");
      out.write("    <link rel=\"shortcut icon\" href=\"favicon.png\" />\r\n");
      out.write("  <script type=\"text/javascript\" src=\"js/modernizr-1.5.min.js\"></script></head>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("  // function for validating Add faculty text fields\r\n");
      out.write("    function validateForm() {\r\n");
      out.write("\t    var x = document.forms[\"add\"][\"fname\"].value;\r\n");
      out.write("\t    var x1 = document.forms[\"add\"][\"lname\"].value;\r\n");
      out.write("\t    var x2 = document.forms[\"add\"][\"email\"].value;\r\n");
      out.write("\t    if (x == \"\") {\r\n");
      out.write("\t        alert(\"FirstName must be filled out\");\r\n");
      out.write("\t        return false;\r\n");
      out.write("\t    }\r\n");
      out.write("\t    else if (x1 === \"\") {\r\n");
      out.write("\t        alert(\"LastName must be filled out\");\r\n");
      out.write("\t        return false;\r\n");
      out.write("\t    }\r\n");
      out.write("\t    else if (x2 === \"\") {\r\n");
      out.write("\t        alert(\"Email must be filled out\");\r\n");
      out.write("\t        return false;\r\n");
      out.write("\t    }\r\n");
      out.write("\t}\r\n");
      out.write("function openCity(evt, cityName) {\r\n");
      out.write("    // Declare all variables\r\n");
      out.write("    var i, tabcontent, tablinks;\r\n");
      out.write("\r\n");
      out.write("    // Get all elements with class=\"tabcontent\" and hide them\r\n");
      out.write("    tabcontent = document.getElementsByClassName(\"tabcontent\");\r\n");
      out.write("    for (i = 0; i < tabcontent.length; i++) {\r\n");
      out.write("        tabcontent[i].style.display = \"none\";\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Get all elements with class=\"tablinks\" and remove the class \"active\"\r\n");
      out.write("    tablinks = document.getElementsByClassName(\"tablinks\");\r\n");
      out.write("    for (i = 0; i < tablinks.length; i++) {\r\n");
      out.write("        tablinks[i].className = tablinks[i].className.replace(\" active\", \"\");\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Show the current tab, and add an \"active\" class to the link that opened the tab\r\n");
      out.write("    document.getElementById(cityName).style.display = \"block\";\r\n");
      out.write("    evt.currentTarget.className += \" active\";\r\n");
      out.write("}\r\n");
      out.write("function SelectCourse(course){\r\n");
      out.write("       document.getElementById('content').style.display = 'block';\r\n");
      out.write("       document.getElementById('content').value=course;\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("<script>\r\n");
      out.write("// Get the element with id=\"defaultOpen\" and click on it\r\n");
      out.write("document.getElementById(\"defaultOpen\").click();\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("  <div id=\"main\">\r\n");
      out.write(" <div class=\"dropdown\" style=\"float:right;\">\r\n");
      out.write("  <button class=\"user dropbtn\"></button>\r\n");
      out.write("  <div class=\"dropdown-content\">\r\n");
      out.write("    <a href=\"UserProfile.jsp\">Profile</a>\r\n");
      out.write("    <a href=\"ChangePassword.jsp\">Change Password</a>\r\n");
      out.write("    <a href=\"LoginPage.html\">Logout</a>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");

	String user = session.getAttribute("username").toString();

      out.write("\r\n");
      out.write(" <h3> Hi ");
      out.print(user );
      out.write(" !</h3>\r\n");
      out.write(" ");

     // session for user
 session.setAttribute("username",user);
 
      out.write("\r\n");
      out.write("    <div id=\"site_content\">\r\n");
      out.write("      <ul class=\"tab\">\r\n");
      out.write("  <li><a href=\"javascript:void(0)\" class=\"tablinks\" onclick=\"openCity(event, 'home')\" id=\"defaultOpen\">Home</a></li>\r\n");
      out.write("  <li><a href=\"javascript:void(0)\" class=\"tablinks\" onclick=\"openCity(event, 'course')\">Course</a></li>\r\n");
      out.write("  <li><a href=\"javascript:void(0)\" class=\"tablinks\" onclick=\"openCity(event, 'faculty')\">Faculty</a></li>  \r\n");
      out.write("  <li><a href=\"javascript:void(0)\" class=\"tablinks\" onclick=\"openCity(event, 'add')\">Add Faculty</a></li>  \r\n");
      out.write("  <li><a href=\"javascript:void(0)\" class=\"tablinks\" onclick=\"openCity(event, 'remove')\">Remove Faculty</a></li>\r\n");
      out.write("</ul>\r\n");
      out.write("\r\n");
      out.write("<div id=\"home\" class=\"tabcontent\" style=\"display:block\">\r\n");
      out.write("  <h3>Home</h3>\r\n");
      out.write("  <p>Welcome!!</p>\r\n");
      out.write("  <p>To schedule timetable, <a href=\"Scheduler1.jsp\">Click here !!</a></p>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"course\" class=\"tabcontent\">\r\n");
      out.write("\r\n");
      out.write("<form method=POST name=selectCourse action=\"SubjectCalendar.jsp\">\r\n");
      out.write("<input type=hidden name=user value=");
      out.print(session.getAttribute("username").toString() );
      out.write(">\r\n");
      out.write("  <h3>Course : <select id=course name=course>\r\n");
      out.write("  <option>-Select Course-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select Name from subject";
  	rs = st.executeQuery(QueryString);
  	out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("\r\n");
      out.write("  </select></h3>\r\n");
      out.write("  <input type=submit value=\"Show Calendar\" name=submit>\r\n");
      out.write("  </form>\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("<div id=\"faculty\" class=\"tabcontent\">\r\n");
      out.write("  <h3>Faculty</h3>\r\n");
      out.write("  <form method=POST name=selectFaculty action=\"FacultyCalendar.jsp\">\r\n");
      out.write("  <input type=hidden name=user value=");
      out.print(session.getAttribute("username").toString() );
      out.write(">\r\n");
      out.write("  <h3>Faculty : <select id=faculty name=faculty>\r\n");
      out.write("  <option>-Select Faculty-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select FacultyName from faculty";
  	rs = st.executeQuery(QueryString);
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></h3>\r\n");
      out.write("  <input type=submit value=\"Show Calendar\" name=submit>\r\n");
      out.write("  </form>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"add\" class=\"tabcontent\">\r\n");
      out.write("<h3>Add Faculty!</h3>\r\n");
      out.write("<form name=add action=\"AddFac.jsp\" method=POST onsubmit=\"return validateForm()\">\r\n");
      out.write("<input type=hidden name=user value=");
      out.print(session.getAttribute("username").toString() );
      out.write(">\r\n");
      out.write("<p>Firstname : <input type=text name=fname></p>\r\n");
      out.write("<p>Lastname : <input type=text name=lname></p>\r\n");
      out.write("<p>Email ID : <input type=text name=email></p>\r\n");
      out.write("<p>Department : <select id=dept name=dept>\r\n");
      out.write("<option>-Select Department-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select Name from department";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></p>\r\n");
      out.write("  <p>Subject : <select id=sub name=sub>\r\n");
      out.write("  <option>-Select Subject-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select Name from subject";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value='");
      out.print( rs.getString(1) );
      out.write("'> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></p>\r\n");
      out.write("  <p>Location : <select id=loc name=loc>\r\n");
      out.write("  <option>-Select Location-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select LocationName from location";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></p> \r\n");
      out.write("  <p>Job Type : <select id=jtype name=jtype>\r\n");
      out.write("  <option>-Select Job Type-</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select DISTINCT Type from faculty";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></p>\r\n");
      out.write("  <p>CreditHours : <input type=text name=chrs  min=\"1\" max=\"12\"></p>\r\n");
      out.write("  <br><input type=submit name=add value=\" Add \"><br><br>\r\n");
      out.write("</form>\r\n");
      out.write("</div>\r\n");
      out.write("<div id=\"remove\" class=\"tabcontent\">\r\n");
      out.write("<h3>Remove Faculty!</h3>\r\n");
      out.write("<form name=add action=\"RemoveFaculty.jsp\" method=POST>\r\n");
      out.write("<input type=hidden name=user value=");
      out.print(session.getAttribute("username").toString() );
      out.write(">\r\n");
      out.write("<p>Faculty : <select id=faculty name=faculty>\r\n");
      out.write("<option>--Select Faculty--</option>\r\n");
      out.write("  ");

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select FacultyName from faculty";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  
      out.write("\r\n");
      out.write("\t  <option value=\"");
      out.print( rs.getString(1) );
      out.write("\"> ");
      out.print(rs.getString(1));
      out.write("</option>\r\n");
      out.write("\t  ");

  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  
      out.write("  \r\n");
      out.write("  </select></p>\r\n");
      out.write("<input type=submit value=\"Remove\">\r\n");
      out.write("</form>\r\n");
      out.write("</div>\r\n");
      out.write("    </div>\r\n");
      out.write("  <!-- javascript at the bottom for fast page loading -->\r\n");
      out.write("  <script type=\"text/javascript\" src=\"js/jquery.min.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\" src=\"js/jquery.easing.min.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\" src=\"js/jquery.lavalamp.min.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\" src=\"js/image_fade.js\"></script>\r\n");
      out.write("  <script type=\"text/javascript\">\r\n");
      out.write("    $(function() {\r\n");
      out.write("      $(\"#lava_menu\").lavaLamp({\r\n");
      out.write("        fx: \"backout\",\r\n");
      out.write("        speed: 700\r\n");
      out.write("      });\r\n");
      out.write("    });\r\n");
      out.write("  </script>\r\n");
      out.write("  </div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
