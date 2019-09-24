맥에서 그래프의 한글이 깨질 때
---

아래 코드를 실행해 맥에서 지원하는 폰트를 지정한 후 그래프를 생성하면 한글이 정상적으로 출력됩니다.

### `ggplot2`로 그래프를 생성할 경우

`theme_set(theme_gray(base_family="AppleGothic"))`

### `wordcloud()` 또는 내장 그래프 함수로 그래프를 생성할 경우

`par(family = "AppleGothic")`



