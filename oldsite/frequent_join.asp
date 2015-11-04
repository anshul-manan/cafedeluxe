<!--METADATA TYPE="typelib" UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" NAME="CDO for Windows 2000 Type Library" --> 
<%@LANGUAGE="VBSCRIPT"%>
<% Option Explicit %>
<%
		dim newCDO, iConf, fields
if request.form("submit") <> "" then
		  Set newCDO = CreateObject("CDO.Message")
		  Set iConf = CreateObject("CDO.Configuration")
		  Set fields = iConf.Fields
		  
		  fields(cdoSendUsingMethod) = cdoSendUsingPort
		  fields(cdoSMTPServer) = "mailone.enforme.com"
		  fields(cdoSMTPServerPort) = 25
		  fields(cdoSMTPAuthenticate) = cdoAnonymous
		  fields.Update
		  
		  'get data from form
		  Dim strFirstName, strLastName, strTo, strBirthdate, strAddress, strCity, strState, strZip, strPhone, strEmail, strEmailConfirm,strBody
		  strFirstName = Request.Form("firstname")
		  strLastName = Request.Form("lastname")
		  strBirthdate = Request.Form("birthdate")
		  strAddress = Request.Form("address")
		  strCity = Request.Form("city")
		  strState = Request.Form("state")
		  strZip = Request.Form("zip")
		  strPhone = Request.Form("phone")
		  strEmail = Request.Form("email")
		  strEmailConfirm = Request.Form("emailconfirm")
		 
		  'Email body
		      strBody = strFirstName & " has sent an inquiry about Frequent Dining Enrollment." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = "First:  " & strFirstName & VbCrLf & "Last:  " & strLastName & VbCrLf & "Birthdate:  " & strBirthdate & VbCrLf & "Address:  " & strAddress & VbCrLf & "City:  " & strCity & VbCrLf & "State:  " & strState & VbCrLf & "Zip:  " & strZip & VbCrLf & "Phone:  " & strPhone & VbCrLf & "Email:  " & strEmail & VbCrLf & "Confirm Email:  " & strEmailConfirm
			  strTo = "marketing@cafedeluxe.com"
		  
		  With newCDO
		  Set .Configuration = iConf
		  .To = strTo
		  .From = Request.Form("email")
		  .Subject = "Frequent Dining Enrollment Form"
		  .TextBody = strBody
		  .Send
		  End With
		  
		  Set newCDO = nothing
		  Set iConf = nothing
		  Set fields = nothing

		response.redirect("frequent_join.asp?email=sent")
		 
end if

'message
		dim strMsg
		strMsg = request.queryString("email")
		select case strMsg
			case "sent"
		strMsg = "<h1>Your enrollment form has been sent.</h1>"	
		end select
%>


<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<head>
<title>Cafe Deluxe- Frequent Dining Program</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="styles.css"/>
<!--[if ie]>
	<link rel="stylesheet" type="text/css" href="ie.css">
	<![endif]-->
</head>

<body bgcolor="#F3C05A" background="images/bkg.gif" link="#A30A14" vlink="#CC6600" alink="#6666CC" text="#000000" topmargin="0">



<table border="0" width="241px" align="left">
  <tr>
    <td height="483" align="left" valign="top">
	<img src="images/animatedframe.gif" WIDTH="150" HEIGHT="130"><br>
	
	<ul class="nav_left">
        <li class="menu"><a href="menu.htm" title="Menu"></a></li>
        <li class="frequent"><a href="frequent.htm" title="Frequent Dining Club" class="selected" style="height: 52px;"></a></li>
		<li class="private"><a href="private.htm" title="Private Dining"></a></li>
		<li class="gift"><a href="giftcards.aspx" title="Gift Cards"></a></li>
		<li class="location"><a href="locations.htm" title="Locations"></a></li>
		<li class="jobs"><a href="jobs.htm" title="Jobs"></a></li>
		<li class="contact"><a href="contactus.htm" title="Contact Us"></a></li>
	</ul>

      <a href="http://www.tortillacoast.com" target="_blank"><img src="images/tcoastbanner.gif" alt="Tortilla Coast" border="0" WIDTH="139" HEIGHT="104"></a> 

    </td>
  </tr>
