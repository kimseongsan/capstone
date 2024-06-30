//
//  ImageUploader.swift
//  ThreadsAppSwiftUI
//
//  Created by HardiB.Salih on 5/14/24.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    
    // Uploads an image to Firebase Storage with an optional compression quality.
    //
    // - Parameters:
    //   - image: The UIImage to upload.
    //   - compressionQuality: The compression quality of the image. Default is 0.25.
    //
    // - Returns:
    //   A String representing the download URL of the uploaded image. Returns nil if there's an error during the upload process.
    //
    // - Throws:
    //   An error if there's a problem with the asynchronous operation.
    static func uploadImage(_ image: UIImage, compressionQuality: CGFloat? = 0.25) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: compressionQuality ?? 0.25) else {
            throw UploadError.invalidImageData
        }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            throw UploadError.uploadFailed(error)
        }
    }
    
    enum UploadError: Error {
        case invalidImageData
        case uploadFailed(Error)
    }
}


