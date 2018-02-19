public class CustomLoginController {

    public String password { get; set; }
    public String username { get; set; }
    
    public boolean error {get; set;}
    public boolean error1 {get; set;}
    
    public CustomLoginController(){
        error=false;
        error1=false;
    }
    
    public PageReference LogUser() {
        List<Login__c> obj = new List<Login__c>();
        
        if(username != null && username != '')
        {
            obj = [Select User_name__c,Password__c from Login__c where User_name__c =:username Limit 1];
            if(obj.size()>0)
            {
                for(Login__c log : obj){
                    if(password == log.Password__c)
                    {
                        return Page.firstpage ;
                    }
                    else
                    {
                      /*  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid Password' );
                        ApexPages.addMessage(myMsg);
                           system.debug('MyMsg:'+myMsg); */
                       
                        error1=true;
                        error=false;
                    }
                }
            }
            else
            {
               /* ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Username does not exist' );
                ApexPages.addMessage(myMsg);
                system.debug('MyMsg:'+myMsg);  */
                
                error1=false;
               error=true;
            }
        }
        return null;
        }
    
    

//##########################################################################################################

/* public String username{get; set;}
public String password {get; set;}
 
public pageReference doLogin()
{  
    return Site.login(username,password,null);
}  */

}