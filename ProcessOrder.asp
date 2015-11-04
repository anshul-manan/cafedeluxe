<!-- connect.asp -->
<!-- #include file="fdgg-util_sha2.asp"-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
               PushForm()
    });
   
    function PushForm() {
        var identifier = $("#oid").val();
        if (identifier=='') { /* For Merchant Test Environment (CTE) */
            history.go(-1);
        }
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
       <form method="post" id="redirectForm" name="redirectForm">
        <%
             formattedDate = getFormattedDate()
            chargetotal =Request.Form("ChargeTotal")
            subtotal = Request.Form("SubTotal")
            storename = getStoreName() 
            sharedsecret = getSharedSecret() 
            timezone = getTimeZone() 
            str = storename + formattedDate + chargetotal + sharedsecret 
            hex_str = "" 
            for i = 1 to len(str) 
            hex_str = hex_str + lcase(cstr(hex(asc(mid(str, i, 1)))))
             next 
            createdHash = SHA256(hex_str)

            shipping = Request.Form("shipping")
            comments = Request.Form("comments")
            bname = Request.Form("bname")
            bcompany = Request.Form("bcompany")
            baddr1 = Request.Form("baddr1")
            baddr2 = Request.Form("baddr2")
            bcity = Request.Form("bcity")
            bstate = Request.Form("bstate")
            bzip = Request.Form("bzip")
            phone = Request.Form("phone")
            bcountry = Request.Form("bcountry")
            email = Request.Form("email")
            sname = Request.Form("sname")
            saddr1 = Request.Form("saddr1")
            saddr2 = Request.Form("saddr2")
            scity = Request.Form("scity")
            sstate = Request.Form("sstate")
            szip = Request.Form("szip")
            scountry = Request.Form("scountry")
        %>
        <input type="hidden" name="timezone" value="<% Response.Write(timezone)%>" />
        <input type="hidden" name="authenticateTransaction" value="false" />
        <input size="50" type="hidden" name="txndatetime" value="<% Response.Write(formattedDate)%>" />
        <input size="50" type="hidden" name="hash" value="<% Response.Write(createdHash)%>" />
        <input size="50" type="hidden" name="storename" id="storename" value="<% Response.Write(storename) %>" />
        <input size="50" type="hidden" name="chargetotal" id="chargetotal1" value="<% Response.Write(chargetotal) %>" />
        <input size="50" type="hidden" name="subtotal" value="<% Response.Write(subtotal) %>" />

        <input type="hidden" name="mode" value="payonly"/>
        <input type="hidden" name="txntype" value="sale" />
        <input type="hidden" name="suppressTitle" value="true"/>
        <input id="bPost" runat=server type="hidden" value="true"/>
        <input id="shipping" runat=server type="hidden" name="shipping" value="<% Response.Write(shipping)%>"/>
        <input id="comments" runat=server type="hidden" name="comments" value="<% Response.Write(comments)%>"/>
        <input id="bname" runat=server type="hidden" name="bname" value="<% Response.Write(bname)%>"/>
        <input id="bcompany" runat=server type="hidden" name="bcompany" value="<% Response.Write(bcompany)%>" />
        <input id="baddr1" runat=server type="hidden" name="baddr1" value="<% Response.Write(baddr1)%>"/>
        <input id="baddr2" runat=server type="hidden" name="baddr2" value="<% Response.Write(baddr2)%>"/>
        <input id="bcity" runat=server type="hidden" name="bcity" value="<% Response.Write(bcity)%>"/>
        <input id="bstate" runat=server type="hidden" name="bstate" value="<% Response.Write(bstate)%>"/>
        <input id="bzip" runat=server type="hidden" name="bzip" value="<% Response.Write(bzip)%>"/>
        <input id="phone" runat=server type="hidden" name="phone" value="<% Response.Write(phone)%>"/>
        <input id="bcountry" runat=server type="hidden" name="bcountry" value="<% Response.Write(bcountry)%>" />
        <input id="email" runat=server type="hidden" name="email" value="<% Response.Write(email)%>"/>
        <input id="sname" runat=server type="hidden" name="sname" value="<% Response.Write(sname)%>"/>
        <input id="saddr1" runat=server type="hidden" name="saddr1" value="<% Response.Write(saddr1)%>"/>
        <input id="saddr2" runat=server type="hidden" name="saddr2" value="<% Response.Write(saddr2)%>"/>
        <input id="scity" runat=server type="hidden" name="scity" value="<% Response.Write(scity)%>"/>
        <input id="sstate" runat=server type="hidden" name="sstate" value="<% Response.Write(sstate)%>"/>
        <input id="szip" runat=server type="hidden" name="szip" value="<% Response.Write(szip)%>"/>
        <input id="scountry" runat=server type="hidden" name="scountry" value="<% Response.Write(scountry)%>"/>

         <% 
             orderId =Request.Form("OrderId")
          %>
        <input type="hidden" name="oid" id="oid" value='<% =orderId %>' />
    </form>
</body>
</html>