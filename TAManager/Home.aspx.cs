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

        protected void Page_PreRender(object sender, EventArgs e)
        {
            this.requireLogin();

            // myapps_h2.Visible = false;
            var DataContainer = TAManager.Data.DataContainer.Instance();
            var apps = from x in DataContainer.Applications
                       where x.User.Equals(this.currentUser(), StringComparison.OrdinalIgnoreCase)
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

            var mycourses = (from x in DataContainer.Courses
                             where x.HTAs.Contains(this.currentUser())
                             select new
                             {
                                 x.BannerName,
                                 x.Year,
                                 Count = (from y in DataContainer.Applications
                                          where y.Preferences.Contains(x.BannerName)
                                          select y).Count()
                             }).ToList();
            if (mycourses.Count > 0)
            {
                m_courseplaceholder.Visible = true;
                coursegrid.DataSource = mycourses;
                coursegrid.DataBind();
            }
            else
            {
                m_courseplaceholder.Visible = false;
            }


            new_app_type.DataSource = availablePeriods;
            new_app_type.DataBind();

            if (new_app_type.Items.Count == 0)
            {
                new_app_type.Visible = false;
                new_app_button.Visible = false;
            }
            else
            {
                new_app_button.Visible = true;
                new_app_type.Visible = true;
            }
        }

        void myapps_ItemDataBound(object sender, DataGridItemEventArgs e)
        {

        }

        protected void New_App(object sender, EventArgs e)
        {

            var DataContainer = TAManager.Data.DataContainer.Instance();
            App a = new App();
            a.User = this.currentUser();
            a.Semester = new_app_type.SelectedItem.Value;
            a.DateStarted = DateTime.Now;
            a.DateCompleted = DateTime.MinValue;
            lock (DataContainer.Applications)
            {
                DataContainer.Applications.Add(a);
            }
        }
    }
}