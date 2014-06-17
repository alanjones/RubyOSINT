#!/usr/bin/env ruby
# -----------------------------------------------------------------------------
# URL checker will perform OSINT using static URLs for known internet facing app
# -----------------------------------------------------------------------------
require 'uri'
require 'net/http'
require "net/https"
#require 'colorize'

class String
def black;          "\033[30m#{self}\033[0m" end
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def blue;           "\033[34m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bg_black;       "\033[40m#{self}\033[0m" end
def bg_red;         "\033[41m#{self}\033[0m" end
def bg_green;       "\033[42m#{self}\033[0m" end
def bg_brown;       "\033[43m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
def bg_magenta;     "\033[45m#{self}\033[0m" end
def bg_cyan;        "\033[46m#{self}\033[0m" end
def bg_gray;        "\033[47m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
def reverse_color;  "\033[7m#{self}\033[27m" end
end





# -----------------------------------------------------------------------------
puts "Enter the Site to be tested"
site = gets.chomp
puts "The target domain in scope is:" +  " #{site} .".bold.blue
puts " "
puts "Dumping web server headers: ".bold.gray.bg_red
# -----------------------------------------------------------------------------
# This section goes and gets the HTTP headers and returns them
 domain = URI(site) # we have to run the target through URI to get only the domain.
 host = domain.host #here we use URI .host to get domain only to feed NET.start
 http = Net::HTTP.start(host) # makes the HTTP request 
 resp = http.head('/')
 resp.each { |k, v| puts "#{k}: #{v}" }
 http.finish  #the lines above return the response and print headers
 puts " "
# -----------------------------------------------------------------------------
#  Generic Admin and Portal List
list = [
 # VPN Checks
 "/+CSCOE+/logon.html",
 "/vpn/",
 "/oaam_server/oamLoginPage.jsp",


  "/login/",
  "/admin/",
  "/upload/",
  "/controlpanel/",
# OWA
 "/exchweb/bin/auth/owalogon.asp",
  "/exchweb/bin/auth/owaauth.dll", #OWA 2003
  "/owa/auth/owaauth.dll", #OWA2007
  "/owa/auth.owa", #OWA 2010
  "/owa/auth.owa", # OWA 2013
  "/exchange/", # check for OWA redirect



#tomcat
 '/robots.txt',
                                '/admin',
                                '/admin/',
                                '/crossdomain.xml',
                                '/sitemap.xml',
                                '/examples',
                                '/examples/jsp/index.html',
                                '/examples/jsp/snp/snoop.jsp',
                                '/examples/jsp/source.jsp',
                                '/examples/servlet/HelloWorldExample',
                                '/examples/servlet/SnoopServlet',
                                '/examples/servlet/TroubleShooter',
                                '/examples/servlet/default/jsp/snp/snoop.jsp',
                                '/examples/servlet/default/jsp/source.jsp',
                                '/examples/servlet/org.apache.catalina.INVOKER.HelloWorldExample',
                                '/examples/servlet/org.apache.catalina.INVOKER.SnoopServlet',
                                '/examples/servlet/org.apache.catalina.INVOKER.TroubleShooter',
                                '/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/snp/snoop.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/source.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/snp/snoop.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/source.jsp',
                                '/examples/servlet/snoop',
                                '/examples/servlets/index.html',
                                '/jsp-examples',
                                '/manager',
                                '/manager/',
                                '/manager/deploy?path=foo',
                                '/manager/html',
                                '/manager/html/',
                                '/manager/status',
                                '/manager/status/',
                                '/servlet/default/',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.WebdavServlet/',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet/',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.servlets.HTMLManagerServlet',
                                '/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.servlets.ManagerServlet',
                                '/servlet/org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.servlets.WebdavServlet/',
                                '/tomcat-docs',
                                '/webdav',
                                '/webdav/index.html',
                                '/webdav/servlet/org.apache.catalina.servlets.WebdavServlet/',
                                '/webdav/servlet/webdav/',
                                '/conf/',
                                '/conf/server.xml/',
                                '/WEB-INF/',
                                '/WEB-INF/web.xml',
                                '/WEB-INF/classes/',
                                '/shared/',
                                '/shared/lib/',

#general admin stuff
'/robots.txt',
                                '/crossdomain.xml',
                                '/sitemap.xml',
                                '/phpinfo.php',
                                '/phpmyadmin',
                                '/invoker/JMXInvokerServlet',   #jboss
                                '/invoker',     #jboss
                                '/invoker/EJBInvokerServlet',
                                '/jmx-console', #jboss
                                '/juddi',       #jboss
                                '/web-console', #jboss
                                '/web-console/invoker', #jboss
                                '/.git/config', #exposed .git/config files
                                '/.svn/entries',        #exposed svn entries
                                '/.svn/wc.db',
                                '/.svn:$i30:$INDEX_ALLOCATION/entries', #exposed svn entries nginx bypass
                                '/.svn::$INDEX_ALLOCATION/entries',     #exposed svn entries nginx bypass
                                '/.svn./entries',       #exposed svn entries nginx bypass
                                '/CVS/Entries',         #Exposed cvs entries
                                '/admin/index.jsp',
                                '/admin/index.html',
                                '/admin/index.php',
                                '/admin/index.asp',
                                '/admin/index.aspx',
                                '/admin/',
                                '/admin',
                                '/_admin',
                                '/Administration',
'/login',
                                '/admin1.php',
                                '/admin.php',
                                '/admin.html',
                                '/admin1.php',
                                '/admin1.html',
                                '/login.php',
                                '/admin/cp.php',
                                '/cp.php',
                                '/administrator/index.php',
                                '/administrator/index.html',
                                '/administartor',
                                '/admin.login',
                                '/administrator/login.php',
                                '/administrator/login.html',
                                '/names.nsf',   #lotus domino
                                '/auth.html', #sonicwall SSL VPN
                                '/crowd/services', #/scanner/http/atlassian_crowd_fileaccess.rb
                                '/owa/auth/logon.aspx', #OWA
                                '/exchange/', #owa
                                '/axis2/services/listServices', #scanner/http/axis_local_file_include.rb
                                '/axis2/axis2-admin/login',     #scanner/http/axis_login.rb
                                '/axis2/axis2-web/HappyAxis.jsp',       #axis
                                '/cgi-mod/view_help.cgi',       #scanner/http/barracuda_directory_traversal.rb
                                '/bitweaver/',  #scanner/http/bitweaver_overlay_type_traversal.rb
                                '/clansphere_2011.3/index.php', #scanner/http/clansphere_traversal.rb
                                '/data/login',  #scanner/http/dell_idrac.rb
                                '/WorkArea/login.aspx',         #scanner/http/ektron_cms400net.rb
                                '/_vti_inf.html', #scanner/http/frontpage_login.rb
                                '/en-US/account/login', #scanner/http/splunk_web_login.rb
                                '/trace.axd',   #scanner/http/trace_axd.rb
                                '/cpqlogin.htm', #CompaqHTTPServer
                                '/hp/device/this.LCDispatcher', #HP Printer
                                '/hmstat.htm', #Xerox priner
                                '/SoundBridgeStatus.html', #roku
                                '/eng/start/StatPtrGen.htm', #Kyocera printer
                                '/cab/top.shtml',       #cannon printer
                                '/DWREasyAjax/dwr/index.html',  #java servlets common from fuzzdb
                                '/dwr/index.html',      #java servlets common from fuzzdb
                                '/dwr/engine.js',       #java servlets common from fuzzdb
                                '/CFIDE/administrator/index.cfm', #coldfusion admin interface
                                '/jsp-examples',        #tomcat
  '/manager',     #tomcat
                                '/manager/',    #tomcat
                                '/manager/deploy?path=foo',     #tomcat
                                '/manager/html',        #tomcat
                                '/manager/html/',       #tomcat
                                '/manager/status',      #tomcat
                                '/manager/status/',     #tomcat
                                '/servlet/default/',    #tomcat
                                '/.htaccess',   #apache
                                '/.htaccess.bak',
                                '/.htpasswd',
                                '/.meta',
                                '/.web',
                                '/apache/logs/access.log',
                                '/apache/logs/access_log',
                                '/apache/logs/error.log',
                                '/apache/logs/error_log',
                                '/httpd/logs/access.log',
                                '/httpd/logs/access_log',
                                '/httpd/logs/error.log',
                                '/httpd/logs/error_log',
                                '/logs/access.log',
                                '/logs/access.log',
                                '/logs/error.log',
                                '/logs/error_log',
                                '/access_log',
                                '/cgi',
                                '/cgi-bin',
                                '/cgi-pub',
                                '/cgi-script',
                                '/dummy',
                                '/error',
                                '/error_log',
                                '/htdocs',
                                '/httpd',
                                '/httpd.pid',
                                '/icons',
                                '/index.html',
                                '/logs',
                                '/manual',
                                '/phf',
                                '/php',
  '/printenv',
                                '/server-info',
                                '/server-status',
                                '/status',
                                '/test-cgi',
                                '/tmp',
                                '/user',
                                '/~bin',
                                '/~ftp',
                                '/~nobody',
                                '/~root',
                                '/xampp/',      #apache
                                '/dashboard',
                                '/index.php/login',
                                '/AdaptCMS/admin.php', #AdaptCMS Lite
                                '/port/crx',            #adobe CQ5
                                '/port/system/console',
                                '/alfresco/service/api/login?u=&pw=',   #alfresco
                                '/default/live/user.html',      #apache Lenya
                                '/iw/tsadmin',  #autonom Intetwoven Teamsite CMS
                                '/bedita-app/admin',    #BEdita
                                '/blosxom/blogs/admin', #blosxom
                                '/login.act',   #cascade server
                                '/dokuwiki?do=login',   #dokuwiki
                                '/dotclear/admin/',     #dotclear
                                '/cms',
                                '/dynpg',       #DynPG
                                '/e107_admin/admin.php?view.all',       #e107
                                '/perl/users/home',     #Eprints
                                '/escenic/',    #escenic Content Engine
                                '/cms',
                                '/joomla/administrator',
                                '/jumbo/loginpage.php', #jumbo
                                '/CMSSiteManager',      #kentico CMS
                                '/knowledgetree/',      #knowledge tree Comm Edition
                                '/logicaldoc/webdav/store',     #logicalDOC
                                '/magnoliaAuthor/.magnolia',    #magnolia
                                '/midgard',     #migard
                                '/Secure/Login.aspx',   #mojo portal
                                '/_mt/mt.cgi',  #movable type
                                '/nucleus/',    #nucleus
                                '/adminzone',   #ocportal
                                '/opencms/opencms/system/login/',       #opencms
                                '/OpenKM',      #openKM
                                '/console',
                                '/papaya/', #papaya CMS
                                '/nuke/admin.php',      #php-nuke
                                '/phpwiki/admin.php',   #phpwiki
                               # '/?command=PULogin',    #Pier
                                '/pivotx',
                                '/admin939',    #prestashop
                                '/processwire/',        #processwire
                                '/pulsepro/',   #pulse CMS
                                '/ravennuke230/admin.php',      #ravennuke CMS
                                '/refinery',    #refirery CMS
                                '/CFIDE/administrator/index.cfm',       #coldfusion
                               # '/?RVGET_document=System+Management',   #renovationsCMS
                                '/serendipity/serendipity_admin.php',   #serendipity
                                '/Sitefinity/LoginPages/LoginForm',     #sitefinity CMD
                                '/_edit',       #squiz cms
                                '/index.php?url=session',       #TangoCMS
                                '/session',     #tangoCMS
                                '/telligent_evolution', #telligent community
                                '/textpattern/index.php',
                                '/textpattern/',        #textpattern
                                '/tiki/tiki-login_scr.php',     #tiki wiki CMS
                                '/cgi-bin/login',       #TWiki
                                '/typo3',       #typo3
                                '/umbraco/login.aspx',  #Umbraco
                                '/wp-admin/',   #wordpress
                                '/yanel/',      #yanel
                                '/robohelp/server',     #adobe robohelp
                                '/resin-admin',
                                '/resin-admin/status.php',
                                '/resin-doc',
                                '/resin-doc/',
                                '/ckeditor/config.js', #CKeditor
                                '/cgi-bin/mj_wwwusr/domain=domain?user=&passw=&func=help&extra=', #majordomo directory traversal


#citrix
'/Citrix/MetFrame/',
                                '/Citrix/MetaFrame/auth/login.aspx',
                                '/Citrix/Xenapp',
                                '/Citrix',
                                '/Citrix/AccessPlatform',
                                '/Citrix/AccessPlatform/auth',
                                '/Citrix/AccessPlatform/media',




# OWA
 "/exchweb/bin/auth/owalogon.asp",
  "/exchweb/bin/auth/owaauth.dll", #OWA 2003
  "/owa/auth/owaauth.dll", #OWA2007
  "/owa/auth.owa", #OWA 2010
  "/owa/auth.owa", # OWA 2013
  "/exchange/", # check for OWA redirect
#SHAREPOINT 
 # Admin Page
  "/_vti_adm/Admin.asmx",
  # ASMX Files
  "/_vti_bin/copy.asmx",
  "/_vti_bin/permissions.asmx",
  "/_vti_bin/lists.asmx",
  "/_vti_bin/sites.asmx",
  "/_vti_bin/alerts.asmx",
  "/_vti_bin/authentication.asmx",
  "/_vti_bin/forms.asmx",
  "/_vti_bin/meetings.asmx",
  "/_vti_bin/imaging.asmx",
  "/_vti_bin/people.asmx",
  "/_vti_bin/versions.asmx",
  "/_vti_bin/search.asmx",
  "/_vti_bin/webs.asmx ",
  "/_vti_bin/usergroup.asmx ",
  "/_vti_bin/dws.asmx",
  "/_vti_bin/DspSts.asmx",
  "/_vti_bin/sharepointemailws.asmx",
  "/_vti_bin/sitedata.asmx",
  "/_vti_bin/webpartpages.asmx",
  # WSDL File Names:
  "/_vti_bin/permissions.asmx?WSDL",
  "/_vti_bin/copy.asmx?WSDL",
  "/_vti_bin/sites.asmx?WSDL",
  "/_vti_bin/lists.asmx?WSDL",
  "/_vti_bin/alerts.asmx?WSDL",
  "/_vti_bin/authentication.asmx?WSDL",
  "/_vti_bin/forms.asmx?WSDL",
  "/_vti_bin/meetings.asmx?WSDL",
  "/_vti_bin/imaging.asmx?WSDL ",
  "/_vti_bin/people.asmx?WSDL",
  "/_vti_bin/versions.asmx?WSDL",
  "/_vti_bin/search.asmx?WSDL ",
  "/_vti_bin/webs.asmx?WSDL",
  "/_vti_bin/usergroup.asmx?WSDL",
  "/_vti_bin/dws.asmx?WSDL ",
  "/_vti_bin/DspSts.asmx?WSDL ",
  "/_vti_bin/sharepointemailws.asmx?WSDL ",
  "/_vti_bin/sitedata.asmx?WSDL ",
  "/_vti_bin/webpartpages.asmx",
   '/allcomments.aspx',
   '/allitems.aspx',
   '/allposts.aspx',
   'archive.aspx',
   '/byauthor.aspx',
   '/calendar.aspx',
   '/_catalogs/',
   '/_catalogs/lt/',
   '/_catalogs/lt/forms/allitems.aspx',
   '/_catalogs/lt/forms/dispform.aspx',
   '/_catalogs/lt/forms/editform.aspx',
   '/_catalogs/lt/forms/upload.aspx',
   '/_catalogs/lt/forms/Allitems.aspx',
   '/_catalogs/lt/forms/DispForm.aspx',
   '/_catalogs/lt/forms/EditForm.aspx',
   '/_catalogs/lt/forms/Upload.aspx',
   '/_catalogs/lt/forms/_vti_cnf/allitems.aspx',
   '/_catalogs/lt/forms/_vti_cnf/editform.aspx',
   '/_catalogs/lt/forms/_vti_cnf/dispform.aspx',
   '/_catalogs/lt/forms/_vti_cnf/upload.aspx',
   '/_catalogs/lt/forms/_vti_cnf/AllItems.aspx',
   '/_catalogs/lt/forms/_vti_cnf/EditForm.aspx',
   '/_catalogs/lt/forms/_vti_cnf/DispForm.aspx',
   '/_catalogs/lt/forms/_vti_cnf/Upload.aspx',
   '/_catalogs/masterpage',
   '/_catalogs/masterpage/Forms/AllItems.aspx',
   '/_catalogs/wp/',
    '/_catalogs/wp/mscontenteditor.dwp',
                                '/_catalogs/wp/msimage.dwp',
                                '/_catalogs/wp/msmembers.dwp',
                                '/_catalogs/wp/mspageviewer.dwp',
                                '/_catalogs/wp/mssimpleform.dwp',
                                '/_catalogs/wp/msxml.dwp',
                                '/_catalogs/wp/_vti_cnf/mscontenteditor.dwp',
                                '/_catalogs/wp/_vti_cnf/msimage.dwp',
                                '/_catalogs/wp/_vti_cnf/msmembers.dwp',
                                '/_catalogs/wp/_vti_cnf/mspageviewer.dwp',
                                '/_catalogs/wp/_vti_cnf/mssimpleform.dwp',
                                '/_catalogs/wp/_vti_cnf/msxml.dwp',
                                '/_catalogs/wp/forms/',
                                '/_catalogs/wp/Forms/AllItems.aspx',
                                '/_catalogs/wp/Forms/dispform.aspx',
                                '/_catalogs/wp/Forms/editform.aspx',
                                '/_catalogs/wp/Forms/upload.aspx',
                                '/_catalogs/wp/Forms/AllItems.aspx',
                                '/_catalogs/wp/Forms/DispForm.aspx',
                                '/_catalogs/wp/Forms/EditForm.aspx',
                                '/_catalogs/wp/Forms/Upload.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/AllItems.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/dispform.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/editform.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/upload.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/AllItems.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/DispForm.aspx',
                                '/_catalogs/wp/forms/_vti_cnf/EditForm.aspx',
 '/_catalogs/wp/forms/_vti_cnf/Upload.aspx',
                                '/_catalogs/wt/',
                                '/_catalogs/wt/Forms/allitems.aspx',
                                '/_catalogs/wt/Forms/common.aspx',
                                '/_catalogs/wt/Forms/dispform.aspx',
                                '/_catalogs/wt/Forms/editform.aspx',
                                '/_catalogs/wt/Forms/upload.aspx',
                                '/_catalogs/wt/Forms/AllItems.aspx',
                                '/_catalogs/wt/Forms/Common.aspx',
                                '/_catalogs/wt/Forms/DispForm.aspx',
                                '/_catalogs/wt/Forms/EditForm.aspx',
                                '/_catalogs/wt/Forms/Upload.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/allitems.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/common.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/dispform.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/editform.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/upload.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/AllItems.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/Common.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/DispForm.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/EditForm.aspx',
                                '/_catalogs/wt/Forms/_vti_cnf/Upload.aspx',
                                '/categories/allcategories.aspx',
                                '/categories/SOMEOTHERDIR/allcategories.aspx',
                                '/categories/viewcategory.aspx',
                                '/default.aspx',
                                '/directory/_layouts/',
                                '/editdocs.aspx',
                                '/Forms/AllItems.aspx',
                                '/Forms/DispForm.aspx',
                                '/Forms/DispForm.aspx?ID=1',
                                '/Forms/EditForm.aspx',
                                '/Forms/EditForm.aspx?ID=1',
                                '/Forms/Forms/AllItems.aspx',
                                '/forms/mod-view.aspx',
                                '/Forms/mod-view.aspx',
                                '/Forms/MyItems.aspx',
                                '/forms/my-sub.aspx',
                                '/Forms/my-sub.aspx',
                                '/Forms/NewForm.aspx',
                                '/forms/webfldr.aspx',
'/_layouts/1033',
                                '/_layouts/1033/IMAGES',
                                '/_layouts/aclinv.aspx',
                                '/_layouts/addrole.aspx',
                                '/_layouts/AdminRecycleBin.aspx',
                                '/_layouts/areanavigationsettings.aspx',
                                '/_layouts/AreaTemplateSettings.aspx',
                                '/_layouts/AreaWelcomePage.aspx',
                                '/_layouts/associatedgroups.aspx',
                                '/_Layouts/authenticate.aspx',
                                '/_layouts/bpcf.aspx',
                                '/_layouts/ChangeSiteMasterPage.aspx',
                                '/_layouts/create.aspx',
                                '/_layouts/editgrp.aspx',
                                '/_layouts/editprms.aspx',
                                '/_layouts/groups.aspx',
                                '/_layouts/help.aspx',
                                '/_layouts/images/',
                                '/_layouts/listedit.aspx',
                                '/_layouts/listfeed.aspx',
                                '/_layouts/ManageFeatures.aspx',
                                '/_layouts/ManageFeatures.aspx?Scope=Site',
                                '/_layouts/mcontent.aspx',
                                '/_layouts/mngctype.aspx',
                                '/_layouts/mngfield.aspx',
                                '/_layouts/mngsiteadmin.aspx',
                                '/_layouts/mngsubwebs.aspx',
                                '/_layouts/mngsubwebs.aspx?view=sites',
                                '/_layouts/myinfo.aspx',
                                '/_layouts/MyPage.aspx',
                                '/_layouts/MyTasks.aspx',
                                '/_layouts/navoptions.aspx',
                                '/_layouts/NewDwp.aspx',
                                '/_layouts/newgrp.aspx',
                                '/_layouts/newsbweb.aspx',
                                '/_layouts/PageSettings.aspx',
                                '/_layouts/people.aspx',
                                '/_layouts/people.aspx?MembershipGroupId=0',
                                '/_layouts/permsetup.aspx',
                                '/_layouts/picker.aspx',
                                '/_layouts/policy.aspx',
'/_layouts/picker.aspx',
                                '/_layouts/policy.aspx',
                                '/_layouts/policyconfig.aspx',
                                '/_layouts/policycts.aspx',
                                '/_layouts/Policylist.aspx',
                                '/_layouts/prjsetng.aspx',
                                '/_layouts/quiklnch.aspx',
                                '/_layouts/recyclebin.aspx',
                                '/_Layouts/RedirectPage.aspx?Target={SiteCollectionUrl}_catalogs/masterpage',
                                '/_layouts/role.aspx',
                                '/_layouts/settings.aspx',
                                '/_layouts/SiteDirectorySettings.aspx',
                                '/_layouts/sitemanager.aspx',
                                '/_Layouts/SiteManager.aspx?lro=all',
                                '/_layouts/spcf.aspx',
                                '/_layouts/storman.aspx',
                                '/_layouts/themeweb.aspx',
                                '/_layouts/topnav.aspx',
                                '/_layouts/user.aspx',
                                '/_layouts/userdisp.aspx',
                                '/_layouts/userdisp.aspx?ID=1',
                                '/_layouts/useredit.aspx',
                                '/_layouts/useredit.aspx?ID=1&Source=/_layouts/people.aspx',
                                '/_layouts/viewgrouppermissions.aspx',
                                '/_layouts/viewlsts.aspx',
                                '/_layouts/vsubwebs.aspx',
                                '/_layouts/WPPrevw.aspx?ID=247',
                                '/_layouts/wrkmng.aspx',
                                '/lists/',
                                '/lists/tasks/',
                                '/lists/Tasks/AllItems.aspx',
                                '/Lists/Announcements/',
                                '/Lists/Announcements/AllItems.aspx',
                                '/Lists/Announcements/titles.aspx',
                                '/Lists/Contacts/',
                                '/Lists/Contacts/AllItems.aspx',
                                '/Lists/Contacts/filter.aspx',
                                '/Lists/blog/',
                                '/Lists/blog/AllItems.aspx',
                                '/Lists/FAQs/',
                                '/Lists/FAQs/AllItems.aspx',
                                 '/Lists/Registration/',
                                '/Lists/FAQs/',
                                '/Lists/FAQs/AllItems.aspx',
                                '/Lists/Registration/',
                                '/Lists/Registration/AllItems.aspx',
                                '/Lists/Links/',
                                '/Lists/Links/AllItems.aspx',
                                '/Lists/Events/',
                                '/Lists/Events/AllItems.aspx',
                                '/Lists/Events/MyItems.aspx',
                                '/lists/asppop3.asp',
                                '/lists/readmessage.asp',
                                '/lists/stylesheet.css',
                                '/mod-view.aspx',
                                '/mycategories.aspx',
                                '/mycomments.aspx',
                                '/myposts.aspx',
                                '/my-sub.aspx',
                                '/Pages/categoryresults.aspx',
                                '/Pages/default.aspx',
                                '/Pages/Forms/AllItems.aspx',
                                '/Pages/login.aspx',
                                '/shared documents/forms/allitems.aspx',
                                '/Shared Documents/Forms/AllItems.aspx',
                                '/sitedirectory',
                                '/sites/random%20crazy%20string',
                                '/SSP/Admin/_layouts/viewscopesssp.aspx?mode=ssp',



  # VPN Checks
 "/+CSCOE+/logon.html",
 "/vpn/",
 "/oaam_server/oamLoginPage.jsp",
#TOMCAT

                                '/admin',
                                '/admin/',
                                '/crossdomain.xml',
                                '/sitemap.xml',
                                '/examples',
                                '/examples/jsp/index.html',
                                '/examples/jsp/snp/snoop.jsp',
                                '/examples/jsp/source.jsp',
                                '/examples/servlet/HelloWorldExample',
                                '/examples/servlet/SnoopServlet',
                                '/examples/servlet/TroubleShooter',
                                '/examples/servlet/default/jsp/snp/snoop.jsp',
                                '/examples/servlet/default/jsp/source.jsp',
                                '/examples/servlet/org.apache.catalina.INVOKER.HelloWorldExample',
                                '/examples/servlet/org.apache.catalina.INVOKER.SnoopServlet',
                                '/examples/servlet/org.apache.catalina.INVOKER.TroubleShooter',
                                '/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/snp/snoop.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.DefaultServlet/jsp/source.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/snp/snoop.jsp',
                                '/examples/servlet/org.apache.catalina.servlets.WebdavServlet/jsp/source.jsp',
                                '/examples/servlet/snoop',
                                '/examples/servlets/index.html',
                                '/jsp-examples',
                                '/manager',
                                '/manager/',
                                '/manager/deploy?path=foo',
                                '/manager/html',
                                '/manager/html/',
                                '/manager/status',
                                '/manager/status/',
                                '/servlet/default/',
                                '/manager/html',
                                '/manager/html/',
                                '/manager/status',
                                '/manager/status/',
                                '/servlet/default/',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.INVOKER.org.apache.catalina.servlets.WebdavServlet/',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet/',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet',
                                '/servlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.servlets.HTMLManagerServlet',
                                '/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.DefaultServlet/tomcat.gif',
                                '/servlet/org.apache.catalina.servlets.InvokerServlet/org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.servlets.ManagerServlet',
                                '/servlet/org.apache.catalina.servlets.SnoopAllServlet',
                                '/servlet/org.apache.catalina.servlets.WebdavServlet/',
                                '/tomcat-docs',
                                '/webdav',
                                '/webdav/index.html',
                                '/webdav/servlet/org.apache.catalina.servlets.WebdavServlet/',
                                '/webdav/servlet/webdav/',
                                '/conf/',
                                '/conf/server.xml/',
                                '/WEB-INF/',
                                '/WEB-INF/web.xml',
                                '/WEB-INF/classes/',
                                '/shared/',
                                '/shared/lib/',
 # CITRIX
                                '/Citrix/MetFrame/',
                                '/Citrix/MetaFrame/auth/login.aspx',
                                '/Citrix/Xenapp',
                                '/Citrix',
                                '/Citrix/AccessPlatform',
                                '/Citrix/AccessPlatform/auth',
                                '/Citrix/AccessPlatform/media',
#PHPMYADMIN
 '/phpmyadmin/',
                                '/phpMyAdmin/',
                                '/PMA/',
                                '/pma/',
                                '/admin/',
                                '/dbadmin/',
                                '/mysql/',
                                '/myadmin/',
                                '/phpmyadmin2/',
                                '/phpMyAdmin2/',
                                '/phpMyAdmin-2/',
                                '/php-my-admin/',
                                '/phpMyAdmin-2.2.3/',
                                '/phpMyAdmin-2.2.6/',
                                '/phpMyAdmin-2.5.1/',
                                '/phpMyAdmin-2.5.4/',
                                '/phpMyAdmin-2.5.5-rc1/',
                                '/phpMyAdmin-2.5.5-rc2/',
                                '/phpMyAdmin-2.5.5/',
                                '/phpMyAdmin-2.5.5-pl1/',
                                '/phpMyAdmin-2.5.6-rc1/',
                                '/phpMyAdmin-2.5.6-rc2/',
                                '/phpMyAdmin-2.5.6/',
                                '/phpMyAdmin-2.5.7/',
                                '/phpMyAdmin-2.5.7-pl1/',
                                '/phpMyAdmin-2.6.0-alpha/',
                                '/phpMyAdmin-2.6.0-alpha2/',
                                '/phpMyAdmin-2.6.0-beta1/',
'/phpMyAdmin-2.6.0-beta2/',
                                '/phpMyAdmin-2.6.0-rc1/',
                                '/phpMyAdmin-2.6.0-rc2/',
                                '/phpMyAdmin-2.6.0-rc3/',
                                '/phpMyAdmin-2.6.0/',
                                '/phpMyAdmin-2.6.0-pl1/',
                                '/phpMyAdmin-2.6.0-pl2/',
                                '/phpMyAdmin-2.6.0-pl3/',
                                '/phpMyAdmin-2.6.1-rc1/',
                                '/phpMyAdmin-2.6.1-rc2/',
                                '/phpMyAdmin-2.6.1/',
                                '/phpMyAdmin-2.6.1-pl1/',
                                '/phpMyAdmin-2.6.1-pl2/',
                                '/phpMyAdmin-2.6.1-pl3/',
                                '/phpMyAdmin-2.6.2-rc1/',
                                '/phpMyAdmin-2.6.2-beta1/',
                                '/phpMyAdmin-2.6.2-rc1/',
                                '/phpMyAdmin-2.6.2/',
                                '/phpMyAdmin-2.6.2-pl1/',
                                '/phpMyAdmin-2.6.3/',
                                '/phpMyAdmin-2.6.3-rc1/',
                                '/phpMyAdmin-2.6.3/',
                                '/phpMyAdmin-2.6.3-pl1/',
                                '/phpMyAdmin-2.6.4-rc1/',
                                '/phpMyAdmin-2.6.4-pl1/',
                                '/phpMyAdmin-2.6.4-pl2/',
                                '/phpMyAdmin-2.6.4-pl3/',
                                '/phpMyAdmin-2.6.4-pl4/',
                                '/phpMyAdmin-2.6.4/',
                                '/phpMyAdmin-2.7.0-beta1/',
                                '/phpMyAdmin-2.7.0-rc1/',
                                '/phpMyAdmin-2.7.0-pl1/',
                                '/phpMyAdmin-2.7.0-pl2/',
                                '/phpMyAdmin-2.7.0/',
                                '/phpMyAdmin-2.8.0-beta1/',
                                '/phpMyAdmin-2.8.0-rc1/',
                                '/phpMyAdmin-2.8.0-rc2/',
                                '/phpMyAdmin-2.8.0/',
                                '/phpMyAdmin-2.8.0.1/',
                                '/phpMyAdmin-2.8.0.2/',
                                '/phpMyAdmin-2.8.0.3/',
                                '/phpMyAdmin-2.8.0.4/',
'/phpMyAdmin-2.8.1/',
                                '/phpMyAdmin-2.8.2/',
                                '/phpMyAdmin-3.3.9.2/',
                                '/sqlmanager/',
                                '/mysqlmanager/',
                                '/p/m/a/',
                                '/PMA2005/',
                                '/pma2005/',
                                '/phpmanager/',
                                '/php-myadmin/',
                                '/phpmy-admin/',
                                '/webadmin/',
                                '/sqlweb/',
                                '/websql/',
                                '/webdb/',
                                '/mysqladmin/',
                                '/mysql-admin/',
                                '/mya/',
                                '/scripts/setup.php',
                                '/config/config.inc.php',
                                '/phpmyadmin/scripts/setup.php',
                                '/phpMyAdmin/scripts/setup.php',
                                '/PMA/scripts/setup.php',
                                '/pma/scripts/setup.php',
                                '/admin/scripts/setup.php',
                                '/dbadmin/scripts/setup.php',
                                '/mysql/scripts/setup.php',
                                '/myadmin/scripts/setup.php',
                                '/phpmyadmin2/scripts/setup.php',
                                '/phpMyAdmin2/scripts/setup.php',
                                '/phpMyAdmin-2/scripts/setup.php',
                                '/php-my-admin/scripts/setup.php',
                                '/phpMyAdmin-2.2.3/scripts/setup.php',
                                '/phpMyAdmin-2.2.6/scripts/setup.php',
                                '/phpMyAdmin-2.5.1/scripts/setup.php',
                                '/phpMyAdmin-2.5.4/scripts/setup.php',
                                '/phpMyAdmin-2.5.5-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.5.5-rc2/scripts/setup.php',
                                '/phpMyAdmin-2.5.5/scripts/setup.php',
                                '/phpMyAdmin-2.5.5-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.5.6-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.5.6-rc2/scripts/setup.php',
                                '/phpMyAdmin-2.5.7/scripts/setup.php',
                                '/phpMyAdmin-2.5.7-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-alpha/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-alpha2/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-beta1/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-beta2/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-rc2/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-rc3/scripts/setup.php',
                                '/phpMyAdmin-2.6.0/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-pl2/scripts/setup.php',
                                '/phpMyAdmin-2.6.0-pl3/scripts/setup.php',
                                '/phpMyAdmin-2.6.1-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.1-rc2/scripts/setup.php',
                                '/phpMyAdmin-2.6.1/scripts/setup.php',
                                '/phpMyAdmin-2.6.1-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.6.1-pl2/scripts/setup.php',
                                '/phpMyAdmin-2.6.1-pl3/scripts/setup.php',
                                '/phpMyAdmin-2.6.2-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.2-beta1/scripts/setup.php',
                                '/phpMyAdmin-2.6.2-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.2/scripts/setup.php',
                                '/phpMyAdmin-2.6.2-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.6.3/scripts/setup.php',
                                '/phpMyAdmin-2.6.3-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.3/scripts/setup.php',
                                '/phpMyAdmin-2.6.3-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.6.4-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.6.4-pl1/scripts/setup.php',
'/phpMyAdmin-2.7.0-beta1/scripts/setup.php',
                                '/phpMyAdmin-2.7.0-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.7.0-pl1/scripts/setup.php',
                                '/phpMyAdmin-2.7.0-pl2/scripts/setup.php',
                                '/phpMyAdmin-2.7.0/scripts/setup.php',
                                '/phpMyAdmin-2.8.0-beta1/scripts/setup.php',
                                '/phpMyAdmin-2.8.0-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.8.0-rc2/scripts/setup.php',
                                '/phpMyAdmin-2.8.0/scripts/setup.php',
                                '/phpMyAdmin-2.8.0.1/scripts/setup.php',
                                '/phpMyAdmin-2.8.0.2/scripts/setup.php',
                                '/phpMyAdmin-2.8.0.3/scripts/setup.php',
                                '/phpMyAdmin-2.8.0.4/scripts/setup.php',
                                '/phpMyAdmin-2.8.1-rc1/scripts/setup.php',
                                '/phpMyAdmin-2.8.1/scripts/setup.php',
                                '/phpMyAdmin-2.8.2/scripts/setup.php',
                                '/phpMyAdmin-3.3.9.2/scripts/setup.php',
                                '/sqlmanager/scripts/setup.php',
                                '/mysqlmanager/scripts/setup.php',
                                '/p/m/a/scripts/setup.php',
                                '/PMA2005/scripts/setup.php',
                                '/pma2005/scripts/setup.php',
                                '/phpmanager/scripts/setup.php',
                                '/php-myadmin/scripts/setup.php',
                                '/phpmy-admin/scripts/setup.php',
                                '/webadmin/scripts/setup.php',
                                '/sqlweb/scripts/setup.php',
                                '/websql/scripts/setup.php',
                                '/webdb/scripts/setup.php',
                                '/mysqladmin/scripts/setup.php',
                                '/mysql-admin/scripts/setup.php',
                                '/phpmyadmin/setup/index.php',
                                '/phpMyAdmin/setup/index.php',
                                '/PMA/setup/index.php',
                                '/pma/setup/index.php',
                                '/admin/setup/index.php',
                                '/dbadmin/setup/index.php',
                                '/mysql/setup/index.php',
                                '/myadmin/setup/index.php',
                                '/phpmyadmin2/setup/index.php',
                                '/phpMyAdmin2/setup/index.php',
                                '/phpMyAdmin-2/setup/index.php',
'/phpMyAdmin-2.2.3/setup/index.php',
                                '/phpMyAdmin-2.2.6/setup/index.php',
                                '/phpMyAdmin-2.5.1/setup/index.php',
                                '/phpMyAdmin-2.5.4/setup/index.php',
                                '/phpMyAdmin-2.5.5-rc1/setup/index.php',
                                '/phpMyAdmin-2.5.5-rc2/setup/index.php',
                                '/phpMyAdmin-2.5.5/setup/index.php',
                                '/phpMyAdmin-2.5.5-pl1/setup/index.php',
                                '/phpMyAdmin-2.5.6-rc1/setup/index.php',
                                '/phpMyAdmin-2.5.6-rc2/setup/index.php',
                                '/phpMyAdmin-2.5.6/setup/index.php',
                                '/phpMyAdmin-2.5.7/setup/index.php',
                                '/phpMyAdmin-2.5.7-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.0-alpha/setup/index.php',
                                '/phpMyAdmin-2.6.0-alpha2/setup/index.php',
                                '/phpMyAdmin-2.6.0-beta1/setup/index.php',
                                '/phpMyAdmin-2.6.0-beta2/setup/index.php',
                                '/phpMyAdmin-2.6.0-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.0-rc2/setup/index.php',
                                '/phpMyAdmin-2.6.0-rc3/setup/index.php',
                                '/phpMyAdmin-2.6.0/setup/index.php',
                                '/phpMyAdmin-2.6.0-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.0-pl2/setup/index.php',
                                '/phpMyAdmin-2.6.0-pl3/setup/index.php',
                                '/phpMyAdmin-2.6.1-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.1-rc2/setup/index.php',
                                '/phpMyAdmin-2.6.1/setup/index.php',
                                '/phpMyAdmin-2.6.1-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.1-pl2/setup/index.php',
                                '/phpMyAdmin-2.6.1-pl3/setup/index.php',
                                '/phpMyAdmin-2.6.2-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.2-beta1/setup/index.php',
                                '/phpMyAdmin-2.6.2-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.2/setup/index.php',
                                '/phpMyAdmin-2.6.2-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.3/setup/index.php',
                                '/phpMyAdmin-2.6.3-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.3/setup/index.php',
                                '/phpMyAdmin-2.6.3-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.4-rc1/setup/index.php',
                                '/phpMyAdmin-2.6.4-pl1/setup/index.php',
                                '/phpMyAdmin-2.6.4-pl2/setup/index.php',
                                '/phpMyAdmin-2.7.0-beta1/setup/index.php',
                                '/phpMyAdmin-2.7.0-rc1/setup/index.php',
                                '/phpMyAdmin-2.7.0-pl1/setup/index.php',
                                '/phpMyAdmin-2.7.0-pl2/setup/index.php',
                                '/phpMyAdmin-2.7.0/setup/index.php',
                                '/phpMyAdmin-2.8.0-beta1/setup/index.php',
                                '/phpMyAdmin-2.8.0-rc1/setup/index.php',
                                '/phpMyAdmin-2.8.0-rc2/setup/index.php',
                                '/phpMyAdmin-2.8.0/setup/index.php',
                                '/phpMyAdmin-2.8.0.1/setup/index.php',
                                '/phpMyAdmin-2.8.0.2/setup/index.php',
                                '/phpMyAdmin-2.8.0.3/setup/index.php',
                                '/phpMyAdmin-2.8.0.4/setup/index.php',
                                '/phpMyAdmin-2.8.1-rc1/setup/index.php',
                                '/phpMyAdmin-2.8.1/setup/index.php',
                                '/phpMyAdmin-2.8.2/setup/index.php',
                                '/phpMyAdmin-3.3.9.2/setup/index.php',
                                '/sqlmanager/setup/index.php',
                                '/mysqlmanager/setup/index.php',
                                '/p/m/a/setup/index.php',
                                '/PMA2005/setup/index.php',
                                '/pma2005/setup/index.php',
                                '/phpmanager/setup/index.php',
                                '/php-myadmin/setup/index.php',
                                '/phpmy-admin/setup/index.php',
                                '/webadmin/setup/index.php',
                                '/sqlweb/setup/index.php',
                                '/websql/setup/index.php',
                                '/webdb/setup/index.php',
                                '/mysqladmin/setup/index.php',
                                '/mysql-admin/setup/index.php',

]
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# begin login to determine HTTP or HTTPS
counter = 0
puts "START GENERIC PORTAL CHECKS".bold.bg_gray.red
uri = URI(site)
list.each do |folder|
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if uri.scheme == 'https'
    request = Net::HTTP::Get.new(File.join(uri.path, folder))
    response = http.request(request)
    if response.code == "200" #or response.code == "302"
    puts "#{File.join(uri.to_s,folder)} STATUS=#{response.code}".green + " PROTOCOL=#{uri.scheme}".red
    else
    counter + 1 
    end
end
end