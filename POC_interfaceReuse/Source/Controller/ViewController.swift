//
//  ViewController.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.

import UIKit

class ViewController: UITableViewController {

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
        let doneItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(chooseImageAction)
        )
        navigationItem.rightBarButtonItem = doneItem

        tableView = TableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")
                as? ImageTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")

        }
        cell.button.tag = indexPath.row
        cell.button.addTarget(
            self,
            action: #selector(chooseImageAction),
            for: .touchUpInside
        )
        if (form == .petLocal) {
            cell.configureCell(isHorizontal: false)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderTableView()
    }
}
