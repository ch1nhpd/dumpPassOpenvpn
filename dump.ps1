$keys = Get-ChildItem "HKCU:\Software\OpenVPN-GUI\configs"
$items = $keys | ForEach-Object {Get-ItemProperty $_.PsPath}

foreach ($item in $items)
{
  $encryptedbytes=$item.'auth-data'
  $entropy=$item.'entropy'
  $entropy=$entropy[0..(($entropy.Length)-2)]

  $decryptedbytes = [System.Security.Cryptography.ProtectedData]::Unprotect(
    $encryptedBytes, 
    $entropy, 
    [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
 
  Write-Host ([System.Text.Encoding]::Unicode.GetString($decryptedbytes))
}