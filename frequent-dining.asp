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
		  fields(cdoSMTPServer) = "mail.enforme.com"
		  fields(cdoSMTPServerPort) = 25
		  fields(cdoSMTPAuthenticate) = cdoAnonymous
		  fields.Update
		  
		  'get data from form
		  Dim strTitle, strFirstName, strLastName, strTo, strBirthdate, strAddress, strCity, strState, strZip, strPhone, strEmail, strEmailConfirm, strChildren, strBody
		  strTitle = Request.Form("title")
		  strFirstName = Request.Form("firstname")
		  strLastName = Request.Form("lastname")
		  strBirthdate = Request.Form("birthdate")
		  strAddress = Request.Form("address")
		  strCity = Request.Form("city")
		  strState = Request.Form("state")
		  strZip = Request.Form("zip")
		  strPhone = Request.Form("phone")
		  strChildren = Request.Form("children")
		  strEmail = Request.Form("email")
		  strEmailConfirm = Request.Form("emailconfirm")
		 
		  'Email body
		      strBody = strFirstName & " has sent an inquiry about Frequent Dining Enrollment." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = "Title:  " & strTitle & VbCrLf & "First:  " & strFirstName & VbCrLf & "Last:  " & strLastName & VbCrLf & "Birthdate:  " & strBirthdate & VbCrLf & "Address:  " & strAddress & VbCrLf & "City:  " & strCity & VbCrLf & "State:  " & strState & VbCrLf & "Zip:  " & strZip & VbCrLf & "Phone:  " & strPhone & VbCrLf & "Email:  " & strEmail & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Number of Children:  " & strChildren
			  strTo = "info@cafedeluxe.com" 'mburrier@enforme.com
		  
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

		response.redirect("frequent-dining.asp?email=sent")
		 
end if

'message
		dim strMsg
		strMsg = request.queryString("email")
		select case strMsg
			case "sent"
		strMsg = "<h2>Your enrollment form has been sent.</h2>"	
		end select
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="Cafe Deluxe restaurant,Cafe Deluxe,Cafe Deluxe Bistro,food,dining,dinner,lunch,brunch, restaurant, Cafe,food,job,employment opportunities, chef and restaurant manager opportunities, kitchen managers, career, fine dining, meeting place,bar,drinks, margaritas,menu,Tortilla Coast,Mexican, Bethesda,Capitol Hill,Washington DC,Maryland, gift certificates,fun,map recruitment
" /><meta name="description" content="Cafe Deluxe combines the charm of a neighborhood tavern with the energy of a bustling European bistro, serving traditional comfort foods with a modern flair
" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cafe Deluxe Frequent Dining Program</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript1.2" type="text/javascript">
	<!--
		function noSpam(user,domain) {
		locationstring = "mailto:" + user + "@" + domain;
			window.location = locationstring;
		}

		function MM_openBrWindow(theURL,winName,features) { //v2.0
			window.open(theURL,winName,features);
		}
	-->
</script>
<script type="text/javascript">

//use errorMode=0 for alert
//use errorMode=1 to write errors to an element
errorMode = 0;

//elementId to write the errors to (if applicable)
errorElementId = '';

//custom js arrays
var reqd_fields = new Array();
reqd_fields[0] = 'email';
reqd_fields[1] = 'emailconfirm';
var sec_fields = new Array();
sec_fields[0] = 'security';
var email_fields = new Array();
email_fields[0] = 'email';
email_fields[1] = 'emailconfirm';
var verify_fields = new Array();
verify_fields[0] = new Array();
verify_fields[0][0] = 'email';
verify_fields[0][1] = 'emailconfirm';
	
