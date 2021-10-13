
## ‘summarise()’ has grouped output by ‘var’

`group_by()`에 둘 이상의 변수를 입력하면
`'summarise()' has grouped output by...` 라는 메시지가 출력됩니다.

``` r
mpg %>% 
  group_by(drv, class) %>%
  summarise(m = mean(hwy))
```

    ## `summarise()` has grouped output by 'drv'. You can override using the `.groups` argument.

    ## # A tibble: 12 x 3
    ## # Groups:   drv [3]
    ##    drv   class          m
    ##    <chr> <chr>      <dbl>
    ##  1 4     compact     25.8
    ##  2 4     midsize     24  
    ##  3 4     pickup      16.9
    ##  4 4     subcompact  26  
    ##  5 4     suv         18.3
    ##  6 f     compact     29.1
    ##  7 f     midsize     27.6
    ##  8 f     minivan     22.4
    ##  9 f     subcompact  30.5
    ## 10 r     2seater     24.8
    ## 11 r     subcompact  23.2
    ## 12 r     suv         17.5

이 메시지는 에러 메시지가 아닙니다. 출력 결과가 어떤 변수를 기준으로
그루핑되어 있는지 알려주는 안내 메시지입니다.
`'summarise()' has grouped output by 'drv'`는 코드의 출력 결과가 `drv`
기준으로 그루핑 되어 있다는 의미입니다. `# Groups:   drv [3]` 부분을
보면 출력 결과가 `drv` 변수 기준으로 그루핑 되어 있고 범주가 3개임을 알
수 있습니다.

#### 안내 메시지를 출력하지 않으려면

`summarise()`의 `.groups`에 값을 입력해 어떤 변수 기준으로 그룹을 유지할
것인지 명시적으로 지정하면 안내 메시지를 출력하지 않습니다.
`summarise()`의 기본값은 `group_by()`에 입력한 변수 중 마지막 변수를
제외하고 그룹을 유지하는 `"drop_last"`입니다. 따라서 `summarise()`에
`.groups = "drop_last"`를 입력하면 출력 결과는 동일하고 안내 메시지는
출력하지 않습니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(m = mean(hwy), .groups = "drop_last")
```

    ## # A tibble: 12 x 3
    ## # Groups:   drv [3]
    ##    drv   class          m
    ##    <chr> <chr>      <dbl>
    ##  1 4     compact     25.8
    ##  2 4     midsize     24  
    ##  3 4     pickup      16.9
    ##  4 4     subcompact  26  
    ##  5 4     suv         18.3
    ##  6 f     compact     29.1
    ##  7 f     midsize     27.6
    ##  8 f     minivan     22.4
    ##  9 f     subcompact  30.5
    ## 10 r     2seater     24.8
    ## 11 r     subcompact  23.2
    ## 12 r     suv         17.5

------------------------------------------------------------------------

## `summarise()`의 `.groups` 활용하기

`summarise()` 의 `.groups`를 활용하면 그룹을 유지하는 방법을 다양하게
조정할 수 있습니다. `.groups`에는 네 종류의 값을 지정할 수 있습니다.

-   `"drop_last"`: 마지막 변수 제외하고 그룹 유지

-   `"keep"`: 모든 변수를 이용해 그룹 유지

-   `"drop"`: 그룹 해제

-   `"rowwise"`: 열을 행처럼 취급

> 출력 결과의 `# Groups: ...`를 보면 어떤 변수를 기준으로 그룹을
> 유지하는지 알 수 있습니다. 그루핑 기준과 출력 결과의 값을 보면
> `.groups`에 지정한 값에 따라 `summarise()`에 연결한 함수의 출력 결과가
> 어떻게 달라지는지 알 수 있습니다.

#### `"drop_last"`: 마지막 변수 제외하고 그룹 유지

