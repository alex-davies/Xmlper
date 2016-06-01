<%@ Page Language="C#" MasterPageFile="~/Xmlper.Master" AutoEventWireup="true" CodeBehind="Validate.aspx.cs" Inherits="Xmlper.Validate" Title="XMLper - Validate" %>
<%@ OutputCache Duration="3600" Location="Any" VaryByParam="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<% if (HttpContext.Current.IsDebuggingEnabled) { %>
    <script type="text/javascript" src="js/Validate.aspx.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/Validate.aspx.css" />
        
<% } else { %>
    <script type="text/javascript" src="js/Validate.aspx.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/Validate.aspx.min.css" />
<% } %>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ValidateMenuItem">
    <div class="selected ui-corner-tl ui-corner-tr validationSelected"></div>
</asp:Content>

<asp:Content  ContentPlaceHolderID="Content" runat="server">

<div id="inputTabs" class="simple-tabs">
<ul>
<li><a href="#splitTab">Split</a></li>
<li><a href="#xmlTab">XML</a></li>
<li><a href="#schemaTab">Schema</a></li>
</ul>
<div id="splitTab">
    <div id="splitXmlInputWrapper" class="split">
        <h3 class="xml-display-header">XML</h3>
        <textarea autocomplete="off" class="xml-display">
<?xml version="1.0" encoding="ISO-8859-1"?>
<catalog>
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

    <div id="splitSchemaInputWrapper" class="split">
        <h3 class="xml-display-header">Schema</h3>
        <textarea autocomplete="off" class="xml-display">
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs='http://www.w3.org/2001/XMLSchema'>

  <xs:element name="catalog">
    <xs:complexType>
      <xs:sequence minOccurs="0" maxOccurs="unbounded">
        <xs:element ref="cd"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>

  <xs:element name="cd">
    <xs:complexType>
      <xs:all>
          <xs:element name="title" type='xs:string'/>
          <xs:element name="artist"  type='xs:string'/>
          <xs:element name="country" minOccurs="0" type='xs:string'/>
          <xs:element name="year" type='xs:int'/>
          <xs:element name="company" minOccurs="0" type="xs:string"/>
          <xs:element name="price" minOccurs="0" type="xs:decimal"/>
      </xs:all>
    </xs:complexType>
  </xs:element>

</xs:schema>
        </textarea>
    </div>
</div>


<div id="xmlTab">
<textarea autocomplete="off" class="xml-display"></textarea>
</div>

<div id="schemaTab">
<textarea autocomplete="off" class="xml-display"></textarea>
</div>



</div>

<div class="button-bar ui-widget-header ui-corner-all">
<img class="ajax-loading hidden" src="images/ajax-loader.gif" width="30" height="30" alt="Loading"/>
<button id="executeButton">Validate</button>
</div>


<div class="ui-state-error ui-corner-all ajax-result ajax-error message-box hidden">
    <span class="ui-icon ui-icon-alert"></span>
    <strong>Error:</strong>
    <label>An error has occured</label>
</div>
    

<div id="validationResult" class="ajax-result hidden">
    <ul>
    </ul>
</div>

<div id="validationSuccess" class="ui-state-correct ui-corner-all ajax-result message-box hidden">
    <span class="ui-icon ui-icon-check"></span>
    <strong>Passed:</strong>
    <label>Your XML successfully validatated</label>
</div>

</asp:Content>
