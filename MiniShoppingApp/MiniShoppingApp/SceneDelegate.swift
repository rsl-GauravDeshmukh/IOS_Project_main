//
//  SceneDelegate.swift
//  MiniShoppingApp
//
//  Created by Gaurav Deshmukh on 11/04/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let deeplinkURLSchema = "minishoppingapp"
    let settingPageLinkURLHost = "mycart"
    let historyPageLinkURLHost = "account"
    var firstVC:UINavigationController!
    var secondVC:UINavigationController!
    var thirdVC:UINavigationController!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let tabBarController = UITabBarController()

        let firstViewController = UINavigationController(rootViewController: ViewController())
        firstViewController.view.backgroundColor = .white
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)

        let secondViewController = UINavigationController(rootViewController: CartViewController())
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "cart"), selectedImage: nil)

        let thirdViewController = UINavigationController(rootViewController: AccountViewController())
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "person"), selectedImage: nil)

        firstVC = firstViewController
        secondVC = secondViewController
        thirdVC = thirdViewController

        tabBarController.viewControllers = [firstVC, secondVC, thirdVC]

        tabBarController.tabBar.barTintColor = .gray

        window = UIWindow(windowScene: windowScene)

        // Check if there is a deep link URL present in the connection options
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    
    func viewController(for url: URL?) -> (UIViewController, Int)? {
        guard let url = url, url.scheme == deeplinkURLSchema else { return nil }

        var desiredViewController: UIViewController?
        var tabIndex: Int?

        if let host = url.host {
            print("url host is \(host)")
        }

        if url.host == settingPageLinkURLHost {
            desiredViewController = CartViewController()
            tabIndex = 1
        } else if url.host == historyPageLinkURLHost {
            desiredViewController = AccountViewController()
            tabIndex = 2
        } else {
            print("Unhandled URL: \(url)")
        }

        if let desiredViewController = desiredViewController, let tabIndex = tabIndex {
            return (desiredViewController, tabIndex)
        } else {
            return nil
        }
    }

    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        if let (desiredViewController, tabIndex) = viewController(for: url) {
            if let tabBarController = self.window?.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = tabIndex
                if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                    navigationController.popToRootViewController(animated: false)
                    navigationController.pushViewController(desiredViewController, animated: false)
                                            }
            }
        }
}


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

