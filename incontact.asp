<html>

<head>
<title>WHO WE HELP</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" link="#339966" vlink="#666666">
<%  'Error Handling line
	         On Error Resume next
		'Create CDONTS Mail object
		 Dim MyMail ,finalBody
		 Set MyMail =CreateObject("CDONTS.NewMail") 
		'Get all form values
        	 finalBody= "<html>"&_
                            "<body>"&_   
      "<table width='552' height='33' border='0' cellpadding='1' cellspacing='1'>"&_
    
     "<tr>"&_ 
      "<font size='2' face='Tahoma, Arial, Verdana, sans-serif' COLOR='RED'>NEW CONTACT MAIL</font>"&_
          "<p><br>"&_
          "</p>"&_
	 "</tr><TABLE>"&_	  
		  
          "<table width='521' height='83' border='0' align='left' cellpadding='2' cellspacing='2'>"&_
            "<tr bgcolor='#339933'>"&_ 
              "<td colspan='2'> <div align='center'><font color='#FFFFFF' size='3' face='Tahoma, Arial, Verdana, sans-serif'><strong>Get In touch with Us </strong></font></div></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td width='150'><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Name :</strong></font></td>"&_
              "<td width='371'><font face='verdana' size='2' color='red'>"&Trim(Request("name"))&"</font></td>"&_
            "</tr>"&_
            "<tr> "&_
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Address 1 :</strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("add1"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Address 2 :</strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("add2"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>State :</strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("state"))&"</font></td>"&_
            "</tr>"&_
            "<tr> "&_
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Country : </strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("country"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><strong><font size='2' face='Tahoma, Arial, Verdana, sans-serif'>Pincode :</font></strong></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("pc"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><strong><font size='2' face='Tahoma, Arial, Verdana, sans-serif'>Email Address :</font></strong></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("em"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Phone Number :</strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("pn"))&"</font></td>"&_
            "</tr>"&_
            "<tr>"&_ 
              "<td><font size='2' face='Tahoma, Arial, Verdana, sans-serif'><strong>Message:</strong></font></td>"&_
              "<td><font face='verdana' size='2' color='red'>"&Trim(Request("mess"))&"</font></td></tr>"&_
             
	     "<TABLE>"&_
             "</BODY>" & _
	    "</HTML>"

 
		MyMail.From = "info@whowehelp.org"
		MyMail.To = "info@whowehelp.org"		
		MyMail.Subject = "NEW CONTACT"
		MyMail.BodyFormat = 0 
		MyMail.MailFormat = 0
		MyMail.Importance= 2
		MyMail.Body =finalBody
		'Send the mail
		 MyMail.Send		
		'Release the mail object
		Set MyMail = Nothing
 'response.redirect "/confirmation.html"

%>
<font>your mail is send</font> 
</body>
</html>
