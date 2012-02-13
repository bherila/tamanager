using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAManager.Data;
namespace TAManager
{
    public partial class Home : System.Web.UI.Page
    {

        protected void Page_PreRender(object sender, EventArgs e) {
            // myapps_h2.Visible = false;

            var apps = from x in DataContainer.Applications
                       //where x.User.Equals(this.currentUser(), StringComparison.OrdinalIgnoreCase)
                       orderby x descending
                       select x;

            var usedPeriods = from x in apps
                              select x.Semester;

            var availablePeriods = from x in DataContainer.HiringPeriods
                                   where x.Open < DateTime.Now && x.Close > DateTime.Now
                                   where !usedPeriods.Contains(x.Name)
                                   select x;


            myapps.DataSource = apps;
            myapps.DataBind();

            new_app_type.DataSource = availablePeriods;
            new_app_type.DataBind();

            if (new_app_type.Items.Count == 0) {
                new_app_type.Visible = false;
                new_app_button.Visible = false;
            }
            else {
                new_app_button.Visible = true;
                new_app_type.Visible = true;
            }
        }

        void myapps_ItemDataBound(object sender, DataGridItemEventArgs e) {
            
        }

        protected void New_App(object sender, EventArgs e) {
            App a = new App();
            a.User = this.currentUser(); 
            a.Semester = new_app_type.SelectedItem.Value;
            a.DateStarted = DateTime.Now;
            a.DateCompleted = DateTime.MinValue; 
            DataContainer.Applications.Add(a);
           
        }
    }
} 