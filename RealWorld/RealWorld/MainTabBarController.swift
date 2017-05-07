import UIKit


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var provider: ServiceProviderType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    init(provider: ServiceProviderType) {
        super.init(nibName: nil, bundle: nil)
        self.provider = provider
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let personalFeedViewController = PersonalFeedViewController()
        let personalFeedBarItem = UITabBarItem(title: "Personal", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        personalFeedViewController.tabBarItem = personalFeedBarItem
        
        
        let globalNavigationBarController = UINavigationController()
        let globalFeedViewController = GlobalFeedViewController(provider: provider)
        let globalFeedBarItem = UITabBarItem(title: "Global", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        globalNavigationBarController.tabBarItem = globalFeedBarItem
        globalNavigationBarController.viewControllers = [globalFeedViewController]
        
        self.viewControllers = [globalNavigationBarController, personalFeedViewController]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
