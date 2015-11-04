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

public partial class ProcessOrder : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        Response.Expires = 0;
        Response.ExpiresAbsolute = DateTime.Now.Subtract(new TimeSpan(1, 0, 0, 0));
        Response.AddHeader("pragma", "no-chache");
        Response.AddHeader("cache-control", "private");
        Response.CacheControl = "no-cache";

        if (Session["OrderID"] == null)
        {
            this.bPost.Value = "false";
            //Response.Redirect("https://www.cafedeluxe.com/giftcards.aspx?location=" + Request["URL"], true);
            ClientScript.RegisterStartupScript(this.GetType(), "backup", "<script language=JavaScript>history.go(-1);</script>");
        }
        else
        {
            this.bPost.Value = "true";
            LoadInfoToPost(Session["OrderID"].ToString());
            Session["OrderID"] = null;
            //ClientScript.RegisterStartupScript(this.GetType(), "postit", "<script language=JavaScript>document.form1.submit();</script>");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void LoadInfoToPost(string strID)
    {
        DataTable dt = CafeDeluxe.Data.DAO.GetAllOrderInfo(strID);

        this.bname.Value = dt.Rows[0]["bFirstname"].ToString() + " " + dt.Rows[0]["bLastname"].ToString();
        this.bcompany.Value = dt.Rows[0]["bCompany"].ToString();
        this.baddr1.Value = dt.Rows[0]["bAddress1"].ToString();
        this.baddr2.Value = dt.Rows[0]["bAddress2"].ToString();
        this.bcity.Value = dt.Rows[0]["bCity"].ToString();
        this.bstate.Value = dt.Rows[0]["bState"].ToString();
        this.bzip.Value = dt.Rows[0]["bZipcode"].ToString();
        this.bcountry.Value = dt.Rows[0]["bCountry"].ToString();
        this.email.Value = dt.Rows[0]["bEmail"].ToString();
        this.phone.Value = dt.Rows[0]["bPhone"].ToString();

        this.sname.Value = dt.Rows[0]["sFirstname"].ToString() + " " + dt.Rows[0]["sLastname"].ToString();
        this.saddr1.Value = dt.Rows[0]["sAddress1"].ToString();
        this.saddr2.Value = dt.Rows[0]["sAddress2"].ToString();
        this.scity.Value = dt.Rows[0]["sCity"].ToString();
        this.sstate.Value = dt.Rows[0]["sState"].ToString();
        this.szip.Value = dt.Rows[0]["sZipcode"].ToString();
        this.scountry.Value = dt.Rows[0]["sCountry"].ToString();

        this.chargetotal.Value = dt.Rows[0]["Total"].ToString();
        this.subtotal.Value = dt.Rows[0]["SubTotal"].ToString();
        this.shipping.Value = dt.Rows[0]["ShippingAmount"].ToString();

        this.oid.Value = strID;
        this.comments.Value = "Quantity = " + dt.Rows[0]["Quantity"].ToString() + "   Amount = $" + dt.Rows[0]["Amount"].ToString() + "    ShippingType = " + dt.Rows[0]["ShippingType"].ToString() + " : $" + dt.Rows[0]["ShippingAmount"].ToString();
    }
}
