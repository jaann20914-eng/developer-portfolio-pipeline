# 현재 덱 디자인 토큰

이 문서는 현재 포트폴리오 PPT에서 추출한 시각 값이다. 같은 형식의 덱을 새로 만들거나 페이지를 추가할 때 이 값을 쓴다. 정보 배치와 좌표는 `layout-spec.md`가, 범용 기본값은 `design-tokens.md`가 담당한다.

```yaml
token_mode: custom
token_source: current-deck
slide_size_in: [13.333, 7.5]
```

- 기존 PPT를 그대로 고치는 작업이면 `design-tokens.md`의 `preserve-existing`이 우선한다. 이 파일은 그 PPT에서 뽑은 값이므로 결과는 같다.
- 웹·노션용 토큰(px 단위, 파란 강조색)과 섞어 쓰지 않는다.

## 글꼴

```yaml
font:
  family: Pretendard
  weight:
    regular: 보통 (b=0)
    bold: 굵게 (b=1, Pretendard Bold)
```

모든 텍스트에 Pretendard를 쓴다. 굵기는 보통·굵게 두 단계만 쓴다.

## 텍스트 역할

단위: 크기 `pt`, 줄 간격 `%`(PowerPoint 줄 간격 배수)

| 역할 | 크기 | 굵기 | 색 | 줄 간격 | 쓰는 곳 |
| --- | --- | --- | --- | --- | --- |
| `slide_title` | 28 | 굵게 | 000000 | 기본 | 모든 페이지 제목 |
| `cover_slogan_sub` | 24 | 굵게 | 333333 | 95 | 표지 슬로건 첫 줄 |
| `cover_slogan_main` | 32 | 굵게 | 000000 | 95 | 표지 슬로건 둘째 줄 |
| `cover_name` | 18 | 굵게 | 000000 | 기본 | 표지 이름 |
| `cover_contact` | 11 | 보통 | 8C8C8C | 135 | 표지 연락처 3줄 |
| `cover_intro_head` | 14 | 굵게 | 1A1A1A | 100 | 표지 소개 핵심 문장 |
| `cover_intro_body` | 11 | 보통 | 595959 | 100 | 표지 소개 보충 2줄 |
| `lead` | 14 | 굵게 | 333333 | 108 | 트러블슈팅 문제 요약 2줄 |
| `section_title` | 13 | 굵게 | 1A1A1A | 100 | 배경·목표·01 원인 등 섹션 제목 |
| `subheading` | 11 | 굵게 | 333333 | 100 | 담당 기능 항목 이름 |
| `body` | 11 | 보통 | 595959 | 115 | 개요·회고 본문 |
| `body_ts` | 10.5 | 보통 | 595959 | 115 | 트러블슈팅 본문 |
| `label` | 본문 크기 | 굵게 | 595959 | 본문과 같음 | 결과·성과·배운 점 줄의 앞 라벨 |
| `body_profile` | 10.5 | 보통 | 595959 | 135 | 이력(교육·경력·수상·자격) |
| `skill_level` | 11 | 굵게 | 1A1A1A | 135 | 기술 스택 `●●●○○  Lv.3` 줄 |
| `index_entry` | 32 | 보통 | 000000 | 100 | 목차 `p.04-07   프로젝트명` |
| `index_desc` | 11 | 보통 | 595959 | 100 | 목차 한 줄 설명 |
| `index_meta` | 9 | 보통 | 595959 | 100 | 목차 기간·인원·역할 |
| `meta` | 9 | 보통 | 8C8C8C | 135 | 개요 페이지 기간·인원·GitHub |
| `page_number` | 9 | 보통 | 8C8C8C | 120 | 오른쪽 위 쪽 번호 |

작업 방식 페이지(L03) 전용:

| 역할 | 크기 | 굵기 | 색 | 줄 간격 |
| --- | --- | --- | --- | --- |
| 리드 | 11 | 보통 | 333333 | 115 |
| 단계 제목 (`00  규칙 설정`) | 11 | 굵게 | 1A1A1A | 100 |
| 단계 설명 | 11 | 보통 | 595959 | 115 |
| 반복 구간 라벨 | 9 | 굵게 | 1A1A1A | 110 |
| 산출물 카드 제목 / 설명 | 10.5 굵게 1A1A1A / 9 보통 595959 | | | 100 |
| 도구·규칙 카드 제목 / 내용 | 10.5 굵게 333333 / 10.5 보통 595959 | | | 100 |

## 색

```yaml
color:
  text_strongest: "#000000"   # 페이지 제목, 표지 메인 슬로건, 목차 항목
  text_strong:    "#1A1A1A"   # 섹션 제목, 기술 수준, 도식 노드 글자
  text_medium:    "#333333"   # 문제 요약, 소제목, 도식 라벨
  text_body:      "#595959"   # 본문 전체
  text_muted:     "#8C8C8C"   # 메타 정보, 쪽 번호, 생략 표시
  accent:         "#768690"   # 도식에서 강조할 대상 1~2곳 (테두리·채움·글자)
  background:     "#FFFFFF"
  divider:        "#F2F2F2"   # 문제 요약 아래 구분선 (흰색 95%)
```

