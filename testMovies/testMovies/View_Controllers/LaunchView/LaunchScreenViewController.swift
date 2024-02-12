import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add your animation code here
        animateLogo()
    }

    func animateLogo() {
        // Implement your logo animation here
        // Example: Rotate the logo
        UIView.animate(withDuration: 2.0, animations: {
            self.view.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            // Transition to the main view controller after the animation
            self.transitionToMainViewController()
        }
    }

    func transitionToMainViewController() {
        // Perform the transition to your main view controller
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryboard.instantiateInitialViewController()
        UIApplication.shared.windows.first?.rootViewController = mainViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
