$ports = @(3000, 50051, 50052, 50053, 50054, 50055)

foreach ($port in $ports) {
    $listeners = Get-NetTCPConnection `
        -LocalPort $port `
        -State Listen `
        -ErrorAction SilentlyContinue

    foreach ($listener in $listeners) {
        $process = Get-Process `
            -Id $listener.OwningProcess `
            -ErrorAction SilentlyContinue

        if ($process -and $process.ProcessName -eq 'node') {
            Stop-Process -Id $process.Id -Force
            Write-Host "Stopped node process on port $port"
        }
        elseif ($process) {
            Write-Warning "Port $port is used by $($process.ProcessName). Not stopped."
        }
    }
}

Write-Host "Stop check completed."