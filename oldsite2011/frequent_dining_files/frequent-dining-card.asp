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
			  strTo = "marketing@cafedeluxe.com" 'mburrier@enforme.com
		  
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

		response.redirect("frequent-dining-card.asp?email=sent")
		 
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cafe Deluxe Frequent Dining Program</title>
<style type="text/css">
<!--
body {
	background-color: #FFF8D9;
	text-align: center;
}
.bodytext {
	font-family: Georgia, "Times New Roman", Times, serif;
	font-size: 14px;
}
a:link {
	font-family: Georgia, "Times New Roman", Times, serif;
	font-size: 14px;
	font-style: normal;
	font-weight: bold;
	color: #CC3433;
}
.bodytext2 {
	font-family: Georgia, "Times New Roman", Times, serif;
	font-size: 14px;
	font-weight: bold;
	color: CC3433;
}
h2 {
	font-size: 14px;
	font-style: italic;
}
.alert {
	background-color: #FFF8D9;
	display: block;
	padding: 5px;
	text-align: center;
	margin: 20px 0 20px 0;
	border: 1px solid #CCC;
}
.red {
	color: #CC0000;
}
-->
</style>
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

<body onload="MM_preloadImages('lib/nav/nav_r2_c2_f3.gif','lib/nav/nav_r2_c2_f2.gif','lib/nav/nav_r4_c2_f3.gif','lib/nav/nav_r4_c2_f2.gif','lib/nav/nav_r6_c2_f3.gif','lib/nav/nav_r6_c2_f2.gif','lib/nav/nav_r8_c2_f3.gif','lib/nav/nav_r8_c2_f2.gif','lib/nav/nav_r10_c2_f3.gif','lib/nav/nav_r10_c2_f2.gif','lib/nav/nav_r12_c2_f3.gif','lib/nav/nav_r12_c2_f2.gif')">
<p>&nbsp;</p>
<table width="779" border="0" align="center" style="vertical-align:top" cellpadding="0" cellspacing="0" background="lib/images/Cafe-Deluxe-back-middle.gif">
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-top.gif" width="779" height="30" /></td>
  </tr>
  <tr>
    <td width="278" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center"><a href="index.htm"><img src="lib/images/cafedeluxe-logo.gif" alt="" width="193" height="99" border="0" /></a></td>
      </tr>
      <tr>
        <td align="center"><!-- #BeginLibraryItem "/Library/nav.lbi" --><script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<body onLoad="MM_preloadImages('../lib/nav/nav_r2_c2_f3.gif','../lib/nav/nav_r2_c2_f2.gif','../lib/nav/nav_r4_c2_f3.gif','../lib/nav/nav_r4_c2_f2.gif','../lib/nav/nav_r6_c2_f3.gif','../lib/nav/nav_r6_c2_f2.gif','../lib/nav/nav_r8_c2_f3.gif','../lib/nav/nav_r8_c2_f2.gif','../lib/nav/nav_r10_c2_f3.gif','../lib/nav/nav_r10_c2_f2.gif','../lib/nav/nav_r12_c2_f3.gif','../lib/nav/nav_r12_c2_f2.gif')"><table border="0" cellpadding="0" cellspacing="0" width="230">
  <!-- fwtable fwsrc="Menu.png" fwpage="Page 1" fwbase="nav.gif" fwstyle="Dreamweaver" fwdocid = "833027933" fwnested="0" -->
  <tr>
    <td><img src="lib/nav/spacer.gif" width="8" height="1" border="0" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="211" height="1" border="0" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="11" height="1" border="0" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="3"><img name="nav_r1_c1" src="lib/nav/nav_r1_c1.gif" width="230" height="18" border="0" id="nav_r1_c1" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="18" border="0" alt="" /></td>
  </tr>
  <tr>
    <td rowspan="12"><img name="nav_r2_c1" src="lib/nav/nav_r2_c1.gif" width="8" height="333" border="0" id="nav_r2_c1" alt="" /></td>
    <td><a href="menu.htm" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r2_c2','lib/nav/nav_r2_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r2_c2','lib/nav/nav_r2_c2_f2.gif','lib/nav/nav_r2_c2_f3.gif',1);MM_swapImage('nav_r2_c2','','lib/nav/nav_r2_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r2_c2" src="lib/nav/nav_r2_c2.gif" width="211" height="44" border="0" id="nav_r2_c2" alt="" /></a></td>
    <td rowspan="12"><img name="nav_r2_c3" src="lib/nav/nav_r2_c3.gif" width="11" height="333" border="0" id="nav_r2_c3" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="44" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r3_c2" src="lib/nav/nav_r3_c2.gif" width="211" height="10" border="0" id="nav_r3_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><a href="locations.htm" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r4_c2','lib/nav/nav_r4_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r4_c2','lib/nav/nav_r4_c2_f2.gif','lib/nav/nav_r4_c2_f3.gif',1);MM_swapImage('nav_r4_c2','','lib/nav/nav_r4_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r4_c2" src="lib/nav/nav_r4_c2.gif" width="211" height="45" border="0" id="nav_r4_c2" alt="" /></a></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="45" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r5_c2" src="lib/nav/nav_r5_c2.gif" width="211" height="5" border="0" id="nav_r5_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><a href="private-dining.asp" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r6_c2','lib/nav/nav_r6_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r6_c2','lib/nav/nav_r6_c2_f2.gif','lib/nav/nav_r6_c2_f3.gif',1);MM_swapImage('nav_r6_c2','','lib/nav/nav_r6_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r6_c2" src="lib/nav/nav_r6_c2.gif" width="211" height="44" border="0" id="nav_r6_c2" alt="" /></a></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="44" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r7_c2" src="lib/nav/nav_r7_c2.gif" width="211" height="10" border="0" id="nav_r7_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><a href="giftcards.htm" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r8_c2','lib/nav/nav_r8_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r8_c2','lib/nav/nav_r8_c2_f2.gif','lib/nav/nav_r8_c2_f3.gif',1);MM_swapImage('nav_r8_c2','','lib/nav/nav_r8_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r8_c2" src="lib/nav/nav_r8_c2.gif" width="211" height="36" border="0" id="nav_r8_c2" alt="" /></a></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="36" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r9_c2" src="lib/nav/nav_r9_c2.gif" width="211" height="7" border="0" id="nav_r9_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="7" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><a href="jobs.htm" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r10_c2','lib/nav/nav_r10_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r10_c2','lib/nav/nav_r10_c2_f2.gif','lib/nav/nav_r10_c2_f3.gif',1);MM_swapImage('nav_r10_c2','','lib/nav/nav_r10_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r10_c2" src="lib/nav/nav_r10_c2.gif" width="211" height="39" border="0" id="nav_r10_c2" alt="" /></a></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="39" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r11_c2" src="lib/nav/nav_r11_c2.gif" width="211" height="9" border="0" id="nav_r11_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><a href="contact.asp" target="_top" onClick="MM_nbGroup('down','navbar1','nav_r12_c2','lib/nav/nav_r12_c2_f3.gif',1)" onMouseOver="MM_nbGroup('over','nav_r12_c2','lib/nav/nav_r12_c2_f2.gif','lib/nav/nav_r12_c2_f3.gif',1);MM_swapImage('nav_r12_c2','','lib/nav/nav_r12_c2_f2.gif',1)" onMouseOut="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r12_c2" src="lib/nav/nav_r12_c2.gif" width="211" height="38" border="0" id="nav_r12_c2" alt="" /></a></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="38" border="0" alt="" /></td>
  </tr>
  <tr>
    <td><img name="nav_r13_c2" src="lib/nav/nav_r13_c2.gif" width="211" height="46" border="0" id="nav_r13_c2" alt="" /></td>
    <td><img src="lib/nav/spacer.gif" width="1" height="46" border="0" alt="" /></td>
  </tr>
