//
//  ViewController.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.

import UIKit
import Photos
import PhotosUI

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
        if indexPath.row == 0 {
            return buildCell(indexPath)
        } else {
            let cell = buildCell(indexPath)
            cell.configureCell(isHorizontal: false)
            return cell
        }
    }

    func buildCell(_ indexPath: IndexPath) -> ImageTableViewCell {
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
        return cell
    }
}

extension ViewController {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderTableView()
    }

    @objc func chooseImageAction(sender: UIButton!) {

        tableView.tag = sender.tag

        let alertVC = UIAlertController(
            title: "Escolha uma imagem",
            message: "Escolha uma imagem da biblioteca ou câmera",
            preferredStyle: .actionSheet
        )

        let cameraAction: UIAlertAction = buildCameraAction()
        let libraryAction: UIAlertAction = buildLibraryAction()
        let cancelAction = UIAlertAction(
            title: "Cancelar",
            style: .cancel
        )

        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)

        self.present(alertVC, animated: true)

    }

    func buildCameraAction() -> UIAlertAction {
        let cameraAction = UIAlertAction(
            title: "Câmera",
            style: .default
        ) { [weak self] (_) in
            guard let self = self else {return}
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true)

        }
        return cameraAction
    }

    func buildLibraryAction() -> UIAlertAction {
        let libraryAction = UIAlertAction(
            title: "Galeria",
            style: .default
        ) { [weak self] (_) in
            guard let self = self else {return}
            var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
            phPickerConfig.selectionLimit = 1
            phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
            let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
            phPickerVC.delegate = self
            self.present(phPickerVC, animated: true)
        }
        return libraryAction
    }

    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    func changeImage(_ image: UIImage) {
        let indexPath = IndexPath(row: tableView.tag, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell else {
            fatalError("Could not convert TableViewCell in IMageTableViewCell")
        }
        cell.image.image = image
        tableView.reloadData()
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Could not load image from CameraPicker")
        }
        changeImage(image)
        self.dismiss(animated: true)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
         picker.dismiss(animated: true, completion: .none)
         results.forEach { result in
               result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
               guard let image = reading as? UIImage, error == nil else { return }
               DispatchQueue.main.async {
                   self.changeImage(image)
               }
          }
       }
  }
}
