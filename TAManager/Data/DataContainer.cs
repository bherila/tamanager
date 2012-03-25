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
    public class DataContainer
    {
        public List<Course> Courses = new List<Course>();
        public List<User> Users = new List<User>();
        public List<App> Applications = new List<App>();
        public List<HiringPeriod> HiringPeriods = new List<HiringPeriod>();

        private static DataContainer c;
        public static DataContainer Instance()
        {
            if (c == null) c = new DataContainer();
            return c;
        }

        public  void Save() {
            lock (DataContainer.Instance())
            {
                using (var stream = System.IO.File.CreateText(System.Web.Hosting.HostingEnvironment.MapPath("/App_Data/TAManager.xml")))
                {
                    XmlSerializer xml = new XmlSerializer(typeof(DataContainer));
                    xml.Serialize(stream, this);
                    stream.Close();
                }
            }
        }

        public static void Load()
        {
            lock (DataContainer.Instance())
            {
                var filename = System.Web.Hosting.HostingEnvironment.MapPath("/App_Data/TAManager.xml");
                if (System.IO.File.Exists(filename))
                {
                    using (var stream = System.IO.File.OpenText(filename))
                    {
                        XmlSerializer xml = new XmlSerializer(typeof(DataContainer));
                        c = (DataContainer)xml.Deserialize(stream);
                        stream.Close();
                    }
                }
                else
                {
                    var cdata = TAManager.Data.DataContainer.Instance();
                    cdata.HiringPeriods.Add(new HiringPeriod()
                    {
                        Open = DateTime.Now,
                        Close = DateTime.Now.AddMonths(1),
                        Type = ApplicationType.HTA,
                        Name = "2012Fall HTA"
                    });
                    cdata.HiringPeriods.Add(new HiringPeriod()
                    {
                        Open = DateTime.Now,
                        Close = DateTime.Now.AddMonths(1),
                        Type = ApplicationType.HTA,
                        Name = "2012Fall UTA"
                    });
                    cdata.HiringPeriods.Add(new HiringPeriod()
                    {
                        Open = DateTime.Now,
                        Close = DateTime.Now.AddMonths(1),
                        Type = ApplicationType.HTA,
                        Name = "2012S UTA"
                    });
                    cdata.HiringPeriods.Add(new HiringPeriod()
                    {
                        Open = DateTime.Now,
                        Close = DateTime.Now.AddMonths(1),
                        Type = ApplicationType.HTA,
                        Name = "2011F UTA"
                    });
                    cdata.HiringPeriods.Add(new HiringPeriod()
                    {
                        Open = DateTime.Now,
                        Close = DateTime.Now.AddMonths(1),
                        Type = ApplicationType.HTA,
                        Name = "2011S UTA"
                    });

                    cdata.Courses.Add(new Course() { BannerName = "CS15", HTAs = new List<string> { "bherila" } });
                    cdata.Courses.Add(new Course() { BannerName = "CS16" });
                    cdata.Courses.Add(new Course() { BannerName = "CS32" });
                    cdata.Courses.Add(new Course() { BannerName = "CS123" });

                    cdata.Users.Add(new User()
                    {
                        FirstName = "Tom",
                        LastName = "Doeppner",
                        IsAdmin = true,
                        Login = "twd",
                        Password = "twd".hashPassword()
                    });


                    cdata.Save();
                }
            }
        }

    }


}