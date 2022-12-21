//
//  EditingViewController.swift
//  photoEditor
//
//  Created by shelley on 2022/12/14.
//

import UIKit

class EditingViewController: UIViewController, UIColorPickerViewControllerDelegate {

    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var selectedPhotoImageView: UIImageView!
    
    @IBOutlet weak var mirrowRotate: UIButton!
    @IBOutlet weak var turnLeftRotate: UIButton!
    @IBOutlet weak var sizeRatioSegmentControl: UISegmentedControl!
    
    var image:UIImageView!
    
//    init? (coder:NSCoder, image:UIImageView){
//        self.image = image
//        super.init(coder: coder)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    向左轉的次數
    var turnLeft = 0
//    鏡像轉的次數
    var mirrowFlip = 1
    
    
//    func setImageViewSize(){
//        imageBackgroundView.bounds.size = CGSize(width: 390, height: 475)
//        selectedPhotoImageView.bounds.size = imageBackgroundView.bounds.size
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedPhotoImageView.image = image.image
//        setImageViewSize()
        sizeRatioSegmentControl.isHidden = true
        mirrowRotate.isHidden = true
        turnLeftRotate.isHidden = true
    }
//    顯示翻轉按鈕
    @IBAction func showRotate(_ sender: Any) {
        mirrowRotate.isHidden = false
        turnLeftRotate.isHidden = false
        print("打開")
    }
//    改變照片方向，鏡像翻轉，利用scale調整，Ｘ是左右，Ｙ是上下
    @IBAction func mirrowFlip(_ sender: Any) {
        mirrowFlip *= -1
        let oneDegree = CGFloat.pi / 180
        selectedPhotoImageView.transform = CGAffineTransform(scaleX: CGFloat(mirrowFlip), y: 1)
        print("轉一次")
    }
//    改變照片方向，向左轉
    @IBAction func rotatePhotoFromLeft(_ sender: Any) {
        turnLeft += 1
        let oneDegree = CGFloat.pi / 180
        selectedPhotoImageView.transform = CGAffineTransform(rotationAngle: (oneDegree * -90) * CGFloat(turnLeft))
    }

    //    顯示照片調整大小的按鈕
    @IBAction func photoSizeAdjust(_ sender: UIButton) {
        sizeRatioSegmentControl.isHidden = false
    }
//    改變照片比例
    @IBAction func sizeRatioChange(_ sender: UISegmentedControl) {
        let length = imageBackgroundView.frame.width
        let width = length
        var height: Int
        
        switch sizeRatioSegmentControl.selectedSegmentIndex{
        case 0:  //原圖
            height = Int(Double(length) / 4.75 * 3.9)
        case 1:
            height = Int(length / 1 * 1)
        case 2:
            height = Int(length / 16 * 9)
        case 3:
            height = Int(length / 4 * 3)
        default:
            height = Int(Double(length) / 4.75 * 3.9)
        }
        imageBackgroundView.bounds.size = CGSize(width: Int(width), height: height)
        selectedPhotoImageView.frame.size = imageBackgroundView.frame.size

    }
    //    改變背景顏色
    @IBAction func colorChange(_ sender: Any) {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        imageBackgroundView.backgroundColor = color
        dismiss(animated: true, completion: nil)
    }
//    儲存照片
    @IBAction func savePhoto(_ sender: Any) {
//    利用 UIGraphicsImageRenderer 將 view 變成 UIImage
        let renderer = UIGraphicsImageRenderer(size: imageBackgroundView.bounds.size)
//     function image(actions:) 產生圖片, drawHierarchy(in:afterScreenUpdates:)繪製成圖片，讓 imageBackgroundView 和它的 subview 出現在圖片裡
        let image = renderer.image(actions: { context in imageBackgroundView.drawHierarchy(in: imageBackgroundView.bounds, afterScreenUpdates: true) })
//     UIActivityViewController 分享圖片
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
