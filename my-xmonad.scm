(define-module (my-xmonad)
 #:use-module (gnu packages wm)
 #:use-module (gnu packages haskell-xyz)
 #:use-module (gnu packages xorg)
 #:use-module (guix gexp)
 #:use-module (guix git-download)
 #:use-module (guix packages)
 #:use-module (guix utils)
 #:use-module (ice-9 popen)
 #:use-module (ice-9 rdelim)
 #:use-module (ice-9 regex))

(define-public my-xmonad
  (package
   (inherit xmonad)
   (name "my-xmonad")
   (version "0.0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ravensiris/my-xmonad")
           (commit "master")))
            (sha256
              (base32 "1jhm7ddcp1a4fhb1z1cbrgwn4gxb0w1ja45lr9kx4jy1i9189abx"))
            (file-name (git-file-name name version))))
          (inputs
            `(("libxpm" ,libxpm)
              ("xmonad" ,xmonad)
              ("ghc-random" ,ghc-random)
              ("ghc-uuid" ,ghc-uuid)
              ("ghc-xmonad-contrib" ,ghc-xmonad-contrib)))
          (arguments
            `(#:phases
              (modify-phases %standard-phases
               (add-after 'install 'make-static
                (lambda* (#:key outputs #:allow-other-keys)
                 (mkdir-p (assoc-ref outputs "static"))))
               (delete 'install-license-files))))))
