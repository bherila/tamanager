using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace TAManager.Data
{
    public class User
    {
        [XmlAttribute("login")]
        public string Login { get; set; }
        [XmlAttribute("password")]
        public string Password { get; set; }
        [XmlAttribute("firstname")]
        public string FirstName { get; set; }
        [XmlAttribute("lastname")]
        public string LastName { get; set; }
        public string FullName {
            get { return FirstName + " " + LastName; }
        }

        [XmlAttribute("admin")]
        public bool IsAdmin { get; set; }
    }
}