</table>
<!-- #EndLibraryItem --></td>
      </tr>
      <tr>
        <td style="text-align:center"><!-- #BeginLibraryItem "/Library/frequent dining program.lbi" --><a href="frequent-dining-card.asp" target="_top"><img src="lib/images/frequent-dining-program.gif" alt="Frequent Dining Program" width="187" height="114" border="0" /></a><!-- #EndLibraryItem --></td>      
        </tr>
    </table></td>
    <td width="500" align="left" valign="top">
      <table width="80%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
        <td align="center"><p><img src="lib/images/Cafe-Deluxe-locations-top.gif" width="449" height="80" /></p>
        </td>
        </tr>

        <tr>
        <td style="border:1px solid #93885F"><img src="lib/images/FOOD_Salmon.jpg" width="470" height="282" /></td>
      </tr>
      <tr>
            <td class="bodytext"><br>Ready to make the most of your Cafe Deluxe dining experience?  Join our Frequent Dining Program and earn 1 point for every dollar you spend on food and drink.  Just present your Frequent Dining card when you pay and watch the points add up.
              <p>
              <table align="center">
                <tr>
                  <td align="center">
            <strong>REWARD LEVELS<br><br>
            350 points, $20 off future visit<br><br>
            500 points, $35 off future visit<br><br>
            750 points, $50 off future visit<br><br>
            1,000 points, $100 off future visit</strong><br>
