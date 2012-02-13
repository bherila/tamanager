using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAManager.Data;

namespace TAManager
{
    public partial class ViewApp : System.Web.UI.Page
    {
        App currentApplication;


        protected override void OnInit(EventArgs e) {
            base.OnInit(e);

            // prevent caching
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            string appSem = Request["semester"];
            string appUser = this.currentUser();
            if (!String.IsNullOrEmpty(Request["user"]))
                appUser = Request["user"];
            
            var appData = from x in DataContainer.Applications
                          where x.Semester.Equals(appSem) && x.User == appUser
                          select x;

            if (appData.Count() == 0) {
                Response.StatusCode = 404;
                throw new Exception("Application not found");
            }
            currentApplication = appData.First();

            // does the user have permission to view this application?
            // cases when user IS authorized: 
            //   1. user's own app
            //   2. user is the HTA for the course during the hiring period
            //   3. user is an admin (can view for all courses in all hiring periods)
            bool accessAllowed = false;
            if (appUser == this.currentUser())
                accessAllowed = true;
            else {

                var currentUserDetails = (from x in DataContainer.Users
                                          where x.Login == this.currentUser()
                                          select x).First();

                var currentUserHTACourses = (from x in DataContainer.Courses
                                             where x.HTAs.Contains(this.currentUser())
                                             select x.BannerName);

                if (currentUserDetails.IsAdmin
                    || currentUserHTACourses.Intersect(currentApplication.Preferences.Split(',')).Count() > 0 )

                    accessAllowed = true;

            }

            if (accessAllowed) {
                m_whyTA.Text = currentApplication.WhyTA;
                m_experience.Text = currentApplication.Experiences;
                m_comments.Text = currentApplication.OtherComments;

                m_coursework.DataSource = (from x in currentApplication.CoursesTaken orderby x.CourseName ascending select x);
                m_coursework.DataBind();

                m_prefs.DataSource = currentApplication.Preferences.Split(',').Where(a => a.Length > 0);
                m_prefs.DataBind();
            }
            else {

                throw new Exception("User is not authorized to view this application");

            }
        }
    }
}