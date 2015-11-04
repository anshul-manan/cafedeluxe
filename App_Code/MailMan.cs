using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Text;

namespace CafeDeluxe.Functionality
{
    /// <summary>
    /// Summary description for MailMan
    /// </summary>
    public class MailMan
    {
        private SmtpClient sClient;
        private MailMessage mMessage;

        public MailMan()
        {
            
        }

        public void MailOrder(string strFrom, string strTo, string strSubject, string strBody)
        {
            mMessage = new MailMessage(strFrom, strTo, strSubject, strBody);
            sClient = new SmtpClient("mailone.enforme.com");
            sClient.Send(mMessage);
        }
                
    }
}
