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

public partial class Redirector : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Buffer = true;

        if (Request.ServerVariables["HTTPS"] == "on")
            Response.Redirect("https://www." + Request.ServerVariables["SERVER_NAME"] + @"/" + Request["Page"]);
    }
}