function dropdownSelected(selectObj) {
	return (selectObj.selectedIndex == 0 || selectObj.value == '')?false:true;
}
function checkboxChecked(checkboxObj) {
	return checkboxObj.checked;
}
function inputFilled(formElem) {
	return (formElem.value == '')?false:true;
}
function isProvided(formElem) {
	switch (formElem.type) {
		case 'select-one':
			return dropdownSelected(formElem);
			break;
		case 'checkbox':
			return checkboxChecked(formElem);
			break;
		default:
			return inputFilled(formElem);
			break;
	}
}
function isEmail(formElem) {
	emailStr = formElem.value;
	atPos = emailStr.indexOf('@');
	dotPos = emailStr.lastIndexOf('.');
	return (atPos > 0 && dotPos > atPos && dotPos < emailStr.length-2);
}
function isSecure(formElem) {
	secStr = formElem.value;
	secPos = secStr.indexOf('23ZALV');
	return (secPos < secStr.length);
}
function displayErrors(a) {
	flag = true;
	spacer = (errorMode==0)?"\n":"<br />";
	errStr = "";
	for (var i=0; i < a.length; i++) {
		if (a[i].length > 0) {
			flag = false;
			for (var v=0; v < a[i].length; v++) {
				errStr += a[i][v] + spacer;					
			}		
		}
	}
	if (errStr != "") {
		if (errorMode == 0)
			alert(errStr);
		else {
			document.getElementById(errorElementId).innerHTML = errStr;
			location.href = "#";			
		}
	}
	return flag;
}
//call from onsubmit parameter of form tag like this: return validate(this)
function validate(formObj) {
	req_error = new Array();				email_error = new Array();	verify_error = new Array();	sec_error = new Array(); error = new Array(
				req_error								,email_error		,verify_error,sec_error		);
	
	for (var i=0; i < reqd_fields.length; i++) {
		formElem = formObj.elements[reqd_fields[i]];
		if (!isProvided(formElem))
			req_error[req_error.length] = formElem.name + " is a required field.";
	}
	for (var i=0; i < email_fields.length; i++) {
		formElem = formObj.elements[email_fields[i]];
		if (!isEmail(formElem))
			email_error[email_error.length] = "\'" + formElem.value + "\' is not a valid email address.";
	}
	for (var i=0; i < sec_fields.length; i++) {
		formElem = formObj.elements[sec_fields[i]];
		if (!isSecure(formElem))
			sec_error[sec_error.length] = "You entered the wrong Security Code. Please try again.";
	}
	for (var i=0; i < verify_fields.length; i++) {
		formElem0 = formObj.elements[verify_fields[i][0]];
		formElem1 = formObj.elements[verify_fields[i][1]];
		if (formElem0.value != formElem1.value)
			verify_error[verify_error.length] = formElem1.name + ' must be the same as ' + formElem0.name + '.';
	}
	return displayErrors(error);
}
</script>
</head>

