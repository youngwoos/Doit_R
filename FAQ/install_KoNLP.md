
## KoNLP 패키지 설치하기

현재 `KoNLP` 패키지가 CRAN에서 삭제된 상태라 `install.packages()`를 이용해 설치할 수 없습니다. 아래
코드를 순서대로 실행하면 깃헙 버전 `KoNLP` 패키지를 설치할 수 있습니다.

#### 1\. java와 rJava 설치

``` r
install.packages("multilinguer")
library(multilinguer)
install_jdk()
```

#### 2\. KoNLP 의존성 패키지 설치

``` r
install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")
```

#### 3\. 깃헙 버전 KoNLP 설치

``` r
install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP", 
                        upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))
```

#### 참고

[KoNLP 설치 이슈 공유,
박찬엽](https://www.facebook.com/notes/r-korea-krugkorean-r-user-group/konlp-설치-이슈-공유/1847510068715020/)
