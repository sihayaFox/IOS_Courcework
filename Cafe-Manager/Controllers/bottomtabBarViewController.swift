

import UIKit

class bottomtabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTabWidth: CGFloat = self.tabBar.frame.size.width / CGFloat((self.tabBar.items?.count)!)
        let singleTabSize = CGSize(width:singleTabWidth , height: self.tabBar.frame.size.height)

        let selectedTabBackgroundImage: UIImage = self.imageWithColor(color: .yellow, size: singleTabSize)
        self.tabBar.selectionIndicatorImage = selectedTabBackgroundImage
        
        

        
    }
    
    
    func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()

            context!.setFillColor(color.cgColor)
            context!.fill(rect)

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return image!
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
