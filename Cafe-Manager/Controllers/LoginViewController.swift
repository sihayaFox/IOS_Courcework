

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    func validationfunction() -> String? {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return ""
        }
        else
        {
            return "bad request"
        }
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        if validationfunction() != ""
        {
            
            let emailget = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordget = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
           
            
            Auth.auth().signIn(withEmail: emailget, password: passwordget) { (Result, Error) in
                if Error != nil
                {
                    let alertshow = UIAlertController(title: "Authentication false", message: "Invalid UserName Password", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                    alertshow.addAction(ok)
                    self.present(alertshow, animated: true)
                }
                else
                {
                    UserDefaults.standard.set(Result?.user.uid, forKey: "userId")
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homesection") as! UITabBarController

                        self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            
            
            
        }
        else
        {
            let alert = UIAlertController(title: "Authetication false", message: "Required field empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    
    

}
