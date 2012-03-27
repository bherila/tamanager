<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="TAManager.ManageCourses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<h1>Manage Courses &amp; Hiring Periods</h1>

<div class="row">
<div class="span6">
    <p>The following hiring periods are available. Complete this form to add a new hiring period.
    If you specify the name of an existing hiring period, it will be replaced.</p>

    <label>Hiring Period Year:</label>
    <asp:TextBox runat="server" ID="nhp_name" />
    <div class="help-inline">e.g. 2012FALL or 2011-2012</div>

    <label>Application Class:</label>
    <asp:TextBox runat="server" ID="nhp_type" />
    <div class="help-inline">e.g. MTA, UTA, HTA, HeadConsultant, SPOC</div>

    <label>Opens:</label>
    <asp:TextBox runat="server" ID="nhp_opens" />
    <div class="help-inline">ISO8601 format, currently <%= DateTime.UtcNow.ToString(TAManager.Extensions.TIME_FORMAT) %></div>

    <label>Closes:</label>
    <asp:TextBox runat="server" ID="nhp_closes" />
    <div class="help-inline">ISO8601 format</div>

    <p><asp:Button ID="Button1" UseSubmitBehavior="false" runat="server" CssClass="btn btn-primary" Text="Create Hiring Period" /></p>

    <p><asp:DataGrid runat="server" CssClass="table table-bordered table-striped table-condensed" ID="hiringperiodgrid" EnableViewState="false">
    <Columns>
        <asp:BoundColumn DataField="Year" />
    </Columns>
    </asp:DataGrid></p>

</div>
<div class="span6">
    <p>The following courses are accepting applications for hiring. Enter course data in the following comma-separated (CSV) format:</p>
    <pre>HIRING_PERIOD,BANNER_NAME,NUM_HTAS,NUM_UTAS
2012FALL,CSCI0150,3,20</pre>
    <div class="alert alert-info"><b>Note:</b> Existing courses will be updated.</div>
    <p><asp:TextBox runat="server" TextMode="MultiLine" Width="95%" Height="300px"></asp:TextBox></p>
    <p><asp:Button UseSubmitBehavior="false" runat="server" CssClass="btn btn-primary" Text="Save Changes" /></p>
</div>

</div>

</asp:Content>
<script runat="server">
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        hiringperiodgrid.PreRender += TAManager.Extensions.GridViewHtmlFix;
        var dc = TAManager.Data.DataContainer.Instance();
        hiringperiodgrid.DataSource = dc.HiringPeriods;
        hiringperiodgrid.DataBind();
    }
</script>