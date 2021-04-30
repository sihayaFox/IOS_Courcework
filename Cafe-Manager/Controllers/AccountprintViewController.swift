

import UIKit
import Firebase

class AccountprintViewController: UIViewController {

    @IBOutlet weak var datefrom: UIDatePicker!
    
    
    @IBOutlet weak var dateTo: UIDatePicker!
    
    @IBOutlet weak var detailsshowview: UIView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datefrom.datePickerMode = .date
        dateTo.datePickerMode = .date
        
       

       
    }
    

    @IBAction func eventsearchbtn(_ sender: Any) {
        
        var place : CGFloat = 30
        db.collection("orderdetails").whereField("dateTime", isGreaterThanOrEqualTo:  datefrom.date).whereField("dateTime",isLessThanOrEqualTo:dateTo.date).getDocuments { (snap, error) in
            
            if error != nil
            {
                print("error")
            }
            else
            {
                
               
                    for element in (snap?.documents)! {
                        let data = element.data()
                        
                       
                        let foodname =  data["Name"]  as! String
                        let fodqty = data["qty"] as! Int
                        let foodunitprice = data["unitprice"] as! Float
                        
                        
                        let name = UILabel()

                        name.textAlignment = .center
                        name.text = foodname
                        name.textColor = UIColor.black
                        self.detailsshowview.addSubview(name)
                        name.translatesAutoresizingMaskIntoConstraints = false
                        name.leftAnchor.constraint(equalTo: self.detailsshowview.leftAnchor, constant: 30).isActive = true
                        name.topAnchor.constraint(equalTo: self.detailsshowview.topAnchor, constant: place).isActive = true
                        
                        var finalqty :String = String(fodqty) + " * " + String(foodunitprice)
                        
                        let Qty = UILabel()

                        Qty.textAlignment = .center
                        Qty.text = finalqty
                        Qty.textColor = UIColor.black
                        self.detailsshowview.addSubview(Qty)
                        Qty.translatesAutoresizingMaskIntoConstraints = false
                        Qty.rightAnchor.constraint(equalTo: self.detailsshowview.rightAnchor, constant: -30).isActive = true
                        Qty.topAnchor.constraint(equalTo: self.detailsshowview.topAnchor, constant: place).isActive = true
                        
                        
                        place = place + 100
                        
                        
                        
                        
                        
                    }
                    
                
                
               
                
                
                
                
                
                        
                
                
                
                
                
            
                
                
                
                
            }
                    
                    
        }
        
    }
    
    
    
    @IBAction func printallbtnevent(_ sender: Any) {
        
        let info = UIPrintInfo(dictionary: nil)
    info.outputType = UIPrintInfo.OutputType.general
    info.jobName = "Print"
    
    let print = UIPrintInteractionController.shared
        print.printInfo = info
        print.printingItem = detailsshowview.converttoimage()
        print.present(from: self.view.frame, in: self.view, animated: true, completionHandler: nil)
    }
    
}




extension UIView {
    func converttoimage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let imageconverted = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageconverted!
    }
}