`group_by()`에 입력한 마지막 변수를 제외하고 그룹을 유지합니다.
`# Groups: drv [3]`를 보면 `group_by()`에 입력한 `drv`와 `class` 중
마지막 변수인 `class`를 제외하고 `drv` 기준으로 그룹을 유지하고, `drv`의
범주가 3개임을 알 수 있습니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "drop_last")
```

    ## # A tibble: 12 x 3
    ## # Groups:   drv [3]
    ##    drv   class        tot
    ##    <chr> <chr>      <int>
    ##  1 4     compact      310
    ##  2 4     midsize       72
    ##  3 4     pickup       557
    ##  4 4     subcompact   104
    ##  5 4     suv          932
    ##  6 f     compact     1020
    ##  7 f     midsize     1047
    ##  8 f     minivan      246
    ##  9 f     subcompact   672
    ## 10 r     2seater      124
    ## 11 r     subcompact   209
    ## 12 r     suv          192

`drv` 기준으로 그루핑되어 있으므로 함수를 추가하면 `drv`별로 연산합니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "drop_last") %>%
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Groups:   drv [3]
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  1975
    ##  2 4     midsize       72  1975
    ##  3 4     pickup       557  1975
    ##  4 4     subcompact   104  1975
    ##  5 4     suv          932  1975
    ##  6 f     compact     1020  2985
    ##  7 f     midsize     1047  2985
    ##  8 f     minivan      246  2985
    ##  9 f     subcompact   672  2985
    ## 10 r     2seater      124   525
    ## 11 r     subcompact   209   525
    ## 12 r     suv          192   525

`group_by()`에 변수를 3개 입력하면 마지막 변수를 제외하고 두 번째
변수까지만 활용해 그룹을 유지합니다.

``` r
mpg %>%
  group_by(drv, class, cyl) %>%
  summarise(tot = sum(hwy), .groups = "drop_last")
```

    ## # A tibble: 26 x 4
    ## # Groups:   drv, class [12]
    ##    drv   class        cyl   tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact        4   210
    ##  2 4     compact        6   100
    ##  3 4     midsize        6    49
    ##  4 4     midsize        8    23
    ##  5 4     pickup         4    62
    ##  6 4     pickup         6   179
    ##  7 4     pickup         8   316
    ##  8 4     subcompact     4   104
    ##  9 4     suv            4   190
    ## 10 4     suv            6   296
    ## # ... with 16 more rows

`drv` 및 `class` 기준으로 그루핑되어 있으므로 함수를 추가하면 `drv` 및
`class`별로 연산합니다.

``` r
mpg %>%
  group_by(drv, class, cyl) %>%
  summarise(tot = sum(hwy), .groups = "drop_last") %>% 
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 26 x 5
    ## # Groups:   drv, class [12]
    ##    drv   class        cyl   tot t_tot
    ##    <chr> <chr>      <int> <int> <int>
    ##  1 4     compact        4   210   310
    ##  2 4     compact        6   100   310
    ##  3 4     midsize        6    49    72
    ##  4 4     midsize        8    23    72
    ##  5 4     pickup         4    62   557
    ##  6 4     pickup         6   179   557
    ##  7 4     pickup         8   316   557
    ##  8 4     subcompact     4   104   104
    ##  9 4     suv            4   190   932
    ## 10 4     suv            6   296   932
    ## # ... with 16 more rows

#### `"keep"`: 모든 변수를 이용해 그룹 유지

`group_by()`에 지정한 모든 변수를 그루핑 기준으로 유지합니다. `drv` 및
`class`별로 그루핑되어 있으므로 함수를 추가하면 하면 `drv` 및
`class`별로 연산합니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "keep") %>%
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Groups:   drv, class [12]
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310   310
    ##  2 4     midsize       72    72
    ##  3 4     pickup       557   557
    ##  4 4     subcompact   104   104
    ##  5 4     suv          932   932
    ##  6 f     compact     1020  1020
    ##  7 f     midsize     1047  1047
    ##  8 f     minivan      246   246
    ##  9 f     subcompact   672   672
    ## 10 r     2seater      124   124
    ## 11 r     subcompact   209   209
    ## 12 r     suv          192   192

#### `"drop"`: 그룹 해제

그룹을 해제합니다. 다음 코드의 출력 결과를 보면 그룹별로 연산하지 않고
전체 행을 대상으로 연산했음을 알 수 있습니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "drop") %>%
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  5485
    ##  2 4     midsize       72  5485
    ##  3 4     pickup       557  5485
    ##  4 4     subcompact   104  5485
    ##  5 4     suv          932  5485
    ##  6 f     compact     1020  5485
    ##  7 f     midsize     1047  5485
    ##  8 f     minivan      246  5485
    ##  9 f     subcompact   672  5485
    ## 10 r     2seater      124  5485
    ## 11 r     subcompact   209  5485
    ## 12 r     suv          192  5485

`ungroup()`을 이용해 그룹을 해제할 때와 결과가 같습니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy)) %>%
  ungroup() %>% 
  mutate(t_tot = sum(tot))
