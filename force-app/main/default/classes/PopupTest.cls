public with sharing class PopupTest {
     public List<Account> getAccounts(){
     
        List<Account> accounttList = new List<Account>();
        accounttList = [Select Id, Name, Website from Account LIMIT 10];
            return accounttList;
        }
}