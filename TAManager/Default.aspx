<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TAManager.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<h2>Please log in.</h2>

<p>Username: <asp:TextBox ID="UsernameTextbox" runat="server" /></p>
<p>Password: <asp:TextBox ID="PasswordTextbox" runat="server" TextMode="Password" /></p>
<asp:Button runat="server" Text="Log in" OnClick="submitCredentials" />

<asp:CustomValidator runat="server" ID="credentialValidator" ErrorMessage="Incorrect username and/or password."></asp:CustomValidator>

</asp:Content>
