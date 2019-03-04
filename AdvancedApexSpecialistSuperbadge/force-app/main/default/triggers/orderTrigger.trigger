/**
 * @name orderTrigger
 * @description
**/
trigger orderTrigger on Order (after update) {
    try {
       if (Trigger.isUpdate && Trigger.new != null) {
                 OrderHelper.AfterUpdate(Trigger.new, Trigger.old);
            } 
    }catch ( Exception e ){
        System.debug(e);
    }
}