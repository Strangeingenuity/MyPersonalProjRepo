trigger AccountTrigger on Account (after insert) {
    //After update
        if (Trigger.isAfter && Trigger.isUpdate) {
              for(Account sp:trigger.New ){
                 sp.addError('Tyaga you cannot update me 1111');
                }
           // AccountTriggerHandlerTyaga.afterUpdate(Trigger.new, Trigger.oldMap);
        }

    //Before update
        if (Trigger.isBefore && Trigger.isUpdate) {
            //AccountTriggerHandlerTyaga.BeforeUpdate(Trigger.new, Trigger.oldMap);
            for(Account sp:trigger.New ){
                  system.debug('tyaga its here');
                  sp.addError('Tyaga you cannot update me');
                }
        }


}