
맥에서 ggiraphExtra 패키지 설치 중 오류가 발생할 경우
-----------------------------------------------------

OS X 10.6.3 이상 버전에서 `ggiraphExtra`를 설치하면 아래와 같은 에러 메시지가 출력되면서 `ggiraphExtra`의 의존 패키지인 `ggiraph`가 설치되지 않는 문제가 발생합니다.

    Error in dyn.load(file, DLLpath = DLLpath, ...) : 
      unable to load shared object '/Library/Frameworks/R.framework/Versions/3.4/Resources/library/gdtools/libs/gdtools.so':
      dlopen(/Library/Frameworks/R.framework/Versions/3.4/Resources/library/gdtools/libs/gdtools.so, 6): Library not loaded: /opt/X11/lib/libcairo.2.dylib
      Referenced from: /Library/Frameworks/R.framework/Versions/3.4/Resources/library/gdtools/libs/gdtools.so
      Reason: image not found
    ERROR: lazy loading failed for package ‘ggiraph’
    * removing ‘/Library/Frameworks/R.framework/Versions/3.4/Resources/library/ggiraph’
    Warning in install.packages :
      installation of package ‘ggiraph’ had non-zero exit status

이런 경우 [R 맥 버전 다운로드 페이지](http://cran.nexr.com/bin/macosx/)에서 XQuartz를 다운받아 설치하고 재부팅 한 후 다시 `ggiraphExtra`를 설치하면 됩니다. 아래 링크로도 다운받을 수 있습니다.

-   <https://www.xquartz.org/>
