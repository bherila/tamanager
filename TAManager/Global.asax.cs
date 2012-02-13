using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using TAManager.Data;

namespace TAManager
{
    public class Global : System.Web.HttpApplication
    {

        void Application_Start(object sender, EventArgs e) {
            // Code that runs on application startup
            DataContainer.HiringPeriods.Add(new HiringPeriod() {
                Open = DateTime.Now,
                Close = DateTime.Now.AddMonths(1),
                Type = ApplicationType.HTA,
                Name = "2012Fall HTA"
            });
            DataContainer.HiringPeriods.Add(new HiringPeriod() {
                Open = DateTime.Now,
                Close = DateTime.Now.AddMonths(1),
                Type = ApplicationType.HTA,
                Name = "2012Fall UTA"
            });
            DataContainer.HiringPeriods.Add(new HiringPeriod() {
                Open = DateTime.Now,
                Close = DateTime.Now.AddMonths(1),
                Type = ApplicationType.HTA,
                Name = "2012S UTA"
            });
            DataContainer.HiringPeriods.Add(new HiringPeriod() {
                Open = DateTime.Now,
                Close = DateTime.Now.AddMonths(1),
                Type = ApplicationType.HTA,
                Name = "2011F UTA"
            });
            DataContainer.HiringPeriods.Add(new HiringPeriod() {
                Open = DateTime.Now,
                Close = DateTime.Now .AddMonths(1),
                Type = ApplicationType.HTA,
                Name = "2011S UTA"
            });

            DataContainer.Courses.Add(new Course() { BannerName = "CS15" });
            DataContainer.Courses.Add(new Course() { BannerName = "CS16" });
            DataContainer.Courses.Add(new Course() { BannerName = "CS32" });
            DataContainer.Courses.Add(new Course() { BannerName = "CS123" });
        }

        void Application_End(object sender, EventArgs e) {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e) {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e) {
            // Code that runs when a new session is started

        }

        void Session_End(object sender, EventArgs e) {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }

        public static string Current_Semester() {
            if (DateTime.Now.Month > 9)
                return (DateTime.Now.Year + 1) + "S";
            else
                return DateTime.Now.Year + "F";
        }

    }
}
