

import UIKit
import FirebaseStorage

class foodshowcell: UITableViewCell {

    @IBOutlet weak var foodimage: UIImageView!
    
  
    
    @IBOutlet weak var discription: UILabel!
    
    @IBOutlet weak var Name: UILabel!
    
   
    @IBOutlet weak var swich: UISwitch!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func setfood(food:fooditem) {
        Name.text = food.Name
        discription.text = food.discription
        price.text =  "Rs "+String( food.price )
        if food.discount == 0
        {
            discount.text = String( food.discount)
            discount.isHidden = true
        }
        else
        {
        discount.text = String( food.discount) + "%Discount"
            discount.isHidden = false
        }
        
        
   
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let pathforphotos = "foodimages/"+food.id+".png"
        
       
        let formattedString = pathforphotos.replacingOccurrences(of: " ", with: "")
        let islandRef = storageRef.child(formattedString)
        
        islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if error != nil {
           print("bad")
          } else {
          
            let image = UIImage(data: data!)
            self.foodimage.image = image
            
            
          }
        }
        
        
        
        

        
        
        
            
        
    }
}
