using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TAManager.Data;

namespace TAManager
{
    public partial class EditApp : System.Web.UI.Page
    {
        [Serializable]
        class PreviousCourse
        {
            public string Name { get; set; }
            public string Grade { get; set; }
        }

        List<string> fruit;
        List<PreviousCourse> previouscourses;
        App currentApplication;

        protected override void OnInit(EventArgs e) {
            base.OnInit(e);
            var DataContainer = TAManager.Data.DataContainer.Instance();

            // prevent caching
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.MinValue);

            fruit = new List<string>();

            string appSem = Request["semester"];

            var appData = from x in DataContainer.Applications
                          where x.Semester.Equals(appSem) && x.User == this.currentUser()
                          select x;

            if (appData.Count() == 0) {
                Response.StatusCode = 404;
                throw new Exception("Application not found");
            }
            currentApplication = appData.First();
            if (currentApplication.Status != ApplicationStatus.InProgress) {
                Response.Redirect("ViewApp.aspx?semester=" + Server.UrlEncode(Request["semester"]));
            }
            
            if (!Page.IsPostBack) {
                TextBox1.Text = currentApplication.WhyTA;
                TextBox3.Text = currentApplication.Experiences;
                TextBox4.Text = currentApplication.OtherComments;
                previouscourses = (from x in currentApplication.CoursesTaken
                                   orderby x.CourseName ascending
                                   select new PreviousCourse() {
                                       Grade = x.Grade,
                                       Name = x.CourseName
                                   }).ToList();
                fruit = currentApplication.Preferences.Split(',').Where(a=>a.Length>0).ToList(); 
            }

            string f = Request["fruit[]"];
            if (!String.IsNullOrEmpty(f)) {
                fruit.AddRange(f.Split(','));
            }
            
            courseaddbutton.Click += (o, args) => { 
                fruit.Add(courses2add.SelectedItem.Value);
                courses2add.SelectedIndex = -1; 
                courses2add.Focus();
            };

            m_coursegrid.RowDeleting += (o, args) => {
                previouscourses.RemoveAt(args.RowIndex);
            };

            PreviousCourseValidator.ServerValidate += (o, args) => {
                args.IsValid = previouscourses.Count > 0;
            };

            TACoursesValidator.ServerValidate += (o, args) => {
                args.IsValid = fruit.Count > 0;
            };

            SaveButton.Click += new EventHandler(SaveButton_Click);
            SubmitButton.Click += new EventHandler(SubmitButton_Click);
        }

        void SubmitButton_Click(object sender, EventArgs e) {
            if (Page.IsValid) {
                currentApplication.Status = ApplicationStatus.Submitted;
                currentApplication.DateCompleted = DateTime.Now;
                Save();
                Response.Redirect("Home.aspx?nocache=" + Guid.NewGuid().ToString("N"));
            }
        }

        void SaveButton_Click(object sender, EventArgs e) {
            Save();
            Response.Redirect("Home.aspx?nocache=" + Guid.NewGuid().ToString("N")); 
        }

        private void Save() {
            currentApplication.WhyTA = TextBox1.Text;
            currentApplication.Experiences = TextBox3.Text;
            currentApplication.OtherComments = TextBox4.Text;
            currentApplication.CoursesTaken = (
                from x in previouscourses
                select new TAManager.Data.App.CourseTaken() {
                    CourseName = x.Name,
                    Grade = x.Grade
                }).ToList();
            currentApplication.Preferences = String.Join(",", fruit);
            DataContainer.Instance().Save();
        }

        protected override void OnLoad(EventArgs e) {
            base.OnLoad(e);
            if (Page.IsPostBack) {
                previouscourses = (List<PreviousCourse>)ViewState["previous_courses"] ?? new List<PreviousCourse>();
            }
            
        }

        protected void AddPreviousCourse(Object sender, EventArgs e) {
            if (Page.IsValid) {
                PreviousCourse p = new PreviousCourse();
                p.Grade = GradeDropDown.SelectedItem.Value;
                p.Name = TextBox2.Text;
                previouscourses.Add(p);
                TextBox2.Text = "";
                TextBox2.Focus(); 
            }
        }

        protected override void OnPreRender(EventArgs e) {
            var DataContainer = TAManager.Data.DataContainer.Instance();

            //if (fruit.Count == 0)
            //    fruit = (from c in TAManager.Data.DataContainer.Courses
            //             select c.BannerName).ToList();

            base.OnPreRender(e);
            courselist.DataSource = fruit;
            courselist.DataBind();

            var availableCourses = (from c in DataContainer.Courses
                                   where !fruit.Contains(c.BannerName)
                                   select c.BannerName).ToList();

            bool canAdd = availableCourses.Count > 0;
            courses2add.Visible = canAdd;
            courseaddbutton.Visible = canAdd; 
            if (canAdd) {
                courses2add.DataSource = availableCourses;
                courses2add.DataBind();
                courses2add.Items.Insert(0, "Please select"); 
            }

            m_coursegrid.DataSource = previouscourses;
            m_coursegrid.DataBind();

            ViewState.Add("previous_courses", previouscourses);
        }

        protected void removeFruit(Object sender, EventArgs e) {
            LinkButton s = (LinkButton)sender;
            fruit.Remove(s.CommandArgument);
            courses2add.Focus(); 
        }

    }
}