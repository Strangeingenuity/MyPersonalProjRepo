Public class StoreFrontController {
        List<DisplayMerchandise> Products;
        List<DisplayMerchandise> ShoppingCart = new List<DisplayMerchandise>();
        
        
        
        
        
        
       Public List<DisplayMerchandise> getproducts(){
              if(Products == Null)
                {
                Products = new List<DisplayMerchandise>();
                for(merchandise__C Item: [SELECT Id, Name, Description__c, Price__c, Total_Inventory__c
                                            FROM Merchandise__c]) {
                    Products.add(new DisplayMerchandise(Item) );
                    }//End of For
                }//End of If
                return Products;
        
        
        
    }//End of Function
  
    Public Class DisplayMerchandise {
       Private Merchandise__C merchandise;
       Public DisplayMerchandise (Merchandise__C Item){
              this.merchandise = Item;
                               
       }//End of Function         
        
        Public String Name {
            get {return merchandise.Name;}
        }
                
       public String description {
get { return merchandise.Description__c; }
}
        
        Public Decimal Price{
            get {return merchandise.Price__C;}               
        }
        
        Public Boolean inStock{
                get{return(0<merchandise.Total_Inventory__C);}
        
        }//End Of class
        Public Integer qtyToBuy {get; set;}
      }
}