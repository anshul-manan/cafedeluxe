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
		  Dim strName, strTo, strEmail, strPhone, strHelp, strComment, strEmailConfirm, strBody
		  strName = Request.Form("name")
		  strEmail = Request.Form("email")
		  strPhone = Request.Form("phone")
		  strHelp = Request.Form("help")
		  strComment = Request.Form("comment")
		  strEmailConfirm = Request.Form("emailconfirm")
		 
		  'Email body
		      strBody = strName & " has filled out the online contact form." & VbCrLf & VbCrLf
			  strBody = strBody & VbCrLf & VbCrLf & "------------------------------------------------" & VbCrLf & VbCrLf & "E-mail:  " & strEmail & VbCrLf
			  strBody = "Name:  " & strName & VbCrLf & "Email:  " & strEmail & VbCrLf & "Confirm Email:  " & strEmailConfirm & VbCrLf & "Phone:  " & strPhone & VbCrLf & "How can we help?:  " & strHelp & VbCrLf & "Comment:  " & strComment 
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Contact Cafe Deluxe</title>
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
	req_error = new Array();				email_error = new Array();	verify_error = new Array();	error = new Array(
				req_error								,email_error		,verify_error		);
	
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
<table width="779" border="0" align="center" valign="top" cellpadding="0" cellspacing="0" background="lib/images/Cafe-Deluxe-back-middle.gif">
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-top.gif" width="779" height="30" /></td>
  </tr>
  <tr>
    <td width="257" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" valign="top"><a href="index.htm"><img src="lib/images/cafedeluxe-logo.gif" width="193" height="99" border="0" /></a></td>
      </tr>
      <tr>
        <td valign="top" align="center"><script type="text/javascript">
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
          <table border="0" cellpadding="0" cellspacing="0" width="230">
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
              <td><a href="private-dining.asp" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r6_c2','lib/nav/nav_r6_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r6_c2','lib/nav/nav_r6_c2_f2.gif','lib/nav/nav_r6_c2_f3.gif',1);MM_swapImage('nav_r6_c2','','lib/nav/nav_r6_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r6_c2" src="lib/nav/nav_r6_c2.gif" width="211" height="44" border="0" id="nav_r6_c2" alt="" /></a></td>
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
              <td><a href="contact.asp" target="_top" onclick="MM_nbGroup('down','navbar1','nav_r12_c2','lib/nav/nav_r12_c2_f3.gif',1)" onmouseover="MM_nbGroup('over','nav_r12_c2','lib/nav/nav_r12_c2_f2.gif','lib/nav/nav_r12_c2_f3.gif',1);MM_swapImage('nav_r12_c2','','lib/nav/nav_r12_c2_f2.gif',1)" onmouseout="MM_swapImgRestore();MM_nbGroup('out')"><img name="nav_r12_c2" src="lib/nav/nav_r12_c2_f2.gif" width="211" height="38" border="0" id="nav_r12_c2" alt="" /></a></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="38" border="0" alt="" /></td>
            </tr>
            <tr>
              <td><img name="nav_r13_c2" src="lib/nav/nav_r13_c2.gif" width="211" height="46" border="0" id="nav_r13_c2" alt="" /></td>
              <td><img src="lib/nav/spacer.gif" width="1" height="46" border="0" alt="" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td><!-- #BeginLibraryItem "/Library/frequent dining program.lbi" --><a href="frequent-dining-card.asp" target="_top"><img src="lib/images/frequent-dining-program.gif" alt="Frequent Dining Program" width="187" height="114" border="0" /></a><!-- #EndLibraryItem --></td>
      </tr>
    </table></td>
    <td width="522" align="center" valign="top"><p><img src="lib/images/Cafe-Deluxe-locations-top.gif" width="449" height="80" /></p>
      <table width="80%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td style="border:1px solid #93885F"><img src="lib/images/FOOD_Seabass.jpg" width="470" height="282" alt="Seabass" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td valign="top" align="left" class="bodytext"><br>Questions? Comments? Concerns?  Please complete the form below and we'll respond as quickly as possible.
              
              </p>
              <form action="" method="POST" name="contactForm" id="contactForm" onSubmit="return validate(this);"><!--onSubmit="JavaScript: return validateMe();"-->
                <%
					  if strMsg <> "" then
					  	response.write "<div class='alert'><b>" & strMsg & "</b></div>"
					  end if
					  
					  %>
                <table width="472" border="0" cellpadding="3" cellspacing="3" class="bodytext">
                  <tr>
                    <td colspan="2" align="right">*Required Fields</td>
                    </tr>
                  <tr>
                    <td width="188" align="left">Name:*</td>
                    <td width="263" align="left"><input type="text" name="name"= /></td>
                  </tr>
                  <tr>
                    <td align="left">Email Address:*</td>
                    <td align="left"><input type="text" name="email" /></td>
                  </tr>
                  <tr>
                    <td align="left">Confirm Email:*</td>
                    <td align="left"><input type="text" name="emailconfirm" /></td>
                  </tr>
                  <tr>
                    <td align="left">Phone Number:*</td>
                    <td align="left"><input type="text" name="phone" /></td>
                  </tr>
                  <tr>
                    <td align="left">How can we help?*</td>
                    <td align="left"><select name="help" class="bodytext">
                      <option value="Guest Feedback">Guest Feedback</option>
                      <option value="Frequent Dining Program">Frequent Dining Program</option>
                      <option value="Charitable Donations">Charitable Donations</option>
                      <option value="General Questions">General Questions</option>
                      <option value="Gift Cards">Gift Cards</option>
                    </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top">Question or comment:</td>
                    <td align="left"><textarea name="comment" cols="35" rows="5"></textarea></td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center" valign="top">
                      <input type="submit" value="Submit" name="submit">
                    </td>
                    </tr>
                </table>
              </form>
              <p><strong>Charitable Donations</strong><br>
Cafe Deluxe and Tortilla Coast proudly support numerous local charities and neighborhood organizations. Due to the high volume of requests, we cannot respond to every inquiry. We do our best to respond within 14-days, however we will not respond if we decline to participate. We do not accept phone requests so please send your solicitation via <a href="javascript:noSpam('donations','cafedeluxe.com')" onFocus="this.blur();"><strong>email</strong></a>, fax or regular mail:</p>
              <p><strong>Mail: </strong>3704 Macomb Street, NW, Suite 2, Washington, DC 20016<br />
              <strong>Fax:</strong> (202) 362-4893</p>
                </td>
   
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="2"><img src="lib/images/Cafe-Deluxe-back-bottom.gif" width="779" height="25" /></td>
  </tr>
</table><!-- #BeginLibraryItem "/Library/footer nav.lbi" -->
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
</table><!-- #EndLibraryItem --><p>
  <map name="Map">
  </map>
</p>
</body>
</html>
