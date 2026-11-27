# 개발자 포트폴리오 파이프라인

프로젝트 자료를 한 번 정리해 두고, 채용 공고에 맞는 소재를 골라 포트폴리오 PPT를 만드는 재사용형 작업 구조다. 기존 PPT에 텍스트만 바꿔 넣거나, 템플릿 PPT로 페이지를 다시 구성하고 도식·차트까지 만들 수 있다.

정리한 소재를 어디에 둘지에 따라 두 가지 방식으로 쓴다.

| | 방식 1 · Notion | 방식 2 · md 파일 |
| --- | --- | --- |
| 소재를 두는 곳 | Notion 데이터베이스 4개 | 내 PC의 `workspace/` 폴더 (md 파일) |
| AI에 전달하는 법 | AI가 Notion 연결로 직접 읽고 씀 | md 파일을 첨부하거나 폴더를 연결 |
| 찾는 법 | Notion 뷰 (필터·그룹) | 폴더 구조 + 파일 맨 위 속성 블록 |
| 필요한 것 | Notion 계정 + AI의 Notion 연결 | 아무것도 없음 (PowerShell 스크립트는 선택) |
| 맞는 경우 | 소재·공고가 많을 때, 여러 기기에서 볼 때 | 빠르게 시작할 때, Notion을 쓰지 않을 때 |
| 자세한 설명 | [notion/schema.md](notion/schema.md) | [markdown/schema.md](markdown/schema.md) |

두 방식은 같은 양식, 같은 작성 기준, 같은 PPT 규칙을 쓴다. 양식 맨 위의 속성 블록(`---` 사이)이 Notion 속성과 1:1로 대응하므로, md로 시작했다가 나중에 Notion으로 옮겨도 된다.

## 전체 흐름

```text
[최초 1회] 지원자 프로필 · 작업 방식
        ↓
[프로젝트마다] 개요 + 담당 기능 + 트러블슈팅 N건 + 회고·성과
        ↓
[저장] 방식 1 Notion  /  방식 2 workspace 폴더 md 파일
        ↓
[공고마다] 공고 정리 → 소재 선별 → PPT 구성표
        ↓
페이지별 원고·발표자 노트 → 페이지 단위 검토
        ↓
PPT 반영 (텍스트 교체 / 템플릿 기반 페이지 구성 / 도식·차트)
        ↓
줄 수 계산으로 정렬 → 저장 후 다시 읽기 → PowerPoint 화면 확인
```

## 핵심 원칙

- 프로젝트마다 `개요 1건`, `담당 기능 1건 이상`, `트러블슈팅 N건`, `회고·성과 1건`으로 분리
- 트러블슈팅 하나를 독립적인 재사용 소재로 관리
- 사실, 직접 기여, 팀 성과, 측정 조건을 분리
- 확인되지 않은 값은 `확인 필요`로 유지하고 최종 PPT에서는 제거
- 트러블슈팅은 회귀·사이드 이펙트 확인 결과(확인된 결과만)로 끝내고, 남은 한계는 발표자 노트로 보냄
- 공고에 맞춰 소재를 선별하되 없는 경험이나 수치를 새로 만들지 않음
- 최종 문구 작성 시 [포트폴리오 문구 작성 기준](references/portfolio-writing-guide.md)을 항상 적용
- 기준 문서의 원칙만 적용하고 예시에 나온 프로젝트 용어와 문구는 재사용하지 않음

## 준비: 스킬 설치

어느 환경이든 `SKILL.md`만 떼어 옮기지 않고 폴더 전체를 유지한다. 연결된 양식과 기준 문서를 읽어야 하기 때문이다. 폴더 이름은 `SKILL.md`의 `name`과 같은 `build-developer-portfolio`로 맞춘다.

