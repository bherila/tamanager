<%@ Page Title="" Language="C#" MasterPageFile="~/Template.master" AutoEventWireup="true" CodeBehind="ImportUsers.aspx.cs" Inherits="TAManager.ImportUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

<h1>Import Users</h1>

<p>This tool will import users from a CSV data source. Paste the CSV data below and
we will send out e-mail invitations to each person individually! How cool!</p>

<p>Data format:</p>
<p><i>CSLOGIN,FIRSTNAME,LASTNAME</i></p>

<p>We will generate a <b>one-time-use link</b> that will log the user in directly, 
and the user will be prompted to set a password. If the user had a password before,
it will be expired and the user will need to set a new password! This works well
because users probably won't remember the password they use every semester.</p>

<asp:TextBox runat="server" TextMode="MultiLine" ID="m_data" Rows="20" 
        Columns="60" >bherila,Ben,Herila
ashley,Ashley,Tuccero</asp:TextBox>

<h2>E-mail Template</h2>
<asp:TextBox runat="server" TextMode="MultiLine" ID="m_mailtemplate" Rows="20" 
        Columns="60" >Dear {FIRSTNAME}, 

Congratulations! You&#39;re invited to apply to be a TA next semester.  Interested? Good! Here&#39;s what you need to do. 

First, click on the following link. You&#39;ll be asked to set a password. This is the password you&#39;ll use to manage your application in the future. We recommend you use a password that you don&#39;t already use for anything else. 

{URL}

Next, select the semester you&#39;d like to TA, and then fill out the application. When you&#39;re done, use the link at the bottom of the page to submit your application. It&#39;s that easy! Head TAs for the courses you apply to may contact you with further details and to arrange an interview.

Good luck!

Love, 
The Meta-TAs</asp:TextBox>

<p>Click the button below to ACTUALLY SEND THESE EMAILS. It may take a while
so please be patient and don't click the button more than once! E-mails will
be sent to <font color="fuchsia">{CSLOGIN}</font>@cs.brown.edu.</p>

<asp:Button Text="Send" runat="server" />


</asp:Content>
