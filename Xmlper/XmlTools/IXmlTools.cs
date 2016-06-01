using System;
namespace Xmlper.XmlTools
{
    public interface IXmlTools
    {
        void Select(string xml, string xpath, System.Collections.Generic.Dictionary<string, string> namespaces, System.IO.TextWriter output);
        void Transform(string xml, string xslt, System.IO.TextWriter output);
        void Validate(string xml, string schema, System.IO.TextWriter output);
        void Prettify(string xml, System.IO.TextWriter output);
    }
}
