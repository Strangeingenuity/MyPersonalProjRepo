Public with sharing Class RoomsPageController extends HotelCommunityController{

    Public List<Room__c> hotelRooms {get;set;}
    
    Public RoomsPageController(){
    
        super();
        String hotelId = ApexPages.currentPage().getParameters().get('hotelId');
        hotelRooms = HotelCommunityService.getRooms(hotelId);
    
    
    }





}