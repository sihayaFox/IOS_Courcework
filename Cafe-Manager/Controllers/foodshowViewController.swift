

import UIKit
import Firebase
import FirebaseStorage

class foodshowViewController: UIViewController {
    
    @IBOutlet weak var foodtableview: UITableView!
    
    var foodlist : [fooddetails] = []
    var categorylist : [category] = []
    var fooditemlist : [fooditem] = []
  //firebase get
    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        foodtableview.delegate = self
        foodtableview.dataSource = self
       
        
        
     
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        categorylist.removeAll()
        fooditemlist.removeAll()
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
            
            self.foodtableview.reloadData()


        }
        
        
        let docRef2 = db.collection("Food")
     
        docRef2.getDocuments { (snapshot, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
               
                for document in (snapshot?.documents)!
                {
                   
                    let dd=document.data()
                    let name = dd["Name"] as! String
                     let discrip = dd["description"] as! String
                     let price = dd["price"] as! Float
                     let discount = dd["discount"] as! Int
                     let foodId = dd["id"] as! String
                     let docid = dd["dicid"] as! String
                    let categoryname = dd["category"] as! String
                    let active = dd["active"] as! Bool
                     
                   
                     
                     
                     
                     let foodget = Cafe_Manager.fooditem(Name:name,discription: discrip,price: price,discount: discount,id: foodId,documentId: docid,category: categoryname,active: active)
                     
                     self.fooditemlist.append(foodget)
                    
                    
                    
   
                }
                self.foodtableview.reloadData()
                
                
                
            }
            
            
        }
        
        
    }
    
   
   
    

}

extension foodshowViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
    
    
}

extension foodshowViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return categorylist.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var filterd : [fooditem] = []
        filterd = fooditemlist.filter{($0.category.contains(categorylist[section].name))}
        return filterd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = foodtableview.dequeueReusableCell(withIdentifier: "cell") as! foodshowcell
        
        var filterd : [fooditem] = []
        
        filterd = fooditemlist.filter{($0.category.contains(categorylist[indexPath.section].name))}
        
        let foods = filterd[indexPath.row]
        cell.setfood(food: foods)
       
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorylist[section].name
    }
    
    
    
    
    
    
    
    
    
}