<body>
<table width="779" border="0" align="center" style="vertical-align:top" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="images/frame_top.png" width="779" height="30" /></td>
  </tr>
  <tr>
    <td width="278" valign="top" background="images/frame_repeat.png"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top" class="leftcolumn"><a href="index.htm"><img src="images/cafedeluxe.gif" alt="Cafe Deluxe" width="191" height="93" border="0" /></a>
        
        <div class="nav">
        	<ul>
            	<li><a href="menus.htm"><span class="navbold">M</span>ENUS</a></li>
                <li><a href="locations.htm"><span class="navbold">L</span>OCATIONS &amp; <span class="navbold">H</span>OURS</a></li>
                <li><a href="private-dining.htm"><span class="navbold">P</span>RIVATE <span class="navbold">D</span>INING</a></li>
                <li><a href="giftcards.htm"><span class="navbold">G</span>IFT <span class="navbold">C</span>ARDS</a></li>
                <li><a href="newsevents.htm"><span class="navbold">N</span>EWS &amp; <span class="navbold">E</span>VENTS</a></li>
                <li><a href="employment.htm"><span class="navbold">E</span>MPLOYMENT</a></li>
                <li id="last"><a href="contact.asp"><span class="navbold">C</span>ONTACT <span class="navbold">U</span>S</a></li>
                </ul>  
				<h2 align="center">Click <a href="https://cloverrestaurantgroup.myguestaccount.com/login/reverse-enroll.srv?merchant_id=zCfppKHjnk4%3d&card_template_id=95JM1yY%2bTeY%3d&label=Frequent%20Dining%20Program" target=_blank>here</a> to join our Frequent Dining Program</h2><br /><br />
                <div class="frequent-dining"><a href="frequent-dining.htm"><img src="images/frequent-dining-program.gif" alt="Frequent Dining Program" border="0" /></a></div>      
        </div></td>
        <td valign="top" class="rightcolumn">
        <div>
        	<ul id="social">
            	<li class="fb"><a href="http://www.facebook.com/cafedeluxe" target="_blank"></a></li>
                <li class="twitter"><a href="http://www.twitter.com/cafedeluxe" target="_blank"></a></li>
				<li class="instagram"><a href="http://instagram.com/cafedeluxedc" target="_blank"></a></li>
                <!--<li class="newsletter"><a href="newsevents.htm"></a></li>-->
            </ul>
        </div>
        <img src="images/locations.gif" alt="Locations" width="470" height="68" /><br />
          <h2 align="center">&nbsp;</h2><br />
          <img src="images/tysonscorner_photo.jpg" width="470" height="282" alt="Tysons Corner" />
          <br /><br />

		  <br /><br />
          <table width="470" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="220" align="left" valign="top" class="tabletext"><p>Ready to make the most of your dining experience at Cafe Deluxe?</p><p>As a member of our <em>Frequent Dining Program</em>, you'll earn one point for every dollar you spend on food and drink at any of our Cafe Deluxe or Tortilla Coast locations. Just present your <em>Frequent Dining</em> card when you pay&mdash;and watch your rewards points add up!</p>
              <p>For more information, see our &nbsp; <strong><a href="pdf/Frequent Dining Program Rules.pdf">Program Rules</a></strong> &amp; <strong><a href="pdf/Frequent Dining Program FAQs.pdf">Answers to FAQs</a></strong>.</p></td>
              <td width="30">&nbsp;</td>
              <td width="220" align="center" valign="top">
              <h2 style="padding-bottom:10px;">REWARD LEVELS</h2>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" style="text-align:center; margin-top:5px;">
  				<tr>
    				<td style="padding-bottom:16px;"><strong>350 points:</strong> <em>$20 off future visit</em></td>
  				</tr>
  				<tr>
    				<td style="padding-bottom:16px;"><strong> 500 points:</strong> <em>$35 off future visit</em></td>
  				</tr>
  				<tr>
    				<td style="padding-bottom:16px;"><strong>750 points:</strong> <em>$50 off future visit</em></td>
  				</tr>
  				<tr>
    				<td style="padding-bottom:16px;"><strong>1,000 points:</strong> <em>$100 off future visit</em></td>
  				</tr>
			</table>
			
			
             <p align="left">To check your <em>Frequent Dining</em> card balance, click <a href="https://cloverrestaurantgroup.myguestaccount.com/login/accountbalance.srv?id=30GdmoeULK4%3d" target="_blank"><strong>here</strong></a>.</p>
