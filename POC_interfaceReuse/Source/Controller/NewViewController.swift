//
//  NewViewController.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 29/11/22.
//

import UIKit

class NewViewController: UIViewController {

    private var form: Form?

    init(_ form: Form) {
        self.form = form
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
