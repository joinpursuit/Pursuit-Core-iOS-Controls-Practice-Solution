import UIKit

class ViewController: UIViewController {

    @IBOutlet var decimalTextField: UITextField!
    @IBOutlet var binaryTextField: UITextField!
    @IBOutlet var bitViewsStackView: UIStackView!
    
    var bitViews = [BitView]()
    
    var currentValue: UInt8 = 0 {
        didSet {
            updateBitViews()
            decimalTextField.text = "\(currentValue)"
            binaryTextField.text = currentValue.paddedBinaryRepresentation
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decimalTextField.delegate = self
        binaryTextField.delegate = self
        loadBitViews()
        currentValue = 1
    }
    
    func loadBitViews() {
        for i in (0...7).reversed() {
            let bitView = BitView()
            bitView.configure(forBit: i, withDelegate: self)
            bitViews.append(bitView)
        }
        bitViews.forEach { bitViewsStackView.addArrangedSubview($0) }
    }
    
    func updateBitViews() {
        let binaryRepresentationOfCurrentValue = Array(currentValue.paddedBinaryRepresentation).map { $0 == "1" ? true : false }
        for (bitIndex, view) in bitViews.enumerated() {
            view.setBit(to: binaryRepresentationOfCurrentValue[bitIndex])
        }
    }
}

extension ViewController: BitViewDelegate {
    func bitDidChangeValue(at bit: Int, to newValue: Bool) {
        let flippedBitVal = UInt8(NSDecimalNumber(decimal: pow(2, bit)).intValue)
        currentValue ^= flippedBitVal
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            guard updatedText != "" else {
                currentValue = 0
                return true
            }
            let newValue: UInt8
            switch textField {
            case decimalTextField:
                guard let val = UInt8(updatedText, radix: 10), textIsValidDecimal(updatedText) else { return false }
                newValue = val
            case binaryTextField:
                guard let val = UInt8(text, radix: 2), textIsValidBinary(updatedText) else { return false }
                newValue = val
            default: fatalError("Unknown text field")
            }
            currentValue = newValue
        }
        return false
    }
    
    func textIsValidDecimal(_ str: String) -> Bool {
        guard let val = Int(str) else { return false }
        return val > -1 && val < 256
    }
    func textIsValidBinary(_ str: String) -> Bool {
        guard let val = Int(str, radix: 2) else { return false }
        return val > -1 && val < 256
    }
}

extension UInt8 {
    var paddedBinaryRepresentation: String {
        var str = String(self, radix: 2)
        while str.count < 8 {
            str = "0\(str)"
        }
        return str
    }
}
