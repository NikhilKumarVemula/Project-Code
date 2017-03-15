<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
  </head>
<body>
  <div id="main">
 <div class="dropdown" style="float:right;">
  <button class="user dropbtn"></button>
  <div class="dropdown-content">
    <a href="UserProfile.jsp">Profile</a>
    <a href="ChangePassword.jsp">Change Password</a>
    <a href="LoginPage.html">Logout</a>
  </div>
</div>
<%
    // session for logined user
	String user = session.getAttribute("username").toString();
 session.setAttribute("username",user);
 %>
 <h3> Hi <%=session.getAttribute("username").toString() %> !</h3>
    <div id="site_content">
     <ul class="tab">
  <li><a href="#" class="tablinks">Schedule</a></li>
  <li><a href=<%= "\"AdminHome.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
</ul>

<div id="home" class="tabcontent" style="display:block">
<h3>Schedule</h3>
<form name=schedule action="Scheduler7.jsp" method=POST>
 <input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<%
// getting data from scheduler pages	
    String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
	String course = request.getParameter("course");
	String faculty = request.getParameter("faculty");
	int noOfdays = Integer.parseInt(request.getParameter("noOfdays"));
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<h3>Course : <label> <%=course %></label><input type=hidden name=course value='<%=course %>'></h3>
<h3>Faculty : <label> <%=faculty %></label><input type=hidden name=faculty value='<%=faculty %>'></h3>
<h3>Number of Days :  <label> <%=noOfdays %></label><input type=hidden name=noOfdays value='<%=noOfdays %>' ></h3>
<%
int chrs = 0;
 try
 {
 	// by entering number of days calendar will be displayed to shcedule timetable for faculty
     // connecting to database and selecting credithours from database
     Statement statement = null;
   ResultSet rs = null;
   String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
   Connection connection = null; 
 	Class.forName(	"com.mysql.jdbc.Driver").newInstance(); 
 	connection = DriverManager.getConnection(connectionURL, "root", "root");
 	Statement st = connection.createStatement();
 	String QueryString = "Select CreditHours from faculty where FacultyName='"+faculty+"'";
 	rs = st.executeQuery(QueryString);
 	if(rs.next())
 	{
 		chrs = Integer.parseInt(rs.getString(1));
}
 	connection.close();
 	}
 catch(Exception e){}
 //int hrsToteach = 0;
 //hrsToteach=(chrs)/noOfdays;
 // creating a 2-dimmensional array for storing timetable data 
  String[][] timetable={{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""}}; 

  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	//Subject:facultyname:room:time
  	String QueryString = "Select t.Course,f.FacultyName,t.RoomNumber,t.TimeDuration,t.Day from faculty f,timetable t where t.FacultyId=f.FacultyId and f.FacultyName='"+faculty+"'";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	if(rs!=null)
  	{
            // loop for storing timetable by clicking on the slots
  		while(rs.next())
  	  	{
  			if(rs.getString(5).equals("Monday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50") || rs.getString(4).equals("8-9.15"))
	  				timetable[0][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") || rs.getString(4).equals("9-10.15"))
	  				timetable[1][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11") || rs.getString(4).equals("10-10.50") || rs.getString(4).equals("10-11.15"))
	  				timetable[2][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12") || rs.getString(4).equals("11-11.50") || rs.getString(4).equals("11-12.15"))
	  				timetable[3][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2") || rs.getString(4).equals("1-1.50") || rs.getString(4).equals("1-2.15"))
	  				timetable[4][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3") || rs.getString(4).equals("2-2.50") || rs.getString(4).equals("2-3.15"))
	  				timetable[5][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4") || rs.getString(4).equals("3-3.50") || rs.getString(4).equals("3-4.15"))
	  				timetable[6][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5") || rs.getString(4).equals("4-4.50") || rs.getString(4).equals("4-5.15"))	
	  				timetable[7][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("5-6") || rs.getString(4).equals("5-5.50") || rs.getString(4).equals("5-6.15"))
	  				timetable[8][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("6-7") || rs.getString(4).equals("6-6.50") || rs.getString(4).equals("6-7.15"))
	  				timetable[9][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Tuesday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50") || rs.getString(4).equals("8-9.15"))
	  				timetable[0][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") || rs.getString(4).equals("9-10.15"))
	  				timetable[1][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11") || rs.getString(4).equals("10-10.50") || rs.getString(4).equals("10-11.15"))
	  				timetable[2][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12") || rs.getString(4).equals("11-11.50") || rs.getString(4).equals("11-12.15"))
	  				timetable[3][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2") || rs.getString(4).equals("1-1.50") || rs.getString(4).equals("1-2.15"))
	  				timetable[4][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3") || rs.getString(4).equals("2-2.50") || rs.getString(4).equals("2-3.15"))
	  				timetable[5][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4") || rs.getString(4).equals("3-3.50") || rs.getString(4).equals("3-4.15"))
	  				timetable[6][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5") || rs.getString(4).equals("4-4.50") || rs.getString(4).equals("4-5.15"))
	  				timetable[7][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("5-6") || rs.getString(4).equals("5-5.50") || rs.getString(4).equals("5-6.15"))
	  				timetable[8][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("6-7") || rs.getString(4).equals("6-6.50") || rs.getString(4).equals("6-7.15"))
	  				timetable[9][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Wednesday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50") || rs.getString(4).equals("8-9.15"))
	  				timetable[0][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") || rs.getString(4).equals("9-10.15"))
	  				timetable[1][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11") || rs.getString(4).equals("10-10.50") || rs.getString(4).equals("10-11.15"))
	  				timetable[2][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12") || rs.getString(4).equals("11-11.50") || rs.getString(4).equals("11-12.15"))
	  				timetable[3][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2") || rs.getString(4).equals("1-1.50") || rs.getString(4).equals("1-2.15"))
	  				timetable[4][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3") || rs.getString(4).equals("2-2.50") || rs.getString(4).equals("2-3.15"))
	  				timetable[5][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4") || rs.getString(4).equals("3-3.50") || rs.getString(4).equals("3-4.15"))
	  				timetable[6][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5") || rs.getString(4).equals("4-4.50") || rs.getString(4).equals("4-5.15"))
	  				timetable[7][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("5-6") || rs.getString(4).equals("5-5.50") || rs.getString(4).equals("5-6.15"))
	  				timetable[8][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("6-7") || rs.getString(4).equals("6-6.50") || rs.getString(4).equals("6-7.15"))
	  				timetable[9][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Thursday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50") || rs.getString(4).equals("8-9.15"))
	  				timetable[0][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") || rs.getString(4).equals("9-10.15"))
	  				timetable[1][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11") || rs.getString(4).equals("10-10.50") || rs.getString(4).equals("10-11.15"))
	  				timetable[2][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12") || rs.getString(4).equals("11-11.50") || rs.getString(4).equals("11-12.15"))
	  				timetable[3][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2") || rs.getString(4).equals("1-1.50") || rs.getString(4).equals("1-2.15"))
	  				timetable[4][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3") || rs.getString(4).equals("2-2.50") || rs.getString(4).equals("2-3.15"))
	  				timetable[5][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4") || rs.getString(4).equals("3-3.50") || rs.getString(4).equals("3-4.15"))
	  				timetable[6][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5") || rs.getString(4).equals("4-4.50") || rs.getString(4).equals("4-5.15"))
	  				timetable[7][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("5-6") || rs.getString(4).equals("5-5.50") || rs.getString(4).equals("5-6.15"))
	  				timetable[8][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("6-7") || rs.getString(4).equals("6-6.50") || rs.getString(4).equals("6-7.15"))
	  				timetable[9][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Friday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50") || rs.getString(4).equals("8-9.15"))
	  				timetable[0][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") || rs.getString(4).equals("9-10.15"))
	  				timetable[1][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11") || rs.getString(4).equals("10-10.50") || rs.getString(4).equals("10-11.15"))
	  				timetable[2][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12") || rs.getString(4).equals("11-11.50") || rs.getString(4).equals("11-12.15"))
	  				timetable[3][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2") || rs.getString(4).equals("1-1.50") || rs.getString(4).equals("1-2.15"))
	  				timetable[4][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3") || rs.getString(4).equals("2-2.50") || rs.getString(4).equals("2-3.15"))
	  				timetable[5][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4") || rs.getString(4).equals("3-3.50") || rs.getString(4).equals("3-4.15"))
	  				timetable[6][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5") || rs.getString(4).equals("4-4.50") || rs.getString(4).equals("4-5.15"))
	  				timetable[7][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("5-6") || rs.getString(4).equals("5-5.50") || rs.getString(4).equals("5-6.15"))
	  				timetable[8][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("6-7") || rs.getString(4).equals("6-6.50") || rs.getString(4).equals("6-7.15"))
	  				timetable[9][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
  	  	}//while
%>
<table class="table1">
 <thead>
      <tr>
          <th></th>
          <th scope="col" abbr="Monday">Monday</th>
          <th scope="col" abbr="Tuesday">Tuesday</th>
          <th scope="col" abbr="Wednesday">Wednesday</th>
          <th scope="col" abbr="Thursday">Thursday</th>
          <th scope="col" abbr="Friday">Friday</th>
      </tr>
  </thead>
  <%
      // if user enters number of days as 3, dividing time slots into 50 min classes
  if(noOfdays==3)
  {
  %>
  <tbody>
      <tr>
          <th scope="row">08:00-08:50</th>
          <td>
	            <%	
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				<div id="8-8.50" >
				<input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:M"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td>
	            <%	
		            data = timetable[0][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-8.50" ><input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:W"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td>
	            <%	
		            data = timetable[0][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-8.50" ><input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">09:00-09:50 </th>
		 						<td>
	            <%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" ><input type=checkbox name="9-9.50" value="9-9.50:M" ></div></td>
		 			            <td><%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[1][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" ><input type=checkbox name="9-9.50" value="9-9.50:W" ></div></td>
		 			            <td><%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[1][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" ><input type=checkbox name="9-9.50" value="9-9.50:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">10:00-10:50 </th>
		 			            <td><%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="10-10.50" ><input type=checkbox name="10-10.50" value="10-10.50:M" ></div></td>
		 			            <td><%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[2][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-10.50" ><input type=checkbox name="10-10.50" value="10-10.50:W" ></div></td>
		 			            <td><%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td><%	
		            data = timetable[2][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-10.50" ><input type=checkbox name="10-10.50" value="10-10.50:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">11:00-11:50</th>
		 			            <td><%	
		            data = timetable[3][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" ><input type=checkbox name="11-11.50" value="11-11.50:M" ></div></td>
		 			            <td><%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[3][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" ><input type=checkbox name="11-11.50" value="11-11.50:W" ></div></td>
		 			            <td><%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[3][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" ><input type=checkbox name="11-11.50" value="11-11.50:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">13:00-13:50 </th>
		 			            <td><%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" ><input type=checkbox name="12-12.50" value="12-12.50:M"></div></td>
		 			            <td><%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td><%	
		            data = timetable[4][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" ><input type=checkbox name="12-12.50" value="12-12.50:W"></div></td>
		 			            <td><%	
		            data = timetable[4][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[4][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" ><input type=checkbox name="12-12.50" value="12-12.50:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">14:00-14:50 </th>
		 			            <td><%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" ><input type=checkbox name="14-14.50" value="14-14.50:M"></div></td>
		 			            <td><%	
		            data = timetable[5][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[5][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" ><input type=checkbox name="14-14.50" value="14-14.50:W"></div></td>
		 			            <td><%	
		            data = timetable[5][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[5][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" ><input type=checkbox name="14-14.50" value="14-14.50:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">15:00-15:50</th>
		 			            <td><%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" ><input type=checkbox name="15-15.50" value="15-15.50:M"></div></td>
		 			            <td><%	
		            data = timetable[6][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[6][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" ><input type=checkbox name="15-15.50" value="15-15.50:W"></div></td>
		 			            <td><%	
		            data = timetable[6][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[6][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" ><input type=checkbox name="15-15.50" value="15-15.50:F"></div></td>
		 			        </tr>
		 			         <tr>
		 			            <th scope="row">16:00-16:50 </th>
		 			            <td><%	
		            data = timetable[7][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" ><input type=checkbox name="16-16.50" value="16-16.50:M"></div></td>
		 			            <td><%	
		            data = timetable[7][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[7][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" ><input type=checkbox name="16-16.50" value="16-16.50:W"></div></td>
		 			            <td><%	
		            data = timetable[7][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td><%	
		            data = timetable[7][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" ><input type=checkbox name="16-16.50" value="16-16.50:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">17:00-17:50 </th>
		 			            <td><%	
		            data = timetable[8][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" ><input type=checkbox name="17-17.50" value="17-17.50:M"></div></td>
		 			            <td><%	
		            data = timetable[8][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[8][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" ><input type=checkbox name="17-17.50" value="17-17.50:W"></div></td>
		 			            <td><%	
		            data = timetable[8][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[8][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" ><input type=checkbox name="17-17.50" value="17-17.50:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">18:00-18:50 </th>
		 			            <td><%	
		            data = timetable[9][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="18-18.50" ><input type=checkbox name="18-18.50" value="18-18.50:M"></div></td>
		 			            <td><%	
		            data = timetable[9][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[9][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="18-18.50" ><input type=checkbox name="18-18.50" value="18-18.50:W"></div></td>
		 			            <td><%	
		            data = timetable[9][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[9][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            }
		            }
		        %><div id="18-18.50" ><input type=checkbox name="18-18.50" value="18-18.50:F"></div></td>
		 			        </tr>
		 			    </tbody>
 <%
  }
// if user enters number of days as 2 then dividing classes into 75min classes
  else if(noOfdays==2)
  {
  %>
  <tbody>
      <tr>
          <th scope="row">8:00-09:15</th>
          <td>
	            <%	
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td>
	            <%	
		            data = timetable[0][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				<div id="8-9.15" ><input type=checkbox class="checkbox" name="8-9.15" value="8-9.15:T"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			            <td>
	            <%	
		            data = timetable[0][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-9.15"><input type=checkbox class="checkbox" name="8-9.15" value="8-9.15:TR"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">09:30-10:45 </th>
		 						<td>
	            <%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		       </td>
		 			            <td><%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9.30-10.45" ><input type=checkbox name="9.30-10.45" value="9.30-10.45:T" ></div></td>
		 			            <td><%	
		            data = timetable[1][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9.30-10.45" ><input type=checkbox name="9.30-10.45" value="9.30-10.45:TR" ></div></td>
		 			            <td><%	
		            data = timetable[1][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">11:00-12:15 </th>
		 			            <td><%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12.15" ><input type=checkbox name="11-12.15" value="11-12.15:T" ></div></td>
		 			            <td><%	
		            data = timetable[2][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
		 			            <td><%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12.15" ><input type=checkbox name="11-12.15" value="11-12.15:TR" ></div></td>
		 			            <td><%	
		            data = timetable[2][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">12:30-13:45</th>
		 			            <td><%	
		            data = timetable[3][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="12.30-13.45" ><input type=checkbox name="12.30-13.45" value="12.30-13.45:T" ></div></td>
		 			            <td><%	
		            data = timetable[3][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="12.30-13.45" ><input type=checkbox name="12.30-13.45" value="12.30-13.45:TR"></div></td>
		 			            <td><%	
		            data = timetable[3][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">14:00-15:15 </th>
		 			            <td><%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="14-15.15" ><input type=checkbox name="14-15.15" value="14-15.15:T"></div></td>
		 			            <td><%	
		            data = timetable[4][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[4][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="14-15.15" ><input type=checkbox name="14-15.15" value="14-15.15:TR"></div></td>
		 			            <td><%	
		            data = timetable[4][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">15:30-16:45 </th>
		 			            <td><%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[5][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="15.30-16.45" ><input type=checkbox name="15.30-16.45" value="15.30-16.45:T"></div></td>
		 			            <td><%	
		            data = timetable[5][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[5][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="15.30-16.45" ><input type=checkbox name="15.30-16.45" value="15.30-16.45:TR"></div></td>
		 			            <td><%	
		            data = timetable[5][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">17:00-18:45</th>
		 			            <td><%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[6][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="17:00-18:45" ><input type=checkbox name="17:00-18:45" value="17:00-18:45:T"></div></td>
		 			            <td><%	
		            data = timetable[6][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[6][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="17:00-18:45" ><input type=checkbox name="17:00-18:45" value="17:00-18:45:TR"></div></td>
		 			            <td><%	
		            data = timetable[6][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			        </tr>		 			        
		 			    </tbody>
  <%
    }
  else
  {
	  %>
	  <tbody>
      <tr>
          <th scope="row">8:00-09:00</th>
          <td>
	            <%	
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				<div id="8-9" ><input type=checkbox class="checkbox" name="8-9" value="8-9:M"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				<div id="8-9" ><input type=checkbox class="checkbox" name="8-9" value="8-9:T"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-9" ><input type=checkbox class="checkbox" name="8-9" value="8-9:W"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-9"><input type=checkbox class="checkbox" name="8-9" value="8-9:TR"></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="8-9" ><input type=checkbox class="checkbox" name="8-9" value="8-9:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">09:00-10:00 </th>
		 						<td>
	            <%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-10" ><input type=checkbox name="9-10" value="9-10:M" ></div></td>
		 			            <td><%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-10" ><input type=checkbox name="9-10" value="9-10:T" ></div></td>
		 			            <td><%	
		            data = timetable[1][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-10" ><input type=checkbox name="9-10" value="9-10:W" ></div></td>
		 			            <td><%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-10" ><input type=checkbox name="9-10" value="9-10:TR" ></div></td>
		 			            <td><%	
		            data = timetable[1][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-10" ><input type=checkbox name="9-10" value="9-10:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">10:00-11:00 </th>
		 			            <td><%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="10-11" ><input type=checkbox name="10-11" value="10-11:M" ></div></td>
		 			            <td><%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-11" ><input type=checkbox name="10-11" value="10-11:T" ></div></td>
		 			            <td><%	
		            data = timetable[2][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-11" ><input type=checkbox name="10-11" value="10-11:W" ></div></td>
		 			            <td><%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-11" ><input type=checkbox name="10-11" value="10-11:TR" ></div></td>
		 			            <td><%	
		            data = timetable[2][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="10-11" ><input type=checkbox name="10-11" value="10-11:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">11:00-12:00</th>
		 			            <td><%	
		            data = timetable[3][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12" ><input type=checkbox name="11-12" value="11-12:M" ></div></td>
		 			            <td><%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12" ><input type=checkbox name="11-12" value="11-12:T" ></div></td>
		 			            <td><%	
		            data = timetable[3][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12" ><input type=checkbox name="11-12" value="11-12:W" ></div></td>
		 			            <td><%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12" ><input type=checkbox name="11-12" value="11-12:TR"></div></td>
		 			            <td><%	
		            data = timetable[3][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="11-12" ><input type=checkbox name="11-12" value="11-12:F" ></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">13:00-14:00 </th>
		 			            <td><%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="1-2" ><input type=checkbox name="1-2" value="1-2:M"></div></td>
		 			            <td><%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="1-2" ><input type=checkbox name="1-2" value="1-2:T"></div></td>
		 			            <td><%	
		            data = timetable[4][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="1-2" ><input type=checkbox name="1-2" value="1-2:W"></div></td>
		 			            <td><%	
		            data = timetable[4][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="1-2" ><input type=checkbox name="1-2" value="1-2:TR"></div></td>
		 			            <td><%	
		            data = timetable[4][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="1-2" ><input type=checkbox name="1-2" value="1-2:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">14:00-15:00 </th>
		 			            <td><%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="2-3" ><input type=checkbox name="2-3" value="2-3:M"></div></td>
		 			            <td><%	
		            data = timetable[5][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="2-3" ><input type=checkbox name="2-3" value="2-3:T"></div></td>
		 			            <td><%	
		            data = timetable[5][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="2-3" ><input type=checkbox name="2-3" value="2-3:W"></div></td>
		 			            <td><%	
		            data = timetable[5][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="2-3" ><input type=checkbox name="2-3" value="2-3:TR"></div></td>
		 			            <td><%	
		            data = timetable[5][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="2-3" ><input type=checkbox name="2-3" value="2-3:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">15:00-16:00</th>
		 			            <td><%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="3-4" ><input type=checkbox name="3-4" value="3-4:M"></div></td>
		 			            <td><%	
		            data = timetable[6][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="3-4" ><input type=checkbox name="3-4" value="3-4:T"></div></td>
		 			            <td><%	
		            data = timetable[6][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="3-4" ><input type=checkbox name="3-4" value="3-4:W"></div></td>
		 			            <td><%	
		            data = timetable[6][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="3-4" ><input type=checkbox name="3-4" value="3-4:TR"></div></td>
		 			            <td><%	
		            data = timetable[6][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="3-4" ><input type=checkbox name="3-4" value="3-4:F"></div></td>
		 			        </tr>
		 			         <tr>
		 			            <th scope="row">16:00-17:00 </th>
		 			            <td><%	
		            data = timetable[7][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="4-5" ><input type=checkbox name="4-5" value="4-5:M"></div></td>
		 			            <td><%	
		            data = timetable[7][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="4-5" ><input type=checkbox name="4-5" value="4-5:T"></div></td>
		 			            <td><%	
		            data = timetable[7][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="4-5" ><input type=checkbox name="4-5" value="4-5:W"></div></td>
		 			            <td><%	
		            data = timetable[7][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="4-5" ><input type=checkbox name="4-5" value="4-5:TR"></div></td>
		 			            <td><%	
		            data = timetable[7][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="4-5" ><input type=checkbox name="4-5" value="4-5:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">17:00-18:00 </th>
		 			            <td><%	
		            data = timetable[8][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="5-6" ><input type=checkbox name="5-6" value="5-6:M"></div></td>
		 			            <td><%	
		            data = timetable[8][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="5-6" ><input type=checkbox name="5-6" value="5-6:T"></div></td>
		 			            <td><%	
		            data = timetable[8][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="5-6" ><input type=checkbox name="5-6" value="5-6:W"></div></td>
		 			            <td><%	
		            data = timetable[8][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="5-6" ><input type=checkbox name="5-6" value="5-6:TR"></div></td>
		 			            <td><%	
		            data = timetable[8][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="5-6" ><input type=checkbox name="5-6" value="5-6:F"></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">18:00-19:00 </th>
		 			            <td><%	
		            data = timetable[9][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="6-7" ><input type=checkbox name="6-7" value="6-7:M"></div></td>
		 			            <td><%	
		            data = timetable[9][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="6-7" ><input type=checkbox name="6-7" value="6-7:T"></div></td>
		 			            <td><%	
		            data = timetable[9][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="6-7" ><input type=checkbox name="6-7" value="6-7:W"></div></td>
		 			            <td><%	
		            data = timetable[9][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %><div id="6-7" ><input type=checkbox name="6-7" value="6-7:TR"></div></td>
		 			            <td><%	
		            data = timetable[9][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            }
		            }
		        %><div id="6-7" ><input type=checkbox name="6-7" value="6-7:F"></div></td>
		 			        </tr>
		 			    </tbody>
	  <%
  }
   %>
          </table>
          
<input type=submit name=Show value="Show">
<%}
	}
	catch(Exception e){}
%>
  </form>
  </div>    
</div>
  <!-- javascript at the bottom for fast page loading -->
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.easing.min.js"></script>
  <script type="text/javascript" src="js/jquery.lavalamp.min.js"></script>
  <script type="text/javascript" src="js/image_fade.js"></script>
  <script type="text/javascript">
    $(function() {
      $("#lava_menu").lavaLamp({
        fx: "backout",
        speed: 700
      });
    });
  </script>
  </div>
</body>
</html>