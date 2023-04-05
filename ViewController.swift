

import UIKit

class ViewController: UIViewController , UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        view.addSubview(button)
        view.addSubview(label)
        UNUserNotificationCenter.current().delegate = self

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 70),
            button.widthAnchor.constraint(equalToConstant: 70),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -30),
//            label.heightAnchor.constraint(equalToConstant: 60),
//            label.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        button.addTarget(self, action: #selector(showNotification), for: .touchUpInside)
        
        let dismiss = UNNotificationAction(
            identifier: "dismiss",
            title: "Dismiss",
            options: [])
        let accept = UNNotificationAction(
            identifier: "accept",
            title: "Accept",
            options: [])
        
        let category = UNNotificationCategory(
            identifier: "category",
            actions: [dismiss, accept],
            intentIdentifiers: [],
            options: [.customDismissAction])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])

    }
    
    let label : UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Touch the button below..."
        l.textColor = .black
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 24)
        return l
    }()
    
    let button : UIButton = {
        let b = UIButton()
        b.backgroundColor = .white
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(">‼️<", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        b.setTitleColor(.black, for: .normal)
        b.setTitleColor(.black.withAlphaComponent(0.5), for: .highlighted)
        return b
    }()
    
    let content : UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.body = "This is a local notification"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "category"
        return content
    }()
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
    
    @objc func showNotification(buttons : UIButton)
    {
        
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {
            (error) in
            if error != nil{
                print("error")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionid = response.actionIdentifier

            switch actionid {
            case "dismiss":
                print("Dismiss button tapped")
            case "accept":
                print("Accept button tapped")
            default:
                break
            }

            completionHandler()
    }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            completionHandler([.banner, .sound, .badge])
            
        }
}

