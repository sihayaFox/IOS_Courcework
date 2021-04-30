

import UIKit
import Firebase

class orderViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    let db = Firestore.firestore()
    var orderdtlmain :[orderdtl] = []
    var globleorder : [orderdtl] = []
    var globle2 : [orderdtl] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        orderdtlmain.removeAll()
        globleorder.removeAll()
      
        let docRef = db.collection("orderonece")

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
                    let cusname = dd["cusname"] as! String
                    let docid = dd["docid"] as! String
                    let userid = dd["userId"] as! String
                    let status = dd["status"] as! Int
                    let section = dd["section"] as! String
                    let phone = dd["cusphone"] as! String
                    let orderno = dd["orderNo"] as! String
                    

                    let order = Cafe_Manager.orderdtl(cusname: cusname, docid: docid, userid: userid, status: status,section: section,orderno: orderno,cusphone: phone)

                    self.orderdtlmain.append(order)


                }



            }
            
            self.tableview.reloadData()


        }
    }
    
    
    
    
    func approveorder(docid:String){
        
        
        let updateshowstatus = db.collection("orderonce").document(docid)
        
        
        updateshowstatus.updateData(["section":"0","status":2]) { (error) in
            if error != nil
            {
               print(error)
            }
            else
            {
                print("updated")
            }
        }
        
        viewWillAppear(true)
        
    }
    
    
    func rejectorder(docid:String){
        
        db.collection("orderonece").document(docid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        viewWillAppear(true)
        
    }
    

   
}

extension orderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let viewController = storyboard?.instantiateViewController(withIdentifier: "orderdetailsshow") as! orderdetailsshow
        viewController.customer = globle2[indexPath.row].customername
        viewController.status = globle2[indexPath.row].status
        viewController.docid = globle2[indexPath.row].docid
        viewController.orderid = globle2[indexPath.row].orderno
        viewController.tel = globle2[indexPath.row].customerphone
        
        self.navigationController?.pushViewController(viewController, animated: true)
       
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var filter : [orderdtl] = []
        
        if section == 1
        {
            filter = orderdtlmain.filter{($0.section.contains("1"))}
            globleorder = filter
        }
        
        else
        {
            filter = orderdtlmain.filter{($0.section.contains("0"))}
            globle2 = filter
        }
        
        return filter.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! ordercellTableViewCell
        
        var filter : [orderdtl] = []
        let section = String( indexPath.section)
        
        filter = orderdtlmain.filter{($0.section.contains(section))}
       
        
        let orr = filter[indexPath.row]
        
        cell.setorder(order: orr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        
        let Reject = UIContextualAction(style: .normal, title: "Reject") { (action, view, completionHandler) in
            
            self.rejectorder(docid: self.globleorder[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        Reject.backgroundColor = .red
        
        let Accept = UIContextualAction(style: .normal, title: "Accept") { (action, view, completionHandler) in
            
            self.approveorder(docid: self.globleorder[indexPath.row].docid)
            self.tableview.reloadData()
            
        }
        Accept.backgroundColor = .green
        
        
        if indexPath.section == 1
        {
        
        let swipe = UISwipeActionsConfiguration(actions: [Reject,Accept])
            return swipe
        }
        
        else
        {
        let swipe = UISwipeActionsConfiguration(actions: [])
            return swipe
        }
       
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Ready "
        }
        else
        {
            return "New "
        }
    }
    
    
    
    
    
}
