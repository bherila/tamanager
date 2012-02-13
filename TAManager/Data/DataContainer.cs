using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace TAManager.Data
{


    public class HiringPeriod
    {
        public ApplicationType Type { get; set; }
        public string Name { get; set; } // e.g. 2011F
        public DateTime Open { get; set; }
        public DateTime Close { get; set; }
    }



    [XmlRoot]
    public static class DataContainer
    {
        public static List<Course> Courses = new List<Course>();
        public static List<User> Users = new List<User>();
        public static List<App> Applications = new List<App>();
        public static List<HiringPeriod> HiringPeriods = new List<HiringPeriod>();

        public static void Save() {

        }
    }


}