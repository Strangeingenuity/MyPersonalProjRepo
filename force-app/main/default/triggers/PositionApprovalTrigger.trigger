trigger PositionApprovalTrigger on Position__c (before insert, before update) {
    system.debug('Tyaga Pati: I am here 11111'); 
    PositionApproval.setPositionApprovers(Trigger.new);
}