- Claude 앱(claude.ai·데스크톱): 폴더 이름을 `build-developer-portfolio`로 바꾼 뒤 그 폴더째 ZIP으로 압축한다. ZIP을 열었을 때 맨 위에 `build-developer-portfolio/SKILL.md`가 있어야 한다. `Customize > Skills`에서 `+` → `Create skill` → `Upload a skill`로 올린다. 코드 실행 기능이 켜져 있어야 한다.
- Claude Code: 개인용은 `~/.claude/skills/build-developer-portfolio/`, 특정 저장소용은 그 저장소의 `.claude/skills/build-developer-portfolio/`에 폴더째 복사한다.
- Codex: Codex의 skills 디렉터리 아래 `build-developer-portfolio`라는 이름으로 복사한다.
- 스킬을 설치할 수 없는 AI: 단계마다 `prompts/`의 프롬프트와, 그 프롬프트가 가리키는 `templates/`, `references/`, `design/` 파일을 함께 첨부한다.

`workspace/`는 개인 자료라 ZIP과 스킬 폴더에 넣지 않는다.

---

## 방식 1 · Notion으로 쓰기

AI가 Notion에 연결되어 있어야 한다 (Claude라면 Notion 커넥터).

### 1-1. 데이터베이스 만들기 (최초 1회)

[notion/schema.md](notion/schema.md)의 순서대로 `프로젝트`, `포트폴리오 소재`, `채용 공고`, `PPT 초안` 데이터베이스 4개를 만든다. [notion/page-templates.md](notion/page-templates.md)대로 데이터베이스 템플릿을 등록하면 새 페이지를 만들 때 양식이 자동으로 들어간다.

```text
build-developer-portfolio 스킬로, 방식 1(Notion)용 데이터베이스 4개를
notion/schema.md대로 "포트폴리오" 페이지 아래에 만들어 줘.
```

이 저장소에는 특정 사용자의 Notion 워크스페이스 주소나 데이터베이스 ID를 넣지 않는다.

### 1-2. 프로필·작업 방식 (최초 1회)

이력서·자격증 등 원자료를 첨부하고 요청한다. 결과는 `포트폴리오 소재`에 유형 `이력·목차`, `작업 방식` 레코드로 저장된다 (프로젝트 관계 없음).

```text
방식 1로, 첨부한 이력 자료로 프로필과 작업 방식 소재를 만들어 줘.
```

### 1-3. 프로젝트 소재 정리 (프로젝트마다)

README, 코드 경로, 테스트·측정 자료를 첨부한다. 개요·담당 기능·트러블슈팅·회고가 각각 독립 레코드로 만들어지고, 양식의 속성 블록 값이 Notion 속성으로 들어간다.

```text
방식 1로, 첨부한 자료를 개요·담당 기능·트러블슈팅·회고 소재로 정리해서
포트폴리오 소재 데이터베이스에 넣어 줘. 확인되지 않은 내용은 확인 필요로 남겨 줘.
```

검토가 끝난 레코드는 `상태`를 `승인`으로 바꾼다. `공고 매칭 가능` 뷰에 나타난다.

### 1-4. 공고별 소재 선별 (공고마다)

공고를 `채용 공고` 데이터베이스에 넣고 요청한다. 결과는 `PPT 초안` 레코드의 구성표로 저장된다.

```text
방식 1로, 채용 공고 "회사-백엔드"에 맞는 소재를 골라 PPT 초안 구성표를 만들어 줘.
```

### 1-5. PPT 만들기