```

    ## `summarise()` has grouped output by 'drv'. You can override using the `.groups` argument.

    ## # A tibble: 12 x 4
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  5485
    ##  2 4     midsize       72  5485
    ##  3 4     pickup       557  5485
    ##  4 4     subcompact   104  5485
    ##  5 4     suv          932  5485
    ##  6 f     compact     1020  5485
    ##  7 f     midsize     1047  5485
    ##  8 f     minivan      246  5485
    ##  9 f     subcompact   672  5485
    ## 10 r     2seater      124  5485
    ## 11 r     subcompact   209  5485
    ## 12 r     suv          192  5485

#### `"rowwise"`: 열을 행처럼 취급

`"rowwise"`는 각 열을 행처럼 취급하도록 그룹 정보를 유지합니다. 아래
코드의 출력 결과는 `.groups`에`"keep"`을 입력했을 때와 같지만
`# Rowwise: drv, class`를 보면 `drv`와 `class` 변수가 행으로 취급됨을 알
수 있습니다.

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "rowwise") %>%
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Rowwise:  drv, class
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310   310
    ##  2 4     midsize       72    72
    ##  3 4     pickup       557   557
    ##  4 4     subcompact   104   104
    ##  5 4     suv          932   932
    ##  6 f     compact     1020  1020
    ##  7 f     midsize     1047  1047
    ##  8 f     minivan      246   246
    ##  9 f     subcompact   672   672
    ## 10 r     2seater      124   124
    ## 11 r     subcompact   209   209
    ## 12 r     suv          192   192

`.groups = "rowwise"`의 영향은 행 방향이 아닌 열 방향으로 연산할 때
드러납니다. 다음 코드의 출력 결과를 보면 `mutate()`에 입력한 `sum()`이
`hwy`열과 `cty`열의 값을 이용해 연산했음을 알 수 있습니다.

``` r
mpg %>%
  group_by(drv) %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty), 
            .groups = "rowwise") %>%
  mutate(tot = sum(hwy, cty))
```

    ## # A tibble: 3 x 4
    ## # Rowwise:  drv
    ##   drv     hwy   cty   tot
    ##   <chr> <int> <int> <int>
    ## 1 4      1975  1476  3451
    ## 2 f      2985  2117  5102
    ## 3 r       525   352   877

`.groups = "rowwise"`를 입력하지 않으면 (1) `drv`별로 `sum(hwy)`과
`sum(cty)`를 구한 다음 (2)행 방향으로 `hwy`와 `cty`의 `sum()`을 구하고
(3)이렇게 구한 값을 다시 `sum()` 하는 절차로 연산하므로 그룹에 관계 없이
`tot`의 값이 같습니다.

``` r
mpg %>%
  group_by(drv) %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty)) %>%
  mutate(tot = sum(hwy, cty))
```

    ## # A tibble: 3 x 4
    ##   drv     hwy   cty   tot
    ##   <chr> <int> <int> <int>
    ## 1 4      1975  1476  9430
    ## 2 f      2985  2117  9430
    ## 3 r       525   352  9430

다음 코드의 출력 결과를 보면 `tot`의 값이 같습니다.

``` r
mpg %>%
  
  # (1)drv별로 sum(hwy)과 sum(cty)를 구함
  group_by(drv) %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty)) %>%
  
  # (2) 행 방향으로 hwy와 cty의 sum()을 구함
  mutate(tot_hwy = sum(hwy),
         tot_cty = sum(cty)) %>% 
  
  # (3) tot_hwy와 tot_cty를 더함
  mutate(tot = tot_hwy + tot_cty)
```

    ## # A tibble: 3 x 6
    ##   drv     hwy   cty tot_hwy tot_cty   tot
    ##   <chr> <int> <int>   <int>   <int> <int>
    ## 1 4      1975  1476    5485    3945  9430
    ## 2 f      2985  2117    5485    3945  9430
    ## 3 r       525   352    5485    3945  9430

`group_by(drv)`를 제외해도 `tot`의 값이 같습니다.

``` r
mpg %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty)) %>%
  mutate(tot = sum(hwy, cty))
```

    ## # A tibble: 1 x 3
    ##     hwy   cty   tot
    ##   <int> <int> <int>
    ## 1  5485  3945  9430

`rowwise()`를 이용해 열을 행처럼 취급하도록 설정하면 `summarise()`에
`.groups = "rowwise"`를 입력할 때와 결과가 같습니다.

