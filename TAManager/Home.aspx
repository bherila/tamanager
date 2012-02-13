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
                    Text = (item.Status == ApplicationStatus.InProgress ? "Edit" : "View"),
                    NavigateUrl = String.Format("EditApp.aspx?Semester={0}", Server.UrlEncode(item.Semester))
                });
            }
        };
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <h2 runat="server" id="myapps_h2">My Applications</h2>

    <asp:DataGrid EnableViewState="false" runat="server" ID="myapps" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundColumn DataField="Semester" HeaderText="Semester" />
            <asp:BoundColumn DataField="DateStarted" HeaderText="Date Started" />
            <asp:BoundColumn DataField="Status" HeaderText="Status" />
            <asp:TemplateColumn HeaderText="Action" /><%-- Bound in OnLoad (above) --%>
        </Columns>
    </asp:DataGrid>

    <asp:LinkButton runat="server" ID="new_app_button" OnClick="New_App">Start application</asp:LinkButton>

    <asp:DropDownList runat="server" ID="new_app_type" 
        DataTextField="Name" 
        DataValueField="Name">
    </asp:DropDownList>

    <h2>My Courses</h2>


</asp:Content>
