import UIKit

class ViewController: UIViewController {

    @IBOutlet var bitViewsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBitViews()
    }
    
    func loadBitViews() {
        var views = [BitView]()
        for i in (0...7).reversed() {
            let bitView = BitView()
            bitView.configure(forBit: i)
            views.append(bitView)
        }
        views.forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
            bitViewsStackView.addArrangedSubview($0)
//            $0.widthAnchor.constraint(equalTo: $0.superview!.widthAnchor, multiplier: 0.08).isActive = true
        }
    }
}

