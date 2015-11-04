<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="GiftCards.aspx.cs" Inherits="GiftCards" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:MultiView runat="server" ID="mvCart">
    <asp:View runat="server" ID="viewSplash">
        <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">            
            <tr class="header"> 
	            <td align="center" valign="middle"><img src="images/gc.gif" alt="" border="0"></td>
	            <td style="width: 264px">
                    <form id="Form1" runat="server">
			            <table>
				            <tr>
					            <td class="right"><strong>Quantity:</strong></td>
					            <td style="width: 170px">
					                <asp:TextBox runat="server" ID="txtQuantity" Columns="5" MaxLength="3" Width="65px" />
                                    <asp:CustomValidator ID="QuantityValidator" runat="server" ControlToValidate="txtQuantity"
                                        ErrorMessage="CustomValidator" OnServerValidate="QuantityValidator_ServerValidate"
                                        ValidateEmptyText="True" ValidationGroup="group1">*</asp:CustomValidator>&nbsp;
					            </td>
				            </tr>
				            <tr>
					            <td class="right"><strong>Amount:</strong></td>
					            <td style="width: 170px">
					                <asp:TextBox runat="server" ID="txtAmount" Columns="10" MaxLength="6" Width="65px" /> <!--<span class="small">$20-$500</span>-->
                                    <asp:CustomValidator ID="AmountValidator" runat="server" ControlToValidate="txtAmount"
                                        ErrorMessage="CustomValidator" OnServerValidate="AmountValidator_ServerValidate"
                                        ValidateEmptyText="True" ValidationGroup="group1">*</asp:CustomValidator>
                                    &nbsp;
					            </td>
				            </tr>
				            <tr>
					            <td>&nbsp;</td>
					            <td style="width: 170px">
					                <asp:Button runat="server" cssclass="button" id="btnSubmit" Text="Add to Cart" CausesValidation="True" CommandName="SubmitSelection" OnCommand="OnAction" />
					            </td>
				            </tr>
				            <tr>
				                <td></td>
				                <td>
				                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="group1"
                        Width="231px" DisplayMode="List" />
				                </td>
				            </tr>
			            </table>
			        </form>
                    
	            </td>
            </tr>
            <tr>
	            <td colspan="2" style="border-top:1px solid #000; border-bottom:1px solid #000; text-align:center; padding:3px 0;"><h2>OR</h2></td>
            </tr>
            <tr class="header" style="text-align: center">
	            <td colspan="2">
   	                <strong>Check your Current Balance:</strong>&nbsp;<button class="button" onClick="popChat()";>Check Card Balance</button>
	            </td>
            </tr>
	        <tr>
		        <td colspan="2"><p align="center">For Gift Card questions and assistance,<br />please contact our office at 202.362.9842 (ext. 101).<!--<br /><em>Minimum per card purchase: $20 / Maximum per card purchase: $500</em>--></p></td>
	        </tr>
	        <tr> 
	            <td  align="left" valign="middle" colspan="2" style="height: 80px" class="tabletext">
					<!--<img src="images/bannerHoliday.jpg" alt="Happy Holidays" title="Happy Holidays" /><br />-->
	                <h2>PURCHASE A GIFT CARD ONLINE</h2>
		            <p>The Cafe Deluxe Gift Card makes a great present for friends, family, teachers or business associates. They can be used at any of our four locations.</p>

					<!--<p><blockquote>This special offer is available to cards purchased online or in our stores until December 23, 2008.  Bonus cards are valid from January 1, 2009 &amp; expire February 28, 2009.  The bonus card will be mailed with the purchased gift card.</blockquote></p>-->
					
					<h2>TERMS OF USE</h2>
                    <p>Present this gift card to pay for food and beverage purchases at Cafe Deluxe or Tortilla Coast. The card value will not be replaced if card is lost, stolen, damaged or used without your permission. Unused value remains on card and cannot be redeemed for cash or applied for gratuities. Additional value may be added to this card at any time.</p>
                    
                    <!--<h2>CORPORATE GIFTS</h2>
                    <p>Corporate and large-scale private purchases of Cafe Deluxe Gift Cards are available at a discounted price of 25% on amounts of $5,000 and greater. They are available only from our Corporate Office, not through the restaurants or Internet orders. Discounts are awarded as additional Gift Cards. For example, if you were to order $5,000 in Gift Cards, you would receive $1,250 in additional Cafe Deluxe Gift Cards.</p>-->
    		    </td>
    	    </tr>
        </table>
    </asp:View>
    
    <asp:View runat="server" ID="viewOrder">
        <form id="Form2" runat="server" action="">
    <table>
    <tr>
    <td>
    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
        <tr>
            <td align="left" valign="middle" colspan="4">
                <p style="color:#CC0000; text-transform:uppercase; font-weight:bold;"><asp:label runat="server" ID="lblProgress">Step 2 of 4 : Checkout</asp:label></p>
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" colspan="4">
                <asp:Label ID="lblInstructions" runat="server" Text="Please review your order, and complete the form below with your shipping and billing information."></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" colspan="4">
                <strong><asp:Label ID="lblRequiredText" runat="server" Text="* Indicates a required field"></asp:Label></strong>
            </td>
        </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td>
       <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
            <tr class="header">
                <td width=30px>
                    Quantity:
                </td>
                <td align=center>
                    Item:
                </td>
                <td align=right>
                    Amount:
                </td>
                <td align=right>
                    Total:
                </td>
                <td align=right width=140px>
                 </td>
            </tr>
            <tr class="total">
                <td align=center>
                    <asp:Label runat="server" ID="lblQuantity"></asp:Label></td>
                <td align=center>
                    <strong>Gift Card</strong>
                </td>
                <td align=right>
                    <asp:Label runat="server" ID="lblAmount"></asp:Label></td>
                <td align=right>
                    <strong><asp:Label runat="server" ID="lblTotal"></asp:Label></strong></td>
                <td align=right width=140px>
                    <asp:Button ID="btnRemove" runat="server" Text="remove" Width="60px" OnClick="btnRemove_Click" CssClass="button" />
                    <asp:Button ID="btnEdit" runat="server" Text="edit" Width="60px" OnClick="btnEdit_Click" CssClass="button" />
                </td>
            </tr>
            <tr class="total" height=28px>
                <td colspan="3" class="right">Shipping Method&dagger;:<asp:DropDownList runat="server" AutoPostBack="true" ID="ddlShippingType" OnSelectedIndexChanged="ddlShippingType_SelectedIndexChanged">
                    </asp:DropDownList></td>
                
                <td align=right>
                    <strong><asp:Label runat="server" ID="lblShippingAmount"></asp:Label></strong>
                </td>
                <td></td>
            </tr>
            <tr class="background" height=28px>
                <td colspan="3" class="right"><i>Total Purchase:</i></td>
                <td align=right><strong><asp:Label runat="server" ID="lblTotalWithShipping"></asp:Label></strong></td>
                <td></td>
            </tr>
            <tr style="background-color:#B49457" height=7px>
                <td colspan=5 style="height: 7px">
                   
                </td>
            </tr>
            <tr>
                <td colspan="5" align=right valign=top>&dagger; Allow one additional business day for processing<br /><br /></td>
            </tr>
        </table>
        <br />
    </td>
    </tr>
    <tr>
    <td>
    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
         <tr class="header">
            <td colspan="6">Card Message</td>
        </tr> 
        <tr class="background">
            <td class="right" colspan="2" valign="top">
                <br />
                Personal Written Message:</td>
            <td colspan="4">
                <br />
                <asp:TextBox runat="server" ID="txtPersonalMessage" Columns="30" Height="104px" TextMode="MultiLine" Width="322px" MaxLength="500" /><br />
                &nbsp;</td>
        </tr>       
