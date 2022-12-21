//
//  PickerViewController.swift
//  photoEditor
//
//  Created by shelley on 2022/12/14.
//

import UIKit

class PickerViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
//    func selectPhoto(_ sender: Any) {
//        let controller = UIImagePickerController()
//        controller.sourceType = .photoLibrary
//        controller.delegate = self
//        present(controller, animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage //轉型成UIImage型別
        imageView.image = image
        
//      選完照片後離開
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Select Photo", message:nil, preferredStyle: .actionSheet)
        
        let cancelController = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelController)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { _ in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        present(alertController, animated: true, completion: nil)
            
        
    }
    
    @IBSegueAction func photoEdit(_ coder: NSCoder) -> EditingViewController? {
        let controller = EditingViewController(coder: coder)
        controller?.image = imageView
        return controller
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let editingViewController = segue.destination as? EditingViewController,
//           let image = sender as? UIImageView {
//            editingViewController.image = image
//        }
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
