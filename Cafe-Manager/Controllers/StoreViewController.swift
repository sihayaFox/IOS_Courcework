

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var firstview: UIView!
    
    @IBOutlet weak var secondview: UIView!
    
    
    @IBOutlet weak var thview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstview.alpha = 1
        secondview.alpha = 0
        thview.alpha = 0

        // Do any additional setup after loading the view.
    }
    
   
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    @IBAction func swichViews(_ sender: UISegmentedControl){
        
       
      
        
        if sender.selectedSegmentIndex == 0 {
            
            firstview.alpha = 1
            secondview.alpha = 0
            thview.alpha = 0
            
            
         
        }
        
        if sender.selectedSegmentIndex == 1 {
            secondview.alpha = 1
            firstview.alpha = 0
            thview.alpha = 0
            
        }
        
        if sender.selectedSegmentIndex == 2
        {
            secondview.alpha = 0
            thview.alpha = 1
            firstview.alpha = 0
            
            
            
        }
        
        
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
