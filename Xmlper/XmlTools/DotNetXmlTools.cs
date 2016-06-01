using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Schema;
using System.Xml;
using System.IO;
using System.Xml.Xsl;
using System.Text;


namespace Xmlper.XmlTools
{
    public class DotNetXmlTools : IXmlTools
    {
        public virtual void Validate(string xml, string schema, TextWriter output)
        {
            bool first = true;
            ValidationEventHandler validationHandler = delegate(object sender, ValidationEventArgs e)
            {
                if (!first)
                    output.Write(",");
                first = false;

                var issue = new
                {
                    lineNumber = e.Exception.LineNumber,
                    linePosition = Math.Max(e.Exception.LinePosition - 1, 0),
                    message = e.Message,
                    severity = e.Severity.ToString()
                };
                output.Write(issue.ToJSON());

            };

            XmlSchema xmlSchema = XmlSchema.Read(new StringReader(schema), validationHandler);

            XmlReaderSettings settings = new XmlReaderSettings();

            settings.ValidationType = ValidationType.Schema;
            settings.ValidationFlags = XmlSchemaValidationFlags.ProcessInlineSchema | XmlSchemaValidationFlags.ReportValidationWarnings;
            settings.Schemas.Add(xmlSchema);

            settings.ValidationEventHandler += validationHandler;

            XmlReader reader = XmlReader.Create(new StringReader(xml), settings);


            output.Write("[");
            while (reader.Read()) ;
            output.Write("]");
        }



        public virtual void Select(string xml, string xpath, Dictionary<string, string> namespaces, System.IO.TextWriter output)
        {
            XmlNamespaceManager namespaceManager = new XmlNamespaceManager(new NameTable());
            foreach(string prefix in namespaces.Keys)
                namespaceManager.AddNamespace(prefix, namespaces[prefix]);

            XmlDocument doc = new XmlDocument();
            doc.PreserveWhitespace = true;
            doc.Load(new StringReader(xml));

   
            bool first = true;
            output.Write("[");
            foreach (XmlNode item in doc.SelectNodes(xpath, namespaceManager))
            {
                if (!first)
                    output.Write(",");
                output.Write(item.OuterXml.ToJSON());
                first = false;
            }
            output.Write("]");
        }

        public virtual void Transform(string xml, string xslt, System.IO.TextWriter output)
        {

            XslCompiledTransform transform = new XslCompiledTransform();
            

            var settings = new XsltSettings();
            settings.EnableDocumentFunction = false;
            settings.EnableScript = false;

            transform.Load(XmlReader.Create(new StringReader(xslt)), settings, new ErrorXmlResolver());
            
            MemoryStream outputStream = new MemoryStream();

            transform.Transform(XmlReader.Create(new StringReader(xml)), XmlWriter.Create(outputStream, transform.OutputSettings));

            var jsonOutput = new { result = transform.OutputSettings.Encoding.GetString(RemoveByteOrderMark(outputStream.ToArray())) };
            output.Write(jsonOutput.ToJSON());
            
        }

        public void Prettify(string xml, TextWriter output)
        {
           

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(xml);

            StringWriter sw = new StringWriter();
            
            
            //if (doc.FirstChild.NodeType == XmlNodeType.XmlDeclaration) {
            //    XmlDeclaration declaration = (XmlDeclaration)doc.FirstChild;
            //    Encoding encoding = Encoding.GetEncoding(declaration.Encoding);
            //    if(encoding != null)
            //        sw.Encoding = encoding;
            //}

           
            

            //XmlTextWriter writer = new XmlTextWriter(sw);
            //writer.Formatting = Formatting.Indented;
            //writer.WriteNode(new XmlReaderSettings,
            //XmlReader r;
            //writer.writeN

            //doc.Save(writer);

            var jsonOutput = new { result = sw.ToString() };
            output.Write(jsonOutput.ToJSON());
  
        }

        /// <summary>
        /// Removes the byte order mark.
        /// </summary>
        ///
        //<param name="bytes">The bytes.</param>
        /// <returns>byte array without the BOM.</returns>
        public static byte[] RemoveByteOrderMark(byte[] bytes)
        {
            if (!StartsWithByteOrderMark(bytes))
            {
                return bytes;
            }

            byte[] results = new byte[bytes.Length - 3];
            Array.Copy(bytes, 3, results, 0, bytes.Length - 3);

            return results;
        }

        /// <summary>
        /// Determines if the byte array starts with a byte order mark.
        /// </summary>
        ///
        ///<param name="bytes">The bytes.</param>
        /// <returns><c>true</c> if the byte array starts with a byte order mark; otherwise false.</returns>
        public static bool StartsWithByteOrderMark(byte[] bytes)
        {
            if (bytes == null || bytes.Length < 3)
            {
                return false;
            }
            return
                bytes[0] == 0xEF &&
                bytes[1] == 0xBB &&
                bytes[2] == 0xBF;
        }


        public class ErrorXmlResolver : XmlResolver
        {

            public override object GetEntity(Uri absoluteUri, string role, Type ofObjectToReturn)
            {
                throw new NotImplementedException("Resolving additional XSLTs are not currently supported, can not resove "+absoluteUri);
            }

            public override System.Net.ICredentials Credentials
            {
                set { }
            }
        }


       
    }
}
