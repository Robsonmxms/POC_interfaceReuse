//
//  ImageTableViewCell.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    private var isHorizontal: Bool = true

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "vertical")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar Imagem", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var heightAnchorHorizontalTrue = { image.heightAnchor.constraint(
        equalTo: stack.widthAnchor,
        multiplier: 0.65
    )
    }()

    lazy var widthAnchorHorizontalTrue = {
        image.widthAnchor.constraint(
            equalTo: stack.widthAnchor,
            multiplier: 0.9
        )
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        applyViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(isHorizontal: Bool = true) {
        self.isHorizontal = isHorizontal
        self.imageConstraints()
    }
}

extension ImageTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(button)
        contentView.addSubview(stack)
    }

    func setupConstraints() {
        stackConstraints()
        imageConstraints()
        buttonConstraints()
    }

    func stackConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            stack.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            stack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
    }

    func imageConstraints() {

        if isHorizontal {
            NSLayoutConstraint.activate([
                heightAnchorHorizontalTrue,
                widthAnchorHorizontalTrue
            ])
        } else {
            NSLayoutConstraint.deactivate([
                heightAnchorHorizontalTrue,
                widthAnchorHorizontalTrue
            ])

            NSLayoutConstraint.activate([
                image.heightAnchor.constraint(
                    equalTo: stack.widthAnchor,
                    constant: 0.9
                ),
                image.widthAnchor.constraint(
                    equalTo: stack.widthAnchor,
                    multiplier: 0.65
                )
            ])
        }
    }

    func buttonConstraints() {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 170)
        ])
    }

    func configureViews() {
        self.backgroundColor = .clear
    }
}
