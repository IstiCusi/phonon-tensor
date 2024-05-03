# Experimental Windows Port


function CheckAndSetNumaNodes {
    $numaNodeStatus = 0
    $paths = Get-ChildItem -Path "C:\sys\bus\pci\devices\*" -Filter numa_node -File
    foreach ($path in $paths) {
        if ((Get-Content $path.FullName) -ne "0") {
            $numaNodeStatus = 1
            break
        }
    }

    if ($numaNodeStatus -eq 1) {
        Write-Host "Not all NUMA nodes are set to 0. Do you want to set all NUMA nodes to 0? [y/n]"
        $answer = Read-Host
        if ($answer -eq "y") {
            Write-Host "Setting all NUMA nodes to 0 with sudo..."
            foreach ($path in $paths) {
                "0" | Set-Content $path.FullName
            }
            Write-Host "All NUMA nodes have been set to 0."
        } else {
            Write-Host "Continuing without changing NUMA nodes."
        }
    } else {
        Write-Host "All NUMA nodes are already set to 0."
    }
}

function Tensor {
    $image = "tensor"
    $baseCommand = "docker run -p 8888:8888 --gpus all -it -v ${PWD}:/home/phonon/workingdir -v /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$env:DISPLAY $image"

    CheckAndSetNumaNodes

    Start-Process -FilePath "xhost" -ArgumentList "+local:tensor"

    if ([string]::IsNullOrEmpty($args[0])) {
        Write-Host "Starting interactive TensorFlow GPU session..."
        Invoke-Expression "$baseCommand zsh"
    } else {
        $scriptPath = $args[0]
        if (-Not (Test-Path $scriptPath)) {
            Write-Host "Error: Script '$scriptPath' does not exist."
            return
        }

        Write-Host "Running Python script '$scriptPath' in the TensorFlow container..."
        Invoke-Expression "$baseCommand bash -c 'cd /home/phonon/workingdir && python $scriptPath; exec bash'"
    }

    Start-Process -FilePath "xhost" -ArgumentList "-local:tensor"
}

Write-Host "Function tensor defined."