<!-- Begin Billing Section -->
        <tr class="header">
            <td colspan="6">Billing Information</td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2"></td>
            <td colspan="4"><asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="group2"
                        Width="321px" DisplayMode="List" />
                </td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2"><br />First Name*</td>
            <td colspan="4"><br />
                <asp:TextBox runat="server" ID="txtBillingFirstName" Columns="30" />&nbsp;
                <asp:CustomValidator ID="BillingFirstNameValidator" runat="server" ErrorMessage="Billing First Name is a required field!"
                    ValidateEmptyText="True" ValidationGroup="group2" ControlToValidate="txtBillingFirstName" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Last Name*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtBillingLastName" Columns="30" />&nbsp;
                <asp:CustomValidator ID="BillingLastNameValidator" runat="server" ErrorMessage="Billing Last Name is a required field!"
                    ValidateEmptyText="True" ValidationGroup="group2" ControlToValidate="txtBillingLastName" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Company</td>
            <td colspan="4"><asp:TextBox runat="server" ID="txtBillingCompany" Columns="30" /></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Address 1*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtBillingAddress1" Columns="30" />&nbsp;
                <asp:CustomValidator ID="BillingAddress1Validator" runat="server" ControlToValidate="txtBillingAddress1"
                    ErrorMessage="Billing Address 1 is a required field!" OnServerValidate="Empty_ServerValidate"
                    ValidateEmptyText="True" ValidationGroup="group2">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Address 2</td>
            <td colspan="4"><asp:TextBox runat="server" ID="txtBillingAddress2" Columns="30" /></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">City*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtBillingCity" Columns="30" />&nbsp;
                <asp:CustomValidator ID="BillingCityValidator" runat="server" ControlToValidate="txtBillingCity"
                    ErrorMessage="Billing City is a required field!" OnServerValidate="Empty_ServerValidate"
                    ValidateEmptyText="True" ValidationGroup="group2">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">State*</td>
            <td colspan="4">
                <select runat="server" id="ddlBillingState" size="1">
                    <option value="Default">-Select a State-</option>
                    <option value="AL">Alabama</option>
                    <option value="AK">Alaska</option>
                    <option value="AZ">Arizona</option>
                    <option value="AR">Arkansas</option>
                    <option value="CA">California</option>
                    <option value="CO">Colorado</option>
                    <option value="CT">Connecticut</option>
                    <option value="DE">Delaware</option>
                    <option value="DC">District of Columbia</option>
                    <option value="FL">Florida</option>
                    <option value="GA">Georgia</option>
                    <option value="HI">Hawaii</option>
                    <option value="ID">Idaho</option>
                    <option value="IL">Illinois</option>
                    <option value="IN">Indiana</option>
                    <option value="IA">Iowa</option>
                    <option value="KS">Kansas</option>
                    <option value="KY">Kentucky</option>
                    <option value="LA">Louisiana</option>
                    <option value="ME">Maine</option>
                    <option value="MD">Maryland</option>
                    <option value="MA">Massachusetts</option>
                    <option value="MI">Michigan</option>
                    <option value="MN">Minnesota</option>
                    <option value="MS">Mississippi</option>
                    <option value="MO">Missouri</option>
                    <option value="MT">Montana</option>
                    <option value="NE">Nebraska</option>
                    <option value="NV">Nevada</option>
                    <option value="NH">New Hampshire</option>
                    <option value="NJ">New Jersey</option>
                    <option value="NM">New Mexico</option>
                    <option value="NY">New York</option>
                    <option value="NC">North Carolina</option>
                    <option value="ND">North Dakota</option>
                    <option value="OH">Ohio</option>
                    <option value="OK">Oklahoma</option>
                    <option value="OR">Oregon</option>
                    <option value="PA">Pennsylvania</option>
                    <option value="RI">Rhode Island</option>
                    <option value="SC">South Carolina</option>
                    <option value="SD">South Dakota</option>
                    <option value="TN">Tennessee</option>
                    <option value="TX">Texas</option>
                    <option value="UT">Utah</option>
                    <option value="VT">Vermont</option>
                    <option value="VA">Virginia</option>
                    <option value="WA">Washington</option>
                    <option value="WV">West Virginia</option>
                    <option value="WI">Wisconsin</option>
                    <option value="WY">Wyoming</option>
                </select>
                <asp:CustomValidator ID="BillingStateValidator" runat="server" ErrorMessage="Billing State is a required field!"
                    ValidateEmptyText="True" ValidationGroup="group2" ControlToValidate="ddlBillingState" OnServerValidate="DropDown_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Zip Code*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtBillingZipcode" Columns="30" />
                <asp:CustomValidator ID="BillingZipcodeValidator" runat="server" ControlToValidate="txtBillingZipcode"
                    ErrorMessage="Billing Zipcode is invalid!" OnServerValidate="BillingZipcodeValidator_ServerValidate"
                    ValidateEmptyText="True" ValidationGroup="group2">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Country*</td>
            <td colspan="4">
                <select name="country" id="ddlBillingCountry" runat=server>
                    <option value="Default">-Select a Country-</option>
                    <option value="US">United States</option>
                </select>
                <asp:CustomValidator ID="BillingCountryValidator" runat="server" ErrorMessage="Billing Country is a required field!"
                    ValidateEmptyText="True" ValidationGroup="group2" OnServerValidate="DropDown_ServerValidate" ControlToValidate="ddlBillingCountry">*</asp:CustomValidator>
            </td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Email*</td>
            <td colspan="4"><asp:TextBox runat="server" ID="txtBillingEmail" Columns="30" />
                <asp:CustomValidator ID="BillingEmailValidator" runat="server" ControlToValidate="txtBillingEmail"
                    ErrorMessage="Billing Email Address is invalid!" OnServerValidate="BillingEmailValidator_ServerValidate"
                    ValidateEmptyText="True" ValidationGroup="group2">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Phone*</td>
            <td colspan="4">
                (
                <asp:TextBox runat="server" ID="txtBillingPhone1" Columns="30" MaxLength="3" Width="41px" />
                ) -
                <asp:TextBox runat="server" ID="txtBillingPhone2" Columns="30" MaxLength="3" Width="41px" />
                -
                <asp:TextBox runat="server" ID="txtBillingPhone3" Columns="30" MaxLength="4" Width="59px" />
                <asp:CustomValidator ID="BillingPhoneValidator" runat="server" ControlToValidate="txtBillingPhone3"
                    ErrorMessage="Billing Phone is invalid!" OnServerValidate="BillingPhoneValidator_ServerValidate"
                    ValidateEmptyText="True" ValidationGroup="group2">*</asp:CustomValidator></td>
        </tr>
        <tr class="header">
            <td colspan="6">Email Updates</td>
        </tr>
        <tr class="background">
            <td colspan=6>
                <table border="0" width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="38px">&nbsp;</td>
                        <td valign="top" align=right><br />
                            <asp:CheckBox ID="cbPromotions" runat="server" />
                        </td>
                        <td><br />
                            Click here if you <strong>do not</strong> wish to receive<br />
                            information about special promotions,<br />
                            offers and information on our restaurants.<br /><br />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="header">
            <td colspan="6">Shipping Information</td>
        </tr>
        <tr class="background">
            <td colspan="6" align=left>
                <table width="100%" cellpadding=0 cellspacing=0>
                    <tr>
                        <td width=15%>
                        
                        </td>
                        <td><br />
                            If your shipping information is the same as your billing<br />information, check the box below and click "Submit". You do<br />not need to provide your address again.<br /><br />
                        </td>
                        <td width=15%>
                        
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan=2>
                            <asp:CheckBox ID="cbSameInfo" runat="server" />&nbsp;&nbsp;<strong>Shipping Information is the same as Billing Information</strong>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2"></td>
            <td colspan="4"><asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="group3"
                        Width="320px" DisplayMode="List" />
                
                </td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">First Name*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtShippingFirstName" Columns="30" />
                <asp:CustomValidator ID="ShippingFirstNameValidator" runat="server" ControlToValidate="txtShippingFirstName"
                    ErrorMessage="Shipping First Name is a required field!" ValidateEmptyText="True"
                    ValidationGroup="group3" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Last Name*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtShippingLastName" Columns="30" />
                <asp:CustomValidator ID="ShippingLastNameValidator" runat="server" ControlToValidate="txtShippingLastName"
                    ErrorMessage="Shipping Last Name is a required field!" ValidateEmptyText="True"
                    ValidationGroup="group3" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Company</td>
            <td colspan="4"><asp:TextBox runat="server" ID="txtShippingCompany" Columns="30" /></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Address 1*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtShippingAddress1" Columns="30" />
                <asp:CustomValidator ID="ShippingAddress1Validator" runat="server" ControlToValidate="txtShippingAddress1"
                    ErrorMessage="Billing Address 1 is a required field!" ValidateEmptyText="True"
                    ValidationGroup="group3" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">Address 2</td>
            <td colspan="4"><asp:TextBox runat="server" ID="txtShippingAddress2" Columns="30" /></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">City*</td>
            <td colspan="4">
                <asp:TextBox runat="server" ID="txtShippingCity" Columns="30" />
                <asp:CustomValidator ID="ShippingCityValidator" runat="server" ControlToValidate="txtShippingCity"
                    ErrorMessage="Shipping City is a required field!" ValidateEmptyText="True" ValidationGroup="group3" OnServerValidate="Empty_ServerValidate">*</asp:CustomValidator></td>
        </tr>
        <tr class="background">
            <td class="right" colspan="2">State*</td>
            <td colspan="4">
                <select name="" size="1" id="ddlShippingState" runat=server>
                    <option value="Default">--Select a State--</option>
                    <option value="AL">Alabama</option>
                    <option value="AK">Alaska</option>
                    <option value="AZ">Arizona</option>
                    <option value="AR">Arkansas</option>
                    <option value="CA">California</option>
                    <option value="CO">Colorado</option>
                    <option value="CT">Connecticut</option>
                    <option value="DE">Delaware</option>
                    <option value="DC">District of Columbia</option>
                    <option value="FL">Florida</option>
                    <option value="GA">Georgia</option>
                    <option value="HI">Hawaii</option>
                    <option value="ID">Idaho</option>
                    <option value="IL">Illinois</option>
                    <option value="IN">Indiana</option>
                    <option value="IA">Iowa</option>
                    <option value="KS">Kansas</option>
                    <option value="KY">Kentucky</option>
                    <option value="LA">Louisiana</option>
                    <option value="ME">Maine</option>
                    <option value="MD">Maryland</option>
                    <option value="MA">Massachusetts</option>
                    <option value="MI">Michigan</option>
                    <option value="MN">Minnesota</option>
                    <option value="MS">Mississippi</option>
                    <option value="MO">Missouri</option>
                    <option value="MT">Montana</option>
                    <option value="NE">Nebraska</option>
                    <option value="NV">Nevada</option>
                    <option value="NH">New Hampshire</option>
                    <option value="NJ">New Jersey</option>
                    <option value="NM">New Mexico</option>
                    <option value="NY">New York</option>
                    <option value="NC">North Carolina</option>
                    <option value="ND">North Dakota</option>
                    <option value="OH">Ohio</option>
                    <option value="OK">Oklahoma</option>
                    <option value="OR">Oregon</option>
                    <option value="PA">Pennsylvania</option>
                    <option value="RI">Rhode Island</option>
                    <option value="SC">South Carolina</option>
                    <option value="SD">South Dakota</option>
                    <option value="TN">Tennessee</option>
                    <option value="TX">Texas</option>
                    <option value="UT">Utah</option>
                    <option value="VT">Vermont</option>
                    <option value="VA">Virginia</option>
                    <option value="WA">Washington</option>
                    <option value="WV">West Virginia</option>
                    <option value="WI">Wisconsin</option>
                    <option value="WY">Wyoming</option>
                </select>
                <asp:CustomValidator ID="ShippingStateValidator" runat="server" ControlToValidate="ddlShippingState"
                    ErrorMessage="Shipping State is a required field!" ValidateEmptyText="True" ValidationGroup="group3" OnServerValidate="DropDown_ServerValidate">*</asp:CustomValidator></td>
        </tr>
            <tr class="background">
                <td class="right" colspan="2">Zip Code*</td>
                <td colspan="4">
                    <asp:TextBox runat="server" ID="txtShippingZipcode" Columns="30" />&nbsp;
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtShippingZipcode"
                        ErrorMessage="Shipping Zipcode is a required field!" OnServerValidate="BillingZipcodeValidator_ServerValidate"
                        ValidateEmptyText="True" ValidationGroup="group3">*</asp:CustomValidator></td>
            </tr>
            <tr class="background">
                <td class="right" colspan="2">Country*</td>
                <td colspan="4">
                    &nbsp;<select name="country" id="ddlShippingCountry" runat=server>
                        <option value="Default">-Select a Country-</option>
                        <option value="US">United States</option>
                    </select>
                    <asp:CustomValidator ID="ShippingCountryValidator" runat="server" ControlToValidate="ddlShippingCountry"
                        ErrorMessage="Shipping Country is a required field!" OnServerValidate="DropDown_ServerValidate"
                        ValidateEmptyText="True" ValidationGroup="group3">*</asp:CustomValidator></td>
            </tr>
            <tr class="background">
                <td class="right" colspan="2">Email*</td>
                <td colspan="4">
                    <asp:TextBox runat="server" ID="txtShippingEmail" Columns="30" />
                    <asp:CustomValidator ID="ShippingEmailValidator" runat="server" ControlToValidate="txtShippingEmail"
                        ErrorMessage="Shipping Email Address is a required field!" OnServerValidate="BillingEmailValidator_ServerValidate"
                        ValidateEmptyText="True" ValidationGroup="group3">*</asp:CustomValidator></td>
            </tr>
            <tr class="background">
                <td class="right" colspan="2" valign="top">Phone*</td>
                <td colspan="4">
                    (
                    <asp:TextBox runat="server" ID="txtShippingPhone1" Columns="30" MaxLength="3" Width="41px" />
                    ) -
                    <asp:TextBox runat="server" ID="txtShippingPhone2" Columns="30" MaxLength="3" Width="41px" />
                    -
                    <asp:TextBox runat="server" ID="txtShippingPhone3" Columns="30" MaxLength="4" Width="59px" />
                    <asp:CustomValidator ID="ShippingPhoneValidator" runat="server" ControlToValidate="txtShippingPhone3"
                        ErrorMessage="Shipping Phone is a required field!" OnServerValidate="ShippingPhoneValidator_ServerValidate"
                        ValidateEmptyText="True" ValidationGroup="group3">*</asp:CustomValidator><br /><br /></td>
            </tr>
            <tr>
                <td colspan=6 style="height: 7px">
                   
                </td>
            </tr>
            <tr>
                <td colspan="6" style="text-align: center">
                    <br />
                    <asp:Button ID="btnSubmitForm" runat="server" Text="Next Step" OnClick="btnSubmitForm_Click" CssClass="button" /><br /><br /></td>
            </tr>
            
        </table>
        </td>
        </tr>
        </table>
    </form>
    </asp:View>
    
    <asp:View runat="server" ID="viewConfirm">
    <form id="Form3" runat="server">
    <table>
        <tr>
            <td>
                 <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                    <tr>
                        <td align="left" valign="middle" colspan="4">
                            <p style="color:#CC0000; text-transform:uppercase; font-weight:bold;"><asp:label runat="server" ID="Label1">Step 3 of 4 : Confirmation</asp:label></p>
                            <p>
                                <asp:Label ID="Label2" runat="server" Text="Please review this information for accuracy.  Click the Next Step button to proceed."
                                    Width="100%"></asp:Label>&nbsp;</p>
                           
                        </td>
                    </tr>
                    </table><br /><br /><br />
                    </td>
                    <tr>
                <td>
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr class="header">
                            <td width=30px>
                                Quantity:
                            </td>
                            <td align=center>
                                Item:
                            </td>
                            <td align=right>
                                Amount:
                            </td>
                            <td align=right>
                                Total:
                            </td>
                            <td align=right>
                                <asp:Button ID="btnConfirmationEdit1" runat="server" Text="edit" Width="60px" OnClick="EditInfo" CssClass="button" /></td>
                        </tr>
                        <tr class="total">
                            <td align=center>
                                <asp:Label ID="lblConfQuantity" runat="server"></asp:Label></td>
                            <td align=center>
                                <strong>Gift Card</strong>
                            </td>
                            <td align=right>
                                <asp:Label ID="lblConfAmount" runat="server"></asp:Label></td>
                            <td align=right>
                                <asp:Label ID="lblConfCost" runat="server" Font-Bold="True"></asp:Label></td>
                            <td>
                            
                            </td>
                        </tr>
                        <tr class="background">
                            <td>
                                
                            </td>
                            <td></td>
                            <td style="text-align:right">
                                Shipping:<asp:Label ID="lblConfShippingType" runat="server"></asp:Label>
                            </td>
                            <td align=right>
                                <asp:Label ID="lblConfShippingCost" runat="server" Font-Bold="True"></asp:Label></td>
                            <td>
                            
                            </td>
                        </tr>
                        <tr class="total">
                            <td colspan=3 style="text-align:right">
                                <i>Total Purchase:</i>
                            </td>
                            <td align=right>
                                <asp:Label ID="lblConfTotalCost" runat="server" Font-Bold="True"></asp:Label>
                            </td>
                            <td></td>
                        </tr>
                        <tr style="background-color:#B49457" height=7px>
                            <td colspan=5 style="height: 7px">
                               
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td><br /><br /><br />
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr class="header">
                            <td class="header" style="text-align:left; width: 30%;">
                                <asp:Label ID="Label21" runat="server" Text="Card Message" Width="148px"></asp:Label></td>
                                <td align=right>
                                    <asp:Button ID="btnConfirmationEdit4" runat="server" Text="edit" Width="60px" OnClick="EditInfo" CssClass="button" /></td>
                        </tr>
                        <tr class="total" >
                            <td style="text-align:right; width: 30%;" valign="top">
                                <asp:Label ID="Label35" runat="server" Text="Personal Written Message:"></asp:Label></td>
                             <td style="text-align:left">
                                 <asp:Label ID="lblPersonalMessage" runat="server" Font-Bold="True" Width="336px"></asp:Label></td>
                        </tr>
                        <tr style="background-color:#B49457" height=7px>
                            <td colspan=5 style="height: 7px">
                               
                            </td>
                        </tr>
                    </table><br /><br /><br />
                </td>
            </tr>
            <tr>
                <td style="height: 408px">
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr class="header">
                            <td class="header" style="text-align:left;" width=30%>
                                <asp:Label ID="Label6" runat="server" Text="Billing Information" Width="148px"></asp:Label></td>
                                <td align=right>
                                    <asp:Button ID="btnConfirmationEdit2" runat="server" Text="edit" Width="60px" OnClick="EditInfo" CssClass="button" /></td>
                        </tr>
                        <tr class="total" >
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label8" runat="server" Text="First Name:"></asp:Label></td>
                             <td style="text-align:left">
                                 <asp:Label ID="lblBFirstname" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label9" runat="server" Text="Last Name:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBLastname" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label10" runat="server" Text="Company:"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblBCompany" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label11" runat="server" Text="Address 1:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBAddress1" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label12" runat="server" Text="Address 2:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBAddress2" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label13" runat="server" Text="City:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBCity" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label14" runat="server" Text="State"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBState" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label15" runat="server" Text="Zip Code:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBZipcode" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label16" runat="server" Text="Country:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBCountry" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label17" runat="server" Text="Email:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBEmail" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label18" runat="server" Text="Phone:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblBPhone" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr style="background-color:#B49457" height=7px>
                            <td colspan=5 style="height: 7px">
                               
                            </td>
                        </tr>
                    </table><br /><br /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr class="header">
                            <td>
                                <asp:Label ID="Label7" runat="server" Text="Shipping Information" Width="148px"></asp:Label></td>
                                <td align=right>
                                    <asp:Button ID="btnConfirmationEdit3" runat="server" Text="edit" Width="60px" OnClick="EditInfo" CssClass="button" /></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label22" runat="server" Text="First Name:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSFirstname" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label23" runat="server" Text="Last Name:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSLastname" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label24" runat="server" Text="Company:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSCompany" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label25" runat="server" Text="Address 1:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSAddress1" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label26" runat="server" Text="Address 2:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSAddress2" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label27" runat="server" Text="City:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSCity" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label28" runat="server" Text="State"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSState" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label29" runat="server" Text="Zip Code:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSZipcode" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label30" runat="server" Text="Country:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSCountry" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="background">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label31" runat="server" Text="Email:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSEmail" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr class="total">
                            <td style="text-align:right;" width=30%>
                                <asp:Label ID="Label32" runat="server" Text="Phone:"></asp:Label></td>
                                <td style="text-align:left">
                                    <asp:Label ID="lblSPhone" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr style="background-color:#B49457" height=7px>
                            <td colspan=5 style="height: 7px">
                               
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align=center><br />
                    <asp:Button ID="btnSubmitOrder" runat="server" OnClick="btnSubmitOrder_Click" Text="Next Step" CssClass="button" /><br /><br />
                </td>
            </tr>
       </table>
       </form>     
    </asp:View>
    
    <asp:View runat="server" ID="viewReceipt">
        <table>
            <tr>
                <td>
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <h1><asp:label runat="server" ID="Label5">Step 4 of 4 : Thank You</asp:label></h1>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <asp:Label ID="Label4" runat="server" Text="Your purchase is complete.  You will receive an email confirmation, with a summary of your information and purchase which will act as your receipt."
                                        Width="100%" Font-Size="11pt"></asp:Label><br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" colspan="4" class="background" height="30" style="width: 516px">
                                <asp:Label ID="lblOrderNumberText" runat="server" Font-Size="11pt">Order Number:  </asp:Label>&nbsp;
                                &nbsp;<asp:Label ID="lblOrderNumber" runat="server" Width="361px" Font-Size="11pt">Order Number:  </asp:Label></td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <br />
                                <asp:Label ID="Label3" runat="server" Width="100%" Height="25px" Text="Your Gift Card will arrive in a card presenter which will inform the recipient of the amount on the card as well as all of our restaraunt locations.  If the guest does not use the balance in one sitting, the remaining balance carries over on the card allowing continual reuse of the allotted funds." Font-Size="11pt"></asp:Label><br />
                                <br />
                                <asp:Label ID="Label33" runat="server" Font-Bold="True" Text="Thank You," Font-Size="11pt"></asp:Label><br />
                                <asp:Label ID="Label34" runat="server" Font-Bold="True" Text="Cafe Deluxe" Font-Size="11pt"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
    </asp:View>
    <div style="clear:both"></div>
    <asp:View runat="server" ID="viewError">
        <table>
            <tr>
                <td>
                    <table border="0" width="100%" align="left" cellspacing="0" cellpadding="5">
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <h1><asp:label runat="server" ID="Label19">Error:</asp:label></h1>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <asp:Label ID="Label20" runat="server" Text="We apologize for the inconvenience, we were unable to process your credit card.  Gift Cards can also be purchased at any of our restaurants, or by calling our office at (202) 362-9842 and using your credit card."
                                        Width="100%"></asp:Label><br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" colspan="4" style="width: 516px">
                                <br />
                                <br />
                                <br />
                                <asp:Label ID="Label37" runat="server" Font-Bold="True" Text="Thank You,"></asp:Label><br />
                                <asp:Label ID="Label38" runat="server" Font-Bold="True" Text="Cafe Deluxe"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
    </asp:View>
</asp:MultiView>

</asp:Content>
