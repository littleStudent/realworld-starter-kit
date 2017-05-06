import UIKit


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let personalFeedViewController = PersonalFeedViewController()
        let personalFeedBarItem = UITabBarItem(title: "Personal", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        personalFeedViewController.tabBarItem = personalFeedBarItem
        
        
        let globalNavigationBarController = UINavigationController()
        let globalFeedViewController = GlobalFeedViewController()
        let globalFeedBarItem = UITabBarItem(title: "Global", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        globalNavigationBarController.tabBarItem = globalFeedBarItem
        globalNavigationBarController.viewControllers = [globalFeedViewController]
        
        self.viewControllers = [globalNavigationBarController, personalFeedViewController]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
