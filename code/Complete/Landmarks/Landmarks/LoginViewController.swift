//
//  LoginViewController.swift
//  Landmarks

import SwiftUI
import UIKit

struct LoginViewController: UIViewControllerRepresentable {
    
    let navController =  UINavigationController()
    
    
    func makeUIViewController(context: Context) -> UINavigationController {
        navController.setNavigationBarHidden(true, animated: false)
        let viewController = UIViewController()
        navController.addChild(viewController)
        return navController
    }

    func updateUIViewController(_ pageViewController: UINavigationController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LoginViewController

        init(_ loginViewController: LoginViewController) {
            self.parent = loginViewController
        }
    }
    
    func authenticate() {
        let app = UIApplication.shared.delegate as! AppDelegate
        //app.authenticateWithDropinUI(navigationController: navController)
        app.authenticateWithHostedUI(navigationController: navController)
    }
    
}
