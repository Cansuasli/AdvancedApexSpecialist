/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
**/
public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static CollaborationGroup ConstructCollaborationGroup(){
        //ToDo: Ensure this method returns a single Chatter CollaborationGroup
        //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
        //    and configured so anyone can join, see and post updates.
        CollaborationGroup colgroup = new CollaborationGroup();
        colgroup.Name = 'TEST' + Constants.INVENTORY_ANNOUNCEMENTS;
        colgroup.CollaborationType = 'Public';
        return colgroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public static List<Product2> ConstructProducts(Integer cnt){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        List<Product2> products = new List<Product2>();
        for(Integer i = 0; i<cnt; i++){
            Product2 prdct = new Product2(Name='TestProduct ' + i, IsActive = true, Initial_Inventory__c = 10);
                if(math.mod(i,4) == 0){
                    prdct.Family='Side';
                }
                if(math.mod(i,4) == 1){
                    prdct.Family='Entree';
                }
                if(math.mod(i,4) == 2){
                    prdct.Family='Dessert';
                }
                if(math.mod(i,4) == 3){
                    prdct.Family='Beverage';
                }
            products.add(prdct);
        }
        return products;
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
    }

    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PriceBookEntry> ConstructPricebookEntries(List<Product2> prods){
        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
        List<PriceBookEntry> listPBE=new List<PriceBookEntry>();
        for(Product2 p: prods)
        {
            PriceBookEntry pbe=new PriceBookEntry();
            pbe.isActive=true;
            pbe.Pricebook2Id=Constants.STANDARD_PRICEBOOK_ID; 
            pbe.Product2Id=p.Id;
            pbe.UnitPrice=10;
            listPBE.add(pbe);
        }
        return listPBE;
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
        //  with all of the required fields populated.
        List<Account> listAcc=new List<Account>();
        for(Integer n=0;n<cnt;n++)
        {
            Account a=new Account();
            a.Name='TEST1_'+n;
            listAcc.add(a);
        }
        
        return listAcc;
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Contact> contactList = new List<Contact>();

        for(Integer i=0; i<cnt; i++){
            Contact c = new Contact();
            c.LastName = 'Last Name ' + i;
            c.AccountId = accts[i].Id;
            contactList.add(c);
        }

        return contactList;
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Order> orderList = new List<Order>();
        for(Integer i = 0; i < cnt; i++){
            orderList.add(new Order(EffectiveDate = System.Today(), AccountId = accts[i].Id, Status = 'Draft', Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID));
        }
        return orderList;
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
        List<OrderItem> orderItemList = new List<OrderItem>();
        for(Integer i=0; i < cnt; i++){
            orderItemList.add(new OrderItem(OrderId = ords[i].id, PriceBookEntryId =pbes[i].id, UnitPrice = pbes[i].UnitPrice, Quantity = Constants.DEFAULT_ROWS));
        }
        return orderItemList;
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static void InsertTestData(Integer cnt){
        //ToDo: Ensure this method calls each of the construct methods
        //  and inserts the results for use as test data.
        CollaborationGroup colG=ConstructCollaborationGroup();
        insert colG;
        
        List<Account> a=ConstructAccounts(cnt);
        insert a;
        
        List<Contact> c=ConstructContacts(cnt, a);
        insert c;
        
        List<Product2> p= ConstructProducts(cnt);
        insert p;
        
        List<PriceBookEntry> pbe = ConstructPricebookEntries(p);
        insert pbe;
       
        List<Order> o=ConstructOrders(cnt, a);
        insert o;
       
       
        List<OrderItem> oi=ConstructOrderItems(cnt, pbe, o);
        insert oi;
    }

}