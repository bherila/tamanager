using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAManager.Data;

namespace TAManager
{
    public partial class ViewCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(this.currentUser()))
                Response.Redirect("Default.aspx?redir=" + Request.RawUrl);

            string banner_name = Request["course"];
            var course_query = DataContainer.Instance().Courses.Where (x=> x.BannerName.Equals(banner_name, StringComparison.OrdinalIgnoreCase));
            if (!this.isAdmin())
                course_query = course_query.Where(x => x.HTAs.Contains(this.currentUser()));

            var course_list = course_query.ToList();
            if (course_list.Count == 0)
                Response.Redirect("Home.aspx?error=ViewCourse.aspx");


            var app_list = new List<App>();
            foreach (Course c in course_list)
                app_list.AddRange(
                    from x in DataContainer.Instance().Applications
                    where x.Preferences.Contains(c.BannerName)
                    select x);

            appgrid.DataSource = app_list;
            appgrid.DataBind();

        }
    }
}