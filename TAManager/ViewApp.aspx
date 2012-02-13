<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="ViewApp.aspx.cs" Inherits="TAManager.ViewApp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<h1>Application</h1>

<h2>1. Why do you want to TA?</h2>
<pre><asp:Literal ID="m_whyTA" runat="server" Mode="Encode"></asp:Literal></pre>

<h2>2. Coursework</h2>
<asp:GridView ID="m_coursework" runat="server">
</asp:GridView>

<h2>3. Teaching Experience</h2>
<pre><asp:Literal ID="m_experience" runat="server" Mode="Encode"></asp:Literal></pre>

<h2>4. Course Preferences</h2>
<asp:BulletedList ID="m_prefs" runat="server" BulletStyle="Numbered">
</asp:BulletedList>

<h2>5. Probable Course Schedule</h2>
<pre><asp:Literal ID="m_schedule" runat="server" Mode="Encode"></asp:Literal></pre>
<h2>6. Additional Comments</h2>
<pre><asp:Literal ID="m_comments" runat="server" Mode="Encode"></asp:Literal></pre>

<a href="Home.aspx?rid=<%= Guid.NewGuid().ToString("N") %>">Return to My Applications</a>

</asp:Content>
