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
		  Dim strName, strTo, strEmail, strPhone, strHelp, strLocation, strComment, strEmailConfirm, strBody
		  strName = Request.Form("name")
		  strEmail = Request.Form("email")
		  strPhone = Request.Form("phone")
		  strHelp = Request.Form("help")
		  strLocation = Request.Form("location")
		  strComment = Request.Form("comment")
		  strEmailConfirm = Request.Form("emailconfirm")
		 
		  'Email body
		      strBody = strName & " has filled out the online contact form." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = "Name:  " & strName & VbCrLf & "Email:  " & strEmail & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Phone:  " & strPhone & VbCrLf & "How can we help?:  " & strHelp & VbCrLf & "Restaurant Location:  " & strLocation & VbCrLf & "Comment:  " & strComment 
			  strTo = "info@cafedeluxe.com"  'mburrier@enforme.com
		  
		  With newCDO
		  Set .Configuration = iConf
		  .To = strTo
		  .From = Request.Form("email")
		  .Subject = "Website Contact Form from " & strName
		  .TextBody = strBody
		  .Send
		  End With
		  
		  Set newCDO = nothing
		  Set iConf = nothing
		  Set fields = nothing

		response.redirect("contact.asp?email=sent")
		 
end if

'message
		dim strMsg
		strMsg = request.queryString("email")
		select case strMsg
			case "sent"
		strMsg = "<h2>Your message has been sent.</h2>"	
		end select
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="Cafe Deluxe restaurant,Cafe Deluxe,Cafe Deluxe Bistro,food,dining,dinner,lunch,brunch, restaurant, Cafe,food,job,employment opportunities, chef and restaurant manager opportunities, kitchen managers, career, fine dining, meeting place,bar,drinks, margaritas,menu,Tortilla Coast,Mexican, Bethesda,Capitol Hill,Washington DC,Maryland, gift certificates,fun,map recruitment
" /><meta name="description" content="Cafe Deluxe combines the charm of a neighborhood tavern with the energy of a bustling European bistro, serving traditional comfort foods with a modern flair
" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Contact Cafe Deluxe</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

//use errorMode=0 for alert
//use errorMode=1 to write errors to an element
errorMode = 0;

//elementId to write the errors to (if applicable)
errorElementId = '';

//custom js arrays
var reqd_fields = new Array();
reqd_fields[0] = 'name';
reqd_fields[1] = 'email';
reqd_fields[2] = 'emailconfirm';
reqd_fields[3] = 'phone';
reqd_fields[4] = 'security';
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
	req_error = new Array(); email_error = new Array();	verify_error = new Array();	sec_error = new Array(); error = new Array( req_error,email_error,verify_error,sec_error	);
	
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
                <li id="last"><a href="contact.asp" id="selected"><span class="navbold">C</span>ONTACT <span class="navbold">U</span>S</a></li>
                </ul> 
                <div class="frequent-dining"><a href="frequent-dining.htm"><img src="images/frequent-dining-program.gif" alt="Frequent Dining Program" border="0" /></a></div>       
        </div></td>
        <td valign="top" class="rightcolumn">
        <div>
        	<ul id="social">
            	<li class="fb"><a href="http://www.facebook.com/cafedeluxe" target="_blank"></a></li>
                <li class="twitter"><a href="http://www.twitter.com/cafedeluxe" target="_blank"></a></li>
                <!--<li class="newsletter"><a href="newsevents.htm"></a></li>-->
            </ul>
        </div>
        <img src="images/locations.gif" alt="Locations" width="470" height="68" /><br />
          <h2 align="center">~ NOW OPEN IN GAITHERSBURG ~</h2><br />
          <h1 align="center"><span class="cap">Q</span>UESTIONS, <span class="cap">C</span>OMMENTS OR <span class="cap">C</span>ONCERNS?</h1>
