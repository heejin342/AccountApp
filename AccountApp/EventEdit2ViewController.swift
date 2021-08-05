import UIKit

class EventEdit2ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var priceTF: UITextField!
    
    private var observer: NSObjectProtocol?

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        datePicker.date = selectedDate
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil,queue: .main)
        {
                [] notification in
            
//                let viewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
//                if let view = viewControllerName {
//                    self.present(view, animated: true, completion: nil)
//                }
            
//                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "WeeklyViewController")
//                self.navigationController?.pushViewController(pushVC!, animated: true)
            
            
                let weeklyViewController = self.storyboard?.instantiateViewController( withIdentifier: "WeeklyViewController") as! WeeklyViewController
                weeklyViewController.minusMoney = 0
                weeklyViewController.plusMoney = 0
                self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func saveAction(_ sender: Any) {

        let newEvent = Event()
            
        newEvent.type = "출금"
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        newEvent.money = priceTF.text
        
        
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)

        }

}
