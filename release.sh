# Repository details
$REPO_OWNER = "Antony-Silvesta"
$REPO_NAME = "Build"
$TOKEN = ""  # Optional: Add your GitHub token if accessing private repositories
$DOWNLOAD_DIR = "C:\Users\$(whoami)\Downloads\Build"  # Adjust the path as needed

# Ensure the download directory exists
if (-not (Test-Path -Path $DOWNLOAD_DIR)) {
    New-Item -ItemType Directory -Path $DOWNLOAD_DIR
}

# Fetch the latest release information from GitHub API
$API_URL = "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"
$Headers = @{ }
if ($TOKEN) {
    $Headers.Add("Authorization", "token $TOKEN")
}

# Send the GET request to fetch release data
$RELEASE_INFO = Invoke-RestMethod -Uri $API_URL -Headers $Headers

# Debugging: Print release info
Write-Host "Release Information: $RELEASE_INFO"

# Parse the release asset download URLs
$ASSET_URLS = $RELEASE_INFO.assets | ForEach-Object { $_.browser_download_url }

# Check if any assets were found
if ($ASSET_URLS.Count -eq 0) {
    Write-Host "No assets found for the latest release."
    exit 1
}

# Download each asset
foreach ($ASSET_URL in $ASSET_URLS) {
    Write-Host "Downloading $ASSET_URL..."
    $FILENAME = [System.IO.Path]::GetFileName($ASSET_URL)
    $DEST_PATH = Join-Path -Path $DOWNLOAD_DIR -ChildPath $FILENAME
    Invoke-WebRequest -Uri $ASSET_URL -OutFile $DEST_PATH
}

Write-Host "Download completed. Files saved to $DOWNLOAD_DIR."
