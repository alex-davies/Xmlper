<%@ Page Language="C#" ValidateRequest="false"%>


<%
        Response.ContentType = "application/json; charset=utf-8";
        string xml = Request["xml"];
        string xslt = Request["xslt"];
        Xmlper.Settings.XmlTools.Transform(xml, xslt, Response.Output);

    
    
     %>