using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace TAManager.Data
{
    public enum ApplicationStatus { InProgress, Submitted, Hired }


    public class App : IComparable<App>
    {
        public App() {
            CoursesTaken = new List<CourseTaken>();
            Preferences = String.Empty;
        }

        [XmlAttribute]
        public string Type { get; set; }


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
        
        public class CourseTaken
        {
            [XmlAttribute("name")]
            public string CourseName { get; set; }

            [XmlAttribute("grade")]
            public string Grade { get; set; }
        }


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
}