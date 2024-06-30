import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State private var selectedImage: UIImage?
    @Binding var name: String
    @Binding var birthDate: String
    @Binding var disabilityLevel: String
    @State private var photosPickerItem: PhotosPickerItem?

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("이미지를 선택하세요")
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
            }
            
            PhotosPicker(
                selection: $photosPickerItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("이미지 선택")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .onChange(of: photosPickerItem) { newItem in
                if let item = newItem {
                    loadImage(from: item)
                }
            }
            
            Button(action: {
                if let image = selectedImage {
                    uploadImage(image)
                }
            }) {
                Text("서버로 이미지 전송")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text("이름: \(name)")
            Text("생년월일: \(birthDate)")
            Text("장애정도: \(disabilityLevel)")
        }
        .padding()
    }
    
    func loadImage(from item: PhotosPickerItem) {
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                }
            }
        }
    }
    
    func uploadImage(_ image: UIImage) {
        // Upload logic remains unchanged
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(name: .constant(""), birthDate: .constant(""), disabilityLevel: .constant(""))
    }
}
