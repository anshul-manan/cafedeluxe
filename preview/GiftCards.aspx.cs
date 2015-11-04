using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using CafeDeluxe.Data;
using System.Text;

public partial class GiftCards : System.Web.UI.Page {

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["ccresponse"] != null)
            UpdateOrder(Request["ccresponse"]);
        else if (!this.IsPostBack)
        {
            System.Uri uri = Request.Url;

            if (!uri.AbsoluteUri.Contains("https"))
                Response.Redirect(uri.AbsoluteUri.Replace("http:", "https:"));
            
            this.mvCart.SetActiveView(this.viewSplash);

            ClientScript.RegisterStartupScript(this.GetType(), "focusLog", "<script language=JavaScript>document.getElementById('ctl00$ContentPlaceHolder1$txtQuantity').focus();</script>");        
        }
    }

    protected void UpdateOrder(string strType)
    {
        string[] strArray = null;
        
        if (strType == "error")
        {
            strArray = Request.Form["OID"].ToString().Split(',');
            CafeDeluxe.Data.DAO.UpdateOrderStatus(3, int.Parse(strArray[0]), "", Request.Form["status"].ToString(), Request.Form["failReason"].ToString());
            this.mvCart.SetActiveView(this.viewError);
            SendEmail(strArray[0],false);
        }
        else if (strType == "confirmed")
        {
            strArray = Request.Form["OID"].ToString().Split(',');
            CafeDeluxe.Data.DAO.UpdateOrderStatus(2, int.Parse(strArray[0]), Request.Form["approval_code"].ToString(), Request.Form["status"].ToString(), "");
            this.lblOrderNumber.Text = strArray[0];
            this.mvCart.SetActiveView(this.viewReceipt);
            SendEmail(strArray[0],true);
        }
    }

    protected void SendEmail(string strID, bool bApproved)
    {
        CafeDeluxe.Functionality.MailMan mm = new CafeDeluxe.Functionality.MailMan();
        string subject = string.Empty;
        StringBuilder sbBody = new StringBuilder();
        DataTable dt = CafeDeluxe.Data.DAO.GetAllOrderInfo(strID);

        sbBody.Append("Order ID : " + strID + "\r\n");

        if (bApproved)
        {
            subject = "Approved Purchase";
            sbBody.Append("Approval Code : " + dt.Rows[0]["ResponseApproval_Code"].ToString() + "\r\n\r\n");
        }
        else
        {
            subject = "Declined Purchase";
            sbBody.Append("Failure Reason : " + dt.Rows[0]["ResponseFailReason"].ToString() + "\r\n\r\n");
        }

        sbBody.Append("Order Date : " + dt.Rows[0]["DTCompleted"].ToString() + "\r\n");
        sbBody.Append("Order : " + dt.Rows[0]["Quantity"].ToString() + "  $" + dt.Rows[0]["Amount"].ToString() + " Gift Cards" + "\r\n");
        sbBody.Append("SubTotal : $" + dt.Rows[0]["SubTotal"].ToString() + "\r\n");
        sbBody.Append("Shipping Type : " + dt.Rows[0]["ShippingType"].ToString() + "\r\n");
        sbBody.Append("Shipping Amount : $" + dt.Rows[0]["ShippingAmount"].ToString() + "\r\n");
        sbBody.Append("Total : $" + dt.Rows[0]["Total"].ToString() + "\r\n\r\n");

        sbBody.Append("Personal Message : " + dt.Rows[0]["PersonalMessage"].ToString() + "\r\n\r\n");

        sbBody.Append("Billing Information:" + "\r\n");
        sbBody.Append(dt.Rows[0]["bFirstName"].ToString() + " " + dt.Rows[0]["bLastName"].ToString() + "\r\n");

        if(dt.Rows[0]["bCompany"].ToString().Trim() != "")
            sbBody.Append(dt.Rows[0]["bCompany"].ToString() + "\r\n");

        sbBody.Append(dt.Rows[0]["bAddress1"].ToString() + "\r\n");

        if (dt.Rows[0]["bAddress2"].ToString().Trim() != "")
            sbBody.Append(dt.Rows[0]["bAddress2"].ToString() + "\r\n");

        sbBody.Append(dt.Rows[0]["bCity"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["bState"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["bZipcode"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["bCountry"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["bPhone"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["bEmail"].ToString() + "\r\n\r\n");

        sbBody.Append("Shipping Information:" + "\r\n");
        sbBody.Append(dt.Rows[0]["sFirstName"].ToString() + " " + dt.Rows[0]["sLastName"].ToString() + "\r\n");

        if (dt.Rows[0]["sCompany"].ToString().Trim() != "")
            sbBody.Append(dt.Rows[0]["sCompany"].ToString() + "\r\n");

        sbBody.Append(dt.Rows[0]["sAddress1"].ToString() + "\r\n");

        if (dt.Rows[0]["sAddress2"].ToString().Trim() != "")
            sbBody.Append(dt.Rows[0]["sAddress2"].ToString() + "\r\n");

        sbBody.Append(dt.Rows[0]["sCity"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["sState"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["sZipcode"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["sCountry"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["sPhone"].ToString() + "\r\n");
        sbBody.Append(dt.Rows[0]["sEmail"].ToString() + "\r\n\r\n");

        //if approved send purchaser and purchase summary email
        if (bApproved)
        {
            StringBuilder sbBody2 = new StringBuilder();
            
            //sbBody2.Append("Contact : " + System.Configuration.ConfigurationManager.AppSettings["ContactName"].ToString() + "\r\n");
            //sbBody2.Append("Contact Email : " + System.Configuration.ConfigurationManager.AppSettings["ContactEmail"].ToString() + "\r\n");
            //sbBody2.Append("Contact Phone : " + System.Configuration.ConfigurationManager.AppSettings["ContactPhone"].ToString() + "\r\n\r\n");
            sbBody2.Append("Thank you for purchasing a Cafe Deluxe and Tortilla Coast gift card.  Please visit our website at cafedeluxe.com or tortillacoast.com for locations and other great information about our restaurants." + "\r\n\r\n");
            sbBody2.Append("We look forward to seeing you soon.  If you have any questions call 202-362-9842 ext. 04" + "\r\n\r\n");

            sbBody2.Append(sbBody.ToString());

            mm.MailOrder(System.Configuration.ConfigurationManager.AppSettings["MailFrom"].ToString(), dt.Rows[0]["bEmail"].ToString(), "Cafe Deluxe Purchase Confirmation", sbBody2.ToString());
        }

        sbBody.Append("Wishes to Receive Promotions : " + dt.Rows[0]["Promos"].ToString());

        //send cafe deluxe a purchase email, approved or declined
        mm.MailOrder(System.Configuration.ConfigurationManager.AppSettings["MailFrom"].ToString(), System.Configuration.ConfigurationManager.AppSettings["MailTo"].ToString(), subject, sbBody.ToString());

    }

    protected void OnAction(object sender, CommandEventArgs e) {
        switch (e.CommandName)
        {
            case ("SubmitSelection"):
                this.Validate("group1");

                if (this.IsValid)
                {
                    this.mvCart.SetActiveView(this.viewOrder);

                    LoadShippingMethods();

                    BindOrderForm();
                }

                break;
            case ("SubmitOrder"):
                // Record Addresses, Record Payment
                break;
            case ("OrderConfirmed"):
                break;
        }
    }

    protected void LoadShippingMethods()
    {
        if (this.ddlShippingType.Items.Count == 0)
        {
            this.ddlShippingType.DataSource = CafeDeluxe.Data.DAO.GetShippingMethods();
            this.ddlShippingType.DataTextField = "Description";
            this.ddlShippingType.DataValueField = "Amount";
            this.ddlShippingType.DataBind();
            this.ddlShippingType.SelectedIndex = 0;
        }
    }

    private void BindOrderForm()
    {
        if (!this.txtAmount.Text.Contains("."))
            this.txtAmount.Text += ".00";

        this.lblQuantity.Text = this.txtQuantity.Text;
        this.lblAmount.Text = this.txtAmount.Text;
        this.lblTotal.Text = (decimal.Parse(this.txtQuantity.Text) * decimal.Parse(this.txtAmount.Text)).ToString();
        CalculateTotalWithShipping();
    }

    private void CalculateTotalWithShipping()
    {
        this.lblShippingAmount.Text = this.ddlShippingType.SelectedValue;
        this.lblTotalWithShipping.Text = (decimal.Parse(lblTotal.Text.Trim()) + decimal.Parse(this.ddlShippingType.SelectedValue)).ToString();
    }

    protected void btnSubmitForm_Click(object sender, EventArgs e)
    {
        SubmitForm();
    }

    protected void SubmitForm()
    {
        this.Validate("group2");

        if (!this.cbSameInfo.Checked)
            this.Validate("group3");

        if (this.IsValid)
        {
            LoadConfirmationInfo();
            this.mvCart.SetActiveView(this.viewConfirm);
        }
    }

    protected void LoadConfirmationInfo()
    {
        this.lblConfAmount.Text = this.lblAmount.Text;
        this.lblConfCost.Text = this.lblTotal.Text;
        this.lblConfQuantity.Text = this.lblQuantity.Text;
        this.lblConfShippingCost.Text = this.lblShippingAmount.Text;
        this.lblConfShippingType.Text = this.ddlShippingType.SelectedItem.Text;
        this.lblConfTotalCost.Text = this.lblTotalWithShipping.Text;

        this.lblPersonalMessage.Text = this.txtPersonalMessage.Text;

        this.lblBFirstname.Text = this.txtBillingFirstName.Text;
        this.lblBLastname.Text = this.txtBillingLastName.Text;
        this.lblBCompany.Text = this.txtBillingCompany.Text;
        this.lblBAddress1.Text = this.txtBillingAddress1.Text;
        this.lblBAddress2.Text = this.txtBillingAddress2.Text;
        this.lblBCity.Text = this.txtBillingCity.Text;
        this.lblBState.Text = this.ddlBillingState.Value;
        this.lblBZipcode.Text = this.txtBillingZipcode.Text;
        this.lblBCountry.Text = this.ddlBillingCountry.Value;
        this.lblBEmail.Text = this.txtBillingEmail.Text;
        this.lblBPhone.Text = "(" + this.txtBillingPhone1.Text + ")" + " - " + this.txtBillingPhone2.Text + " - " + this.txtBillingPhone3.Text;
        
        if (!this.cbSameInfo.Checked)
        {
            this.lblSFirstname.Text = this.txtShippingFirstName.Text;
            this.lblSLastname.Text = this.txtShippingLastName.Text;
            this.lblSCompany.Text = this.txtShippingCompany.Text;
            this.lblSAddress1.Text = this.txtShippingAddress1.Text;
            this.lblSAddress2.Text = this.txtShippingAddress2.Text;
            this.lblSCity.Text = this.txtShippingCity.Text;
            this.lblSState.Text = this.ddlShippingState.Value;
            this.lblSZipcode.Text = this.txtShippingZipcode.Text;
            this.lblSCountry.Text = this.ddlShippingCountry.Value;
            this.lblSEmail.Text = this.txtShippingEmail.Text;
            this.lblSPhone.Text = "(" + this.txtShippingPhone1.Text + ")" + " - " + this.txtShippingPhone2.Text + " - " + this.txtShippingPhone3.Text;
        }
        else
        {
            this.lblSFirstname.Text = this.txtBillingFirstName.Text;
            this.lblSLastname.Text = this.txtBillingLastName.Text;
            this.lblSCompany.Text = this.txtBillingCompany.Text;
            this.lblSAddress1.Text = this.txtBillingAddress1.Text;
            this.lblSAddress2.Text = this.txtBillingAddress2.Text;
            this.lblSCity.Text = this.txtBillingCity.Text;
            this.lblSState.Text = this.ddlBillingState.Value;
            this.lblSZipcode.Text = this.txtBillingZipcode.Text;
            this.lblSCountry.Text = this.ddlBillingCountry.Value;
            this.lblSEmail.Text = this.txtBillingEmail.Text;
            this.lblSPhone.Text = "(" + this.txtBillingPhone1.Text + ")" + " - " + this.txtBillingPhone2.Text + " - " + this.txtBillingPhone3.Text;
        }
        
    }

    protected void ddlShippingType_SelectedIndexChanged(object sender, EventArgs e)
    {
        CalculateTotalWithShipping();
    }

    protected void QuantityValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (this.txtQuantity.Text.Trim() == "")
        {
            args.IsValid = false;
            this.QuantityValidator.ErrorMessage = "Quantity cannot be blank!";
        }
        else if (!isInteger(1, 100, args.Value))
        {
            args.IsValid = false;
            this.QuantityValidator.ErrorMessage = "Quantity Must be between 1 and 100!";
        }
    }

    protected bool isInteger(decimal dMin, decimal dMax, string strAmount)
    {
        bool bReturn = true;

        for (int i = 0; i < strAmount.Length; i++)
            if (strAmount.Substring(i,1) != "." && !char.IsNumber(strAmount, i))
                return false;

        decimal dAmount = decimal.Parse(strAmount);

        if (dAmount < dMin || dAmount > dMax)
            return false;

        return bReturn;
    }
    
    protected void AmountValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (this.txtAmount.Text.Trim() == "")
        {
            args.IsValid = false;
            this.AmountValidator.ErrorMessage = "Amount cannot be blank!";
        }
        else if (!isInteger(20, 500, args.Value))
        {
            args.IsValid = false;
            this.AmountValidator.ErrorMessage = "The Amount Must be between $20 and $500!";
        }
    }
    
    protected void Empty_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = ValidateEmpty(args.Value.Trim());
    }

    protected bool ValidateEmpty(string strValue)
    {
        if (strValue == "")
            return false;

        return true;
    }
    
    protected void BillingEmailValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value.Trim() == "")
        {
            this.BillingEmailValidator.ErrorMessage = "Billing Email is a required field!";
            args.IsValid = false;
        }
        else
        {
            Regex objEmailRegex = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");

            if(!objEmailRegex.IsMatch(args.Value.Trim()))
            {
                this.BillingEmailValidator.ErrorMessage = "Billing Email is invalid!";
                args.IsValid = false;
            }
        }
    }

    protected void BillingPhoneValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (this.txtBillingPhone1.Text.Trim() == "" && this.txtBillingPhone2.Text.Trim() == "" && this.txtBillingPhone3.Text.Trim() == "")
        {
            this.BillingPhoneValidator.ErrorMessage = "Billing Phone is a required field!";
            args.IsValid = false;
        }
        else
        {
            Regex objPhoneRegex = new Regex(@"((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}");

            string strCompleteNumber = "(" + this.txtBillingPhone1.Text.Trim() + ") " + this.txtBillingPhone2.Text.Trim() + "-" + this.txtBillingPhone3.Text.Trim();

            if (!objPhoneRegex.IsMatch(strCompleteNumber))
            {
                this.BillingPhoneValidator.ErrorMessage = "Billing Phone is invalid!";
                args.IsValid = false;
            }
        }
    }

    protected void ShippingPhoneValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (this.txtShippingPhone1.Text.Trim() == "" && this.txtShippingPhone2.Text.Trim() == "" && this.txtShippingPhone3.Text.Trim() == "")
        {
            this.ShippingPhoneValidator.ErrorMessage = "Shipping Phone is a required field!";
            args.IsValid = false;
        }
        else
        {
            Regex objPhoneRegex = new Regex(@"((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}");

            string strCompleteNumber = "(" + this.txtShippingPhone1.Text.Trim() + ") " + this.txtShippingPhone2.Text.Trim() + "-" + this.txtShippingPhone3.Text.Trim();

            if (!objPhoneRegex.IsMatch(strCompleteNumber))
            {
                this.ShippingPhoneValidator.ErrorMessage = "Shipping Phone is invalid!";
                args.IsValid = false;
            }
        }
    }

    protected void BillingZipcodeValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value.Trim() == "")
        {
            this.BillingZipcodeValidator.ErrorMessage = "Billing Zipcode is a required field!";
            args.IsValid = false;
        }
        else
        {
            Regex objZipRegex = new Regex(@"\d{5}(-\d{4})?");

            if (!objZipRegex.IsMatch(args.Value.Trim()))
            {
                this.BillingZipcodeValidator.ErrorMessage = "Billing Zipcode is invalid!";
                args.IsValid = false;
            }
        }
    }
    
    protected void BillingCardNumberValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //^((4\d{3})|(5[1-5]\d{2})|(6011))-?\d{4}-?\d{4}-?\d{4}|3[4,7]\d{13}$
        //This is another credit card pattern but this time we're specifying that the card number must start with a 4, 5, 6, or 7. This pattern matches all the major credit cards including Visa which has a length of 16 and a prefix of 4, MasterCard which has a length of 16 and a prefix of 51-55, Discover which has a length of 16, and a prefix of 6011, and finally American Express which has a length of 15 and a prefix of 34 or 37. All of the 16 digit formats (Visa, MasterCard, and Discover) accept an optional hyphen between each group of four digits.

        //Let's start with the ^((4\d{3})|(5[1-5]\d{2})|(6011)). It's not as bad as it looks. The first thing to notice is that it is one big group with two OR conditions inside. This group is going to be the definition for the first four digits of the card. The string must start with a group comprised of a "4" followed by exactly three digits (4\d{3}) OR a group comprised of a "5" followed by a 1, 2, 3, 4, or 5, followed by exactly four digits (5[1-5]\d{2}), OR a group comprised of a 6011 (6011).

        //" 
        //--------------------------------------------------------------------------------
        //You can find out more about the RegEx Class in the Visual Studio .NET help.
        //--------------------------------------------------------------------------------
        // " 


        //Next is -?, which means that there can be 0 or 1 hyphens following the initial set of four digits. 

        //Next is \d{4}-?, which refers to the second group of four digits. It means that exactly four digits followed by 0 or 1 hyphens are acceptable.

        //Next is another \d{4}-?, which refers to the third group of four digits. It, too, means that exactly four digits followed by 0 or 1 hyphens are acceptable.

        //Next is \d{4}, which refers to the fourth group of four digits. It means that exactly four digits are acceptable.

        //Next is the | (or) which signals the end of the 16 digit pattern and the beginning of the American Express pattern. This pattern, 3[4,7]\d{13}$ means that the string must start with "34" or "37" followed by 13 digits. In this pattern, spaces and hyphens are not acceptable in American Express card numbers.



        //if (args.Value.Trim() == "")
        //{
        //    this.BillingCardNumberValidator.ErrorMessage = "Billing Card Number is a required field!";
        //    args.IsValid = false;
        //}
        //else
        //{
        //    Regex objCardNumberRegex = new Regex(@"^((4\d{3})|(5[1-5]\d{2})|(6011))-?\d{4}-?\d{4}-?\d{4}|3[4,7]\d{13}$");

        //    if (!objCardNumberRegex.IsMatch(args.Value.Trim()))
        //    {
        //        this.BillingCardNumberValidator.ErrorMessage = "Billing Card Number is invalid!";
        //        args.IsValid = false;
        //    }
        //}
    }
    
    protected void DropDown_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value == "Default")
            args.IsValid = false;
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        this.txtQuantity.Text = string.Empty;
        this.txtAmount.Text = string.Empty;
        this.mvCart.SetActiveView(this.viewSplash);
        ClientScript.RegisterStartupScript(this.GetType(), "focusLog", "<script language=JavaScript>document.getElementById('ctl00$ContentPlaceHolder1$txtQuantity').focus();</script>");        
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        this.mvCart.SetActiveView(this.viewSplash);
        ClientScript.RegisterStartupScript(this.GetType(), "focusLog", "<script language=JavaScript>document.getElementById('ctl00$ContentPlaceHolder1$txtQuantity').focus();</script>");        
    }

    protected void EditInfo(object sender, EventArgs e)
    {
        this.mvCart.SetActiveView(this.viewOrder);
    }
   
    protected void btnSubmitOrder_Click(object sender, EventArgs e)
    {
        bool bPromos = true;

        if (this.cbPromotions.Checked)
            bPromos = false;

        Session["OrderID"] = CafeDeluxe.Data.DAO.InsertOrder(bPromos, this.lblBFirstname.Text, this.lblBLastname.Text, this.lblBCompany.Text, this.lblBAddress1.Text, this.lblBAddress2.Text, this.lblBCity.Text, this.lblBState.Text, this.lblBZipcode.Text, this.lblBCountry.Text, this.lblBEmail.Text, this.lblBPhone.Text, this.lblSFirstname.Text, this.lblSLastname.Text, this.lblSCompany.Text, this.lblSAddress1.Text, this.lblSAddress2.Text, this.lblSCity.Text, this.lblSState.Text, this.lblSZipcode.Text, this.lblSCountry.Text, this.lblSEmail.Text, this.lblSPhone.Text, this.lblPersonalMessage.Text, "Gift Card", int.Parse(this.lblConfQuantity.Text), decimal.Parse(this.lblConfAmount.Text), decimal.Parse(this.lblConfCost.Text), this.ddlShippingType.SelectedItem.Text, decimal.Parse(this.lblConfShippingCost.Text), decimal.Parse(this.lblConfTotalCost.Text));
        Response.Redirect("ProcessOrder.aspx", true);
    }

    
}
