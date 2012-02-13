using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace TAManager.Data
{
    public class Course
    {
        // <course bannerName="" legacyName="">
        //    <professor>jj</professor>
        //    <professor>twd</professor>
        // </course>

        [XmlAttribute("bannerName")]
        public string BannerName { get; set; }

        [XmlAttribute("legacyName")]
        public string LegacyName { get; set; }

        [XmlAttribute("year")]
        public string Year { get; set; }

        [XmlAttribute("numTAs")]
        public int AllowedTAs { get; set; }

        [XmlAttribute("numHTAs")]
        public int AllowedHTAs { get; set; }

        [XmlArray("prof")]
        public List<string> Professor { get; set; }

        [XmlArray("ta")]
        public List<string> TAs { get; set; }

        [XmlArray("hta")]
        public List<string> HTAs { get; set; }
    }


    public class User
    {
        [XmlAttribute("login")] public string Login { get; set; }
        [XmlAttribute("password")] public string Password { get; set; }
        [XmlAttribute("firstname")] public string FirstName { get; set; }
        [XmlAttribute("lastname")] public string LastName { get; set; }
        public string FullName {
            get { return FirstName + " " + LastName; }
        }

        [XmlAttribute("admin")]
        public bool IsAdmin { get; set; }
    }

    public enum ApplicationType { HTA, UTA }
    public enum ApplicationStatus { InProgress, Submitted, Hired }

    public class App : IComparable<App>
    {
        public App() {
            CoursesTaken = new List<CourseTaken>();
            Preferences = String.Empty; 
        }

        [XmlAttribute]
        public ApplicationType Type { get; set; }

        [XmlAttribute]
        public ApplicationStatus Status { get; set; }

        [XmlAttribute]
        public string User { get; set; }

        [XmlAttribute]
        public string Semester { get; set; }

        [XmlElement]
        public string WhyTA { get; set; }

        [XmlElement]
        public string Experiences { get; set; }

        [XmlElement]
        public string ProbableSchedule { get; set; }

        [XmlElement]
        public string OtherComments { get; set; }

        [XmlElement("course_taken")]
        public List<CourseTaken> CoursesTaken { get; set; }

        [XmlElement]
        public string Essay { get; set; }

        [XmlAttribute]
        public DateTime DateStarted { get; set; }

        [XmlAttribute]
        public DateTime DateCompleted { get; set; }

        [XmlAttribute]
        public string Preferences { get; set; }

        public int CompareTo(App other) {
            //if (this.Semester.Length != 5 || other.Semester.Length != 5) {
            //    throw new Exception("Both semesters must be of length 5"); 
            //}

            int y1 = int.Parse(this.Semester.Substring(0, 4));
            int y2 = int.Parse(other.Semester.Substring(0, 4));

            if (y1 > y2) {
                return 1;
            }
            else if (y1 < y2) {
                return -1;
            }
            else {
                char s1 = this.Semester[4];
                char s2 = other.Semester[4];

                if (s1 == 'F' && s2 == 'S') {
                    return 1;
                }
                else if (s1 == 'S' && s2 == 'F') {
                    return -1;
                }
                else if (s1 == s2)
                    return 0;
                else {
                    throw new Exception("Invalid semester");
                }
            }


        }
    }

    public class CourseTaken
    {
        [XmlAttribute("name")]
        public string CourseName { get; set; }

        [XmlAttribute("grade")]
        public string Grade { get; set; }
    }

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