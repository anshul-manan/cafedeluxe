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
		  fields(cdoSMTPServer) = "smtp.enforme.com"
		  fields(cdoSMTPServerPort) = 25
		  fields(cdoSMTPAuthenticate) = cdoAnonymous
		  fields.Update
		  
		  'get data from form
		  Dim strName, strTo, strEmail, strEmailConfirm, strPhone, strCompanyName, strLocation, strTypeofevent, strDate, strNumber, strComments, strBody, strTime, strHear
		  strName = Request.Form("name")
		  strEmail = Request.Form("email")
		  strEmailConfirm = Request.Form("emailconfirm")
		  strPhone = Request.Form("phone")
		  strCompanyName = Request.Form("companyName")
		  strDate = Request.Form("date")
		  strTime = Request.Form("time")
		  strLocation = Request.Form("location")
		  strTypeofevent = Request.Form("typeofevent")
		  strNumber = Request.Form("peopleNumber")
		  strHear = Request.Form("hear")
		  strComments = Request.Form("comments")
		 
		  'Email body
		      strBody = strName & " has sent an inquiry about private dining." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = strBody & "Phone:  " & strPhone & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Company:  " & strCompanyName & VbCrLf & "Date:  " & strDate & VbCrLf & "Time:  " & strTime & VbCrLf & "Restaurant:  " & strLocation & VbCrLf & "Type of Event:  " & strTypeofevent & VbCrLf & "Number of people:  " & strNumber & VbCrLf & "How did you hear about us?:  " & strHear & VbCrLf &  "Comments:  " & strComments
			  strTo = "events@cafedeluxe.com" 'mburrier@enforme.com
		  
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

		response.redirect("private-dining-form.asp?email=sent")
		 
end if

'message
		dim strMsg
		strMsg = request.queryString("email")
		select case strMsg
			case "sent"
		strMsg = "<h2>Your inquiry has been sent.</h2>"	
		end select
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="Cafe Deluxe restaurant,Cafe Deluxe,Cafe Deluxe Bistro,food,dining,dinner,lunch,brunch, restaurant, Cafe,food,job,employment opportunities, chef and restaurant manager opportunities, kitchen managers, career, fine dining, meeting place,bar,drinks, margaritas,menu,Tortilla Coast,Mexican, Bethesda,Capitol Hill,Washington DC,Maryland, gift certificates,fun,map recruitment
" /><meta name="description" content="Cafe Deluxe combines the charm of a neighborhood tavern with the energy of a bustling European bistro, serving traditional comfort foods with a modern flair
" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cafe Deluxe Private Dining Form</title>
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
reqd_fields[4] = 'date';
reqd_fields[5] = 'location';
reqd_fields[6] = 'peopleNumber';
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
	return (selectObj.value == '')?false:true;
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
				req_error								,email_error		,verify_error	,sec_error	);
	
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
                <li><a href="private-dining.asp" id="selected"><span class="navbold">P</span>RIVATE <span class="navbold">D</span>INING</a></li>
                <li><a href="giftcards.htm"><span class="navbold">G</span>IFT <span class="navbold">C</span>ARDS</a></li>
                <li><a href="newsevents.htm"><span class="navbold">N</span>EWS &amp; <span class="navbold">E</span>VENTS</a></li>
                <li><a href="employment.htm"><span class="navbold">E</span>MPLOYMENT</a></li>
                <li id="last"><a href="contact.asp"><span class="navbold">C</span>ONTACT <span class="navbold">U</span>S</a></li>
                </ul>  
                <div class="frequent-dining"><a href="frequent-dining.asp" target="_blank"><img src="images/frequent-dining-program.gif" alt="Frequent Dining Program" border="0" /></a></div>      
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
        <img src="images/locations.gif" alt="Locations" width="470" height="68" />
        <h2 align="center">~ OPENING IN WEST END DC LATE SPRING 2014 ~</h2><br />
        <h1 align="center"><span class="cap">P</span>RIVATE <span class="cap">D</span>INING <span class="cap">I</span>NQUIRY</h1>
          
          <!-- Form -->
<form action="" method="POST" name="cateringInquiry" id="cateringInquiry" onSubmit="return validate(this);">
					<%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  %>
                    <table border="0" class="text" width="400">
					  <tr>

				 	    <td colspan="2" align="right" class="bodytext"><span class="required-small">* Required fields</span></td>
					  </tr>
					  <tr>
						  <td width="166" class="bodytext">Name: <span class="red">*</span></td><td width="224" align="left"><input type="text" name="name" value="" maxlength="50"></td>
					  </tr>
					  <tr>

						  <td class="bodytext">Phone number: <span class="red">*</span></td><td align="left"><input type="text" name="phone" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td class="bodytext">E-mail address: <span class="red">*</span></td><td align="left"><input type="text" name="email" value="" maxlength="50"></td>
					  </tr>
					   <tr>
						  <td class="bodytext">Confirm E-Mail: <span class="red">*</span></td><td align="left"><input type="text" name="emailconfirm" value="" maxlength="50"></td>

					  </tr>
					  <tr>
						  <td class="bodytext" valign="top">Address:</td><td align="left"><textarea name="address" value="" rows="3" cols="" style=""></textarea></td>
					  </tr>
					  <tr>
						  <td class="bodytext">Company name:</td><td align="left"><input type="text" name="companyName" value="" maxlength="50"></td>
					  </tr>
					  <tr>
					 	 <td class="bodytext">Date of event: <span class="red">*</span></td><td align="left"><input type="text" name="date" value="" maxlength="50"></td>
					  </tr>
					  <tr>

						  <td class="bodytext">Start time of event:</td><td align="left"><input type="text" name="time" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td class="bodytext">Restaurant Location: <span class="red">*</span></td><td align="left"><select name="location">
						    <option value="Cleveland Park" selected="selected" >Cleveland Park</option>
						    <option value="Bethesda">Bethesda</option>
						    <option value="Tysons Corner">Tysons Corner</option>
						    <option value="Gaithersburg">Gaithersburg</option>
							<option value="West End">West End</option>
                          </select></td>
					  </tr>	
					  <tr>
						  <td class="bodytext">Number of people: <span class="red">*</span></td><td align="left"><input type="text" name="peopleNumber" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td class="bodytext">Type of Event: <span class="red">*</span></td><td align="left"><select name="typeofevent">
						    <option value="Birthday" selected="selected" >Birthday</option>
						    <option value="Meeting">Meeting</option>
						    <option value="Reception">Reception</option>
						    <option value="Rehearsal Dinner">Rehearsal Dinner</option>
							<option value="Shower">Shower</option>
							<option value="Holiday Party">Holiday Party</option>
							<option value="Reunion">Reunion</option>
							<option value="Other">Other</option>
                          </select></td>
					  </tr>		 
					  <tr>

						  <td class="bodytext">How you heard about us:</td><td align="left"><input type="text" name="hear" value=""></td>
					  </tr>
					  <tr>
						  <td colspan="2" class="bodytext">Comments / notes:</td>
					  </tr>
					  <tr>
						  <td colspan="2"><textarea name="comments" value="" rows="5" cols="50" style=""></textarea></td>

					  </tr>
					                    <tr>
                    <td align="left" valign="top">Security code: <span class="red">*</span></td>
                    <td align="left"><img src="images/verificationcode.gif" align="absmiddle" /> <input name="security" type="text" size="10" /></td>
                  </tr>
					  <tr>
						  <td colspan="2" align="right"><input type="submit" value="Submit" name="submit"></td>
					  </tr>  
					</table>
			  </form>
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
