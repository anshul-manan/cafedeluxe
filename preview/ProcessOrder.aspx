<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProcessOrder.aspx.cs" Inherits="ProcessOrder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script language="javascript" type="text/javascript">
        function PushForm()
        {
            if(document.getElementById("bPost").value == "true")
                document.form1.submit();
        }
    </script>
</head>
<body onload="PushForm();">
    <form id="form1" action="https://www.linkpointcentral.com/lpc/servlet/lppay" method="post" name="form1">
        <input id="bPost" type="hidden" value="" runat=server/>
        
        <INPUT id="storename" runat=server type="hidden" name="storename" value="1001257409">
        <INPUT type="hidden" name="mode" value="payonly">
        <input type="hidden" name="txntype" value="sale" />
        <input type="hidden" name="suppressTitle" value="true">
        
        <input id="chargetotal" runat=server type="hidden" name="chargetotal" value="">
        <input id="subtotal" runat=server type="hidden" name="subtotal" value="">
        <input id="shipping" runat=server type="hidden" name="shipping" value="10.00">
                
        <input id="comments" runat=server type="hidden" name="comments" value="">
        
        <input id="oid" runat=server type="hidden" name="oid" value="5">
        
        <input id="bname" runat=server type="hidden" name="bname" value="">
        <input id="bcompany" runat=server type="hidden" name="bcompany" value="" />
        <input id="baddr1" runat=server type="hidden" name="baddr1" value="">
        <input id="baddr2" runat=server type="hidden" name="baddr2" value="">
        <input id="bcity" runat=server type="hidden" name="bcity" value="">
        <input id="bstate" runat=server type="hidden" name="bstate" value="">
        <input id="bzip" runat=server type="hidden" name="bzip" value="">
        <input id="phone" runat=server type="hidden" name="phone" value="">
        <input id="bcountry" runat=server type="hidden" name="bcountry" value="" />
        <input id="email" runat=server type="hidden" name="email" value="">
        
        <input id="sname" runat=server type="hidden" name="sname" value="">
        <input id="saddr1" runat=server type="hidden" name="saddr1" value="">
        <input id="saddr2" runat=server type="hidden" name="saddr2" value="">
        <input id="scity" runat=server type="hidden" name="scity" value="">
        <input id="sstate" runat=server type="hidden" name="sstate" value="">
        <input id="szip" runat=server type="hidden" name="szip" value="">
        <input id="scountry" runat=server type="hidden" name="scountry" value="">
                
</form>

<form id="form2" runat=server>

</form>
</body>
</html>
