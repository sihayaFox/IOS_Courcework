
import UIKit

class ordercellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var customername: UILabel!
    
  
    @IBOutlet weak var statusbtn: UIButton!
    
    @IBOutlet weak var orderid: UILabel!
    
    
    
    func setorder(order:orderdtl) {
        
        
        customername.text = order.customername
        
        orderid.text = "Order No : " + order.orderno
        
        
        if order.status == 1
        {
            statusbtn.setTitle("Need an Approval", for: .normal)
        }
        
        if order.status == 2
        {
            statusbtn.setTitle("Accepted", for: .normal)
        }
        
        
      
       
    }
    
}
