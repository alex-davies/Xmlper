<%@ Page Language="C#" MasterPageFile="~/Xmlper.Master" CodeBehind="Transform.aspx.cs" Inherits="Xmlper.Xslt" Title="XMLper - Transform" %>
<%@ OutputCache Duration="3600" Location="Any" VaryByParam="none" %>

<asp:Content ContentPlaceHolderID="Head" runat="server">
<% if (HttpContext.Current.IsDebuggingEnabled) { %>
    <script type="text/javascript" src="js/Transform.aspx.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/Transform.aspx.css" />
        
<% } else { %>
    <script type="text/javascript" src="js/Transform.aspx.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="css/Transform.aspx.min.css" />
<% } %>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="TransfromMenuItem">
    <div class="selected ui-corner-tl ui-corner-tr transformSelected"></div>
</asp:Content>



<asp:Content ContentPlaceHolderID="Content" runat="server">

<div id="inputTabs" class="simple-tabs" class="ui-tabs-hide">
<ul>
<li><a href="#splitTab">Split</a></li>
<li><a href="#xmlTab">XML</a></li>
<li><a href="#xsltTab">XSLT</a></li>
</ul>
<div id="splitTab">
    
    <div id="splitXmlInputWrapper" class="split">
        <div class="header-bar">
            <div class="header-bar-content">
                <h3>XML</h3>
                <ul>
                    <li class="header-button prettify-button ui-state-default ui-corner-all" title="Prettify">
                        <span class="ui-icon ui-icon-heart" ></span>
                    </li>
                </ul>
            </div>
        </div>
          

            
            
        
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

    <div id="splitXsltInputWrapper" class="split">
        <div class="header-bar">
            <div class="header-bar-content">
                <h3>XSLT</h3>
                <ul>
                    <li class="header-button prettify-button ui-state-default ui-corner-all" title="Prettify">
                        <span class="ui-icon ui-icon-heart" ></span>
                    </li>
                </ul>
            </div>
        </div>
        <textarea autocomplete="off" class="xml-display">
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

      <xsl:template match="/">
        <table>
          <xsl:apply-templates select="//cd"/>
        </table>
      </xsl:template>
      
      <xsl:template match="cd">
        <tr>
          <td><xsl:value-of select="title"/></td>
          <td><xsl:value-of select="price"/></td>
        </tr>
      </xsl:template>
      
</xsl:stylesheet>
        </textarea>
    </div>
</div>


<div id="xmlTab">
<textarea autocomplete="off" class="xml-display"></textarea>
</div>

<div id="xsltTab">
<textarea autocomplete="off" class="xml-display"></textarea>
</div>



</div>

<div class="button-bar ui-widget-header ui-corner-all">
<img class="ajax-loading hidden" src="images/ajax-loader.gif" width="30" height="30" alt="Loading"/>
<button id="executeButton">Transform</button>
</div>


<div class="ui-state-error ui-corner-all ajax-result ajax-error message-box hidden">
    <span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-alert"></span>
    <strong>Error:</strong>
    <label>An error has occured</label>
</div>
    

<div id="transformedXml" class="ajax-result hidden">
    <textarea autocomplete="off" readonly="readonly" class="xml-display">
    </textarea>
</div>

</asp:Content>
