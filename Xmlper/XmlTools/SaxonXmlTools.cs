using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Saxon.Api;
using System.IO;
using System.Xml;
using System.Collections.Generic;
using System.Xml.Schema;
using System.Text;
using net.sf.saxon.trace;


namespace Xmlper.XmlTools
{
    public class SaxonXmlTools : DotNetXmlTools
    {


        public override void Transform(string xml, string xslt, TextWriter output)
        {
            // Create a Processor instance.
            Processor processor = new Processor();
            processor.Implementation.setCompileWithTracing(true);
            

            // Load the source document.
            XdmNode input = processor.NewDocumentBuilder().Build(XmlReader.Create(new StringReader(xml)));

            // Create a transformer for the stylesheet.
           
            XsltTransformer transformer = processor.NewXsltCompiler().Compile(new StringReader(xslt)).Load();
           
            transformer.Implementation.setTraceListener(new RecursionLimit(Settings.MaximumRecursionDepth));

            // Set the root node of the source document to be the initial context node.
            transformer.InitialContextNode = input;

            // Create a serializer.
            Serializer serializer = new Serializer();
            StringBuilder outputString = new StringBuilder();
            serializer.SetOutputWriter(new StringWriter(outputString));

            // Transform the source XML to System.out.
            transformer.Run(serializer);
            output.Write(@"{""result"":""");
            output.Write(outputString.Replace("\"", "\\\"").Replace("\n", "\\n"));
            output.Write(@"""}");
        }

        public override void Select(string xml, string xpath, Dictionary<string, string> namespaces, TextWriter output)
        {
            Processor processor = new Processor();
            XPathCompiler compiler = processor.NewXPathCompiler();
            foreach(string prefix in namespaces.Keys){
                compiler.DeclareNamespace(prefix, namespaces[prefix]);
            }

            // Load the source document.
            XdmNode input = processor.NewDocumentBuilder().Build(XmlReader.Create(new StringReader(xml)));


            XPathSelector xpathSelector = compiler.Compile(xpath).Load();

            xpathSelector.ContextItem = input;

            bool first = true;
            output.Write("[");
            foreach(XdmItem item in xpathSelector.Evaluate())
            {
                if(!first)
                    output.Write(",");
                output.Write("\"{0}\"",item.ToString().Replace("\n","\\n"));
                first = false;
            }
            output.Write("]");
        }

        

       


        public class RecursionLimit : TraceListener
        {
            public int RecursionDepth = 0;
            public int MaxRecursionDepth;

            public RecursionLimit(int maxRecursionDepth)
            {
                MaxRecursionDepth = maxRecursionDepth;
            }

            #region TraceListener Members
            public void enter(InstructionInfo ii, net.sf.saxon.expr.XPathContext xpc)
            {
                if (++RecursionDepth > MaxRecursionDepth)
                    throw new Exception(string.Format("Exceeded the maximum recursion depth of {0}, The XSLT may be causing endless recursion", MaxRecursionDepth));
            }

            public void leave(InstructionInfo ii)
            {
                RecursionDepth--;
            }

            public void close() { }
            public void endCurrentItem(net.sf.saxon.om.Item i) { }
            public void open() { }
            public void startCurrentItem(net.sf.saxon.om.Item i) { }

            #endregion
        }


    }
}
