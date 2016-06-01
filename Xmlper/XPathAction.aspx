<%@ Page Language="C#" ValidateRequest="false"%>


<%
        Response.ContentType = "application/json; charset=utf-8";
        string xml = Request["xml"];
        string xpath = Request["xpath"];

        string[] prefixes = Request.Params.GetValues("prefix") ?? new string[0];
        string[] namespaces = Request.Params.GetValues("namespace") ?? new string[0];
        System.Collections.Generic.Dictionary<string, string> xpathNamespaces = new System.Collections.Generic.Dictionary<string, string>();
        if (prefixes.Length != namespaces.Length)
            throw new Exception("equal number of prefix and namespaces must be submitted");
        
        for (int i = 0; i < prefixes.Length; i++)
        {
            xpathNamespaces[prefixes[i]] = namespaces[i];
        }

        Xmlper.Settings.XmlTools.Select(xml, xpath, xpathNamespaces, Response.Output);

    
    
     %>