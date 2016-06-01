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
using Xmlper.XmlTools;

namespace Xmlper
{
    public static class Settings
    {
        public static int MaximumRecursionDepth
        {
            get
            {
                return int.Parse(ConfigurationManager.AppSettings["MaximumRecursionDepth"]);
            }
        }

        private static IXmlTools _xmlTools;
        public static IXmlTools XmlTools
        {
            get
            {
                if(_xmlTools == null)
                {
                    Type type = Type.GetType(ConfigurationManager.AppSettings["XmlToolsTypeName"], true);
                    _xmlTools = (IXmlTools)Activator.CreateInstance(type);
                }
                return _xmlTools;
            }
        }

    }
}
