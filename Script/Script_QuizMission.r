### 혼자서 해보기 -------------------------------------------------- ####

#### Quiz 03-3 ####

## Q1
score <- c(80, 60, 70, 50, 90)
score

## Q2
mean(score)

## Q3
mean_score <- mean(score)
mean_score


## -------------------------------------------------------------------- ##

#### Quiz 04-2 ####

## Q1
sales <- data.frame(fruit = c("사과", "딸기", "수박"),
                    price = c(1800, 1500, 3000),
                    volume = c(24, 38, 13))
sales

## Q2
mean(sales$price)   # 가격 평균
mean(sales$volume)  # 판매량 평균


## -------------------------------------------------------------------- ##

#### Quiz 05-2 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)         # mpg 데이터 불러오기
mpg_new <- mpg                             # 복사본 만들기

## Q2
mpg_new <- rename(mpg_new, city = cty)     # cty를 city로 수정
mpg_new <- rename(mpg_new, highway = hwy)  # hwy를 highway로 수정

## Q3
head(mpg_new)                              # 데이터 일부 출력


## -------------------------------------------------------------------- ##

#### Quiz 06-2 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)   # mpg 데이터 불러오기

mpg_a <- mpg %>% filter(displ <= 4)  # displ 4 이하 추출
mpg_b <- mpg %>% filter(displ >= 5)  # displ 5 이상 추출

mean(mpg_a$hwy)  # displ 4 이하 hwy 평균
mean(mpg_b$hwy)  # displ 5 이상 hwy 평균

## Q2
mpg_audi <- mpg %>% filter(manufacturer == "audi")      # audi 추출
mpg_toyota <- mpg %>% filter(manufacturer == "toyota")  # toyota 추출

mean(mpg_audi$cty)    # audi의 cty 평균
mean(mpg_toyota$cty)  # toyota의 cty 평균

## Q3
# manufacturer가 chevrolet, ford, honda에 해당하면 추출
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_new$hwy)


## -------------------------------------------------------------------- ##

#### Quiz 06-3 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)  # mpg 데이터 불러오기

df <- mpg %>% select(class, cty)    # class, cty 변수 추출
head(df)                            # df 일부 출력

## Q2
df_suv <- df %>% filter(class == "suv")          # class가 suv인 행 추출
df_compact <- df %>% filter(class == "compact")  # class가 compact인 행 추출

mean(df_suv$cty)                                 # suv의 cty 평균
mean(df_compact$cty)                             # compact의 cty 평균


## -------------------------------------------------------------------- ##

#### Quiz 06-4 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)          # mpg 데이터 불러오기

mpg %>% filter(manufacturer == "audi") %>%  # audi 추출
  arrange(desc(hwy)) %>%                    # hwy 내림차순 정렬
  head(5)                                   # 5행까지 출력


## -------------------------------------------------------------------- ##

#### Quiz 06-5 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)                # mpg 데이터 불러오기
mpg_new <- mpg                                    # 복사본 만들기

mpg_new <- mpg_new %>% mutate(total = cty + hwy)  # 합산 변수 만들기

## Q2
mpg_new <- mpg_new %>% mutate(mean = total/2)     # 평균 변수 만들기

## Q3
mpg_new %>%
  arrange(desc(mean)) %>%  # 내림차순 정렬
  head(3)                  # 상위 3행 출력

## Q4
mpg %>%
  mutate(total = cty + hwy,   # 합산 변수 만들기
         mean = total/2) %>%  # 평균 변수 만들기
  arrange(desc(mean)) %>%     # 내림차순 정렬
  head(3)                     # 상위 3행 출력


## -------------------------------------------------------------------- ##

#### Quiz 06-6 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)  # mpg 데이터 불러오기

mpg %>%
  group_by(class) %>%               # class별 분리
  summarise(mean_cty = mean(cty))   # cty 평균 구하기

## Q2
mpg %>%
  group_by(class) %>%                  # class별 분리
  summarise(mean_cty = mean(cty)) %>%  # cty 평균 구하기
  arrange(desc(mean_cty))              # 내림차순 정렬하기

## Q3
mpg %>%
  group_by(manufacturer) %>%           # manufacturer별 분리
  summarise(mean_hwy = mean(hwy)) %>%  # hwy 평균 구하기
  arrange(desc(mean_hwy)) %>%          # 내림차순 정렬하기
  head(3)                              # 상위 3행 출력

## Q4
mpg %>%
  filter(class == "compact") %>%  # compact 추출
  group_by(manufacturer) %>%      # manufacturer별 분리
  summarise(count = n()) %>%      # 빈도 구하기
  arrange(desc(count))            # 내림차순 정렬


## -------------------------------------------------------------------- ##

#### Quiz 06-7 ####