</td>
            </tr>
          </table>

          
          
          <!-- Form -->
		  <!-- Temporarily commenting out for new enroll link
          <form action="" method="POST" name="freqeuntDining" id="freqeuntDining" onSubmit="return validate(this);">
					</%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  %>
                    <table width="400" border="0" align="center" class="text">
					  <tr>
						  <td width="152"><span class="bodytext">Title:</span></td>
						  <td width="238" align="left"><span class="bodytext">
					      <select name="title">
						  	<option name="Mr.">Mr.
							<option name="Ms.">Ms.
							<option name="Mrs.">Mrs.
							<option name="Dr.">Dr.
							<option name="Rev.">Rev.
						  </select>
						  </span></td>

					  </tr>
				    <tr>
						  <td width="152"><span class="bodytext">First Name:</span></td>
						  <td width="238" align="left"><span class="bodytext">
					      <input type="text" name="firstname" value="" maxlength="50">
						  </span></td>

					  </tr>
					  <tr>
						  <td><span class="bodytext">Last Name:</span></td>
						  <td align="left"><span class="bodytext">
					      <input type="text" name="lastname" value="" maxlength="50">
						  </span></td>
					  </tr>
					
					   <tr>
					     <td>&nbsp;</td>
					     <td align="left">&nbsp;</td>
				      </tr>
					  <tr>
						  <td><span class="bodytext">Address:</span></td>
						  <td align="left"><span class="bodytext">
					      <textarea name="address"></textarea>
						  </span></td>

					  </tr>
					  <tr>
					 	 <td><span class="bodytext">City:</span></td>
					 	 <td align="left"><span class="bodytext">
				 	     <input type="text" name="city" value="" maxlength="50">
					 	 </span></td>
					  </tr>
					  <tr>
                        <td><span class="bodytext">State:</span></td>
					    <td align="left"><span class="bodytext">
				        <input name="state" type="text" value="" size="2" maxlength="50">
					    </span></td>
				      </tr>

					  <tr>
						  <td><span class="bodytext">Zip:</span></td>
						  <td align="left"><span class="bodytext">
					      <input name="zip" type="text" value="" size="10" maxlength="50">
						  </span></td>
					  </tr>		  
					  <tr>
					    <td>&nbsp;</td>
					    <td align="left">&nbsp;</td>
				      </tr>
					  <tr>
						  <td><span class="bodytext">Telephone:</span></td>
						  <td align="left"><span class="bodytext">
					      <input type="text" name="phone" value="">
						  </span></td>

					  </tr>
					  <tr>
                        <td><span class="bodytext">Email:<span class="red">*</span></span></td>
					    <td align="left"><span class="bodytext">
				        <input name="email" type="text" id="email" value="">
					    </span></td>
				      </tr>
					  <tr>
					    <td><span class="bodytext">Confirm Email:<span class="red">*</span></span></td>
					    <td align="left"><span class="bodytext">
				        <input name="emailconfirm" type="text" id="emailconfirm" value="">
					    </span></td>

				      </tr>
					      <tr>
						  <td><span class="bodytext">Birth Date:</span></td>

					    <td align="left"><span class="bodytext">
				        <input type="text" name="birthdate" value="" maxlength="50">
					    </span></td>
					  </tr>
					    <tr>
						  <td><span class="bodytext">Number of Children Under 18 in Household:</span></td>

					    <td align="left"><span class="bodytext">
				        <input type="text" name="children" value="" maxlength="50">
					    </span></td>
					  </tr>
				  <tr>
                    <td align="left" valign="top">Security Code: <span class="red">*</span></td>
                    <td align="left"><img src="images/verificationcode.gif" align="absmiddle" /> <input name="security" type="text" size="10" /></td>
                  </tr>
					  <tr>
					    <td colspan="2">&nbsp;</td>
				      </tr>
					  <tr>
						  <td colspan="2"><span class="bodytext"> Thank you for enrolling. You should receive your <em>Frequent Dining</em> card in three to four business days.</span></td>
					  </tr>
					  <tr>
						  <td colspan="2" align="center"><input type="submit" value="Submit" name="submit"></td>
					  </tr> 
					</table>
	  </form>
	  -->
          <!-- End Form -->
          
          </td>
      </tr>
    </table></td>
    <td width="500" align="left" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="images/frame_bottom.png" width="779" height="25" /></td>
  </tr>
</table>

<div class="footer">
    <div class="copyright">&copy; 2012 <a href="http://www.cloverrestaurantgroup.com" target="_blank">Clover Restaurant Group LLC</a></div>
    <div class="restuarants">
    	<table width="300" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="visit">Visit our other restaurants</td>
    <td><a href="http://www.tortillacoast.com" target="_blank"><img src="images/tortillacoast.png" alt="Tortilla Coast" border="0" /></a></td>
  </tr>
</table>
</div>
</div>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-42971504-1', 'cafedeluxe.com');
  ga('send', 'pageview');

</script>

</body>
</html>
