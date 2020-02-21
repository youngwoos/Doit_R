#### 07-1 ####

## -------------------------------------------------------------------- ##
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

is.na(df)               # 결측치 확인
table(is.na(df))        # 결측치 빈도 출력
table(is.na(df$sex))    # sex 결측치 빈도 출력
table(is.na(df$score))  # score 결측치 빈도 출력

mean(df$score)  # 평균 산출
sum(df$score)   # 합계 산출


## -------------------------------------------------------------------- ##
library(dplyr)                # dplyr 패키지 로드
df %>% filter(is.na(score))   # score가 NA인 데이터만 출력
df %>% filter(!is.na(score))  # score 결측치 제거

df_nomiss <- df %>% filter(!is.na(score))  # score 결측치 제거
mean(df_nomiss$score)                      # score 평균 산출
sum(df_nomiss$score)                       # score 합계 산출

df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))  # score, sex 결측치 제거
df_nomiss                                                # 출력

df_nomiss2 <- na.omit(df)  # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2                 # 출력


## -------------------------------------------------------------------- ##
mean(df$score, na.rm = T)  # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T)   # 결측치 제외하고 합계 산출

exam <- read.csv("csv_exam.csv")  # 데이터 불러오기
exam[c(3, 8, 15), "math"] <- NA   # 3, 8, 15행의 math에 NA 할당
exam

exam %>% summarise(mean_math = mean(math))  # math 평균 산출

# math 결측치 제외하고 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))  

exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출


## -------------------------------------------------------------------- ##
mean(exam$math, na.rm = T) # 결측치 제외하고 math 평균 산출

exam$math <- ifelse(is.na(exam$math), 55, exam$math)  # math가 NA면 55로 대체
table(is.na(exam$math))                               # 결측치 빈도표 생성
exam                                                  # 출력
mean(exam$math)                                       # math 평균 산출


#### 07-2 ####

## -------------------------------------------------------------------- ##
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                         score = c(5, 4, 3, 4, 2, 6))
outlier

table(outlier$sex)
table(outlier$score)

# sex가 3이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

# score가 5보다 크면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score))


## -------------------------------------------------------------------- ##
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

# 상자 그림 통계치 출력
boxplot(mpg$hwy)$stats            

# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

# 결측치 확인
table(is.na(mpg$hwy))  

mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))


## -------------------------------------------------------------------- ##
## 1.결측치 정제하기

# 결측치 확인
table(is.na(df$score))

# 결측치 제거
df_nomiss <- df %>% filter(!is.na(score))

# 여러 변수 동시에 결측치 제거
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))

# 함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm = T)
exam %>% summarise(mean_math = mean(math, na.rm = T))


## 2.이상치 정제하기

# 이상치 확인
table(outlier$sex)

# 결측 처리
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)

# boxplot으로 극단치 기준 찾기
boxplot(mpg$hwy)$stats

# 극단치 결측 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

