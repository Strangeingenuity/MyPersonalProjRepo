Public with sharing Class HotelPageController extends HotelCommunityController{

    Public Hotel__c Hotel{get;set;}
    Public List<HotelCommunityService.HotelNewsItem> hotelNews{get;set;}
        
    Public HotelPageController(){
        Hotel = HotelCommunityService.getHotel(contact.Hotel__C);
        hotelNews = HotelCommunityService.getHotelNews(contact.Hotel__c);
      }    
    
    
}