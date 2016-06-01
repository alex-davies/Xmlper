<%@ Page Language="C#" MasterPageFile="~/Xmlper.Master" AutoEventWireup="true" CodeBehind="XPath.aspx.cs" Inherits="Xmlper.XPath" Title="XMLper - XPath" %>
<%@ OutputCache Duration="3600" Location="Any" VaryByParam="none" %>

<asp:Content ContentPlaceHolderID="Head" runat="server">

<script type="text/javascript" src="js/codemirror/highlight.min.js"></script>
<link rel="Stylesheet" type="text/css" href="css/codemirror/xmlcolors.css" />

<% if (HttpContext.Current.IsDebuggingEnabled) { %>
    <script type="text/javascript" src="js/XPath.aspx.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/XPath.aspx.css" />
        
<% } else { %>
    <script type="text/javascript" src="js/XPath.aspx.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/XPath.aspx.min.css" />
<% } %>



</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="XPathMenuItem">
    <div class="selected ui-corner-tl ui-corner-tr xpathSelected"></div>
</asp:Content>

<asp:Content ContentPlaceHolderID="Content" runat="server">

<div id="inputTabs" class="simple-tabs">
<ul>
<li><a href="#xmlTab">XML</a></li>
<li><a href="#xpathNamespaces">XPath Namespaces</a></li>
</ul>


<div id="xmlTab">
<textarea autocomplete="off" class="xml-display" name="xml">
<?xml version="1.0" encoding="ISO-8859-1"?>
<catalog xmlns="http://www.xmlper.com/example">
    <cd>
        <title>Empire Burlesque</title>
        <artist>Bob Dylan</artist>
        <country>USA</country>
        <company>Columbia</company>

        <price>10.90</price>
        <year>1985</year>
    </cd>
    <cd>
        <title>Hide your heart</title>
        <artist>Bonnie Tyler</artist>
        <country>UK</country>

        <company>CBS Records</company>
        <price>9.90</price>
        <year>1988</year>
    </cd>

</catalog>
</textarea>
</div>

<div id="xpathNamespaces">
<table id="namespaceTable" cellpadding="0" cellspacing="0">
<tr>
    <th class="content-header prefix-header">Prefix</th>
    <th class="content-header namespace-header">Namespace</th>
    <th class="action-header"></th>
</tr>
<tr class="template">
    <td><input class="prefix-input" name="prefix" type="text" />:</td>
    <td><input class="namespace-input" name="namespace" type="text" /></td>
    <td><a href="#" class="remove-namespace-link">remove</a></td>
</tr>
<tr>
    <td><input  class="prefix-input" name="prefix" type="text" value="eg" />:</td>
    <td><input class="namespace-input" name="namespace" type="text" value="http://www.xmlper.com/example" /></td>
    <td><a href="#" class="remove-namespace-link">remove</a></td>
</tr>
</table>
<a href="#" class="add-namespace-link">add namespace</a>
</div>

</div>

<div class="button-bar ui-widget-header ui-corner-all">
<img class="ajax-loading hidden" src="images/ajax-loader.gif" width="30" height="30" alt="Loading"/>
<label for="xpathInput">XPath: </label>
<input id="xpathInput" name="xpath" type="text" value="//*[eg:price>10]" />
<button id="executeButton">Select</button>
</div>


<div class="ui-state-error ui-corner-all ajax-result ajax-error message-box hidden">
    <span class="ui-icon ui-icon-alert"></span>
    <strong>Error:</strong>
    <label>An error has occured</label>
</div>
    

<div id="emptyResultMessage" class="ui-state-highlight ui-corner-all hidden ajax-result message-box">
    <span class="ui-icon ui-icon-info"></span>
    <label>No nodes were found to match your query</label>
</div>

<div id="resultContainer" class="ajax-result hidden">
    <ul></ul>
</div>



</asp:Content>
