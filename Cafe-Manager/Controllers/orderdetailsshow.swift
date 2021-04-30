

import UIKit
import Firebase

class orderdetailsshow: UIViewController {
    
    @IBOutlet weak var customername: UILabel!
    @IBOutlet weak var statusbtn: UIButton!
    
    @IBOutlet weak var callbtn: UIButton!
    
    @IBOutlet weak var orderdtlsview: UIView!
    
    var customer : String = ""
    var status : Int = 0
    var docid : String = ""
    var orderid : String = ""
    var tel : String = ""
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customername.text = customer + "(" + orderid + ")"
        statusbtn.setTitle(String(status), for: .normal)
        
        orderdtlsview.layer.borderWidth = 1.0
        orderdtlsview.layer.borderColor = UIColor.darkGray.cgColor
        orderdtlsview.backgroundColor = .white
        orderdtlsview.layer.shadowColor = UIColor.gray.cgColor
        orderdtlsview.layer.shadowOpacity = 0.4
        orderdtlsview.layer.shadowOffset = CGSize.zero
        orderdtlsview.layer.shadowRadius = 6
        
        
        

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for subview in self.orderdtlsview.subviews {
            
               subview.removeFromSuperview()
            
        }
        
        var cons : CGFloat = 50
            let docRef = db.collection("orderonece").document(docid)
        
        docRef.getDocument { (document, error) in
            if let document = document,document.exists{
                
                let dd = document.data()
                let totalfind = dd!["totalAmount"] as! Float
                
               
                let ts =  dd!["dateTime"]  as! Timestamp
                let aDate = ts.dateValue()
                let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss aa"
                    let formattedTimeZoneStr = formatter.string(from: aDate)
                
                let date = UILabel()
                
                date.textAlignment = .center
                date.text = formattedTimeZoneStr
                date.textColor = UIColor.black
                self.orderdtlsview.addSubview(date)
                date.translatesAutoresizingMaskIntoConstraints = false
                date.leftAnchor.constraint(equalTo: self.orderdtlsview.leftAnchor, constant: 10).isActive = true
                date.topAnchor.constraint(equalTo: self.orderdtlsview.topAnchor, constant: 5).isActive = true
                
                
                let docorderdtl = self.db.collection("orderdetails")
                
                docorderdtl.whereField("orderid", isEqualTo: self.docid).getDocuments { (snap, error) in
                    
                    if error != nil
                    {
                        print("error")
                    }
                    else
                    {
                        
                        for element in (snap?.documents)! {
                            let data = element.data()
                            
                            let item = UILabel()
                            
                            item.textAlignment = .center
                            item.text = data["Name"] as? String
                            item.textColor = UIColor.black
                            self.orderdtlsview.addSubview(item)
                            item.translatesAutoresizingMaskIntoConstraints = false
                            item.leftAnchor.constraint(equalTo: self.orderdtlsview.leftAnchor, constant: 30).isActive = true
                            item.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                            
                            
                            let qty = data["qty"] as? Int
                            let singleprice = data["unitprice"] as? Int
                            
                            let convertstrinprice = String(singleprice!)
                            let convertstrinqty = String(qty!)
                            
                            let final = convertstrinqty + " X " + "Rs." + convertstrinprice
                            
                            let price = UILabel()
                            
                            price.textAlignment = .center
                            price.text = final
                            price.textColor = UIColor.black
                            self.orderdtlsview.addSubview(price)
                            price.translatesAutoresizingMaskIntoConstraints = false
                            price.rightAnchor.constraint(equalTo: self.orderdtlsview.rightAnchor, constant: -30).isActive = true
                            price.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons).isActive = true
                            
                            cons = cons + 50
                        }
                        
                        
                        
                        let total = UILabel()
                        let totget = String("TOTAL: Rs." + String(totalfind))
                        total.textAlignment = .center
                        total.text = totget
                        total.textColor = UIColor.black
                        self.orderdtlsview.addSubview(total)
                        total.translatesAutoresizingMaskIntoConstraints = false
                        total.rightAnchor.constraint(equalTo: self.orderdtlsview.rightAnchor, constant: -30).isActive = true
                        total.topAnchor.constraint(equalTo: date.bottomAnchor, constant: cons + 5).isActive = true
                        
                        
                        
                        
                        
                    
                        
                        
                        
                        
                    }
                }
                
                
                
                
               
            }
        }
    }
    
    
    @IBAction func call(_ sender: Any) {
        
        guard let url = URL(string: "telprompt://\(tel)"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

    

}
