import UIKit

class BitView: UIView {
    
    func configure(forBit bit: Int) {
        bitDescriptionLabel.text = "\(Int(pow(2, Double(bit))))"
    }
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 5
        return sv
    }()
    
    private lazy var bitSwitch: UISwitch = {
        let s = UISwitch()
        s.isOn = false
        return s
    }()
    
    private lazy var bitDescriptionLabel: UILabel = {
        let lab = UILabel()
        lab.text = "0"
        return lab
    }()
    
    private lazy var bitValueLabel: UILabel = {
        let lab = UILabel()
        lab.text = "0"
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(bitValueLabel)
        stackView.addArrangedSubview(bitSwitch)
        stackView.addArrangedSubview(bitDescriptionLabel)
    }
    
    private func configureConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
