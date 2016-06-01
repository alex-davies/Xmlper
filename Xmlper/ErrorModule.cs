using System;
using System.Web;
using System.Linq;

namespace Xmlper
{
    public class ErrorModule : IHttpModule
    {
        public void Init(HttpApplication app)
        {
            app.Error += new System.EventHandler(OnError);
        }



        public void OnError(object obj, EventArgs args)
        {
            // At this point we have information about the error
            HttpContext ctx = HttpContext.Current;
            Exception ex = ctx.Server.GetLastError().GetBaseException();

            //stop it from going in a loop, if our error page errors
            //then we will just let the error go through as is
            if (ctx.Items.Contains("alreadyError"))
                return;
            ctx.Items["alreadyErrored"] = true;


            //if they were expecting json, give them back json
            if(ctx.Request.AcceptTypes.ToList().Exists(h => h.Contains("application/json")))
            {
                ctx.Response.Clear();
                ctx.Response.ContentType = "application/json";
                ctx.Response.StatusCode = 500;

                var error = new {errorMessage = ex.Message};

                ctx.Response.Write(error.ToJSON());
                ctx.Response.End();
            }
            else{
                ctx.Response.Clear();
                HttpContext.Current.Server.Execute("~/Error.aspx", ctx.Response.Output, true);
            }
            ctx.Server.ClearError();
           
        }

        public void Dispose() { }
    
    }
}
