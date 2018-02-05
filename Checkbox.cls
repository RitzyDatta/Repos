public class Checkbox {
public String[] choices { get; set; }
public Boolean displayInputputText{get;set;}
//public Boolean chkBx{get;set;}
//public String input{get;set;}

// list<Object_List__c> source= [select name,type, industry, phone, fax from account where type = 'customer - direct'];


 public list<SelectOption> getLists(){
     list<SelectOption> Obj1= new list<SelectOption>();
     
     for (Object_List__c ow : [  SELECT Name FROM Object_List__c]) {   
         Obj1.add(new SelectOption(ow.name,ow.name));   
       }
     
     //Obj1=[select name from Object_List__c];
     return Obj1;
    }


}