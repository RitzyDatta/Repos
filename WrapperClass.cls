public class WrapperClass{


//------------------------- VARIABLE DECLARATION --------------------------------------------------------

    public List<oObject> objectList {get; set;}        //HERE
    public List<STRING> selectedObject{get;set;}    
   // public Integer value {get;set;}    //HERE
    list<Object_List__c> Obj3=[  SELECT Name FROM Object_List__c];    //HERE
     
    Integer i,j;
    
     public Request_Details__c req1{get;set;}   //##################################### DAY4
     public List<Filter1__c> fil2{get;set;} 
     
    
    
    public WrapperClass(apexpages.standardcontroller cont){}
    
    public String[] choices { get; set; }
    public Boolean displayInputputText{get;set;}
    public boolean s {get; set;}
    public boolean s1 {get; set;}
    
//----------------------------------------------------------FOR REST------------------------------------------------------------------
public String loginurl{get;set;}
 public string UserName{get;set;}    //THIS IS FOR SOURCE
 
 public string Password{get;set;}
 public string PID{get;set;}
 public string PID1{get;set;}
 public String SecurityToken{get;set;}
 public String conKey{get;set;}
 public String conSecret{get;set;}
 
 public String loginurl1{get;set;}
 public string UserName1{get;set;}  //THIS IS FOR TARGET
 public string Password1{get;set;}
 public String SecurityToken1{get;set;}
 public String conKey1{get;set;}
 public String conSecret1{get;set;}
 
 public list<string> customFieldIdList{get;set;}
 public list<string> customFieldNameList{get;set;}
  public String errMsg{get;set;}
 public string displayError{get;set;}

//  Class to handle HTTP Rest calls to other SFDC instances
    //
    //  [HTTP-00]   - Reached limit on callouts
    //  [HTTP-01]   - Unable to get OAuth 2.0 token from remote SFDC
    //  [HTTP-02]   - Error in SOQL REST query
 
    String  accessToken;                    // OAuth 2.0 access token
    String  sfdcInstanceUrl;                // Endpoint URL for SFDC instance
//------------------------------------------ DAY 7 ----------------------------------------------------------
     public List<Login__c> UserObj{get;set;} 
     public list<Request_Details__c> req3{get;set;}
     public String password123 { get; set; }
     public String username123 { get; set; }
   
    public boolean error {get; set;}
    public boolean error1 {get; set;}
   
 
 
 
//------------------------- VARIABLE DECLARATION --------------------------------------------------------

    public WrapperClass() //CONSTRUCTOR
    {
       s=false;
       s1=false;
       
       
       error=false;  //############################# DAY 7
       error1=false;
       req1 = new Request_Details__c ();    //##################################### DAY4
       req1.ID=null;
       UserObj = new list<Login__c>(); //########################### DAY7
       
       displayError = 'none';
   }
    
    
    
//########################################## LOGIN PAGE #################################################
  //################################################### DAY7 ################################################################################
    
public string orderBy{get;set;} 
   
   public PageReference LogUser() {
      
       
       if(username123 != null && username123 != '')
       {
           UserObj = [Select User_name__c,Password__c,Position__c from Login__c where User_name__c =:username123];
           
           if(UserObj.size()>0)
           {
               for(Login__c log : UserObj){
                   if(password123 == log.Password__c)
                   {
                       if(log.Position__c=='Customer')
                       {
                           req3=new list<Request_Details__c>();
                           req3= [select name,ID,Request_ID__c,status__c from Request_Details__c where Login_name__c = :UserObj[0].ID];
                           return Page.command ;
                           }
                       else
                       {
                           req3=new list<Request_Details__c>();
                           req3= [select name,ID,Request_ID__c,status__c from Request_Details__c];
                           return Page.status;
                       }
                       
                   }
                   else
                   {
                       error1=true;
                       error=false;
                   }
               }
           }
           
           else
           {
               error1=false;
               error=true;
           }
      }
      else
           {
               error=true;
           }
       return null;
       }

    
 //########################################## LOGIN PAGE #################################################  
 //#################################################################################################   
    
    
    
    public void rendersec()
    {    
        s = true;}

   /* 
    public list<Object_list__c> getObj3()
    {
        return Obj3;}
    
    
    public list<SelectOption> getLists()    // CONFIGURATION
    {
        list<SelectOption> Obj1= new list<SelectOption>();
        
        for (Object_List__c ow : [  SELECT Name FROM Object_List__c]) {   
            Obj1.add(new SelectOption(ow.name,ow.name));   
          }
        
        return Obj1;
   }
    */
    
    //#########################################  DAY 2  ############################################################
// configuration->
//------------------------------------------------------------------ REST CALL ----------------------------------------------------
    private HttpResponse send(String uri,String httpMethod) {
        return send(uri,httpMethod,null);
        }


    private HttpResponse send(String uri, String httpMethod, String body) {
         
         
        if (Limits.getCallouts() == Limits.getLimitCallouts())
            displayError='block';
    
        Http h = new Http();
        HttpRequest hRqst = new HttpRequest();
        hRqst.setEndpoint(uri);                     // caller provides, this will be a REST resource
        hRqst.setMethod(httpMethod);                // caller provides
        hRqst.setTimeout(6000); 
        if (body != null) 
            hRqst.setBody(body);                    // caller provides
        if (this.accessToken != null)               // REST requires using the token, once obtained for each request
            hRqst.setHeader('Authorization','Bearer ' + this.accessToken);
        
            return h.send(hRqst);                   // make the callout
        
        
    }


     public void authenticateByUserNamePassword(String consumerKey, String consumerSecret, String uName, String uPassword) {
        
        String uri=loginurl + '/services/oauth2/token';
        String clientId     = EncodingUtil.urlEncode(consumerKey,'UTF-8');
        String clientSecret = EncodingUtil.urlEncode(consumerSecret,'UTF-8');
        String username     = EncodingUtil.urlEncode(uName,'UTF-8');
        String password     = EncodingUtil.urlEncode(uPassword,'UTF-8');
 
        String body =   'grant_type=password&client_id=' + clientId + 
                        '&client_secret=' + clientSecret +
                        '&username=' + username + 
                        '&password=' + password; 
 
        HttpResponse hRes = this.send(uri,'POST',body);
        if (hRes.getStatusCode() != 200) 
             displayError='block';
         
 
        Map<String,String> res = (Map<String,String>) JSON.deserialize(hRes.getBody(),Map<String,String>.class);
 
        this.accessToken        = res.get('access_token');      // remember these for subsequent calls
        this.sfdcInstanceUrl    = res.get('instance_url');
         
         
    }


    public void doSoqlQuery() {
        string pass;
        errMsg  = 'Some error occurred, please try again';
        
        boolean a;
        s=true;
        
            try{
                
                Pass=Password + SecurityToken;
            
           authenticateByUserNamePassword(conKey, conSecret, UserName, Pass);
            
               
            PageReference urlpg = new PageReference(this.sfdcInstanceUrl + '/services/data/v28.0/tooling/query/?q=Select+Id,DeveloperName+from+CustomObject');
            
        
            String uri = urlPg.getUrl();               // let APEX do the URL encoding of the parms as necessary
        
            HttpResponse hRes = this.send(uri,'GET');
        
            
            
           if (hRes.getStatusCode() != 200)
                displayError='block';
              
            
           
           JSONParser parser = JSON.createParser(hRes.getBody());
        
            customFieldNameList = new List<string>();
              customFieldIdList = new List<string>();
              displayError='none';
              
              while (parser.nextToken() != null)
              {
                  if((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&((parser.getText() == 'DeveloperName'))){
                        parser.nextToken();
                        customFieldNameList.add(parser.getText());
                        }
                  if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                        parser.nextToken();
                        customFieldIdList.add(parser.getText());
                        }
                        } 
                  system.Debug('NAAAAAAAAAAAAAAAAAAAMEEEEEEEE   :' +customFieldNameList);
           
          }
          catch(exception e)
          {
              s1=false;
              
              s=false;
              displayError='block';
               system.debug('EXXXXXXXXXXXCEEEEEEEEEEEEEEPPPPPPPPPPPTIONNNN:  '+e);
               system.debug('DISPLAYYYYYYYYY ERROOOOOOOOOORRRRRR:  '+displayError);
               
          }
            
    }





    public class oObject {
        public string obj2 {get; set;}
        public Boolean selected {get; set;}
        
        public oObject(String o) {
            obj2 = o;
            selected = false;
            }
        
        }
        
        
     public PageReference processSelected() {
         s=true;
        selectedObject = new List<string>();
        if(objectList != null){
        for(oObject oObj2 : objectList) {
            if(oObj2.selected == true) {
                selectedObject.add(oObj2.Obj2);
            }
       s1=true;
            }
            }
            
       // value = selectedObject.size();
       
        return null;
        }
        
        
        
         public List<oObject> getObject() {
           if(objectList != null) {
               return objectList;
             }
             else{
                
             if(customFieldNameList != null)
             
             {
                 objectList = new List<oObject>();
                for(String o : customFieldNameList) {
                    objectList.add(new oObject(o));
                }
                }
                
             system.debug('OBJECT LIIIIISSSSSSSSSSTTTTTTTTTT:  ' +objectList);
            
            return objectList;
            }
            }
            
                      
            
        public List<string> getSelectedObject(){
            //System.debug('printingtcontc inside get'+selectedContacts.size());
            if(selectedObject.size()>0 )
                return selectedObject;
            else return null;
            }
    
    
    
//########################## DAY 3 ################################################################

        
    
//########################## DAY 4 ################################################################
    
    
 list<string> queries=new list<string>();
  
 
   public String inputText {
         get { return null;}
        set { 
        inputText = value;
        queries.add(inputText);
        }
        }

    

     public pagereference save1(){
       
       req1.SDFC_login_URL_source__c=loginurl;
       req1.User_ID_source__c=UserName;
       req1.Password_source__c=password;
       req1.Security_Token_Source__c= SecurityToken;
       req1.Consumer_key_source__c= conKey;
       req1.Consumer_Secret_source__c=conSecret;
       
       req1.SDFC_login_URL_target__c=loginurl1;
       req1.User_ID_target__c=UserName1;
       req1.Password_target__c=password1;
       req1.Security_Token_Target__c= SecurityToken1;
       req1.Consumer_key_target__c= conKey1;
       req1.Consumer_Secret_target__c=conSecret1;
       
       if(req1 != null){
          i=0;
        // req1.Login_name__c = UserObj[0].ID;   // ################################# DAY 7
       insert req1;
       fil2 = new List<Filter1__c>();
       
       
       for(String s : selectedObject) {
           
          Filter1__c f= new Filter1__c();
          f.Name = s;
          f.Requset_Name__c = req1.ID;
          f.Queries__c = queries[i];
           insert f;
           i++;

           }
            }

           else
               system.debug('not');
           return page.secondpage;
          } 
//############################################ DAY 5 #####################################


    public void reset(){

        loginurl='';
        
        UserName = '';    //THIS IS FOR SOURCE
        Password = '';
        SecurityToken = '';
        conKey = '';
        conSecret = '';
        
        loginurl1 = '';
        UserName1 = '';    //THIS IS FOR SOURCE
        Password1 = '';
        SecurityToken1 = '';
        conKey1 = '';
        conSecret1 = '';
    }  
     public void reset1(){
          selectedObject = new List<String>();
          s1=false;
          inputText=null;
          queries=new list<string>();
          objectlist=null;
         }


//############################################ DAY 6 #####################################
//############################################ SECOND PAGE #####################################

  public Request_Details__c req2{
   get{
   
      req2 = new Request_Details__c (); 
       req2=req1.clone();
       return req2;}
       
   set{}
   }

   public Filter1__c[] fil1{
   get{
   if (req1.ID != null)
   {
   fil1 = new list<Filter1__c>();
   fil1 = [ select Name, queries__c from  Filter1__c where Requset_Name__c= :req1.ID];
   return fil1;}
   else
       return null;
   }
   set{}

   }
   
   
   
//############################## DAY 7 ###################################################################


public PageReference status() 
{
    
      return Page.status;
     }
    
   
//######################################## DAY 8 #######################################################
//---------------- DOWNLOAD LINK --------------------------------------------------------


public string description{get;set;}
public string description1{get;set;}
public string val{get;set;}

public String getFileContents() {

    description= 'sf.source.serverurl=' +req2.SDFC_login_URL_source__c  + '\r\n';
    description= description+ 'sf.source.username='+ req2.User_ID_source__c+ '\r\n';
    description= description + 'sf.source.password='+req2.Password_source__c+ '\r\n\r\n';
    
    description= description + 'sf.target.serverurl=' +req2.SDFC_login_URL_target__c+ '\r\n';
    description= description + 'sf.target.username='+req2.User_ID_target__c+ '\r\n';
    description= description + 'sf.target.password='+req2.Password_target__c+ '\r\n';
    
    return EncodingUtil.base64Encode(Blob.valueOf(description));
}
   
   
   public String getFileContents1() {

    description1='';
    i=0;
    
    for(Filter1__c s : fil1){
        description1+='"'+s.name+'",'+ +'"'+s.queries__c+'",'+'"skipProperty/skip_for_'+s.name+'.properties"'+'\r\n';
        i++; 
    }
    
    
    return EncodingUtil.base64Encode(Blob.valueOf(description1));
}

//------------------------- DETAILS FROM LIST OF LINKS ----------------------------------------------------------

public pagereference a(){
   req1 = new Request_Details__c ();
   val=ApexPages.CurrentPage().getParameters().get('vall');
   req1= [select SDFC_login_URL_source__c,User_ID_source__c,Password_source__c,SDFC_login_URL_target__c,User_ID_target__c,Password_target__c from Request_Details__c where name= :val];
   return page.secondpage;
}


//####################################### DAY 8 ########################################################################


public pagereference b()
{
return page.firstpage;
}




//################################ DAY 9 ##########################################################################



}