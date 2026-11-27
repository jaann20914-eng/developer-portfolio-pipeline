# 포트폴리오 디자인 토큰

이 문서는 시각 값만 관리한다. 페이지 구성, 문구, 이미지 선택, 장식 규칙은 포함하지 않는다.

> 아래 값은 기존 PPT가 없을 때 쓰는 범용 시작값이다. 현재 포트폴리오 덱과 같은 형식으로 만들 때는 [tokens-current-deck.md](tokens-current-deck.md)를 쓴다. 두 파일의 값을 섞어 쓰지 않는다.

## 적용 상태

```yaml
token_mode: preserve-existing
token_source: existing-ppt   # current-deck 이면 tokens-current-deck.md 사용
```

- `preserve-existing`: 기존 PPT의 값을 유지
- `custom`: 이 문서의 사용자 지정 값을 적용
- `custom` + `token_source: current-deck`: `tokens-current-deck.md`의 값을 적용

기존 PPT가 있는 작업의 기본값은 `preserve-existing`이다. 사용자가 디자인 변경을 요청하기 전에는 아래 기본값으로 기존 PPT를 덮어쓰지 않는다.

## 글꼴

```yaml
font:
  family:
    primary: Pretendard
    fallback_korean: Noto Sans KR
    fallback_latin: Arial
  weight:
    regular: 400
    medium: 500
    semibold: 600
    bold: 700
```

한글이 포함된 모든 문자는 한글 글리프를 지원하는 글꼴 사용. 실제 배포 환경에 글꼴이 없으면 fallback 순서 적용.

## 글자 크기

단위: `pt`

```yaml
font_size:
  cover_title: 30
  cover_subtitle: 17
  slide_title: 22
  section_title: 15
  body_large: 14
  body: 12
  body_small: 10
  metric_large: 24
  metric_label: 10
  caption: 9
  footnote: 8
```

기존 PPT가 없는 경우의 시작값이다. 슬라이드가 복잡하다는 이유로 `body_small` 이하를 기본 본문에 사용하지 않는다. 텍스트가 넘치면 먼저 문장을 줄인다.

## 줄 간격과 문단 간격

```yaml
line_height:
  title: 1.15
  heading: 1.20
  body: 1.35
  caption: 1.25

paragraph_spacing_pt:
  title_after: 10
  section_after: 6
  body_after: 5
  list_item_after: 3
```

## 공간 간격

단위: `pt`

```yaml
spacing:
  xs: 4
  sm: 8
  md: 12
  lg: 20
  xl: 28
  xxl: 40
```

같은 단계의 항목은 동일 간격을 사용한다. 관련 항목 사이 간격은 서로 다른 섹션 사이 간격보다 작게 유지한다.

## 텍스트 박스 내부 여백

단위: `pt`

```yaml
inset:
  compact:
    horizontal: 6
    vertical: 4
  default:
    horizontal: 10
    vertical: 8
  spacious:
    horizontal: 16
    vertical: 12
```

## 색상

형식: `#RRGGBB`

```yaml
color:
  background: "#FFFFFF"
  surface: "#F7F8FA"
  text_primary: "#171A1F"
  text_secondary: "#525866"
  text_muted: "#858C99"
  border: "#DDE1E8"
  accent: "#315EFB"
  accent_soft: "#EAF0FF"
  positive: "#16845B"
  warning: "#B76E00"
  negative: "#C43D3D"
  on_accent: "#FFFFFF"
```

색상은 의미를 보조할 때만 사용한다. 결과의 좋고 나쁨을 색상만으로 구분하지 않고 텍스트 라벨을 함께 둔다.

## 선과 구분 요소

단위: `pt`

```yaml
stroke:
  hairline: 0.5
  default: 1
  emphasis: 2

corner_radius:
  none: 0
  small: 4
  medium: 8
```

## 강조 규칙

```yaml
emphasis:
  slide_title_weight: 700
  section_title_weight: 600
  body_weight: 400
  metric_weight: 700
  key_phrase_weight: 600
  max_accent_colors_per_slide: 1
```

본문 전체를 굵게 만들지 않는다. 한 문단에서 굵은 강조는 핵심 구절이나 수치에만 사용한다.

## 토큰 변경 절차

1. 기존 PPT 사용 여부 확인
2. 기존 PPT 사용 시 실제 글꼴·크기·색상·간격 추출
3. 추출값을 별도 프로젝트 토큰 파일에 기록
4. 사용자가 변경을 승인한 항목만 `custom`으로 전환
5. 대표 슬라이드에서 가독성과 넘침 확인
6. 전체 슬라이드 적용 후 원본과 비교

이 파일의 값은 기본 예시다. 특정 프로젝트의 확정 디자인 값은 이 파일을 직접 덮어쓰기보다 복사본에서 관리한다.
