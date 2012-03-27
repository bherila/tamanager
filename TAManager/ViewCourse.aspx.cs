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
        Course CurrentCourse;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.requireLogin();

            string banner_name = Request["course"];
            string hiring_period = Request["hiringperiod"];

            var course_query = DataContainer.Instance().Courses.Where(x => x.BannerName.Equals(banner_name, StringComparison.OrdinalIgnoreCase));
            if (!this.isAdmin())
                course_query = course_query.Where(x => x.HTAs.Contains(this.currentUser()));

            var CourseList = course_query.ToList();
            if (CourseList.Count != 1)
                Response.Redirect("Home.aspx?error=ViewCourse.aspx");
            CurrentCourse = CourseList[0];

            // get the preference ordering
            string f = Request["fruit[]"];
            if (!String.IsNullOrEmpty(f))
            {
                CurrentCourse.HiringPreferences = f; // comma separated list of cs logins
                DataContainer.Instance().Save();
            }

        }

        protected override void OnLoad(EventArgs e)
        {



            var app_list = new List<App>(from x in DataContainer.Instance().Applications
                                         where x.Preferences.Contains(CurrentCourse.BannerName)
                                         select x);
            
            // now sort according to preferences
            {
                var tmpList = new List<App>();
                foreach (var x in (CurrentCourse.HiringPreferences ?? "").Split(','))
                {
                    tmpList.AddRange(app_list.Where(a => a.User.Equals(x, StringComparison.OrdinalIgnoreCase)));
                    app_list.RemoveAll(a => a.User == x);
                }
                tmpList.AddRange(app_list);
                app_list = tmpList;
            }


            appgrid.DataSource = app_list;
            appgrid.DataBind();

            prefs_body.DataSource = (from x in app_list
                                     select x.User);
            prefs_body.DataBind();
        }
    }
}