<p>Please complete the form below and we'll respond as quickly as possible.</p>

          <!-- Form -->
          <form action="" method="POST" name="contactForm" id="contactForm" onSubmit="return (validate(this) && checkForm());">
                <%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  
					  %>
                <table width="472" border="0" cellpadding="3" cellspacing="3" class="bodytext">
                  <tr>
                    <td colspan="2" align="right"><span class="required-small">* Required Fields</span></td>
                    </tr>
                  <tr>
                    <td width="188" align="left">Name: <span class="red">*</span></td>
                    <td width="263" align="left"><input type="text" name="name"= /></td>
                  </tr>
                  <tr>
                    <td align="left">Email Address: <span class="red">*</span></td>
                    <td align="left"><input type="text" name="email" /></td>
                  </tr>
                  <tr>
                    <td align="left">Confirm Email: <span class="red">*</span></td>
                    <td align="left"><input type="text" name="emailconfirm" /></td>
                  </tr>
                  <tr>
                    <td align="left">Phone Number: <span class="red">*</span></td>
                    <td align="left"><input type="text" name="phone" /></td>
                  </tr>
                  <tr>
                    <td align="left">How can we help? <span class="red">*</span></td>
                    <td align="left"><select name="help" class="bodytext">
                      <option value="Guest Feedback">Guest Feedback</option>
                      <option value="Frequent Dining Program">Frequent Dining Program</option>
                      <option value="Charitable Donations">Charitable Donations</option>
                      <option value="General Questions">General Questions</option>
                      <option value="Gift Cards">Gift Cards</option>
                    </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top">Restaurant Location: </td>
                    <td align="left"><select name="location">
						    <option value="Cleveland Park">Cleveland Park</option>
						    <option value="Bethesda">Bethesda</option>
						    <option value="Tysons Corner">Tysons Corner</option>
						    <option value="Gaithersburg">Gaithersburg</option>
                          </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top">Question or comment:</td>
                    <td align="left"><textarea name="comment" cols="35" rows="5"></textarea></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top">Security code: <span class="red">*</span></td>
                    <td align="left"><img src="images/verificationcode.gif" align="absmiddle" /> <input name="security" type="text" size="10" /></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center" valign="top">
                      <input type="submit" value="Submit" name="submit" id="submit">
                    </td>
                    </tr>
                </table>
              </form>
          <!-- End Form -->          
          <br />
<h1 align="center"><span class="cap">C</span><span class="tabletext">HARITABLE </span><span class="cap">D</span><span class="tabletext">ONATIONS</span></h1>
<span class="tabletext">
          <table width="470" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="220" align="left" valign="top" class="tabletext"><p>Cafe Deluxe and Tortilla Coast proudly support numerous local and neighborhood charities and organizations.</p>
                <p>Due to the high volume of requests, we cannot respond to every inquiry.</p>
                <p>We do our best to respond within 14-days, but will not respond if we decline to participate.</p></td>
              <td width="30">&nbsp;</td>
              <td width="220" align="left" valign="top" class="tabletext"><p>We do not accept phone requests, so please submit your solicitation via:</p>
                <ul style="text-align:left;">
  <li style="padding-bottom:5px;"><strong>Email</strong>, using the form above</li>
                  <li style="padding-bottom:5px;"><strong>Fax</strong> at 202.362.4893</li>
                  <li><strong>Regular Mail</strong> to:<br />
                    3704 Macomb Street, NW<br />Suite 2<br />
                    Washington, DC 20016</li>
              </ul></td>
              </tr>
          </table>
</span></td>
      </tr>
    </table></td>
    <td width="500" align="left" valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="images/frame_bottom.png" width="779" height="25" /></td>
  </tr>
</table>

<div class="footer">
    <div class="copyright">&copy; 2011 Cafe Deluxe</div>
    <div class="restuarants">
    	<table width="300" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="visit">Visit our other restaurants</td>
    <td><a href="http://www.tortillacoast.com" target="_blank"><img src="images/tortillacoast.png" alt="Tortilla Coast" border="0" /></a></td>
  </tr>
</table>
</div>
</div>

</body>
</html>
