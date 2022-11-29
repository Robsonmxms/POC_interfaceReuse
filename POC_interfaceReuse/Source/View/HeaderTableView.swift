//
//  HeaderTableView.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.
//

import UIKit

class HeaderTableView: UIView {

    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .max
        label.text = "Textinho qualquer"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderTableView: ViewCodeConfiguration {
    func buildHierarchy() {
        self.addSubview(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(
                equalTo: self.heightAnchor
            ),
            label.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.9
            ),
            label.centerXAnchor.constraint(
                equalTo: self.centerXAnchor
            )
        ])
    }

    func configureViews() {
        self.backgroundColor = .clear
    }

}
