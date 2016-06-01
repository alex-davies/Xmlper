<%@ Page Title="" Language="C#" MasterPageFile="~/Xmlper.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Xmlper.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<style>
.error-info
{
	margin: 5px;
}

.error-info label
{
	font-weight:bold;
	width:60px;
	min-width:60px;
	display:block;
	float:left;

	
}

.stack-trace
{
	white-space:pre;
	font-family:Monospace;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
<div class="ui-state-error ui-corner-all ajax-result message-box" style="padding:20px 10px">
    <span class="ui-icon ui-icon-alert"></span>
    <strong>Oh no! </strong>
    <label>We have encountered a problem</label>
    
    <div class="error-info">
        <label>Type:</label>
         <%=Exception.GetType().Name %>
    </div>
    
    <div class="error-info">
        <label>Message:</label>
        <%=Exception.Message %>
    </div>
    
    <% if (HttpContext.Current.IsDebuggingEnabled) { %>
        <div class="error-info">
            <label>Stack Trace:</label>
            <span class="stack-trace">
<%=Exception.StackTrace %></span>
        </div>
    <% } %>

    
</div>
</asp:Content>
