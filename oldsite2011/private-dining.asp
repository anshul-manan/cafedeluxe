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
		  Dim strName, strTo, strEmail, strEmailConfirm, strPhone, strCompanyName, strLocation, strDate, strNumber, strComments, strBody, strTime, strHear
		  strName = Request.Form("name")
		  strEmail = Request.Form("email")
		  strEmailConfirm = Request.Form("emailconfirm")
		  strPhone = Request.Form("phone")
		  strCompanyName = Request.Form("companyName")
		  strDate = Request.Form("date")
		  strTime = Request.Form("time")
		  strLocation = Request.Form("location")
		  strNumber = Request.Form("peopleNumber")
		  strHear = Request.Form("hear")
		  strComments = Request.Form("comments")
		 
		  'Email body
		      strBody = strName & " has sent an inquiry about private dining." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = strBody & "Phone:  " & strPhone & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Company:  " & strCompanyName & VbCrLf & "Date:  " & strDate & VbCrLf & "Time:  " & strTime & VbCrLf & "Restaurant:  " & strLocation & VbCrLf & "Number of people:  " & strNumber & VbCrLf & "How did you hear about us?:  " & strHear & VbCrLf &  "Comments:  " & strComments
			  strTo = "events@CafeDeluxe.com" 'mburrier@enforme.com
		  
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

		response.redirect("private-dining.asp?email=sent")
		 
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cafe Deluxe Private Dining</title>
<meta name="description" content="Cafe Deluxe combines the charm of a neighborhood tavern with the energy of a bustling European bistro, serving traditional comfort foods with a modern flair
" />
<meta name="description" content="Cafe Deluxe restaurant,Cafe Deluxe,Cafe Deluxe Bistro,food,dining,dinner,lunch,brunch, restaurant, Cafe,food,job,employment opportunities, chef and restaurant manager opportunities, kitchen managers, career, fine dining, meeting place,bar,drinks, margaritas,menu,Tortilla Coast,Mexican, Bethesda,Capitol Hill,Washington DC,Maryland, gift certificates,fun,map recruitment
" />
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
	color: #CC3433;
}
a:visited {
	color: #D54746;
}
a:hover {
	color: #D54746;
}
a:active {
	color: #DD5C5B;
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
reqd_fields[0] = 'name';
reqd_fields[1] = 'email';
reqd_fields[2] = 'emailconfirm';
reqd_fields[3] = 'phone';
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

<body onload="MM_preloadImages('../lib/nav/nav_r2_c2_f3.gif','../lib/nav/nav_r2_c2_f2.gif','../lib/nav/nav_r4_c2_f3.gif','../lib/nav/nav_r4_c2_f2.gif','../lib/nav/nav_r6_c2_f3.gif','../lib/nav/nav_r6_c2_f2.gif','../lib/nav/nav_r8_c2_f3.gif','../lib/nav/nav_r8_c2_f2.gif','../lib/nav/nav_r10_c2_f3.gif','../lib/nav/nav_r10_c2_f2.gif','../lib/nav/nav_r12_c2_f3.gif','../lib/nav/nav_r12_c2_f2.gif')">
<p>&nbsp;</p>
<table width="779" border="0" align="center" style="vertical-align:top" cellpadding="0" cellspacing="0" background="lib/images/Cafe-Deluxe-back-middle.gif">
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-top.gif" width="779" height="30" /></td>
  </tr>
  <tr>
    <td width="278" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" valign="top"><a href="index.htm"><img src="lib/images/cafedeluxe-logo.gif" width="193" height="99" border="0" class="bodytext" /></a></td>
      </tr>
      <tr>
        <td align="center"><script type="text/javascript">
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
          <table border="0" cellpadding="0" cellspacing="0" width="230" valign="top">
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
              <td><a href="menu.htm" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r2_c2','lib/nav/nav_r2_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r2_c2','lib/nav/nav_r2_c2_f2.gif','lib/nav/nav_r2_c2_f3.gif',1);MM_swapImage('nav_r2_c2','','lib/nav/nav_r2_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r2_c2" src="lib/nav/nav_r2_c2.gif" width="211" height="44" border="0" id="nav_r2_c2" alt="" /></a></td>
              <td rowspan="12"><img name="nav_r2_c3" src="lib/nav/nav_r2_c3.gif" width="11" height="333" border="0" id="nav_r2_c3" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="44" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r3_c2" src="lib/nav/nav_r3_c2.gif" width="211" height="10" border="0" id="nav_r3_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="10" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><a href="locations.htm" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r4_c2','lib/nav/nav_r4_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r4_c2','lib/nav/nav_r4_c2_f2.gif','lib/nav/nav_r4_c2_f3.gif',1);MM_swapImage('nav_r4_c2','','lib/nav/nav_r4_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r4_c2" src="lib/nav/nav_r4_c2.gif" width="211" height="45" border="0" id="nav_r4_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="45" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r5_c2" src="lib/nav/nav_r5_c2.gif" width="211" height="5" border="0" id="nav_r5_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="5" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><a href="private-dining.asp" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r6_c2','lib/nav/nav_r6_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r6_c2','lib/nav/nav_r6_c2_f2.gif','lib/nav/nav_r6_c2_f3.gif',1);MM_swapImage('nav_r6_c2','','lib/nav/nav_r6_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r6_c2" src="lib/nav/nav_r6_c2_f2.gif" width="211" height="44" border="0" id="nav_r6_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="44" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r7_c2" src="lib/nav/nav_r7_c2.gif" width="211" height="10" border="0" id="nav_r7_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="10" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><a href="giftcards.htm" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r8_c2','lib/nav/nav_r8_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r8_c2','lib/nav/nav_r8_c2_f2.gif','lib/nav/nav_r8_c2_f3.gif',1);MM_swapImage('nav_r8_c2','','lib/nav/nav_r8_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r8_c2" src="lib/nav/nav_r8_c2.gif" width="211" height="36" border="0" id="nav_r8_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="36" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r9_c2" src="lib/nav/nav_r9_c2.gif" width="211" height="7" border="0" id="nav_r9_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="7" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><a href="jobs.htm" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r10_c2','lib/nav/nav_r10_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r10_c2','lib/nav/nav_r10_c2_f2.gif','lib/nav/nav_r10_c2_f3.gif',1);MM_swapImage('nav_r10_c2','','lib/nav/nav_r10_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r10_c2" src="lib/nav/nav_r10_c2.gif" width="211" height="39" border="0" id="nav_r10_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="39" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r11_c2" src="lib/nav/nav_r11_c2.gif" width="211" height="9" border="0" id="nav_r11_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="9" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><a href="contact.asp" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r12_c2','lib/nav/nav_r12_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r12_c2','lib/nav/nav_r12_c2_f2.gif','lib/nav/nav_r12_c2_f3.gif',1);MM_swapImage('nav_r12_c2','','lib/nav/nav_r12_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r12_c2" src="lib/nav/nav_r12_c2.gif" width="211" height="38" border="0" id="nav_r12_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="38" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r13_c2" src="lib/nav/nav_r13_c2.gif" width="211" height="46" border="0" id="nav_r13_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="46" border="0" alt="" /></td>
            </tr>
          </table></td>
      </tr>
      <!--<a href="http://www.cafedeluxe.com/frequent-dining-card.asp" id="Frequent" title="Frequent Dining Program" target="_blank"><span>Frequent Dining Program</span></a>-->
    </table></td>
    <td width="500" align="left" valign="top">
      <table width="80%" border="0" cellspacing="0" cellpadding="0">
                <tr>
        <td align="center"><p><img src="lib/images/Cafe-Deluxe-locations-top.gif" width="449" height="80" /></p>
        </td>
        </tr>
        <tr>
        <td style="border:1px solid #93885F"><img src="lib/images/LOCATION_PrivateDiningRoom.jpg" width="470" height="282" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="bodytext"><br>Cafe Deluxe locations offer several private and semi-private group dining venues, accommodating 10 to 200 guests. Warm and sophisticated atmospheres and delicious bistro-style cuisine create the ideal location for your next business or social event. Our versatile menu options can be customized to fit your event whether it's a rehearsal dinner, family brunch or office party.
              <br>
               </p>
              <p class="bodytext">Download our <a href="lib/menus/CateringCDW-2010-11-08.pdf"><strong>private dining menus and FAQ's</strong></a><br><br>
                Ready to schedule your next special event? Submit an event inquiry or contact our event team at (202) 465-4677 or <a href="javascript:noSpam('events','cafedeluxe.com')" onFocus="this.blur();"><strong>email us</strong></a>.</p></td>

          </tr>
          <tr><td>
          <form action="" method="POST" name="cateringInquiry" id="cateringInquiry" onSubmit="return validate(this);">
					<%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  %>
                    <table border="0" class="text" width="400">
					  <tr>

				 	    <td colspan="2" align="right" class="bodytext"><span class="red">*</span> Required fields</td>
					  </tr>
					  <tr>
						  <td width="110" class="bodytext">Name: <span class="red">*</span></td><td align="left"><input type="text" name="name" value="" maxlength="50"></td>
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
						  <td class="bodytext">Company name:</td><td align="left"><input type="text" name="companyName" value="" maxlength="50"></td>
					  </tr>
					  <tr>
					 	 <td class="bodytext">Date of event:</td><td align="left"><input type="text" name="date" value="" maxlength="50"></td>
					  </tr>
					  <tr>

						  <td class="bodytext">Time of day:</td><td align="left"><input type="text" name="time" value="" maxlength="50"></td>
					  </tr>
					  <tr>
						  <td class="bodytext">Restaurant Location:</td><td align="left"><select name="location">
						    <option value="Cleveland Park">Cleveland Park</option>
						    <option value="Bethesda">Bethesda</option>
						    <option value="Tysons Corner">Tysons Corner</option>
						    <option value="Tortilla Coast">Tortilla Coast</option>
                          </select></td>
					  </tr>	
					  <tr>
						  <td class="bodytext">Number of people:</td><td align="left"><input type="text" name="peopleNumber" value="" maxlength="50"></td>
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
                    <td align="left"><img src="lib/images/verificationcode.gif" align="absmiddle" /> <input name="security" type="text" size="10" /></td>
                  </tr>
					  <tr>
						  <td colspan="2" align="right"><input type="submit" value="Submit" name="submit"></td>
					  </tr>  
					</table>
			  </form>
             
          
          </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-bottom.gif" width="779" height="25" /></td>
  </tr>
</table>
<!-- #BeginLibraryItem "/Library/footer nav.lbi" -->
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
</table>
<!-- #EndLibraryItem -->
<map name="Map" id="Map">
</map>
</body>
</html>
