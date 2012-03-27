<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TAManager.Home" %>
<%@ Import Namespace="TAManager.Data" %>
<script runat="server">
    protected override void OnLoad(EventArgs e) {
        base.OnLoad(e);
        myapps.ItemDataBound += (o, args) => {
            if (args.Item != null) {
                /* get the data item corresponding to this row */
                App item = (App)args.Item.DataItem;
                if (item == null)
                    return;
                        
                TableCell col3 = (TableCell)args.Item.Controls[3];
                        
                /* create hyperlink for edit or view, depending on the application status*/
                col3.Controls.Add /* and add to the grid cell */ (new HyperLink() {
                    Text = (item.Status == ApplicationStatus.InProgress ? @"<i class=""icon-pencil""></i> Edit" : @"<i class=""icon-search""></i> View"),
                    NavigateUrl = String.Format("EditApp.aspx?Semester={0}", Server.UrlEncode(item.Semester))
                });
            }
        };

        myapps.PreRender += TAManager.Extensions.GridViewHtmlFix;
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<% if (Request["success"] == "true")
   { %>
   <div class="alert alert-success"><%= Session["message"]%></div>
<% } %>

<div class="row">
    <div class="span6">
        <h2 runat="server" id="myapps_h2">My Applications</h2>
        <p>You can view and modify your current applications. Applications you've submitted are read-only,
        as are applications for which the hiring period is closed. You can still view these applications
        and copy and paste bits into a new application, if you wish.</p>
        <p><asp:DataGrid EnableViewState="false" runat="server" ID="myapps" CssClass="table table-bordered table-striped" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundColumn DataField="Semester" HeaderText="Semester" />
                <asp:BoundColumn DataField="DateStarted" HeaderText="Date Started" />
                <asp:BoundColumn DataField="Status" HeaderText="Status" />
                <asp:TemplateColumn HeaderText="Action" /><%-- Bound in OnLoad (above) --%>
            </Columns>
        </asp:DataGrid></p>

        <p><b>To start a new application,</b> first select an available semester from the drop-down list
        below. Then click <em>start application</em>.</p>
        
        <div class="form-inline">
            <asp:DropDownList runat="server" ID="new_app_type" 
                DataTextField="Name" 
                DataValueField="Name">
            </asp:DropDownList>

            <asp:LinkButton runat="server" CssClass="btn btn-success" ID="new_app_button" OnClick="New_App"><i class="icon-white icon-ok"></i> Start application</asp:LinkButton>
        
        </div>

    </div><!-- /.span6 -->
    
    <asp:PlaceHolder runat="server" id="m_courseplaceholder">
    <div class="span6">
        <h2>My Courses</h2>
        <p>You're a HTA who has permission to view and modify applications for the following courses.</p>
        <p><asp:DataGrid EnableViewState="false" runat="server" ID="coursegrid" AutoGenerateColumns="false" CssClass="table table-bordered table-striped">
            <Columns>
                <asp:HyperLinkColumn DataTextField="BannerName" HeaderText="Banner Name" DataNavigateUrlField="BannerName" DataNavigateUrlFormatString="ViewCourse.aspx?course={0}" />
                <asp:BoundColumn DataField="Year" HeaderText="Semester" />
                <asp:BoundColumn DataField="Count" HeaderText="Applications Received" />
            </Columns>
        </asp:DataGrid></p>
    </div><!-- /.span6 -->
    </asp:PlaceHolder>

</div><!-- /.row -->
</asp:Content>
