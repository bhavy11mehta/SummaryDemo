//
//  DocumentPicker.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI
import MobileCoreServices // Import MobileCoreServices for file type identification
import PDFKit

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var documentContent: String
    @Binding var selectedFileName: String
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // Update UI if needed
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let selectedFileURL = urls.first {
                // Retrieve file name with extension
                if let pdf = PDFDocument(url: selectedFileURL) {
                    let pageCount = pdf.pageCount
                    let content = NSMutableAttributedString()
                    for i in 0 ..< pageCount {
                        guard let page = pdf.page(at: i) else { continue }
                        guard let pageContent = page.attributedString else { continue }
                        content.append(pageContent)
                    }
                    parent.documentContent = content.string
                    parent.selectedFileName = selectedFileURL.lastPathComponent
                }
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // Handle cancellation if needed
        }
    }
}


