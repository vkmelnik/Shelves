//
//  PageViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit
import RichEditorView

class PageController: UIViewController {
    
    var page: Page?
    let picker = UIImagePickerController()
    public var pageIndex: Int = 0
    private var notebook: Notebook = Notebook()
    weak var parentPageViewController: UIPageViewController?
    var cameraButton: UIBarButtonItem?
    var doneButton: UIBarButtonItem?
    
    func setupPage() {
        
        let page = Page()
        page.setHtml(html: notebook.pages[pageIndex])
        view.addSubview(page)
        page.pin(to: view)
        self.page = page
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.prefersLargeTitles = false
        picker.delegate = self
        setupPage()
        
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(addImage))
        parentPageViewController?.navigationItem.setRightBarButton(cameraButton, animated: false)
        self.cameraButton = cameraButton
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneEditing))
        self.doneButton = doneButton
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        parentPageViewController?.navigationItem.setRightBarButton(doneButton, animated: false)
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        parentPageViewController?.navigationItem.setRightBarButton(cameraButton, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save(page?.editor?.contentHTML)
    }
    
    @objc
    func addImage() {
        openGallary()
    }
    
    @objc
    func doneEditing() {
        view.endEditing(true)
    }
    
    func openGallary() {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func save(_ html: String?) {
        notebook.pages[pageIndex] = html ?? ""
        NotebookController.saveNotebook(notebook: notebook)
    }
    
    func insertImage(editor: RichEditorView, src: String, width: Int? = nil, height: Int? = nil, alt: String = "") {
        let finalWidth = width == nil ? "auto" : "\(width!)px"
        let finalHeight = height == nil ? "auto" : "\(height!)px"
        editor.html += "<img src=\"\(src)\" alt=\"\(alt)\" style=\"width: \(finalWidth); height: \(finalHeight); max-width: 90%;\" /><br />"
        editor.runJS("RE.focus()") // Move cursor to a newly added line
    }
    
    convenience init(pageIndex: Int, notebook: Notebook, parent: UIPageViewController?) {
        self.init()
        self.pageIndex = pageIndex
        self.notebook = notebook
        self.parentPageViewController = parent
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

extension PageController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        do {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let folderURL = documentsPath?.appendingPathComponent("\(notebook.name)")
            let folderExists = (try? folderURL!.checkResourceIsReachable()) ?? false
            if !folderExists {
                try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: false)
            }
            let imagePath = folderURL?.appendingPathComponent("Image_\(image.hash).png")
            try image.pngData()?.write(to: imagePath!)
            insertImage(editor: (page?.editor)!, src: imagePath!.absoluteString)
        } catch {
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
