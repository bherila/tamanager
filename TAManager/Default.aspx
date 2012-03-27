<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TAManager.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<div class="hero-unit">

    <h2>Welcome to the Application Portal</h2>

    <p>This is where you can apply for courses to TA (or Head-TA) and where (if you're a Head TA) you can manage
    applications for your own courses.</p>

</div>

<% if (Request["signout"] == "done")
   { %>
<div class="alert alert-success">
    <i class="icon-check"></i> <strong>You are now signed out.</strong> Please close the browser to erase your history so that the back button can't be used to see your personal data.
</div>
<% } %>

<h2>Please sign in.</h2>

<p>This is NOT the same as your CS login!</p>

<asp:CustomValidator CssClass="alert alert-error" runat="server" ID="credentialValidator" Display="Dynamic">
    Incorrect username and/or password.
</asp:CustomValidator>

<p>Username: <asp:TextBox ID="UsernameTextbox" runat="server" /></p>
<p>Password: <asp:TextBox ID="PasswordTextbox" runat="server" TextMode="Password" /></p>


<asp:Button runat="server" Text="Log in" OnClick="submitCredentials" />



</asp:Content>
