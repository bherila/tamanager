using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TAManager
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void submitCredentials(object sender, EventArgs e) {
            var container = TAManager.Data.DataContainer.Instance();
            var users = (from x in container.Users
                       where x.Login.Equals(UsernameTextbox.Text, StringComparison.OrdinalIgnoreCase)
                       select x).ToList();

            if (users.Count == 0) {
                credentialValidator.IsValid = false;
                return;
            }

            var user = users.First();

            if (PasswordTextbox.Text == user.Password) {
                Session["mustchangepassword"] = true;
                Session["currentuser"] = user.Login;
                Session["isadmin"] = user.IsAdmin;
            }
            else if (PasswordTextbox.Text.hashPassword() == user.Password)
            {
                Session["mustchangepassword"] = false;
                Session["currentuser"] = user.Login;
                Session["isadmin"] = user.IsAdmin;
            }
            else {
                credentialValidator.IsValid = false;
                return;
            }

            if (string.IsNullOrEmpty(Request["redir"]))
                Response.Redirect("Home.aspx");
            else
                Response.Redirect(Request["redir"]);
            
        }
    }
}

