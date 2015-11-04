
using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Data Access Object for Cafe Deluxe Ecommerce
/// </summary>
namespace CafeDeluxe.Data
{
    public class DAO
    {
        public DAO() 
        {
        
        }

        public static void UpdateOrderStatus(int iStatusID, int iOrderID, string strApprovalCode, string strStatus, string strFailReason)
        {
            CafeDeluxeTableAdapters.QueriesTableAdapter sta = new global::CafeDeluxe.CafeDeluxeTableAdapters.QueriesTableAdapter();
            sta.UpdateStatusByID(iStatusID,strApprovalCode,strStatus,strFailReason,DateTime.Now,iOrderID);
        }

        public static CafeDeluxe.ShippingDataTable GetShippingMethods()
        {
            CafeDeluxe.ShippingDataTable dt = new CafeDeluxe.ShippingDataTable();
            CafeDeluxeTableAdapters.ShippingTableAdapter sta = new global::CafeDeluxe.CafeDeluxeTableAdapters.ShippingTableAdapter();
            sta.Fill(dt);
            return dt;
        }

        public static CafeDeluxe.AllOrderInfoDataTable GetAllOrderInfo(string strOrderID)
        {
            CafeDeluxe.AllOrderInfoDataTable dt = new CafeDeluxe.AllOrderInfoDataTable();
            CafeDeluxeTableAdapters.AllOrderInfoTableAdapter sta = new global::CafeDeluxe.CafeDeluxeTableAdapters.AllOrderInfoTableAdapter();
            sta.FillByOrderID(dt,int.Parse(strOrderID));
            return dt;
        }

        public static string InsertOrder(bool bPromos, string bFirst, string bLast, string bComp, string bAddr1, string bAddr2, string bCity, string bState, string bZip, string bCountry, string bEmail, string bPhone, string sFirst, string sLast, string sCompany, string sAddr1, string sAddr2, string sCity, string sState, string sZip, string sCountry, string sEmail, string sPhone, string strPersonalMessage, string strDesc, int Quantity, decimal Amount, decimal subtotal, string shippingtype, decimal shippingamount, decimal total)
        {
            CafeDeluxeTableAdapters.QueriesTableAdapter sta = new global::CafeDeluxe.CafeDeluxeTableAdapters.QueriesTableAdapter();
            System.Nullable<int> bsi = new System.Nullable<int>();
            System.Nullable<int> ii = new System.Nullable<int>();
            System.Nullable<int> oi = new System.Nullable<int>();
            sta.InsertAllOrderInfo(bFirst, bLast, bComp, bAddr1, bAddr2, bCity, bState, bZip, bCountry, bEmail, bPhone, sFirst, sLast, sCompany, sAddr1, sAddr2, sCity, sState, sZip, sCountry, sEmail, sPhone, bPromos, strPersonalMessage, ref bsi, strDesc, Quantity, Amount, ref ii, subtotal, shippingtype, shippingamount, total, ref oi);
            return oi.ToString();
        }


        public static void InsertError(string strURL, string strException)
        {
            CafeDeluxeTableAdapters.QueriesTableAdapter sta = new global::CafeDeluxe.CafeDeluxeTableAdapters.QueriesTableAdapter();
            sta.InsertError(strURL, strException, DateTime.Now);
                       
        }
    }
}