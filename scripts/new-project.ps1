param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string]$ProjectSlug,

    [Parameter(Mandatory = $true)]
    [string]$ProjectName
)

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageRoot = Split-Path -Parent $scriptRoot
$templateRoot = Join-Path $packageRoot 'templates'
$workspaceRoot = Join-Path $packageRoot 'workspace'
$projectRoot = Join-Path $workspaceRoot $ProjectSlug

if (Test-Path -LiteralPath $projectRoot) {
    throw "Project folder already exists: $projectRoot"
}

New-Item -ItemType Directory -Path $projectRoot | Out-Null
$troubleshootingRoot = Join-Path $projectRoot 'troubleshooting'
New-Item -ItemType Directory -Path $troubleshootingRoot | Out-Null

$copies = @(
    @{ Source = '01-project-overview.md'; Destination = '01-project-overview.md' },
    @{ Source = '02-my-contribution.md'; Destination = '02-my-contribution.md' },
    @{ Source = '04-retrospective-outcomes.md'; Destination = '04-retrospective-outcomes.md' },
    @{ Source = '05-deck-plan.md'; Destination = '05-deck-plan.md' }
)

foreach ($copy in $copies) {
    Copy-Item -LiteralPath (Join-Path $templateRoot $copy.Source) -Destination (Join-Path $projectRoot $copy.Destination)
}

Copy-Item -LiteralPath (Join-Path $templateRoot '03-troubleshooting.md') -Destination (Join-Path $troubleshootingRoot 'TS-01.md')

$editableFiles = Get-ChildItem -LiteralPath $projectRoot -Recurse -File -Filter '*.md'
foreach ($file in $editableFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    $content = $content.Replace('- 프로젝트명:', "- 프로젝트명: $ProjectName")
    Set-Content -LiteralPath $file.FullName -Value $content -Encoding utf8
}

Write-Output "Created project workspace: $projectRoot"