</td><tr></table>
              <p class="bodytext">
*Read the <a href="frequent-dining-rules.htm" class="bodytext"><strong>program rules</strong></a>, <a href="frequent-dining-faqs.htm"><strong>review the FAQ's</strong></a> and <a href="https://www.valutec.net/Customers/Balance.aspx" target="_blank"><strong>check your account balance</strong></a>.
              <p>
<strong>Sign up today!</strong>
<form action="" method="POST" name="freqeuntDining" id="freqeuntDining" onSubmit="return validate(this);">
					<%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  %>
                    <table width="400" border="0" align="center" class="text">
					  
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
						  <td><span class="bodytext">Birth date (MM/DD):</span></td>

					    <td align="left"><span class="bodytext">
				        <input type="text" name="birthdate" value="" maxlength="50">
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
						  <td><span class="bodytext">Phone:</span></td>
						  <td align="left"><span class="bodytext">
					      <input type="text" name="phone" value="">
						  </span></td>

					  </tr>
					  <tr>
                        <td><span class="bodytext">Email:</span></td>
					    <td align="left"><span class="bodytext">
				        <input name="email" type="text" id="email" value="">
					    </span></td>
				      </tr>
					  <tr>
					    <td><span class="bodytext">Confirm Email:</span></td>
					    <td align="left"><span class="bodytext">
				        <input name="emailconfirm" type="text" id="emailconfirm" value="">
					    </span></td>

				      </tr>
				  <tr>
                    <td align="left" valign="top">Security code: <span class="red">*</span></td>
                    <td align="left"><img src="lib/images/verificationcode.gif" align="absmiddle" /> <input name="security" type="text" size="10" /></td>
                  </tr>
					  <tr>
					    <td colspan="2">&nbsp;</td>
				      </tr>
					  <tr>
						  <td colspan="2"><span class="bodytext"> Thank you for enrolling today. You will receive your Frequent Dining card in 3 to 4 business days.<em> As a program member you will receive special email offers and promotions from Cafe Deluxe.</em></span></td>
					  </tr>
					  <tr>
						  <td colspan="2" align="center"><input type="submit" value="Submit" name="submit"></td>
					  </tr>
					  <tr>
					    <td colspan="2" align="center">&nbsp;</td>
				      </tr>  
					</table>
	  </form>

</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-bottom.gif" width="779" height="25" /></td>
  </tr>
</table>
<map name="Map" id="Map">
</map><!-- #BeginLibraryItem "/Library/footer nav.lbi" -->
<style type="text/css">
<!--
a:link {
	color: #F00;
}
a:visited {
	color: #F00;
}
a:hover {
	color: #F00;
}
a:active {
	color: #F00;
}
-->
</style>
<table align="center">
<tr>
<td width="178" class="bodytext" style="font-size:9px; font-family:Arial, Helvetica, sans-serif; color:#333"><a href="privacy.htm">privacy</a>- (c) 2009 Cafe Deluxe</td>
</tr>
</table><!-- #EndLibraryItem --></body>
</html>
