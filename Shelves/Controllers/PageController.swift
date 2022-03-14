//
//  PageViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    let picker = UIImagePickerController()
    public var pageIndex: Int = 0
    private var notebook: Notebook = Notebook()
    weak var parentPageViewController: UIPageViewController?
    
    func setupPage() {
        parentPageViewController?.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(addImage)), animated: false)
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let button = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(addImage))
        navigationItem.setRightBarButton(button, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        save(page?.editor?.html)
    }
    
    @objc
    func addImage() {
        openGallary()
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
            page?.editor?.insertImage(imagePath!.absoluteString, alt: "<Image>")
        } catch {
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
