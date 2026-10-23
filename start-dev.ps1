$root = $PSScriptRoot

$targets = @(
    'services\auth-service',
    'services\customer-service',
    'services\product-service',
    'services\order-service',
    'services\shipment-service',
    'api-gateway'
)

foreach ($t in $targets) {
    $dir = Join-Path $root $t

    if (-not (Test-Path $dir)) {
        Write-Warning "Folder not found: $dir"
        continue
    }

    Start-Process powershell.exe `
        -WorkingDirectory $dir `
        -ArgumentList '-NoExit', '-Command', 'npm start'
}

Write-Host "Started development service windows."