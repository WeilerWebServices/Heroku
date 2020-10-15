// Replace each {{app-name}} with the real name application
jQuery(document).ready(function($) {
   
   // *** Getting the app name with the current url
   // We get the hostName
   var hostName = window.location.hostname;

   // And we parse it with his real application name
   var nameApp = hostName.substr('0',hostName.indexOf(".herokuapp.com"));

   // We could define it from HTML
   if (nameApp == '') nameApp = "your-app";

   // To change <title> with IE we have to use document property
   if ($('title:contains("{{app-name}}")')) {
      var title = document.title.replace("{{app-name}}",nameApp);
      document.title = title; 
   } 
   
   $("body *").replaceText("{{app-name}}",nameApp);

});
