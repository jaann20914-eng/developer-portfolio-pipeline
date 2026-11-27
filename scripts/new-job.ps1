param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$JobSlug,

    [Parameter(Mandatory = $true)]
    [string]$CompanyRole
)

# 채용 공고 하나당 폴더를 만든다: workspace/_jobs/<JobSlug>/
#   07-job-posting.md  공고 원문과 요구 사항
#   05-deck-plan.md    이 공고용 PPT 구성표
# md 파일 방식(방식 2)에서 쓴다. Notion 방식이면 같은 내용을 Notion 데이터베이스에 만든다.

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageRoot = Split-Path -Parent $scriptRoot
$templateRoot = Join-Path $packageRoot 'templates'
$jobsRoot = Join-Path (Join-Path $packageRoot 'workspace') '_jobs'
$jobRoot = Join-Path $jobsRoot $JobSlug

# 양식 파일은 UTF-8이다. Windows PowerShell 5.1은 인코딩을 지정하지 않으면 한글을 깨뜨리므로 항상 utf8로 읽고 쓴다.
function Update-Template {
    param([string]$Path, [hashtable]$Replacements)
    $content = Get-Content -Raw -Encoding utf8 -LiteralPath $Path
    foreach ($pattern in $Replacements.Keys) {
        $content = [regex]::Replace($content, $pattern, [string]$Replacements[$pattern])
    }
    Set-Content -LiteralPath $Path -Value $content -Encoding utf8 -NoNewline
}

if (Test-Path -LiteralPath $jobRoot) {
    throw "Job folder already exists: $jobRoot"
}

New-Item -ItemType Directory -Path $jobRoot -Force | Out-Null

$posting = Join-Path $jobRoot '07-job-posting.md'
$plan = Join-Path $jobRoot '05-deck-plan.md'
Copy-Item -LiteralPath (Join-Path $templateRoot '07-job-posting.md') -Destination $posting
Copy-Item -LiteralPath (Join-Path $templateRoot '05-deck-plan.md') -Destination $plan

$today = Get-Date -Format 'yyyy-MM-dd'
$safeName = $CompanyRole.Replace('$', '$$')

Update-Template -Path $posting -Replacements @{
    '(?m)^회사_직무:[ \t]*(?=\r?$)' = "회사_직무: $safeName"
}
Update-Template -Path $plan -Replacements @{
    '(?m)^초안명:[ \t]*(?=\r?$)'   = "초안명: $safeName-$today"
    '(?m)^채용_공고:[ \t]*(?=\r?$)' = "채용_공고: $JobSlug"
}

Write-Output "Created job workspace: $jobRoot"
