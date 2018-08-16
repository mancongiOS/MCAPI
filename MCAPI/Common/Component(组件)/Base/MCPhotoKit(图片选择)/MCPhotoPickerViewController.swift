import UIKit
import Photos
import PhotosUI

/* 屏幕宽度 */
let screenWidth  = UIScreen.main.bounds.width
/* 屏幕高度 */
let scrrenHeight = UIScreen.main.bounds.height


class MCPhotoPickerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    //四、实例如下
    //1、列出系统所有的相册，并获取每一个相册中的PHAsset对象
    func fetchAllSystemAblum() -> Void {
        let smartAlbums:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        print("智能\(smartAlbums.count)个")
        
        //smartAlbums中保存的是各个智能相册对应的PHAssetCollection
        for i in 0..<smartAlbums.count {
            
            //获取一个相册(PHAssetCollection)
            let collection = smartAlbums[i]
            
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                
                //赋值
                let assetCollection = collection
                
                //从每一个智能相册获取到的PHFetchResult中包含的才是真正的资源(PHAsset)
                let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                
                print("\(assetCollection.localizedTitle)相册,共有照片数:\(assetsFetchResults.count)")
                
                assetsFetchResults.enumerateObjects({ (asset, i, nil) in
                    //获取每一个资源(PHAsset)
                    print("\(asset)")
                })
            }
        }
    }
    
    //2、列出用户创建的相册，并获取每一个相册中的PHAsset对象，代码如下：
    func fetchAllUserCreatedAlbum() -> Void {
        let topLevelUserCollections:PHFetchResult = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        //topLevelUserCollections中保存的是各个用户创建的相册对应的PHAssetCollection
        print("用户创建\(topLevelUserCollections.count)个")
        
        for i in 0...topLevelUserCollections.count {
            
            //获取一个相册(PHAssetCollection)
            let collection = topLevelUserCollections[i]
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                
                //类型强制转换
                let assetCollection = collection as! PHAssetCollection
                
                
                //从每一个智能相册中获取到的PHFetchResult中包含的才是真正的资源(PHAsset)
                let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                
                print("\(assetCollection.localizedTitle)相册，共有照片数:\(assetsFetchResults.count)")
                
                assetsFetchResults.enumerateObjects({ (asset, i, nil) in
                    //获取每一个资源(PHAsset)
                    print("\(asset)")
                })
            }
        }
    }
    
    
    //3、获取所有资源的集合，并按资源的创建时间排序
    func getAllSourceCollection() -> Array<PHAsset> {
        
        let options:PHFetchOptions = PHFetchOptions.init()
        var assetArray = [PHAsset]()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        let assetFetchResults:PHFetchResult = PHAsset.fetchAssets(with: options)
        for i in 0..<assetFetchResults.count {
            //获取一个资源(PHAsset)
            let asset = assetFetchResults[i]
            
            //添加到数组
            assetArray.append(asset)
        }
        return assetArray
    }
    
    
    //4、获取缩略图方法
    func getAssetThumbnail(asset:PHAsset) -> Void {
        
        //获取缩略图
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions() //可以设置图像的质量、版本、也会有参数控制图像的裁剪
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize.init(width: screenWidth/4, height: scrrenHeight/4), contentMode: .aspectFit, options: option) { (thumbnailImage, info) in
            
            print("缩略图:\(thumbnailImage),图像信息：\(info)")
        }
    }
    
    //5、获取原图的方法
    func getAssetOrigin(asset:PHAsset) -> Void {
        
        //获取原图
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions() //可以设置图像的质量、版本、也会有参数控制图像的裁剪
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize:PHImageManagerMaximumSize, contentMode: .aspectFit, options: option) { (originImage, info) in
            
            print("原图:\(originImage),图像信息：\(info)")
        }
    }
}

