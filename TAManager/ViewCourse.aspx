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
        $('#fruit_list').sortable();
    });
    $(document).ready(function () {
        $('#fruit_list').sortable();
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<h1>View Course</h1>
<p><a href="Home.aspx?rid=<%= Guid.NewGuid().ToString("N") %>"><b>Return to portal</b></a></p>
<asp:ScriptManager ID="ScriptManager1" runat="server" />
<p>
<asp:DataGrid runat="server" ID="appgrid" AutoGenerateColumns="false" CssClass="table table-bordered table-striped">
<Columns>
    <asp:BoundColumn HeaderText="Applicant Name" DataField="User" />
    <asp:BoundColumn HeaderText="Why TA?" DataField="WhyTA" />
    <asp:BoundColumn HeaderText="Experiences" DataField="Experiences" />
    <asp:BoundColumn HeaderText="Probable Course Schedule" DataField="ProbableSchedule" />
    <asp:BoundColumn HeaderText="Applicant Comments" DataField="OtherComments" />
    <asp:BoundColumn HeaderText="Essay" DataField="Essay" />
    <asp:BoundColumn HeaderText="Date Submitted" DataField="DateCompleted" />
</Columns>
</asp:DataGrid>
</p>

<div class="row">
<div class="span3">
<h2>Hiring Preferences</h2>
<p>Drag and drop the applicants in the list below to define your hiring preferences, then click Save Changes below. 
The grid above will update when you click Save Changes.</p>
<asp:PlaceHolder runat="server" ID="prefs_placeholder">
    <asp:Literal ID="prefs_header" runat="server" Text='<ul ID="fruit_list">' />
    <asp:Repeater ID="prefs_body" runat="server">
    <ItemTemplate>
        <li><input type="hidden" name="fruit[]" value="<%# Container.DataItem %>" /><%# Container.DataItem %></li>
    </ItemTemplate>
    </asp:Repeater>
    <asp:Literal ID="prefs_footer" runat="server" Text='</ul>' />
</asp:PlaceHolder>
</div>
</div>

<asp:Button runat="server" ID="savebtn" Text="Save Changes" />

<script type="text/javascript">
    prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(EndRequest);
    function EndRequest(sender, args) {
        $(document).AjaxReady();
    }
</script>

</asp:Content>
<script runat="server">
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        appgrid.PreRender += TAManager.Extensions.GridViewHtmlFix;
    }
</script>