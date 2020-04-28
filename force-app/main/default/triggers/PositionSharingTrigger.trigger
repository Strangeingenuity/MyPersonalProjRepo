Trigger PositionSharingTrigger on Position__c (after insert, after update) {
/** 
 * When a Position record is modified, make sure the sharing rules on the record match 
 * the status fields:
 *   If Status/sub-status = open/approved
 *      - Hiring Manager = Edit
 *      - All others in organization = Read
 *   Else
 *      - Hiring Manager = Read
 *      - All others in organization = No Access
 * NOTE: Because the Hiring Manager may have been changed on an update, we need to make sure 
 * that any share records for the old Hiring Manager are removed. 
*/
    
    // Map of Position ID --> New Hiring Mgr Id             
    Map<ID,ID> posIdToNewMgrIdMap = new Map<ID,ID>();           
    // A list of records that we are accumulating to put in the database.
    List<sObject> sharesToInsert = new List<sObject>(); 
    
    // Loop through records that are in the trigger and:
    for (Position__c position:Trigger.new){
        //TODO: Implement the following algorithm (there are 8 numbered TODOs):
        //TODO 1: if this is insert OR
        if (Trigger.isInsert
            ||position.Status__c != Trigger.oldMap.get(position.Id).Status__c || position.Sub_Status__c != Trigger.oldMap.get(position.Id).Sub_Status__c
            ||Position.Hiring_Manager__C != Trigger.OldMap.get(Position.Id).Hiring_Manager__c) 
                {   
                                                    
            //TODO 3: create a Position__share record named positionShare for the hiring manager 
            Position__Share posShare = new Position__Share();
            
            //TODO 4: set the Position__share parentId to the id of current position (the object on which share is being set)
            posShare.ParentId = Position.Id;
            //TODO 5: set the userOrGroupId to the hiring manager (the user for who is being given access)
            posShare.userOrGroupId = Position.Hiring_Manager__C;
            //TODO 6: set the rowCause to Schema.Position__Share.RowCause.Hiring_Manager__c
            posShare.rowCause = Schema.position__Share.RowCause.Hiring_Manager__C;
        
            // if Status/sub-status = open/approved 
            if ((position.Status__c == 'Open') && (position.Sub_Status__c=='Approved')){
                //TODO 7:   set accessLevel field of the Position__share record to the string value Edit
                 posShare.accesslevel = 'Edit';
                                                       
            } 
            
            else {
                //TODO 8: set accessLevel field of the Position__share record to the string value Read
                posShare.accesslevel = 'Read';
        }
        // add the Position__Share record to the sharestToInsert list       
           sharesToInsert.add(posShare);
        }
        // Only worried about change in hiring manager if record is updated.
        // If this an update, 
        //      if hiring manager changed
        //            store record in a map (posIdtoNewMgrIdMap) with key = position record id, value = new hiring manager id
        if (Trigger.isUpdate){
            //Build the Map of Hiring Manager changes
            if(position.Hiring_Manager__c != Trigger.oldMap.get(position.Id).Hiring_Manager__c){
                posIdToNewMgrIdMap.put(position.Id,position.Hiring_Manager__c);
            }           
        }
    }

    if (posIdToNewMgrIdMap!=null && posIdToNewMgrIdMap.size() > 0 ) {
        PositionSharingClass.deletePositionSharingByRowCause(posIdToNewMgrIdMap, 'Hiring_Manager__c');      
    }
    // Insert the new share objects in the DB 
    Database.insert(sharesToInsert);        
}