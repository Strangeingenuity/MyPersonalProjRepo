public class Fridge 
{
    Private String modelNumber;
    Private Integer numberInStock;
    public static Integer stockThreshold = 5;
    
    public void updateStock(Integer justSold)     
            {
            numberInStock = numberInStock - justSold;
            }
    Public Void SetModelNum(string themodelnum)
            {
            modelNumber = themodelnum;    
            }

    Public String GetModelNum()
            {
            return(modelNumber);   
            }
            
    Public Fridge (){
            modelNumber = 'XFGHY099';
            numberInStock = 0;    
    }       
    
    Public Fridge(String themodelnum, integer thenuminstock){
          modelNumber = themodelnum ;
          numberInStock= thenuminstock ;
          
           
    }        
            
}