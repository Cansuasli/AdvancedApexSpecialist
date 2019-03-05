/**
 * @name product2Trigger
 * @description Trigger to notify staff of low levels of inventory
**/
trigger product2Trigger on Product2 (after update) {
    try {
       if (Trigger.isUpdate && Trigger.new != null) {
                 Product2Helper.AfterUpdate(Trigger.new);
            } 
    }catch ( Exception e ){
        System.debug(e);
    }
}