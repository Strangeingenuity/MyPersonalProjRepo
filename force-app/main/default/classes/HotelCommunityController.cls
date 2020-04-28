Public abstract with sharing class HotelCommunityController{

    Public Contact contact{get;set;}
    
    Public HotelCommunityController(){
           contact = HotelCommunityService.getContact(HotelCommunityService.getUserId());
    
    }

}