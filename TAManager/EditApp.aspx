<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="EditApp.aspx.cs" Inherits="TAManager.EditApp" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
<script type="text/javascript">
    // when the entire document has loaded, run the code inside this function
    jQuery.fn.extend({
        AjaxReady: function (fn) {
            if (fn) {
                return jQuery.event.add(this[0], "AjaxReady", fn, null);
            } else {
                var ret = jQuery.event.trigger("AjaxReady", null, this[0], false, null);
                // if there was no return value then the even validated correctly
                if (ret === undefined)
                    ret = true;
                return ret;
            }
        }
    });
    $(document).AjaxReady(function () {
        // Wow! .. One line of code to make the unordered list drag/sortable!
        $('#fruit_list').sortable();
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <h2>Apply to TA!</h2>
<asp:ScriptManager ID="ScriptManager1" runat="server" />
<p>Please answer the following...</p>


    <div class="alert fade in">
    <a class="close" data-dismiss="alert" href="#">&times;</a>
    <strong>Your changes are not saved</strong> until you click the <em>Save and Continue Later</em> or <em>Save and Submit Application</em> link at the bottom of this page.
    </div>


    <h2>1. Why do you want to TA?</h2>
    <p><asp:TextBox ID="TextBox1" runat="server" Height="93px" TextMode="MultiLine" Width="500px"></asp:TextBox></p>
    <asp:RequiredFieldValidator ID="WhyTAValidator" runat="server" 
        ControlToValidate="TextBox1" ValidationGroup="SubmitValidation" 
        ErrorMessage="Please explain why you would like to be a TA."></asp:RequiredFieldValidator>

    <h2>2. What courses have you taken previously?</h2>

    <asp:CustomValidator ID="PreviousCourseValidator" runat="server" ValidationGroup="SubmitValidation" Display="Dynamic">
        <div class="alert alert-error">Please list relevant courses you have taken previously.</div>
    </asp:CustomValidator>

    <div class="row">
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
--%>
            <div class="span4">
            <p><asp:GridView ID="m_coursegrid" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-condensed table-striped">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Course Name" />
                    <asp:BoundField DataField="Grade" HeaderText="Grade" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView></p>
            </div>
            
            <div class="span8">
            <div class="well">
                    <h3>Add New</h3>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="AddCourse"
                        HeaderText="Please correct the following errors." ShowMessageBox="false" CssClass="alert alert-error" />
                    <p>
                        <label>Course Name</label>
                        <input type="text" ID="TextBox2" runat="server" class="span3" />
                        <span class="help-inline">(must be in format AAAA####[A], e.g. CSCI0150 or APMA2821H)</span>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox2" 
                                ErrorMessage="Not a valid course name" Display="None"
                                ValidationExpression="[A-Za-z]{4}[0-9]{4}[A-Za-z]{0,1}" 
                                ValidationGroup="AddCourse" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBox2"  Display="None"
                                ErrorMessage="Course name is required" ValidationGroup="AddCourse" />
                    </p>
                    <p>
                        <label>Grade Received:</label>
                        <asp:DropDownList ID="GradeDropDown" runat="server" CssClass="span3">
                            <asp:ListItem>Please Select</asp:ListItem>
                            <asp:ListItem>A</asp:ListItem>
                            <asp:ListItem>B</asp:ListItem>
                            <asp:ListItem>C</asp:ListItem>
                            <asp:ListItem>S</asp:ListItem>
                            <asp:ListItem>NC</asp:ListItem>
                            <asp:ListItem>AU</asp:ListItem>
                            <asp:ListItem>M</asp:ListItem>
                            <asp:ListItem>INC</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator runat="server" ControlToValidate="GradeDropDown" 
                            Operator="NotEqual" ValidationGroup="AddCourse" 
                            ValueToCompare="Please Select" Display="None"
                            ErrorMessage="Grade is required." />
                    </p>
                    <p>
                        <asp:Button ID="addpreviouscoursebutton" runat="server" OnClick="AddPreviousCourse" ValidationGroup="AddCourse" Text="Add" />
                    </p>
            </div>
            </div>
<%--
        </ContentTemplate>
    </asp:UpdatePanel>--%>
    </div>

    <h2>3. What teaching experience do you have?</h2>
        <p><asp:TextBox ID="TextBox3" runat="server" Height="93px" TextMode="MultiLine" Width="500px"></asp:TextBox></p>

    <h2>4. What courses are you applying to?</h2>
    <div class="well">
    
    <p>Add up to 10 courses, then drag and drop the courses to sort them in your order of preference. </p>
    
        <asp:CustomValidator ID="TACoursesValidator" runat="server" ValidationGroup="SubmitValidation"
        ErrorMessage="You must apply to at least one course." CssClass="alert alert-error"></asp:CustomValidator>


    <asp:UpdatePanel ID="up2" runat="server">
        <ContentTemplate>
            <asp:Literal runat="server" Text='<ul ID="fruit_list">' />
            <asp:Repeater ID="courselist" runat="server">
                <ItemTemplate>
                    <li>
            <input type="hidden" name="fruit[]" value="<%# Container.DataItem %>" /><%# Container.DataItem %>
                        <asp:LinkButton ID="LinkButton3" runat="server" 
                            CommandArgument="<%# Container.DataItem %>" OnClick="removeFruit">Remove</asp:LinkButton>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    
                </FooterTemplate>
            </asp:Repeater>
            <asp:Literal ID="Literal1" runat="server" Text='</ul>' />
            <asp:DropDownList ID="courses2add" runat="server">
            </asp:DropDownList>
            <button type="button" ID="courseaddbutton" runat="server" class="btn btn-primary" enableviewstate="false" ValidationGroup="AddCourseToTA"><i class="icon-plus icon-white"></i> Add</button>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="courses2add" ValueToCompare="Please select" Operator="NotEqual" ValidationGroup="AddCourseToTA" ErrorMessage="Please select a course."></asp:CompareValidator>

        </ContentTemplate>
    </asp:UpdatePanel>

        </div>

    <h2>5. Any additional comments?</h2>
    <p>
        <asp:TextBox ID="TextBox4" runat="server" Height="93px" TextMode="MultiLine" 
            Width="500px"></asp:TextBox> </p>


    <hr />
    <p>You can save your progress and continue working on your application later, or you 
        can submit your application for review. Once your application is submitted, you 
        will no longer be able to edit it. </p>
    <p>
        <i class="icon-star"></i>
        <asp:LinkButton ID="SaveButton" runat="server" CausesValidation="False">Save and continue later</asp:LinkButton>
    </p>
    <p>
        <i class="icon-ok"></i>
        <asp:LinkButton ID="SubmitButton" runat="server" ValidationGroup="SubmitValidation" OnClientClick="return confirm('Are you sure you want to submit this application?');">Submit application and finalize</asp:LinkButton>
    </p>
    <script type="text/javascript">
        prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(EndRequest);
        function EndRequest(sender, args) {
            $(document).AjaxReady();
        }
    </script>
</asp:Content>
