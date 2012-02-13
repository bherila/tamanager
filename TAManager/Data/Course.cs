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
        public string BannerName { 
            get; 
            set; 
        }

        [XmlAttribute("legacyName")]
        public string LegacyName { 
            get; 
            set;
        }

        [XmlAttribute("year")]
        public string Year {
            get;
            set;
        }

        [XmlAttribute("numTAs")]
        public int AllowedTAs {
            get { return _allowedTAs; }
            set {
                if (value >= 0)
                    _allowedTAs = value;
                else
                    throw new ArgumentException("Value must be positive.");
            }
        }
        private int _allowedTAs;

        [XmlAttribute("numHTAs")]
        public int AllowedHTAs {
            get { return _allowedHTAs; }
            set {
                if (value >= 0)
                    _allowedHTAs = value;
                else
                    throw new ArgumentException("Value must be positive.");
            }
        }
        private int _allowedHTAs;

        [XmlArray("prof")]
        public List<string> Professor { get; set; }

        [XmlArray("ta")]
        public List<string> TAs { get; set; }

        [XmlArray("hta")]
        public List<string> HTAs { get; set; }
    }

}