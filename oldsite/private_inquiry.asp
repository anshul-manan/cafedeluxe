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
		  Dim strName, strTo, strEmail, strEmailConfirm, strPhone, strCompanyName, strRestaurant, strDate, strLoc, strNumber, strNotes, strBody, strTime, strHear
		  strName = Request.Form("name")
		  strEmail = Request.Form("email")
		  strEmailConfirm = Request.Form("emailconfirm")
		  strPhone = Request.Form("phone")
		  strCompanyName = Request.Form("companyName")
		  strRestaurant = Request.Form("restaurant")
		  strDate = Request.Form("date")
		  strTime = Request.Form("time")
		  strNumber = Request.Form("peopleNumber")
		  strHear = Request.Form("hear")
		  strNotes = Request.Form("notes")
		 
		  'Email body
		      strBody = strName & " has sent an inquiry about private dining." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = strBody & "Phone:  " & strPhone & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Company:  " & strCompanyName & VbCrLf & "Date:  " & strDate & VbCrLf & "Time:  " & strTime & VbCrLf & "Restaurant:  " & strRestaurant & VbCrLf & "# of people:  " & strNumber & VbCrLf & "How did you hear about us?:  " & strHear & VbCrLf &  "Notes:  " & strNotes
			  strTo = "events@CafeDeluxe.com"
		  
		  With newCDO
		  Set .Configuration = iConf
		  .To = strTo
		  .From = Request.Form("email")
		  .Subject = "Cafe Deluxe Private Dining Inquiry from " & strName
		  .TextBody = strBody
		  .Send
		  End With
		  
		  Set newCDO = nothing
		  Set iConf = nothing
		  Set fields = nothing

		response.redirect("private_inquiry.asp?email=sent")
		 
end if

'message
		dim strMsg
		strMsg = request.queryString("email")
		select case strMsg
			case "sent"
		strMsg = "<h1>Your inquiry has been sent.</h1>"	
		end select
%>


<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<head>
<title>Cafe Deluxe- Private Dining</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="styles.css"/>


<script language="Javascript">
	function validateMe(){
		var strMessage = "";
		var blnError = false;
		
		strMessage = "Please correct the items listed below and click the Submit button to continue:";
		
		if(document.cateringInquiry.nameFirst.value == ''){
			strMessage = strMessage + "\nPlease enter your first name.";
			blnError = true;
		}
		
		if(document.cateringInquiry.nameLast.value == ''){
			strMessage = strMessage + "\nPlease enter your last name.";
			blnError = true;
		}
		
		if(document.cateringInquiry.email.value == ''){
			strMessage = strMessage + "\nPlease enter your email.";
			blnError = true;
		}
		if(document.cateringInquiry.phone.value == ''){
			strMessage = strMessage + "\nPlease enter your phone number.";
			blnError = true;
		}
		else {
			if (document.cateringInquiry.email.value.indexOf('@') < 0 || document.cateringInquiry.email.value.indexOf('.') < 0 || document.cateringInquiry.email.value.indexOf(' ') >= 0) {
				blnError = true;
				strMessage = strMessage + '\nPlease enter a valid email address. A valid email address must have one "@" symbol (but not more than one), at least one "." and must contain no spaces.';
			}
			else {
				var TempString = document.cateringInquiry.email.value;
				var TempArray = TempString.split('@');
				if (TempArray.length > 2) {
					blnError = true;
					strMessage = strMessage + '\nPlease enter a valid email address. A valid email address must have only one "@" symbol.';
				}
			}
		}
		
		if(blnError == true){
			alert(strMessage);
			return false;
		} else {
			return true;
		}
	}
	</script>
</head>

<body bgcolor="#F3C05A" background="images/bkg.gif" link="#A30A14" vlink="#CC6600" alink="#6666CC" text="#000000" topmargin="0">


<table border="0" width="241px" align="left">
  <tr>
    <td height="483" align="left" valign="top">
	<img src="images/animatedframe.gif" WIDTH="150" HEIGHT="130"><br>
	
	<ul class="nav_left">
        <li class="menu"><a href="menu.htm" title="Menu"></a></li>
        <li class="frequent"><a href="frequent.htm" title="Frequent Dining Club" style="height: 52px;"></a></li>
		<li class="private"><a href="private.htm" title="Private Dining" class="selected"></a></li>
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
    <td height="53" align="center" valign="middle" colspan="2"><a href="index.htm"><img name="image1" src="images/CDlogo.gif" border="0" alt="Cafe Deluxe Home" WIDTH="210" HEIGHT="108"></a><br>
      <img src="images/linegfx.gif" border="0" WIDTH="505" HEIGHT="13"><br>
      <img src="images/titleprivate.gif"> </td>
  </tr>
  
	<tr>
		<td colspan="2" class="menu_private">
			<ul>
				<li><a href="private_menu.htm">Event Menus</a></li>
				<li><a href="private_misc.htm">Misc. Info</a></li>
				<li><a href="private_directions.htm">Directions</a></li>
				<li><a href="private_inquiry.asp" style="background: none" class="selected">Event Inquiry</a></li>
			</ul>
		</td>
	</tr>

  <tr> 
    <td colspan="2" style="vertical-align: top"> 
					<p class="text">Welcome to Cafe Deluxe Private Dining.  We look forward to helping you plan a great party!</p>
					<p class="text">Please fill out this form to inquire about private dining, and we'll get back to you within 24 hours. Thanks for your interest!</p>
				    <form action="" method="POST" name="cateringInquiry" id="cateringInquiry" onSubmit="JavaScript: return validateMe();">
					<table border="0" class="text" width="400">
					  <%
					  if strMsg <> "" then
					  	response.write "<tr><td colspan=""2"" height=""50""><b>" & strMsg & "</b></td></tr>"
					  end if
					  %><tr>
					 	 <td colspan="2" style="font-size: 11px;"><span class="req">*</span> - Required fields</td>
					  </tr>
					  <tr>
						  <td width="110">Name:<span class="req">*</span></td><td><input type="text" name="name" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Phone number:<span class="req">*</span></td><td><input type="text" name="phone" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>E-mail address:<span class="req">*</span></td><td><input type="text" name="email" value="" maxlength="50"></td>
					  </tr>
					   <tr>
						  <td>Confirm E-Mail:</td><td><input type="text" name="emailconfirm" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Company name:</td><td><input type="text" name="companyName" value="" maxlength="50"></td>
					  </tr>
					  <tr>
					 	 <td>Date of event:</td><td><input type="text" name="date" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Time of day:</td><td><input type="text" name="time" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td>Name of Restaurant:</td><td><input type="text" name="restaurant" value="" maxlength="50"></td>
					  </tr>	
					  <tr>
						  <td>Number of people:</td><td><input type="text" name="peopleNumber" value="" maxlength="50"></td>
					  </tr>		 
					  <tr>
						  <td>How you heard about us:</td><td><input type="text" name="hear" value=""></td>
					  </tr>
					  <tr>
						  <td colspan="2">Comments / notes:</td>
					  </tr>
					  <tr>
						  <td colspan="2"><textarea name="notes" value="" maxlength="1000" rows="10" cols="50" style=""></textarea></td>
					  </tr>
					  <tr>
						  <td colspan="2" align="right"><input type="submit" value="Submit" name="submit"></td>
					  </tr>  
					</table>
			  </form>
 </td>

  </tr>
  <tr> 
    <td height="53" align="center" valign="middle" colspan="2"> 
      <p><img name="image4" src="images/dings2.gif" WIDTH="505" HEIGHT="20"></p>
      </td>
  </tr>
</table>

</body>
</html>