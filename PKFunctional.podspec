Pod::Spec.new do |s|
    s.name                = "PKFunctional"
    s.version             = "0.1.3"
    s.summary             = "Functional extensions to Foundation classes."
    s.description         = "Adds a very light touch of higher-order functions to Foundation's classes."
    s.homepage            = "http://github.com/pkluz/PKFunctional"
    s.license             = "MIT"
    s.author              = "Philip Kluz"
    s.source              = { :git => "https://github.com/pkluz/PKFunctional.git", :tag => "v#{s.version}" }
    s.requires_arc        = true
    s.platform            = :ios, "8.0"
    s.source_files        = "PKFunctional/**/*.{h,m}"
    s.framework           = "Foundation"
end
