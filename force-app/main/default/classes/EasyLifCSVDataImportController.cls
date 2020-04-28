public with sharing class EasyLifCSVDataImportController{
    public Blob FileBody{get;set;}
    public string FileConToString{get;set;}
    public String[] FileStringSplitToLines{get;set;}
    public List<EasyLife__EasyUpdates__c> DataList{get;set;}
    EasyLife__EasyUpdate__c myCS1 = EasyLife__EasyUpdate__c.getValues('BatchNum');
    Decimal CurrentBatchId =  myCS1.LastBatchId__c;
    String  InitialStatus = 'Not-Processed';
    String ObjName;
    EasyLife__EasyUpdateQueue__c QueueBuild = New EasyLife__EasyUpdateQueue__c();
    
    public EasyLifCSVDataImportController(){
           FileStringSplitToLines= new String[]{};
           DataList= New List<EasyLife__EasyUpdates__c>();
      }
    public Void importCSVFile() {
           FileConToString = FileBody.toString();
           FileStringSplitToLines = FileConToString.split('\n');
           Decimal RecordCount = 0;
           for(Integer i=1;i<FileStringSplitToLines.size();i++){ 
                   EasyLife__EasyUpdates__c EasyDatUpdObj = new EasyLife__EasyUpdates__c();
                   string[] RecordData = FileStringSplitToLines[i].split(',');

                   EasyDatUpdObj.EasyLife__ObjectName__c= RecordData[0];           
                   EasyDatUpdObj.EasyLife__RecordId__c= RecordData[1];
                   EasyDatUpdObj.EasyLife__Column_Old_Value__c = RecordData[2];
                   EasyDatUpdObj.EasyLife__Column_New_Value__c= RecordData[3];
                   EasyDatUpdObj.EasyLife__BatchNumber__c = CurrentBatchId+1;
                   EasyDatUpdObj.EasyLife__JobStatus__c= InitialStatus;
                   RecordCount++;                                             
                   DataList.add(EasyDatUpdObj);
               }
       Insert(DataList);
       myCS1.LastBatchId__c=  CurrentBatchId+1;
       Update myCS1;
       QueueBuild.EasyLife__JobNumber__c = CurrentBatchId+1 ; 
       QueueBuild.EasyLife__NumberOfRecords__c = RecordCount ;  
       QueueBuild.EasyLife__ObjectName__c = ObjName;
       Insert(QueueBuild);
    }    
}