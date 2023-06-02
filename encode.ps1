# Variables
$sourceDir = (Resolve-Path ".\Source").Path  # Set this to the root of your DVD collection
$outputDir = ".\Encoded"  # Set this to where you want the transcoded files to go
$handbrakePath = ".\HandBrakeCLI.exe"  # Path to HandBrakeCLI.exe
$presetPath = ".\preset.json"  # Path to your preset file
$presetName = "BluRay Rip 1080p"  # Set this to your HandBrake profile

# Create output directory if it doesn't exist
if (!(Test-Path -Path $outputDir)) {
    New-Item -ItemType directory -Path $outputDir
}

# Function to transcode a file
function Transcode-File($sourceFile, $outputFile, $profile) {
    & $handbrakePath --preset-import-file $presetPath -Z $presetName -i $sourceFile -o $outputFile
}

# Function to format folder name to proper case
function Format-FolderName($folderName) {
    $folderName = $folderName.ToLower().Replace("_", " ")
    $folderName = (Get-Culture).TextInfo.ToTitleCase($folderName)
    return $folderName
}

# Walk through the directory structure
Get-ChildItem -Path $sourceDir -Recurse -File | Where-Object { $_.Extension -eq ".mkv" } | ForEach-Object {
    $sourceFile = $_.FullName
    $relativePath = $_.FullName.Replace($sourceDir, '').TrimStart('\')
    $folderName = Format-FolderName -folderName $_.Directory.Name
    $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $newFileName = "${folderName}_${fileNameWithoutExtension}.mp4"
    $outputFile = Join-Path $outputDir ($relativePath -replace [regex]::Escape($_.Name), $newFileName)

    # Create output directory for this file if it doesn't exist
    $outputDirForFile = Split-Path -Path $outputFile -Parent
    if (!(Test-Path -Path $outputDirForFile)) {
        New-Item -ItemType directory -Path $outputDirForFile
    }

    # Transcode the file
    Transcode-File -sourceFile $sourceFile -outputFile $outputFile -profile $profile
}
