

import UIKit
import FirebaseAuth
import Firebase

class UserRegViewController: UIViewController {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func regevent(_ sender: Any) {
        
        
        if mail.text != "" && tel.text != "" && password.text != "" {
            
            Auth.auth().createUser(withEmail: mail.text!, password: password.text!) { (result, err) in
                if err != nil {
          
                    let alert = UIAlertController(title: "failure", message: "false", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
                else
                {
                    let db = Firestore.firestore()
                  
                    let ref =  db.collection("User")
                    
          
                    
                    
                    ref.addDocument(data: ["phone" :self.tel.text!,"UID" : result!.user.uid ,"email": result!.user.email!]) { (erro) in
                        if erro != nil
                        {
                         print(erro)
                        }
                        else
                        {
                          
                          
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homesection") as! UITabBarController

                                self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                }
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "failure", message: "required feild empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    

}
