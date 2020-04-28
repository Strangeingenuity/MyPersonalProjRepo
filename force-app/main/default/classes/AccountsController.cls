public class AccountsController {
   @AuraEnabled
   public static List<Account> getAccounts() {
       //Case11222 code changes completed 
       //Some more code changes were meanwhile done in the master branch

       return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode
       FROM Account ORDER BY createdDate ASC];
   }   
}