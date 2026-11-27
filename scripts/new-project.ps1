param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$ProjectSlug,

    [Parameter(Mandatory = $true)]
    [string]$ProjectName,

    [ValidateRange(1, 9)]
    [int]$TroubleshootingCount = 1
)

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageRoot = Split-Path -Parent $scriptRoot
$templateRoot = Join-Path $packageRoot 'templates'
$workspaceRoot = Join-Path $packageRoot 'workspace'
$projectRoot = Join-Path $workspaceRoot $ProjectSlug
$profileRoot = Join-Path $workspaceRoot '_profile'

# 양식 파일은 UTF-8이다. Windows PowerShell 5.1은 인코딩을 지정하지 않으면 한글을 깨뜨리므로 항상 utf8로 읽고 쓴다.
function Update-Template {
    param([string]$Path, [hashtable]$Replacements)
    $content = Get-Content -Raw -Encoding utf8 -LiteralPath $Path
    foreach ($pattern in $Replacements.Keys) {
        $content = [regex]::Replace($content, $pattern, [string]$Replacements[$pattern])
    }
    Set-Content -LiteralPath $Path -Value $content -Encoding utf8 -NoNewline
}

# 지원자 공통 양식: workspace/_profile/ 에 한 번만 만든다. 이미 있으면 덮어쓰지 않는다.
if (-not (Test-Path -LiteralPath $profileRoot)) {
    New-Item -ItemType Directory -Path $profileRoot -Force | Out-Null
}
foreach ($shared in @('00-profile.md', '06-work-process.md')) {
    $destination = Join-Path $profileRoot $shared
    if (Test-Path -LiteralPath $destination) {
        Write-Output "Kept existing shared file: $destination"
    }
    else {
        Copy-Item -LiteralPath (Join-Path $templateRoot $shared) -Destination $destination
        Write-Output "Created shared file: $destination"
    }
}

if (Test-Path -LiteralPath $projectRoot) {
    throw "Project folder already exists: $projectRoot"
}

# 프로젝트별 양식
New-Item -ItemType Directory -Path $projectRoot | Out-Null
$troubleshootingRoot = Join-Path $projectRoot 'troubleshooting'
New-Item -ItemType Directory -Path $troubleshootingRoot | Out-Null

foreach ($name in @('01-project-overview.md', '02-my-contribution.md', '04-retrospective-outcomes.md')) {
    Copy-Item -LiteralPath (Join-Path $templateRoot $name) -Destination (Join-Path $projectRoot $name)
}

for ($i = 1; $i -le $TroubleshootingCount; $i++) {
    $id = 'TS-{0:D2}' -f $i
    $destination = Join-Path $troubleshootingRoot "$id.md"
    Copy-Item -LiteralPath (Join-Path $templateRoot '03-troubleshooting.md') -Destination $destination
    Update-Template -Path $destination -Replacements @{
        '(?m)^소재_ID: TS-01[ \t]*(?=\r?$)' = "소재_ID: $id"
        '- 소재 ID: `TS-01`'      = "- 소재 ID: ``$id``"
    }
}

# 프로젝트명 채우기 (속성 블록의 "프로젝트:"와 본문의 "- 프로젝트명:")
$safeName = $ProjectName.Replace('$', '$$')
Get-ChildItem -LiteralPath $projectRoot -Recurse -File -Filter '*.md' | ForEach-Object {
    Update-Template -Path $_.FullName -Replacements @{
        '(?m)^프로젝트:[ \t]*(?=\r?$)' = "프로젝트: $safeName"
        '(?m)^- 프로젝트명:[ \t]*(?=\r?$)' = "- 프로젝트명: $safeName"
    }
}

Write-Output "Created project workspace: $projectRoot ($TroubleshootingCount troubleshooting file(s))"
Write-Output "Job postings and deck plans: run scripts/new-job.ps1"
