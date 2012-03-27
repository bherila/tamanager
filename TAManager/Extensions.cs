using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Reflection;

namespace TAManager
{
    public static class Extensions
    {
        public static string TIME_FORMAT = @"yyyy-MM-ddTHH:mm:ssZ";

        public static string currentUser(this System.Web.UI.Page p) {
            return (string) p.Session["currentuser"]; 
        }

        public static string hashPassword(this string s) {
            using (var hasher = System.Security.Cryptography.SHA256.Create()) {
                byte[] hashedPassword = hasher.ComputeHash(System.Text.Encoding.Unicode.GetBytes(s));
                return Convert.ToBase64String(hashedPassword);
            }
        }

        public static void requireLogin(this System.Web.UI.Page p) {
            if (String.IsNullOrEmpty(p.currentUser())) {
                p.Response.Redirect("Default.aspx?redir=" + p.Request.RawUrl);
            }
        }

        public static bool isAdmin(this System.Web.UI.Page p)
        {
            object isadmin = p.Session["isadmin"];
            if (isadmin == null)
                return false;
            return (bool)isadmin;
        }

        public static void GridViewHtmlFix(object sender, EventArgs e)
        {
            Table table = (sender as DataGrid).Controls[0] as Table;
            if (table != null && table.Rows.Count > 0)
            {
                table.Rows[0].TableSection = TableRowSection.TableHeader;
                table.Rows[table.Rows.Count - 1].TableSection = TableRowSection.TableFooter;
                FieldInfo field = typeof(WebControl).GetField("tagKey", BindingFlags.Instance | BindingFlags.NonPublic);
                foreach (TableCell cell in table.Rows[0].Cells)
                {
                    field.SetValue(cell, System.Web.UI.HtmlTextWriterTag.Th);
                }
            }
        }

    }
}