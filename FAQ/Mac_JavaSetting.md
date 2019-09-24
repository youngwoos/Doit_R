맥에서 Java 설정하기
---

아래 코드를 실행해 자바의 dylib 파일을 설정한 다음 `KoNLP` 등 `rJava`를 이용하는 패키지를 로드하세요. `jdk1.8.0_144.jdk` 부분은 자바 버전에 따라 다릅니다. 파인더로 `/Library/Java/JavaVirtualMachines/`에 들어가서 버전을 확인한 후 수정해서 사용하세요.

`dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home/jre/lib/server/libjvm.dylib')`
