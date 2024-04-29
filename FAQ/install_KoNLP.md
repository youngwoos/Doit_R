
## KoNLP 패키지 설치하기

#### 1. 자바 설치하기

`KoNLP` 패키지는 ’자바’가 설치되어 있어야 사용할 수 있습니다. Amazon
Corretto를 이용하면 자바를 손쉽게 설치할 수 있습니다. 다음 페이지에
접속해 운영체제에 맞는 설치 파일을 다운로드하여 설치합니다.

- Amazon Corretto 11 다운로드 페이지 <https://bit.ly/download_corretto>

웹페이지의 ’플랫폼’을 보면 운영체제 이름과 비트(x64 또는 x86)가 표시되어
있습니다. 윈도우 사용자는 msi, 맥 사용자는 pkg 파일을 다운로드하면
됩니다. 설치할 때는 설정을 변경하지 말고 \[Next\]와 \[Install\] 버튼을
클릭해 설치하세요.

사용하는 운영체제를 알아보려면 R에서 `sessionInfo()`를 실행해 `Platform`
부분을 확인하면 됩니다. 비트(bit)는 맨 마지막 괄호에 표시됩니다.

#### 2. KoNLP 의존성 패키지 설치

어떤 패키지는 다른 패키지의 기능을 이용하기 때문에 다른 패키지를 함께
설치해야만 작동합니다. 이처럼 패키지가 의존하고 있는 패키지를 ’의존성
패키지’라고 합니다. `KoNLP` 패키지를 사용하려면 의존성 패키지들을 먼저
설치해야 합니다.

``` r
install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")
```

#### 3. `KoNLP` 패키지 설치하기

`remotes` 패키지의 `install_github()`를 이용해 깃허브(github)에 있는
`KoNLP` 패키지를 설치합니다.

``` r
install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP", 
                        upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))
```

`KoNLP` 패키지가 이미 설치되어 있으면
`...has not changed since last install` 이라는 메시지가 출력됩니다.
이때는 `install_github()`에 `force = T`를 입력하면 패키지를 강제로 다시
설치합니다.

#### 4. `scala-library-2.11.8.jar`파일 다운로드하기

다음 코드를 실행해 `scala-library-2.11.8.jar`파일을 다운로드해서 `KoNLP`
패키지 설치 폴더 안에 삽입합니다.

``` r
download.file(
  url = "https://github.com/youngwoos/Doit_R/raw/master/Data/scala-library-2.11.8.jar",
  destfile = paste0(.libPaths()[1], "/KoNLP/Java/scala-library-2.11.8.jar"))
```

#### 5. 형태소 사전 설정하기

`KoNLP` 패키지가 사용하는 ’NIA 사전’은 120만여 개 단어로 구성되어
있습니다. 형태소 분석을 할 때 NIA 사전을 사용하도록 `useNIADic()`을
실행합니다.

``` r
library(KoNLP)
useNIADic()
```

    ## Backup was just finished!
    ## 1213109 words dictionary was built.

#### 6. KoNLP 실행 확인

`KoNLP` 패키지가 잘 작동하는지 확인합니다.

``` r
extractNoun("대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다.")
```

    ## [1] "대한민국" "주권"     "국민"     "권력"     "국민"
