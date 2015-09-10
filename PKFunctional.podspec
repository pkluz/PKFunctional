Pod::Spec.new do |s|
    s.name                = "PKFunctional"
    s.version             = "0.1.0"
    s.summary             = "Functional extensions to Foundation classes."
    s.description         = <<-DESC
                                Adds a very light touch of higher order functions to Foundations classes.
                            DESC
    s.homepage            = "http://github.com/pkluz/PKFunctional"
    s.license             = "MIT"
    s.author              = "Philip Kluz"
    s.source              = { :git => "https://github.com/pkluz/PKFunctional.git", :tag => "v#{s.version}" }
    s.default_subspec     = 'Core'
    s.requires_arc        = true
    s.platform            = :ios, "8.0"
    s.header_mappings_dir = "."

    s.source_files = 'PKFunctional/**/*.{h,m}'
    s.framework = 'Foundation'

    s.subspec 'Core' do |ss|
        ss.source_files     = "PKFunctional/**/*.{c,h,m}"
        ss.frameworks       = "Foundation"
    end
end
