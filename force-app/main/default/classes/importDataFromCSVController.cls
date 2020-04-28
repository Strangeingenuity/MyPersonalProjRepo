public with sharing class importDataFromCSVController {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<EasyLife__EasyUpdates__c> DataList{get;set;}
    
    public importDataFromCSVController(){
           csvFileLines = new String[]{};
           DataList= New List<EasyLife__EasyUpdates__c>();
      }
    public Void importCSVFile() {
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n');
            
           for(Integer i=1;i<csvFileLines.size();i++){
               EasyLife__EasyUpdates__c EasyDatUpdObj = new EasyLife__EasyUpdates__c();
               string[] csvRecordData = csvFileLines[i].split(',');
               EasyDatUpdObj.EasyLife__ObjectName__c= csvRecordData[0] ;             
               EasyDatUpdObj.EasyLife__RecordId__c= csvRecordData[1];
               EasyDatUpdObj.EasyLife__Column_Old_Value__c = csvRecordData[2];
               EasyDatUpdObj.EasyLife__Column_New_Value__c= csvRecordData[3];                                                                               
               DataList.add(EasyDatUpdObj);             

                }
       Insert(DataList);
    }
}