public class WrapperClass{

    public List<oObject> objectList {get; set;}        //HERE
    public List<Object_list__c> selectedObject{get;set;}    
   // public Integer value {get;set;}    //HERE
    list<Object_List__c> Obj3=[  SELECT Name FROM Object_List__c];    //HERE
    
   // public String inputText;  //##################################### DAY4
    
    
    
    
    Integer i,j;
    
     public Request_Details__c req1{get;set;}   //##################################### DAY4
     public Request_Details__c req2{get;set;} 
     public Filter1__c fil1{get;set;}    //##################################### DAY4
     public List<Filter1__c> fil2{get;set;} 
    
    
    public WrapperClass(apexpages.standardcontroller cont){}
    
    public String[] choices { get; set; }
    public Boolean displayInputputText{get;set;}
    public boolean s {get; set;}
    public boolean s1 {get; set;}
    
    public WrapperClass()
    {
       s=false;
       s1=false;
       
       req1 = new Request_Details__c ();    //##################################### DAY4
       req2 = new Request_Details__c (); 
       //fil1 = new List<Filter1__c>();    //##################################### DAY4
    }
    
    
    
    
    public void rendersec()
    {    
        s = true;
       
        
        }
    
    
    public list<Object_list__c> getObj3()
    {
        return Obj3;
    
    }
    
    
    public list<SelectOption> getLists()
    {
        list<SelectOption> Obj1= new list<SelectOption>();
        
        for (Object_List__c ow : [  SELECT Name FROM Object_List__c]) {   
            Obj1.add(new SelectOption(ow.name,ow.name));   
          }
        
        return Obj1;
   }
    
    
    //#########################################  DAY 2  ############################################################

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


    
    
    public pagereference cclear()
    {
       selectedObject = new List<Object_list__c>();

       s = true;
       return null;
   
    }
        
    
    //########################## DAY 4 ################################################################
    
    
 list<string> queries=new list<string>();
 
 
 // public String inputText; 
 
   public String inputText {
         get { return null;}
        set { 
        inputText = value;
        queries.add(inputText);
        }
        }
 
 
 
 /* public String getinputText(){return null;}

    public void setinputText()
    {
        inputText = value;
        queries.add(inputText);
    }


    public void addque(String b){   // not
       queries.add(b);
        }  */
    

     public void save1(){
   
       if(req1 != null){
          i=0;
              
       insert req1;
       fil2 = new List<Filter1__c>();
       
       
       for(Object_List__c s : selectedObject) {
           
          Filter1__c f= new Filter1__c();
          f.Name = s.name;
          f.Requset_Name__c = req1.name;
          f.Queries__c = queries[i];
           insert f;
           i++;

           }
               /* if(fil2 != null){
                   insert fil2;
                   } */
                   
            }

           else
               system.debug('not');
          } 
}