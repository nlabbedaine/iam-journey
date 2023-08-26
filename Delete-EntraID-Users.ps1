### Basic MS Graph commands lines for Entra ID administration - a learning session ###

# Install the module needed
Install-Module -Name Microsoft.Graph

# Import the Module
Import-Module Microsoft.Graph

# Method 1
# Basic way to connect MS Graph with your user
$scopes = @(
    "Permissions1",
    "Permissions2"
)
 
Connect-MgGraph -Scopes $scopes

# Method 2
# Improved method to connect your script from your local system
# Create a self-signed certificate and an app registration to establish a connection to MS Graph with your script "https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-self-signed-certificate"
# Create an app registration with the necessary permissions and associate your certificate "https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app"

Connect-MgGraph `
    -ClientId "***" `
    -TenantId "***" `
    -CertificateThumbprint "***"

# Retrieving a list of UPNs from a csv file
$Path = "C:\your\path\to\the\file.csv"
$users = Import-Csv -Path $Path -Delimiter "," -Encoding utf8


# Iterating through each Users in the previous CSV file to find the ObjectID of a user's UPN
foreach ($user in $users) {
    $ObjectId = (Get-MgUser -Filter "UserPrincipalName eq '$($user.UPN)'").Id
    Write-Output "'$ObjectId' = '$($user.UPN)'"

    #Delete a users
    Remove-MgUser -UserId $ObjectId
    #Restore a users
    Restore-MgDirectoryDeletedItem -DirectoryObjectId $ObjectId
}

