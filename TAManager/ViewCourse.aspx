<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="ViewCourse.aspx.cs" Inherits="TAManager.ViewCourse" %>
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

<asp:GridView runat="server" ID="appgrid" AutoGenerateColumns="false">
<Columns>
    <asp:BoundField HeaderText="Applicant Name" DataField="User" />
    <asp:BoundField HeaderText="Why TA?" DataField="WhyTA" />
    <asp:BoundField HeaderText="Experiences" DataField="Experiences" />
    <asp:BoundField HeaderText="Probable Course Schedule" DataField="ProbableSchedule" />
    <asp:BoundField HeaderText="Applicant Comments" DataField="OtherComments" />
    <asp:BoundField HeaderText="Essay" DataField="Essay" />
    <asp:BoundField HeaderText="Date Submitted" DataField="DateCompleted" />
    <asp:BoundField HeaderText="HTA Comment" DataField="HTAComment" />
</Columns>
</asp:GridView>

<h2>Hiring Preferences</h2>
<p>Drag and drop the applicants in the list below to define your hiring preferences.</p>
<asp:PlaceHolder runat="server" ID="prefs_placeholder">
    <asp:Literal ID="prefs_header" runat="server" Text='<ul ID="fruit_list">' />
    <asp:Repeater ID="prefs_body" runat="server">
    <ItemTemplate>
        <li><input type="hidden" name="fruit[]" value="<%# Container.DataItem %>" /><%# Container.DataItem %></li>
    </ItemTemplate>
    </asp:Repeater>
    <asp:Literal ID="prefs_footer" runat="server" Text='</ul>' />
</asp:PlaceHolder>

<asp:Button runat="server" ID="savebtn" Text="Save Changes" />


</asp:Content>
