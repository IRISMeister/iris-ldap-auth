; Enable IAM Account
Set tSC=##class(Security.Users).Get("IAM",.prop)
If (prop("Enabled")=1) { halt } 
Set prop("Enabled")=1
Set prop("Password")="sys"
Set tSC=##class(Security.Users).Modify("IAM",.prop)

; Enable IAM apis
Set tSC=##class(Security.Applications).Get("/api/IAM",.prop)
Set prop("Enabled")=1
Set tSC=##class(Security.Applications).Modify("/api/IAM",.prop)

#; Add LDAP Config
Set prop("LDAPBaseDN")="DC=example,DC=com"
Set prop("LDAPFlags")=104
Set prop("LDAPHostNames")="ldap-server"
Set prop("LDAPSearchPassword")="ldap"
Set prop("LDAPSearchUsername")="cn=admin,dc=example,dc=com"
Set prop("LDAPUniqueDNIdentifier")="uid"
Set tSC=##class(Security.LDAPConfigs).Create("example.com",.prop)

; Change default security domain, Auth/Web session option
Set tSC=##class(Security.System).Get(,.prop)
Set prop("DefaultSecurityDomain")="example.com"
Set prop("AutheEnabled")=8191
Set tSC=##class(Security.System).Modify(,.prop)

; Create New REST App for coffeemakerapp demo
Kill prop
Set prop("NameSpace")="USER"
Set prop("DispatchClass")="cmAPI.disp"
Set prop("AutheEnabled")=2080 ; Password+LDAP,  2144=NoAuth+Password+LDAP
Set tSC = ##Class(Security.Applications).Create("/rest/coffeemakerapp",.prop)

; Add coffeemakerapp apps
Set $NAMESPACE="USER"
Set tSC=$SYSTEM.OBJ.LoadDir("/home/irisowner/OS/FirstLook-IAM/cls","ck",,1)
Set tSC=$SYSTEM.OBJ.Load("/home/irisowner/OS/FirstLook-IAM/gbl/coffeemakers.gof")

halt