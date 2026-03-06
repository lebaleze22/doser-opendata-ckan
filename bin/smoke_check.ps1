param(
  [string]$BaseUrl = "http://localhost:5000"
)

$ErrorActionPreference = "Stop"

$targets = @(
  "/",
  "/dataset",
  "/organization",
  "/group",
  "/about",
  "/api/3/action/status_show"
)

$failed = $false

foreach ($path in $targets) {
  $url = "$BaseUrl$path"
  try {
    $res = Invoke-WebRequest -Uri $url -Method Get -TimeoutSec 20 -UseBasicParsing
    $ok = $res.StatusCode -ge 200 -and $res.StatusCode -lt 400
    if ($ok) {
      Write-Host "[OK]  $($res.StatusCode) $url"
    }
    else {
      $failed = $true
      Write-Host "[ERR] $($res.StatusCode) $url"
    }
  }
  catch {
    $failed = $true
    Write-Host "[ERR] --- $url"
    Write-Host "      $($_.Exception.Message)"
  }
}

if ($failed) {
  exit 1
}

Write-Host "Smoke check passed."
