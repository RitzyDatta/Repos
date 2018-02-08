public class WrapperClass {

public List<oObject> objectList {get; set;}        //HERE
public List<Object_list__c> selectedObject{get;set;}    
public Integer value {get;set;}    //HERE
list<Object_List__c> Obj3=[  SELECT Name FROM Object_List__c];    //HERE

public WrapperClass(apexpages.standardcontroller cont){}

public String[] choices { get; set; }
public Boolean displayInputputText{get;set;}
public boolean s {get; set;}

public WrapperClass()
{
   s=false;
}

public pagereference rendersec()
{
    s = true;
    return null;
}


public list<Object_list__c> getObj3(){
        return Obj3;
    
    }


public list<SelectOption> getLists(){
    list<SelectOption> Obj1= new list<SelectOption>();
    
    for (Object_List__c ow : [  SELECT Name FROM Object_List__c]) {   
        Obj1.add(new SelectOption(ow.name,ow.name));   
      }
    
    return Obj1;
   }


    public class oObject {
        public Object_List__c obj2 {get; set;}
        public Boolean selected {get; set;}
        
        public oObject(Object_List__c o) {
            obj2 = o;
            selected = false;
            }
        }
        
     public PageReference processSelected() {
        selectedObject = new List<Object_list__c>();
        
        for(oObject oObj2 : getObject()) {
            if(oObj2.selected == true) {
                selectedObject.add(oObj2.Obj2);
            }
            }
            
        value = selectedObject.size();
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
        

}