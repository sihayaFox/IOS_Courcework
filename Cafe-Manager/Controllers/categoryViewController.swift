

import UIKit
import Firebase


class categoryViewController: UIViewController {

    @IBOutlet weak var categoryname: UITextField!
    
    
    @IBOutlet weak var tableview: UITableView!
    var categorylist : [category] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        categorylist.removeAll()
      
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
                    let id = dd["id"] as! String

                    let category = Cafe_Manager.category(id: id, name: name)

                    self.categorylist.append(category)


                }



            }
            
            self.tableview.reloadData()


        }
       
        
    }
    
    
   
    
    func validation() -> String? {
        if categoryname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return ""
        }
        else
        {
            return "Requeire fields empty"
        }
        
    }
    
    
    @IBAction func addcategory(_ sender: Any) {
        
        if validation() != ""
        {
        
        
        
        let ref2 =  db.collection("category").document()
        
        ref2.setData(["id":ref2.documentID,"name":categoryname.text!]) { (err) in
            if err != nil{
                
            }
            else
            {
                let alert = UIAlertController(title: "Succesfully", message: "Data Inserted", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                     })
                     alert.addAction(ok)
                self.present(alert, animated: true)
                
                self.categoryname.text = ""
                self.viewWillAppear(true)
            
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
    
    

    

}


extension categoryViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categorylist.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = categorylist[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete category") { (action, view, completionHandler) in
            print(self.categorylist[indexPath.row].id)
            
            self.db.collection("category").document(self.categorylist[indexPath.row].id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            self.viewWillAppear(true)
        }
        delete.backgroundColor = .red
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        
        return swipe
    }
    
    
}