## Q1
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

mpg <- as.data.frame(ggplot2::mpg)      # mpg 데이터 불러오기
mpg <- left_join(mpg, fuel, by = "fl")  # mpg에 연료 가격 변수 추가

## Q2
mpg %>%
  select(model, fl, price_fl) %>%       # model, fl, price_fl 추출
  head(5)                               # 앞부분 일부 출력


## -------------------------------------------------------------------- ##

#### Quiz 07-1 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)           # mpg 데이터 불러오기
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA  # NA 할당하기

table(is.na(mpg$drv))  # drv 결측치 빈도표 출력
table(is.na(mpg$hwy))  # hwy 결측치 빈도표 출력

## Q2
mpg %>%
  filter(!is.na(hwy)) %>%          # 결측치 제외
  group_by(drv) %>%                # drv별 분리
  summarise(mean_hwy = mean(hwy))  # hwy 평균 구하기


## -------------------------------------------------------------------- ##

#### Quiz 07-2 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)                  # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k"                # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)  # cty 이상치 할당

# 이상치 확인
table(mpg$drv)

# drv가 4, f, r이면 기존 값 유지, 그 외 NA할당
mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)

# 이상치 확인
table(mpg$drv)

## Q2
# 상자 그림 생성 및 통계치 산출
boxplot(mpg$cty)$stats

# 9~26 벗어나면 NA 할당
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)

# 상자 그림 생성
boxplot(mpg$cty)

## Q3
mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%  # 결측치 제외
  group_by(drv) %>%                      # drv별 분리
  summarise(mean_hwy = mean(cty))        # cty 평균 구하기


## -------------------------------------------------------------------- ##

#### Quiz 08-1 ####

## Q1
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

## Q2
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)


## -------------------------------------------------------------------- ##

#### Quiz 08-2 ####

## Q1
# 평균 표 생성
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

# 그래프 생성
ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                      y = mean_cty)) + geom_col()

## Q2
ggplot(data = mpg, aes(x = class)) + geom_bar()


## -------------------------------------------------------------------- ##

#### Quiz 08-3 ####

## Q1
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()


## -------------------------------------------------------------------- ##

#### Quiz 08-4 ####

## Q1
class_mpg <- mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()


## -------------------------------------------------------------------- ##

#### Quiz 15-1 ####

## Q1
mpg <- as.data.frame(ggplot2::mpg)       # mpg 데이터 불러오기

mpg$tot <- (mpg$cty + mpg$hwy)/2         # 통합 연비 변수 만들기

df_comp <- mpg[mpg$class == "compact",]  # compact 추출
df_suv <- mpg[mpg$class == "suv",]       # suv 추출

mean(df_comp$tot)                        # compact의 tot 평균 산출
mean(df_suv$tot)                         # suv의 tot 평균 산출


## -------------------------------------------------------------------- ##

#### Quiz 15-2 ####

## Q1
class(mpg$drv)                 # 타입 확인

## Q2
mpg$drv <- as.factor(mpg$drv)  # factor 로 변환
class(mpg$drv)                 # 타입 확인

## Q3
levels(mpg$drv)                # 범주 확인


#### 분석 도전 ------------------------------------------------------ ####

#### Mission 05 ####

## 문제1
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

## 문제2
library(dplyr)
midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)

## 문제3
midwest$ratio <- midwest$asian/midwest$total*100
hist(midwest$ratio)

## 문제4
mean(midwest$ratio)
midwest$group <- ifelse(midwest$ratio > 0.4872462, "large", "small")

## 문제5
table(midwest$group)

library(ggplot2)
qplot(midwest$group)


## -------------------------------------------------------------------- ##

#### Mission 06 ####

## 문제1
# midwest 불러오기
midwest <- as.data.frame(ggplot2::midwest)

# midwest에 백분율 변수 추가
midwest <- midwest %>%
  mutate(ratio_child = (poptotal-popadults)/poptotal*100)

## 문제2
midwest %>%
  arrange(desc(ratio_child)) %>%   # ratio_child 내림차순 정렬
  select(county, ratio_child) %>%  # county, ratio_child 추출
  head(5)                          # 상위 5행 출력

## 문제3
# midwest에 grade 변수 추가
midwest <- midwest %>%
  mutate(grade = ifelse(ratio_child >= 40, "large",
                        ifelse(ratio_child >= 30, "middle", "small")))

# 미성년 비율 등급 빈도표
table(midwest$grade)

## 문제4
midwest %>%
  mutate(ratio_asian = (popasian/poptotal)*100) %>%  # 백분율 변수 추가
  arrange(ratio_asian) %>%                           # 내림차순 정렬
  select(state, county, ratio_asian) %>%             # 변수 추출
  head(10)                                           # 상위 10행 출력 
