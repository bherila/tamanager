using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAManager
{
    public static class Extensions
    {

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
                p.Response.Redirect("Default.aspx", true); 
            }
        }

        public static bool isAdmin(this System.Web.UI.Page p)
        {
            object isadmin = p.Session["isadmin"];
            if (isadmin == null)
                return false;
            return (bool)isadmin;
        }

    }
}