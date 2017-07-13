#### 15-1 ####

## -------------------------------------------------------------------- ##
exam <- read.csv("csv_exam.csv")

exam[]    # 조건 없이 전체 데이터 출력
exam[1,]  # 1행 추출
exam[2,]  # 2행 추출


## -------------------------------------------------------------------- ##
exam[exam$class == 1,]  # class가 1인 행 추출
exam[exam$math >= 80,]  # 수학점수가 80점 이상인 행 추출

# 1반 이면서 수학점수가 50점 이상
exam[exam$class == 1 & exam$math >= 50,]

# 영어점수가 90점 미만이거나 과학점수가 50점 미만
exam[exam$english < 90 | exam$science < 50,]


## -------------------------------------------------------------------- ##
exam[,1]  # 첫 번째 열 추출
exam[,2]  # 두 번째 열 추출
exam[,3]  # 세 번째 열 추출


## -------------------------------------------------------------------- ##
exam[, "class"]  # class 변수 추출
exam[, "math"]   # math 변수 추출

exam[,c("class", "math", "english")]  # class, math, english 변수 추출


## -------------------------------------------------------------------- ##
# 행, 변수 모두 인덱스
exam[1,3]

# 행 인덱스, 열 변수명
exam[5, "english"]

# 행 부등호 조건, 열 변수명
exam[exam$math >= 50, "english"]

# 행 부등호 조건, 열 변수명
exam[exam$math >= 50, c("english", "science")]


## -------------------------------------------------------------------- ##
exam$tot <- (exam$math + exam$english + exam$science)/3
aggregate(data=exam[exam$math >= 50 & exam$english >= 80,], tot~class, mean)

exam %>%
  filter(math >= 50 & english >= 80) %>%
  mutate(tot = (math + english + science)/3) %>%
  group_by(class) %>%
  summarise(mean = mean(tot))


#### 15-2 ####

## -------------------------------------------------------------------- ##
var1 <- c(1,2,3,1,2)          # numeric 변수 생성
var2 <- factor(c(1,2,3,1,2))  # factor 변수 생성

var1  # numeric 변수 출력
var2  # factor 변수 출력

var1+2  # numeric 변수로 연산
var2+2  # factor 변수로 연산

class(var1)
class(var2)

levels(var1)
levels(var2)

var3 <- c("a", "b", "b", "c")          # 문자 변수 생성
var4 <- factor(c("a", "b", "b", "c"))  # 문자로 된 factor 변수 생성

var3
var4

class(var3)
class(var4)

mean(var1)
mean(var2)


## -------------------------------------------------------------------- ##
var2 <- as.numeric(var2)  # numeric 타입으로 변환
mean(var2)                # 함수 재적용
class(var2)               # 타입 확인
levels(var2)              # 범주 확인


#### 15-3 ####

## -------------------------------------------------------------------- ##
# 벡터 만들기
a <- 1
a

b <- "hello"
b

# 데이터 구조 확인 
class(a)
class(b)


# 데이터 프레임 만들기
x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a","b","c"))
x1

# 데이터 구조 확인
class(x1)


# 매트릭스 만들기 - 1~12로 2열
x2 <- matrix(c(1:12), ncol = 2)
x2

# 데이터 구조 확인
class(x2)


# array 만들기 - 1~20으로 2행 x 5열 x 2차원
x3 <- array(1:20, dim = c(2, 5, 2))
x3

# 리스트 생성 - 앞에서 생성한 데이터 구조 활용
x4 <- list(f1 = a,   # 벡터
           f2 = x1,  # 데이터 프레임
           f3 = x2,  # 매트릭스
           f4 = x3)  # 어레이
x4

# 데이터 구조 확인
class(x4)


mpg <- ggplot2::mpg
x <- boxplot(mpg$cty)
x

x$stats[,1]     # 요약 통계량 추출
x$stats[,1][3]  # 중앙값 추출
x$stats[,1][2]  # 1분위수 추출


## -------------------------------------------------------------------- ##

## 1.데이터 추출하기
exam[1,]                                  # 행 번호로 행 추출
exam[exam$class == 1,]                    # 조건을 충족하는 행 추출
exam[exam$class == 1 & exam$math >= 50,]  # 여러 조건을 충족하는 행 추출

exam[,1]                                  # 열 번호로 변수 추출
exam[, "class"]                           # 변수명으로 변수 추출
exam[,c("class", "math", "english")]      # 변수명으로 여러 변수 추출
exam[1,3]                                 # 행, 변수 동시 추출 - 인덱스
exam[exam$math >= 50, "english"]          # 행, 변수 동시 추출 - 조건문, 변수명


## 2.변수 타입
var <- c(1,2,3,1,2)                   # numeric 변수 만들기
var <- factor(c(1,2,3,1,2))           # factor 변수 만들기
var <- factor(c("a", "b", "b", "c"))  # 문자로 구성된 factor 변수 만들기
 
class(var)                            # 변수 타입 확인하기
levels(var)                           # factor 변수의 구성 범주 확인
var <- as.numeric(var)                # factor 타입을 numeric 타입으로 변환하기


## 3.데이터 구조
a <- 1                                   # 벡터 만들기
b <- "hello"

x1 <- data.frame(var1 = c(1,2,3),        # 데이터 프레임 만들기
                 var2 = c("a","b","c"))

x2 <- matrix(c(1:12), ncol = 2)          # 매트릭스 만들기

x3 <- array(1:20, dim=c(2, 5, 2))        # 어레이 만들기

x4 <- list(f1 = a,                       # 리스트 만들기
           f2 = x1,
           f3 = x2,
           f4 = x3)

# 리스트 활용하기
x <- boxplot(mpg$cty)  # 상자 그림 만들기
x$stats[,1]            # 요약 통계량 추출

