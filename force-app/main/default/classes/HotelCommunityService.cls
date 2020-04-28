Public Class HotelCommunityService{

    Public Static Id getUserId(){
        return UserInfo.getUserId();
     }

    Public Static Contact getContact(Id UserId){
        Contact c = null;
        User u = [SELECT Id, ContactId FROM User where Id =: UserId];
        if(u!=null && u.ContactId != null)
            { 
            c = [SELECT Id, Hotel_Name__c, Hotel_Img__c, Text_Color__c, Hotel__C from Contact where Id = :u.contactId];
         }
         
        return c;    
     }
     
     
    Public Static Hotel__C getHotel(Id hotelId){
        Hotel__C hotel = null;
        if(hotelId!=null){
        hotel = [SELECT Id, Name, Home_Page_Text__C,Text_Color__C from Hotel__c where Id = : hotelId];
        //Background_Image__c, Home_page_Image__c
        }
        return hotel;
    
    } 
     
    Public Static List<HotelNewsItem> getHotelNews(Id hotelId){
        List<HotelNewsItem> newsList = new List<HotelNewsItem>{};
        if(hotelId != null)
        {
            for(Hotel_News__c hn:[SELECT Id, Name, Content__C, Title__c, CreatedDate From Hotel_News__C 
                                    Where Hotel__C = :hotelId
                                    ORDER By CreatedDate DESC]){
                                    
               HotelNewsItem hni = new HotelNewsItem(hn);
               newsList.add(hni);                     
                                    
               }
       }
   
       return newsList;
   }
   
   Public Static List<Room__C>  getRooms(Id hotelId){
       List<Room__C> hotelRooms = new List<Room__C>();
       
       if(hotelId !=null){
       
           for(Room__C room : [SELECT Id, Name, Description__C, Price__C,Preview_Room_Image__c
                           FROM Room__C where Hotel__C =: hotelId
                           ORDER By Price__C]){
           
               hotelRooms.add(room);
            }
       }
       return hotelRooms;
   }
   
   Public Class HotelNewsItem{
    Private Hotel_News__c news;
    Public HotelNewsItem(Hotel_News__c item) {this.news = item;}
    
    Public string id{get {return news.id;} }
    public string name { get {return news.Name;} }
    Public string title { get {return news.Title__C;} }
    public string content {get {return news.content__C;} }
    
    Public string createDate{
        get{
            return news.CreatedDate.format('MM/dd/yyyy');
        }
        
    }

}
   
   
   
     
   
}