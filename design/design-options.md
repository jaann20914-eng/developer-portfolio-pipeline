# 교체형 디자인 옵션

이 문서는 향후 사용자가 시각 스타일을 바꿀 때 선택할 디자인 프리셋의 구조를 정의한다. 현재 단계에서는 디자인을 자동 적용하지 않는다.

## 현재 설정

```yaml
design_mode: preserve-existing
active_option: none
approved_options: [monotone-evidence]
allow_automatic_switch: false
```

- `preserve-existing`: 기존 PPT 디자인 유지
- `option`: 사용자가 승인한 디자인 옵션 적용
- `approved_options`: 사용자가 승인해 바로 쓸 수 있는 옵션. 승인됐어도 작업마다 사용자가 요청할 때 `active_option`으로 지정한다
- `allow_automatic_switch: false`: AI가 임의로 디자인 옵션을 선택하거나 교체하지 않음

기존 포트폴리오 PPT를 고치는 작업은 `preserve-existing`과 `monotone-evidence`의 결과가 같다. 그 PPT에서 뽑은 값이기 때문이다.

## 파일 책임

| 파일 | 담당 범위 |
| --- | --- |
| `layout-spec.md` | 정보 구조, 페이지 유형, 영역 역할 |
| `design-tokens.md` | 글꼴, 크기, 굵기, 간격, 색상 |
| `design-options.md` | 시각 분위기와 토큰 조합을 선택하는 프리셋 |

디자인 옵션은 문구의 사실, 페이지 순서, 선택 소재를 변경하지 않는다. 레이아웃 변경이 필요한 옵션은 별도 레이아웃 버전으로 관리한다.

## 디자인 옵션 작성 양식

새 옵션은 아래 양식을 복제해 추가한다.

```yaml
option:
  id: option-id
  name: 사용자에게 보여 줄 이름
  status: draft
  intended_use: 적용하기 좋은 직무·포트폴리오 성격
  avoid_when: 적용하지 않을 조건
  token_overrides:
    font_family_primary: null
    background: null
    text_primary: null
    accent: null
    spacing_scale: null
  visual_rules:
    density: null
    alignment: null
    divider_style: null
    image_treatment: null
  required_layout_version: base
```

`null` 값은 기본 디자인 토큰을 유지한다는 의미다.

## 향후 옵션 슬롯

### O01. 기본 기술 포트폴리오

```yaml
id: clean-technical
status: reserved
```

- 긴 기술 설명과 전후 비교의 가독성 중심
- 과도한 장식 없이 수치와 흐름을 우선하는 방향
- 구체적인 색상과 글꼴은 추후 사용자 승인 후 정의

### O02. 제품·UI/UX 중심

```yaml
id: product-visual
status: reserved
```

- 화면 이미지와 사용자 흐름의 비중이 높은 프로젝트용
- 이미지 크롭과 캡션 규칙을 별도 정의할 예정
- 현재 자동 적용 금지

### O03. 백엔드·인프라 중심

```yaml
id: system-evidence
status: reserved
```

- 구조 비교, 측정 결과, 검증 조건의 위계가 중요한 프로젝트용
- 표와 흐름도의 가독성 규칙을 별도 정의할 예정
- 현재 자동 적용 금지

### O04. 단색 근거 중심 (현재 포트폴리오 덱)

```yaml
option:
  id: monotone-evidence
  name: 단색 근거 중심
  status: approved          # 사용자 승인 2026-11-27
  intended_use: 실시간·정합성·성능 개선처럼 구조 비교와 전후 수치가 핵심인 개발자 포트폴리오
  avoid_when: 화면 디자인 자체가 주요 성과인 프로젝트만 모은 덱 (O02 product-visual 검토)
  token_overrides:
    source: design/tokens-current-deck.md
    font_family_primary: Pretendard
    background: "#FFFFFF"
    text_primary: "#1A1A1A"
    accent: "#768690"
    spacing_scale: tokens-current-deck.md의 간격 규칙 (0.08 / 0.36 / 0.20 / 0.08 / 0.14 in)
  visual_rules:
    density: 한 페이지 왼쪽 텍스트 열 + 오른쪽 시각 자료 한 가지
    alignment: 왼쪽 정렬, 섹션 제목과 본문을 같은 세로선에
    divider_style: 문제 요약 아래 짧은 연회색 막대 1개
    image_treatment: 대표 화면은 테두리 없음, 로고는 단색 333333
  required_layout_version: layout-spec.md (L01~L07)
```

- 글자 색은 회색 5단계만, 강조색은 도식 안 1~2곳만
- 상태색(초록·빨강) 대신 `X` / `O` 글자로 결과 표시
- 차트는 연한 하늘색 단일 계열 또는 회색·하늘색 두 계열

## 옵션 추가 기준

- 색상만 다른 옵션을 별도 디자인으로 만들지 않음
- 특정 프로젝트의 임시 요구를 범용 옵션으로 확장하지 않음
- 한 옵션이 어떤 콘텐츠에서 유리하고 불리한지 함께 기록
- 프리셋 안에 프로젝트 고유 문구·기술·회사명을 포함하지 않음
- 옵션이 바뀌어도 문구 작성 기준과 사실성 규칙은 유지

## 교체 절차

1. 사용자가 디자인 옵션을 명시적으로 선택
2. 기존 PPT 유지 여부와 변경 허용 범위 확인
3. 옵션의 `token_overrides`를 프로젝트용 디자인 토큰 복사본에 반영
4. 필요한 경우 호환되는 레이아웃 버전 선택
5. 표지, 프로젝트 개요, 트러블슈팅 비교 페이지에 시험 적용
6. 사용자 승인 후 전체 슬라이드 적용
7. 원본과 결과를 나란히 비교해 텍스트 잘림과 정보 위계 확인

사용자가 옵션을 선택하지 않으면 `preserve-existing` 상태를 유지한다.
