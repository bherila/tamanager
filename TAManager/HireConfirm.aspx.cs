using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TAManager
{
    public partial class HireConfirm : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            var dc = TAManager.Data.DataContainer.Instance();
            var hps = dc.HiringPeriods;
            var current_hiring_period = hps[0]; //TODO
            var apps = dc.Applications.Where(app => app.Semester == current_hiring_period.Name);

            // split up (cache) the CSV preferences for each student application
            var ApplicantWishes = from y in apps
                                  let Prefs = y.Preferences.Split(',')
                                  select new
                                  {
                                      Prefs,
                                      FirstChoice = Prefs.First(),
                                      StudentName = y.User
                                  };


            // Get list of users eligible for hire by each course (e.g. within top N)
            var CourseWishes = (from x in dc.Courses
                                where x.Year == current_hiring_period.Name
                                let CoursePrefs = x.HiringPreferences.Split(',')
                                let HappyToHires = CoursePrefs.Take(x.AllowedTAs)
                                select new { x.BannerName, CoursePrefs, HappyToHires }).ToList();

            Dictionary<string, List<string>> hires = new Dictionary<string, List<string>>(); // <course, List<login>>

            // hire by student preferences first
            foreach (var x in ApplicantWishes)
            {
                var possible_courses = from y in CourseWishes
                                       where y.HappyToHires.Contains(x.StudentName)
                                       select y.BannerName;

                hires[possible_courses.First()].Add(x.StudentName);
            }


        }


    }
}