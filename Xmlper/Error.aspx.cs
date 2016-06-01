using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Xmlper
{
    public partial class Error : System.Web.UI.Page
    {
        public Exception Exception
        {
            get
            {
                return Server.GetLastError().GetBaseException();
            }
        }
    }
}
