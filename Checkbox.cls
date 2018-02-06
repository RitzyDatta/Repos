public class Checkbox {


public Checkbox(apexpages.standardcontroller cont){}

public String[] choices { get; set; }
public Boolean displayInputputText{get;set;}
public boolean s {get; set;}

public checkbox()
{
   s=false;
}

public pagereference rendersec()
{
    s = true;
    return null;
}

public list<SelectOption> getLists(){
    list<SelectOption> Obj1= new list<SelectOption>();
    
    for (Object_List__c ow : [  SELECT Name FROM Object_List__c]) {   
        Obj1.add(new SelectOption(ow.name,ow.name));   
      }
    
    return Obj1;
   }

}