아래 [PPT 만들기 (공통)](#ppt-만들기-공통)를 따른다.

---

## 방식 2 · md 파일로 쓰기

Notion 없이 md 파일만 주고받는다. 폴더 구조, 속성 블록, 단계별로 보낼 파일은 [markdown/schema.md](markdown/schema.md)에 있다.

### 2-1. 양식 준비

**스크립트로 만들기 (권장)** — PowerShell에서 저장소 폴더로 이동한 뒤 실행한다.

```powershell
cd "저장소_경로\developer-portfolio-pipeline"

# 프로젝트마다: 트러블슈팅 수만큼 -TroubleshootingCount (기본 1, 최대 9)
powershell -ExecutionPolicy Bypass -File .\scripts\new-project.ps1 -ProjectSlug "my-project" -ProjectName "프로젝트명" -TroubleshootingCount 2

# 공고마다
powershell -ExecutionPolicy Bypass -File .\scripts\new-job.ps1 -JobSlug "company-backend" -CompanyRole "회사-백엔드"
```

- `workspace/_profile/`: `00-profile.md`, `06-work-process.md` (처음 한 번만 생성, 이미 있으면 그대로 둠)
- `workspace/my-project/`: 개요·담당 기능·회고 양식과 `troubleshooting/TS-01.md` ~ `TS-0N.md`. 속성 블록의 `프로젝트`, `소재_ID`가 채워짐
- `workspace/_jobs/company-backend/`: `07-job-posting.md`, `05-deck-plan.md`
- `-ExecutionPolicy Bypass`는 이번 실행에만 스크립트 실행 제한을 푼다

**스크립트 없이** — `templates/`의 파일을 [markdown/schema.md](markdown/schema.md)의 폴더 구조대로 복사하고, 속성 블록의 `프로젝트`와 `소재_ID`만 직접 고친다.

### 2-2. 프로필·작업 방식 (최초 1회)

이력 자료와 `_profile/` 두 파일을 첨부한다.

```text
방식 2로, 첨부한 이력 자료로 00-profile.md와 06-work-process.md를 채워 줘.
```

### 2-3. 프로젝트 소재 정리 (프로젝트마다)

프로젝트 자료와 그 프로젝트 폴더의 양식 파일을 첨부한다. 채워진 파일을 받아 같은 이름으로 덮어쓴다.

```text
방식 2로, 첨부한 자료를 이 양식들에 채워 줘.
속성 블록도 채우고, 확인되지 않은 내용은 확인 필요로 남겨 줘.
```

검토가 끝난 파일은 속성 블록의 `상태`를 `승인`으로 바꾼다. 공고 매칭은 `상태: 승인`인 파일만 대상으로 한다.

### 2-4. 공고별 소재 선별 (공고마다)

`07-job-posting.md`에 공고 원문을 붙이고, 공고 파일·구성표·승인된 소재 파일을 함께 첨부한다 (폴더를 연결했다면 폴더째).

```text
방식 2로, 07-job-posting.md 공고에 맞는 소재를 골라 05-deck-plan.md를 채워 줘.
```

### 2-5. PPT 만들기

아래 [PPT 만들기 (공통)](#ppt-만들기-공통)를 따른다. 구성표는 `workspace/_jobs/<공고>/05-deck-plan.md`를 쓴다.

---

## PPT 만들기 (공통)

기존 PPT, 구성표, 선택한 소재를 전달하고 [PPT 초안 프롬프트](prompts/03-build-deck.md)를 따른다.

1. 페이지 구성표 작성 (레이아웃 ID, 목차 쪽 범위 포함)
2. 페이지별 텍스트 원고와 발표자 노트 생성
3. 페이지 단위 검토와 승인
4. 작업 모드 선택: `text-only`(텍스트만 교체, 기본) / `rebuild-from-template`(템플릿 슬라이드로 페이지 구성) / `diagram`(도식·차트·로고)
5. `_수정전백업` 사본을 만들고 최신 파일 위에 반영
6. 텍스트 상자 위치는 Pretendard 글자 폭으로 줄 수를 계산해 정렬 (LibreOffice 렌더링은 한글·영문 사이 간격 때문에 PowerPoint와 줄바꿈이 다름)
7. 저장 후 다시 읽어 확인하고, 목차 쪽 범위·노트 쪽 표기·차트 값·용어 대조
8. PowerPoint 화면으로 최종 확인하고 구성표의 `상태`·`확인_방법`을 고침

```text
build-developer-portfolio 스킬로, 이 구성표대로 첨부한 PPT에 반영해 줘.
작업 모드는 text-only.
```

PPT의 정보 배치와 좌표는 [레이아웃 명세](design/layout-spec.md), 글꼴·크기·간격·색상 값은 [디자인 토큰](design/design-tokens.md)에서 관리한다. 현재 포트폴리오 형식의 실제 값은 [현재 덱 디자인 토큰](design/tokens-current-deck.md)에 있다. 시각 스타일 프리셋은 [디자인 옵션](design/design-options.md)에 등록한다.

기존 PPT를 사용하는 경우 `preserve-existing`이 기본값이다. 사용자가 디자인 변경을 명시적으로 요청하기 전에는 디자인 토큰이나 옵션을 기존 PPT에 적용하지 않는다. 현재 포트폴리오 형식으로 새 페이지를 만들 때는 `tokens-current-deck.md`를 쓴다.

## 폴더 구성

```text
developer-portfolio-pipeline/
├─ SKILL.md                         Claude·Codex에서 파이프라인을 실행하는 스킬
├─ templates/                       두 방식이 함께 쓰는 입력 양식 (맨 위 속성 블록 포함)
│  ├─ 00-profile.md                 지원자 프로필 (최초 1회)
│  ├─ 01~04                         프로젝트별 개요·담당 기능·트러블슈팅·회고
│  ├─ 05-deck-plan.md               공고별 PPT 구성표
│  ├─ 06-work-process.md            작업 방식 페이지 (최초 1회)
│  └─ 07-job-posting.md             채용 공고
├─ notion/                          방식 1: Notion 데이터베이스 속성·뷰·페이지 템플릿
├─ markdown/                        방식 2: 폴더 구조·속성 블록·단계별로 보낼 파일
├─ prompts/                         스킬 없이 쓸 때의 단계별 프롬프트
├─ references/                      문구 기준·태그·PPT 적용 규칙
├─ design/                          레이아웃·디자인 토큰·디자인 옵션
│  └─ tokens-current-deck.md        현재 포트폴리오 덱에서 추출한 시각 값
├─ scripts/
│  ├─ new-project.ps1               새 프로젝트 양식 폴더 생성 (방식 2)
│  └─ new-job.ps1                   새 공고 폴더 생성 (방식 2)
└─ workspace/                       방식 2의 개인 자료 (.gitignore로 제외)
```

## 권장 운영 규칙

- `원자료 → 소재 초안 → 승인 → PPT 반영`의 상태를 건너뛰지 않음
- 같은 개념의 용어는 프로젝트 용어표에서 하나로 고정
- 회사마다 문장을 억지로 바꾸기보다 공고에 맞는 소재 조합을 먼저 변경
- 방식 2에서는 소재 파일 이름과 `소재_ID`를 바꾸지 않음. 구성표가 파일 경로로 연결됨
- 민감 정보, 자격 증명, 실제 사용자 데이터는 Notion과 공개 저장소에 저장하지 않음
- 개인 프로젝트 자료와 실제 PPT 파일은 공개 저장소 밖에서 관리
- PPT를 고치기 전에는 PowerPoint 창을 저장하지 않고 닫음. 열린 창이 나중에 저장되면 수정본을 덮어씀

## 공개 저장소로 배포하기 전

- 예시 데이터에 개인정보·회사명·비공개 링크가 없는지 확인
- `workspace/`, 원본 PPT, 측정 원본 등 개인 자료가 커밋되지 않았는지 확인
- 저장소 라이선스 선택 후 `LICENSE` 추가
- Notion 템플릿 공개 복제 링크를 만들었다면 README에 연결

현재 패키지는 라이선스를 임의로 선택하지 않았다. 공개 배포 전 MIT, Apache-2.0 등 원하는 조건을 정해야 한다.
