<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="EditApp.aspx.cs" Inherits="TAManager.EditApp" %>
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
    <p>1. Why do you want to TA?</p>
    <p>
        <asp:TextBox ID="TextBox1" runat="server" Height="93px" TextMode="MultiLine" 
            Width="500px"></asp:TextBox>
    </p>
    <asp:RequiredFieldValidator ID="WhyTAValidator" runat="server" 
        ControlToValidate="TextBox1" ValidationGroup="SubmitValidation" 
        ErrorMessage="Please explain why you would like to be a TA."></asp:RequiredFieldValidator>
    <p>2. What courses have you taken previously?</p>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="m_coursegrid" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Course Name" />
                    <asp:BoundField DataField="Grade" HeaderText="Grade" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            <asp:Panel ID="Panel1" runat="server" GroupingText="Add new">
                <p>
                    Course Name:
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    &nbsp;(must be in format AAAA####[A], e.g. CSCI0150 or APMA2821H)
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="TextBox2" ErrorMessage="Not a valid course name" ValidationExpression="[A-Za-z]{4}[0-9]{4}[A-Za-z]{0,1}" ValidationGroup="AddCourse" ForeColor="Red" /></p>
                <p>
                    Grade Received:
                    <asp:DropDownList ID="GradeDropDown" runat="server">
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
                    <asp:CompareValidator runat="server" ForeColor="Red" ControlToValidate="GradeDropDown" ValueToCompare="Please Select" Operator="NotEqual" ValidationGroup="AddCourse" ErrorMessage="Grade is required." />
                </p>
                <p>
                    <asp:Button ID="addpreviouscoursebutton" runat="server" Text="Add" OnClick="AddPreviousCourse" ValidationGroup="AddCourse"  />
                </p>
            </asp:Panel>
            <asp:CustomValidator ID="PreviousCourseValidator" runat="server" ValidationGroup="SubmitValidation"
                ErrorMessage="Please list relevant courses you have taken previously."></asp:CustomValidator>
        </ContentTemplate>
    </asp:UpdatePanel>
    <p>
        3. What teaching experience do you have?</p>
        <asp:TextBox ID="TextBox3" runat="server" Height="93px" TextMode="MultiLine" 
            Width="500px"></asp:TextBox></p>

            <p>
    4. What courses are you applying to? Add up to 10 courses, then drag and drop 
    the courses to sort them in your order of preference.<br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
    <asp:Button ID="courseaddbutton" runat="server" ValidationGroup="AddCourseToTA" Text="Add" EnableViewState="false" />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="courses2add" ValueToCompare="Please select" Operator="NotEqual" ValidationGroup="AddCourseToTA" ErrorMessage="Please select a course."></asp:CompareValidator>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:CustomValidator ID="TACoursesValidator" runat="server" ValidationGroup="SubmitValidation"
        ErrorMessage="You must apply to at least one course."></asp:CustomValidator>

    <p>5. Any additional comments?</p>
    <p>
        <asp:TextBox ID="TextBox4" runat="server" Height="93px" TextMode="MultiLine" 
            Width="500px"></asp:TextBox> </p>
    <p>You can save your progress and continue working on your application later, or you 
        can submit your application for review. Once your application is submitted, you 
        will no longer be able to edit it. </p>
    <p>
        <asp:LinkButton ID="SaveButton" runat="server" CausesValidation="False">Save and continue later</asp:LinkButton>
    </p>
    <p>
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
