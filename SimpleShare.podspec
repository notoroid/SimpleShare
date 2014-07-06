Pod::Spec.new do |s|
  s.name         = "SimpleShare"
  s.version      = "0.8.2"
  s.summary      = "SimpleShare provides a user interface for sharing the image."
  
  s.description  = <<-DESC
                   SimpleShare Provides a simple UI for photo-sharing Be. As a shared location, and then corresponding SNS Instagram, Twitter, such as Facebook, the image transmission by e-mail or messenger. support iOS7 SDK or later.
                   DESC

  s.homepage     = "https://github.com/notoroid/SimpleShare"
  s.screenshots  = "https://raw.githubusercontent.com/notoroid/SimpleShare/master/Screenshots/ss00.png", "https://raw.githubusercontent.com/notoroid/SimpleShare/master/Screenshots/ss01.png", "https://raw.githubusercontent.com/notoroid/SimpleShare/master/Screenshots/ss02.png"


  s.license      = "The MIT License (MIT)"

  s.author             = { "notoroid" => "noto@irimasu.com" }
  s.social_media_url   = "http://twitter.com/notoroid"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/notoroid/SimpleShare.git", :tag => "v0.8.2",:submodules => true }
  s.dependency 'LineKit'
  s.dependency 'UIImage+BlurredFrame'
  s.source_files  = "Lib/**/*.{h,m}"
  s.public_header_files = "Lib/**/*.h"
  s.resources = "Lib/*.{xib,storyboard}"
  s.frameworks = "QuartzCore", "AssetsLibrary", "Social", "Accounts", "MessageUI", "MobileCoreServices"
  s.requires_arc = true
    
end