``` r
mpg %>%
  group_by(drv) %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty)) %>%
  rowwise() %>% 
  mutate(tot = sum(hwy, cty))
```

    ## # A tibble: 3 x 4
    ## # Rowwise: 
    ##   drv     hwy   cty   tot
    ##   <chr> <int> <int> <int>
    ## 1 4      1975  1476  3451
    ## 2 f      2985  2117  5102
    ## 3 r       525   352   877

### `.groups` 설정 비교

##### 기본형

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy)) %>% 
  mutate(t_tot = sum(tot))
```

    ## `summarise()` has grouped output by 'drv'. You can override using the `.groups` argument.

    ## # A tibble: 12 x 4
    ## # Groups:   drv [3]
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  1975
    ##  2 4     midsize       72  1975
    ##  3 4     pickup       557  1975
    ##  4 4     subcompact   104  1975
    ##  5 4     suv          932  1975
    ##  6 f     compact     1020  2985
    ##  7 f     midsize     1047  2985
    ##  8 f     minivan      246  2985
    ##  9 f     subcompact   672  2985
    ## 10 r     2seater      124   525
    ## 11 r     subcompact   209   525
    ## 12 r     suv          192   525

##### `"drop_last"`: 마지막 변수 제외하고 그룹 유지

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "drop_last") %>% 
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Groups:   drv [3]
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  1975
    ##  2 4     midsize       72  1975
    ##  3 4     pickup       557  1975
    ##  4 4     subcompact   104  1975
    ##  5 4     suv          932  1975
    ##  6 f     compact     1020  2985
    ##  7 f     midsize     1047  2985
    ##  8 f     minivan      246  2985
    ##  9 f     subcompact   672  2985
    ## 10 r     2seater      124   525
    ## 11 r     subcompact   209   525
    ## 12 r     suv          192   525

##### `"keep"`: 모든 변수를 이용해 그룹 유지

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "keep") %>% 
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Groups:   drv, class [12]
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310   310
    ##  2 4     midsize       72    72
    ##  3 4     pickup       557   557
    ##  4 4     subcompact   104   104
    ##  5 4     suv          932   932
    ##  6 f     compact     1020  1020
    ##  7 f     midsize     1047  1047
    ##  8 f     minivan      246   246
    ##  9 f     subcompact   672   672
    ## 10 r     2seater      124   124
    ## 11 r     subcompact   209   209
    ## 12 r     suv          192   192

##### `"drop"`: 그룹 해제

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "drop") %>% 
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310  5485
    ##  2 4     midsize       72  5485
    ##  3 4     pickup       557  5485
    ##  4 4     subcompact   104  5485
    ##  5 4     suv          932  5485
    ##  6 f     compact     1020  5485
    ##  7 f     midsize     1047  5485
    ##  8 f     minivan      246  5485
    ##  9 f     subcompact   672  5485
    ## 10 r     2seater      124  5485
    ## 11 r     subcompact   209  5485
    ## 12 r     suv          192  5485

##### `"rowwise"`: 열을 행처럼 취급

``` r
mpg %>%
  group_by(drv, class) %>%
  summarise(tot = sum(hwy), .groups = "rowwise") %>% 
  mutate(t_tot = sum(tot))
```

    ## # A tibble: 12 x 4
    ## # Rowwise:  drv, class
    ##    drv   class        tot t_tot
    ##    <chr> <chr>      <int> <int>
    ##  1 4     compact      310   310
    ##  2 4     midsize       72    72
    ##  3 4     pickup       557   557
    ##  4 4     subcompact   104   104
    ##  5 4     suv          932   932
    ##  6 f     compact     1020  1020
    ##  7 f     midsize     1047  1047
    ##  8 f     minivan      246   246
    ##  9 f     subcompact   672   672
    ## 10 r     2seater      124   124
    ## 11 r     subcompact   209   209
    ## 12 r     suv          192   192

``` r
# 손쉽게 열간 연산 가능
mpg %>%
  group_by(drv) %>%
  summarise(hwy = sum(hwy), 
            cty = sum(cty), 
            cyl = sum(cyl),
            .groups = "rowwise") %>%
  mutate(tot1 = sum(hwy, cty, cyl),
         tot2 = mean(c(hwy, cty, cyl)))
```

    ## # A tibble: 3 x 6
    ## # Rowwise:  drv
    ##   drv     hwy   cty   cyl  tot1  tot2
    ##   <chr> <int> <int> <int> <int> <dbl>
    ## 1 4      1975  1476   668  4119 1373 
    ## 2 f      2985  2117   518  5620 1873.
    ## 3 r       525   352   192  1069  356.