- 글자 색은 회색 5단계만 쓴다. 덜 중요한 정보는 글씨를 줄이기보다 색을 한 단계 낮춘다.
- 강조색은 도식 안에서만, 한 도식에 1~2곳만 쓴다. 본문 글자에는 쓰지 않는다.
- 초록·빨강 같은 상태색은 쓰지 않는다. 좋고 나쁨은 `X` / `O` 같은 글자로 구분한다.

## 굵기 원칙

- 굵게: 페이지 제목, 섹션 제목, 소제목, 결과·성과·배운 점 줄의 앞 라벨, 문제 요약, 도식 노드
- 보통: 본문 문장
- 예외: 본문 안의 핵심 수치 1개는 굵게 허용 (예: 목표 문장 안의 규모 수치)

## 목록

```yaml
list:
  bullet_char: "•"
  bullet_font: Pretendard
  bullet_size_pct: 100
  marL_emu: 127000
  indent_emu: -127000
  continuation_line: 기호 없음, marL 127000, indent 0
```

- `-`, `*`, `•`를 글자로 쳐 넣지 않고 글머리 기호 기능을 쓴다.
- 줄을 직접 나눈 둘째 줄은 기호 없이 윗줄 글자 시작 위치에 맞춘다.
- 기호를 쓰는 곳: `02 개선 과정`, 개요의 주요 기능, 이력 항목(교육·경력·수상·자격)
- 기호 없이 줄만 바꾸는 곳: `01 원인`, `03-1 결과`, `03-2 회귀 확인`, 회고의 `라벨  내용` 줄, 담당 기능 설명

## 간격

기준: 위 텍스트의 마지막 줄 아래끝 → 다음 텍스트의 첫 줄 위끝 (글자 상자 기준, inch)

```yaml
spacing_in:
  section_title_to_body: 0.08
  body_to_next_section_title: 0.36
  body_to_subheading: 0.20
  subheading_to_body: 0.08
  section_title_to_subheading: 0.14
paragraph_spacing: 0   # 문단 앞·뒤 간격은 0, 간격은 상자 위치로만 조절
text_box_inset: 0      # 텍스트 상자 안쪽 여백 0, 위쪽 정렬
```

- 트러블슈팅 페이지는 `layout-spec.md`의 섹션 행 격자를 먼저 따르고, 격자 안에서 섹션 제목 → 본문 0.08을 지킨다.
- 줄 수는 렌더링 결과가 아니라 Pretendard 글자 폭으로 계산한다. LibreOffice는 한글과 영문·숫자 사이에 빈칸을 더 넣어 PowerPoint와 줄바꿈이 다르게 나온다.

## 도식

### 구조 비교형 (서버 → 채널 → 사용자 화면)

```yaml
diagram_structure:
  panel_fill: "#F5F5F5"          # Before·After 두 칸 모두
  panel_label: 12pt 굵게 1A1A1A   # Before / After
  node_fill: "#FFFFFF"
  node_line: 1A1A1A 1~1.2pt
  server_node: 채움 1A1A1A, 글자 12pt 굵게 FFFFFF
  node_label: 8~11pt 굵게 1A1A1A
  connector: 1A1A1A 1pt, 끝 화살표
  grid_line: DEDEDE 0.5pt
  other_users: 595959 또는 E5E5E5 점
  highlight: 768690 (대상 1~2곳)
```

### 순서도형 (시스템 축 사이 요청 순서)

```yaml
diagram_sequence:
  lane_header: 흰 채움, 333333 0.75pt 테두리, 10pt 굵게 1A1A1A
  lifeline: 회색 점선
  message_label: 9pt 보통 333333 (2줄까지)
  skipped_call: 회색 점선 + "생략" 9pt 8C8C8C
  band_before: 채움 F2F2F2, 테두리 없음
  band_after: 흰 채움, 8C8C8C 0.75pt 테두리
  band_label: 10pt 보통 1A1A1A (Before / After)
  situation_line: 9pt, 구간과 반대 면색 (Before 위 흰색, After 위 F2F2F2)
  section_bracket: 9pt 보통 333333 ("[ 상황 ]")
  result_mark: 채움 없음, 9pt 굵게 333333, "X 409" / "O 202"
```

## 차트

```yaml
chart:
  type: 가로 막대 (bar, barDir=bar)
  gap_width: 42~55
  single_series_fill: "#8EC5F5"
  two_series:
    before: "#C9CDD2"
    after: "#8EC5F5"
    legend: 아래
  data_label: 10pt 1A1A1A, 감소율은 0.0"%" 형식
  axis_text: 10pt 595959
  gridline: D9D9D9 / E6E6E6
  title: 13pt 1A1A1A
```

## 이미지

```yaml
logo:
  size_in: 0.32
  color: "#333333"   # 단색 아이콘
  count_per_page: 3
screenshot:
  border: 없음
  caption: 9pt 보통 8C8C8C (앱 화면 여러 장일 때만)
```