</table>


<table border="0" width="585" align="left" cellpadding="2">
  <tr> 
    <td height="53" align="center" valign="middle"><a href="index.htm"><img name="image1" src="images/CDlogo.gif" border="0" alt="Cafe Deluxe Home" WIDTH="210" HEIGHT="108"></a><br>
      <img src="images/linegfx.gif" border="0" WIDTH="505" HEIGHT="13"><br>
      <a href="frequent.htm"><img src="images/titlefrequent.gif" border="0"></a> </td>
  </tr>
  
	<tr>
		<td class="menu_frequent">
			<ul>
				<li><a href="frequent_join.asp" class="selected">ENROLL TODAY</a></li>
                <li><a href="frequent_rules.htm">PROGRAM RULES</a></li>
				<li><a href="frequent_faqs.htm">FAQ's</a></li>
				<li><a href="https://www.valutec.net/Customers/Balance.aspx" target="_blank" style="background: none">CHECK BALANCE</a></li>
			</ul>		</td>
	</tr>
  <tr> 
    <td style="vertical-align: top"><h1 align="center"><br>
      Frequent Dining Enrollment Form</h1><br>
<form action="" method="POST" name="freqeuntDining" id="freqeuntDining">
					<table width="400" border="0" align="center" class="text">
					  <%
					  if strMsg <> "" then
					  	response.write "<tr><td colspan=""2"" height=""50""><b>" & strMsg & "</b></td></tr>"
					  end if
					  %>
					  <tr>
						  <td width="110">First Name:</td>
						  <td><input type="text" name="firstname" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Last Name:</td>
						  <td><input type="text" name="lastname" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Birth date <br>
					      (MM/DD)</td>
					    <td><input type="text" name="birthdate" value="" maxlength="50"></td>
					  </tr>
					   <tr>
					     <td>&nbsp;</td>
					     <td>&nbsp;</td>
				      </tr>
					  <tr>
						  <td>Address:</td><td><textarea name="address"></textarea></td>
					  </tr>
					  <tr>
					 	 <td>City:</td><td><input type="text" name="city" value="" maxlength="50"></td>
					  </tr>
					  <tr>
                        <td>State:</td>
					    <td><input name="state" type="text" value="" size="2" maxlength="50"></td>
				      </tr>
					  <tr>
						  <td>Zip:</td><td><input name="zip" type="text" value="" size="10" maxlength="50"></td>
					  </tr>		  
					  <tr>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
				      </tr>
					  <tr>
						  <td>Phone:</td><td><input type="text" name="phone" value=""></td>
					  </tr>
					  <tr>
                        <td>Email:</td>
					    <td><input name="email" type="text" id="email" value=""></td>
				      </tr>
					  <tr>
					    <td>Confirm Email:</td>
					    <td><input name="emailconfirm" type="text" id="emailconfirm" value=""></td>
				      </tr>
					  <tr>
					    <td colspan="2">&nbsp;</td>
				      </tr>
					  <tr>
						  <td colspan="2"> Thank you for enrolling today. You will receive your Frequent Dining card in 3 to 4 business days.</td>
					  </tr>
					  <tr>
						  <td colspan="2" align="center"><input type="submit" value="Submit" name="submit"></td>
					  </tr>
					  <tr>
					    <td colspan="2" align="center">Please DO NOT click Submit button more than once.</td>
				      </tr>  
					</table>
	  </form>

      </td>
  </tr>
  <tr> 
    <td height="53" align="center" valign="middle"> 
      <p><img name="image4" src="images/dings2.gif" WIDTH="505" HEIGHT="20"></p>      </td>
  </tr>
</table>

</body>
</html>
