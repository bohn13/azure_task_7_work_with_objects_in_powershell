$files = Get-ChildItem -Path .\data -Filter *.json

$TargetVM = "Standard_B2pts_v2"

$regions = @()

foreach($file in $files) {
    $json = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    $foundVm = $json | Where-Object { $_.name -eq $TargetVM}

    if ($foundVm) {
        Write-Host "Found VM: $($foundVm.name) in file: $($file.FullName)"
        $regions += $file.BaseName
    } else {
        Write-Host "VM: $TargetVM not found in file: $($file.FullName)"
    }

}

$regions | ConvertTo-Json | Out-File -FilePath ./result.json