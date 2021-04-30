

import UIKit
import Firebase
import FirebaseStorage

class CellClassset : UITableViewCell{
    
}

class insertfooditem: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var categorybtn: UIButton!
    @IBOutlet weak var fooddescrip: UITextField!
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var swich: UISwitch!
    
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    let transparentView = UIView()
    let tableview = UITableView()
    var selectedbtn = UIButton()
    
    var datasourceforcategory :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
         
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CellClassset.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        datasourceforcategory.removeAll()
     
        let db = Firestore.firestore()
        let docRef = db.collection("category")

        docRef.getDocuments { (snapshot, error) in
            if error != nil
            {
                print("error")
            }
            else
            {

                for document in (snapshot?.documents)!
                {

                    let dd=document.data()
                    let name = dd["name"] as! String
                   

                    self.datasourceforcategory.append(name)


                }



            }
            
            self.tableview.reloadData()


        }
    }
    
    
    
    
    
    @IBAction func uploadimage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
       present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imagedata = image.pngData() else {
            return
        }
     
        
            
        self.image.image = UIImage(data: imagedata)
        
        
        
                
            
        }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(tableview)
        tableview.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        tableview.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0.5
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(self.datasourceforcategory.count * 50))
        } completion: { (true) in
            
        }


    }
    
    @objc func removeTransparentView(){
        
        let frames = selectedbtn.frame
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.transparentView.alpha = 0
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            
        } completion: { (Bool) in
            
        }
        
    }
    
    func validationset() -> String? {
        if name.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || fooddescrip.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || price.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || discount.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return ""
        }
        else
        {
            return " fields empty"
        }
        
    }
    
    
    
    @IBAction func addevent(_ sender: Any) {
        
        
        if validationset() != ""
        {
            
            if(categorybtn.titleLabel?.text == "Category")
            {
                let alert = UIAlertController(title: "Failure", message: " select category", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                     })
                     alert.addAction(ok)
                self.present(alert, animated: true)
            }
            else
            {
                
                var active : Bool = false
                
                if swich.isOn
                {
                    active = true
                }
                else
                {
                    active = false
                }
                
                let db = Firestore.firestore()
                let ref2 =  db.collection("Food").document()
                let discountver = Float(discount.text!)
                let sellprice = Float(price.text!)
                
                
                ref2.setData(["Name":name.text!,"active":active,"category":categorybtn.titleLabel?.text!,"description":fooddescrip.text,"dicid":ref2.documentID,"discount":discountver ,"price":sellprice,"id":ref2.documentID]) { (err) in
                    if err != nil{
                        
                    }
                    else
                    {
                        
                        let storage = Storage.storage().reference()
                        
                        let path:String = "foodimages/" + ref2.documentID + ".png"
                        
                        storage.child(path).putData((self.image.image?.pngData())!, metadata: nil) { (_, Error) in
                            if Error != nil
                            {
                                print("erro")
                            }
                            else
                            {
                                
                                
                            }
                        }
                        
                        
                        
                        
                        
                        
                        let alert = UIAlertController(title: "Succesfully", message: "Data inserted", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                             })
                             alert.addAction(ok)
                        self.present(alert, animated: true)
                    }
                }
                
                
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "Failure", message: " field empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
        
        
    }
    
    
    
    @IBAction func addcategory(_ sender: Any) {
        
      
        selectedbtn = categorybtn
        
        addTransparentView(frames: categorybtn.frame)
    }
    

   

}

extension insertfooditem : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceforcategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = datasourceforcategory[indexPath.row]
        cell.backgroundColor = .yellow
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorybtn.setTitle(datasourceforcategory[indexPath.row], for: .normal)
        removeTransparentView()
    }
    
}
