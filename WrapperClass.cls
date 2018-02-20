public class WrapperClass{

    public List<oObject> objectList {get; set;}        //HERE
    public List<Object_list__c> selectedObject{get;set;}    
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
     public List<Login__c> UserObj{get;set;} //############################# DAY 7
    
    public WrapperClass()
    {
       s=false;
       s1=false;
       
       
       error=false;  //############################# DAY 7
       error1=false;
       req1 = new Request_Details__c ();    //##################################### DAY4
       req1.ID=null;
       UserObj = new list<Login__c>(); //########################### DAY7
   }
    
    
    
//########################################## LOGIN PAGE #################################################
  //################################################### DAY7 ################################################################################
    
    
   public String password { get; set; }
   public String username { get; set; }
   
   public boolean error {get; set;}
    public boolean error1 {get; set;}
   
   
   public PageReference LogUser() {
      
       
       if(username != null && username != '')
       {
           UserObj = [Select User_name__c,Password__c,Position__c from Login__c where User_name__c =:username];
           
           if(UserObj.size()>0)
           {
               for(Login__c log : UserObj){
                   if(password == log.Password__c)
                   {
                       if(log.Position__c=='Customer')
                       {
                           req3=new list<Request_Details__c>();
                           req3= [select Request_ID__c,status__c from Request_Details__c where Login_name__c = :UserObj[0].ID];
                           return Page.firstpage ;
                           }
                       else
                       {
                           req3=new list<Request_Details__c>();
                           req3= [select Request_ID__c,status__c from Request_Details__c];
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
    
    
    //#########################################  DAY 2  ############################################################
// FILTER DETAILS->

    public class oObject {
        public Object_List__c obj2 {get; set;}
        public Boolean selected {get; set;}
        
        public oObject(Object_List__c o) {
            obj2 = o;
            selected = false;
            }
        
        }
        
        
      public PageReference processSelected() {
         s=true;
        selectedObject = new List<Object_list__c>();
        
        for(oObject oObj2 : getObject()) {
            if(oObj2.selected == true) {
                selectedObject.add(oObj2.Obj2);
            }
       s1=true;
            }
            
       // value = selectedObject.size();
        //System.debug('printingtcontc'+selectedContacts.size());
        return null;
        }
        
        
        
        public List<oObject> getObject() {
            if(objectList == null) {
                objectList = new List<oObject>();
                for(Object_list__c o : [  SELECT Name FROM Object_List__c]) {
                    objectList.add(new oObject(o));
                }
            }
            return objectList;
            }
            
                      
            
        public List<Object_List__c> getSelectedObject(){
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
   
       if(req1 != null){
          i=0;
         req1.Login_name__c = UserObj[0].ID;   // ################################# DAY 7
       insert req1;
       fil2 = new List<Filter1__c>();
       
       
       for(Object_List__c s : selectedObject) {
           
          Filter1__c f= new Filter1__c();
          f.Name = s.name;
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
         req1 = new Request_Details__c ();
    }

     public void reset1(){
          selectedObject = new List<Object_list__c>();
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
   
   fil1 = new list<Filter1__c>();
   fil1 = [ select Name, queries__c from  Filter1__c where Requset_Name__c= :req1.ID];
   return fil1;}
   
   set{}

   }
   
   
   
//############################## DAY 7 ###################################################################

public list<Request_Details__c> req3{get;set;}


public PageReference status() 
{
    
      return Page.status;
     }
    
   

   

}