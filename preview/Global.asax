<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        try
        {  
            //log error and email error
            
            string strURL = Request.Url.AbsolutePath;
            Exception exs = Server.GetLastError();

            CafeDeluxe.Data.DAO.InsertError(strURL, exs.ToString());

            CafeDeluxe.Functionality.MailMan mm = new CafeDeluxe.Functionality.MailMan();
            mm.MailOrder(System.Configuration.ConfigurationManager.AppSettings["MailErrorTo"].ToString(), System.Configuration.ConfigurationManager.AppSettings["MailErrorTo"].ToString(), "Website Error", strURL + "  :  " + exs.ToString());
            
        }
        catch(Exception ex)
        {
            CafeDeluxe.Data.DAO.InsertError("Global.asax", ex.ToString());
        }
        
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
