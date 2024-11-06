targetScope = 'resourceGroup'

@minLength(1)
param environmentName string

@minLength(3)
param resourceToken string

param tags object


var abbrs = loadJsonContent('./abbreviations.json')

module aiPlatformBaseline 'br/public:avm/ptn/ai-platform/baseline:0.6.1' = {
  name: 'aiPlatformBaselineDeployment'
  params: {
    name: '${environmentName}-${resourceToken}'
    location: resourceGroup().location
    tags: tags

    // NOTE: we are disabling most of the security features for this baseline deployment
    // to make it easier to get started learning. 
    // You should enable these features in a production

    bastionConfiguration: {
      enabled: false 
    }
    containerRegistryConfiguration: {
      name: '${abbrs.containerRegistryRegistries}${resourceToken}'
    }
    keyVaultConfiguration: {
      name: '${abbrs.keyVaultVaults}${environmentName}-${take(resourceToken, 24 - 1 - length(abbrs.keyVaultVaults) - length(environmentName))}'
      enablePurgeProtection: false
    }
    storageAccountConfiguration: {
      name: '${abbrs.storageStorageAccounts}${resourceToken}'

    }
    virtualMachineConfiguration: {
      enabled: false
    }
    virtualNetworkConfiguration: {
      enabled: false
    }
    workspaceConfiguration: {
     networkIsolationMode:'AllowInternetOutbound'
    }
  }
}

@description('The resource ID of the application insights component.')
output applicationInsightsResourceId string = aiPlatformBaseline.outputs.applicationInsightsResourceId

@description('The name of the application insights component.')
output applicationInsightsName string = aiPlatformBaseline.outputs.applicationInsightsName

@description('The application ID of the application insights component.')
output applicationInsightsApplicationId string = aiPlatformBaseline.outputs.applicationInsightsApplicationId

@description('The instrumentation key of the application insights component.')
output applicationInsightsInstrumentationKey string = aiPlatformBaseline.outputs.applicationInsightsInstrumentationKey

@description('The connection string of the application insights component.')
output applicationInsightsConnectionString string = aiPlatformBaseline.outputs.applicationInsightsConnectionString

@description('The resource ID of the log analytics workspace.')
output logAnalyticsWorkspaceResourceId string = aiPlatformBaseline.outputs.logAnalyticsWorkspaceResourceId

@description('The name of the log analytics workspace.')
output logAnalyticsWorkspaceName string = aiPlatformBaseline.outputs.logAnalyticsWorkspaceName

@description('The resource ID of the key vault.')
output keyVaultResourceId string = aiPlatformBaseline.outputs.keyVaultResourceId

@description('The name of the key vault.')
output keyVaultName string = aiPlatformBaseline.outputs.keyVaultName

@description('The URI of the key vault.')
output keyVaultUri string = aiPlatformBaseline.outputs.keyVaultUri

@description('The resource ID of the storage account.')
output storageAccountResourceId string = aiPlatformBaseline.outputs.storageAccountResourceId

@description('The name of the storage account.')
output storageAccountName string = aiPlatformBaseline.outputs.storageAccountName

@description('The resource ID of the container registry.')
output containerRegistryResourceId string = aiPlatformBaseline.outputs.containerRegistryResourceId

@description('The name of the container registry.')
output containerRegistryName string = aiPlatformBaseline.outputs.containerRegistryName

@description('The resource ID of the workspace hub.')
output workspaceHubResourceId string = aiPlatformBaseline.outputs.workspaceHubResourceId

@description('The name of the workspace hub.')
output workspaceHubName string = aiPlatformBaseline.outputs.workspaceHubName

@description('The principal ID of the workspace hub system assigned identity, if applicable.')
output workspaceHubManagedIdentityPrincipalId string = aiPlatformBaseline.outputs.workspaceHubManagedIdentityPrincipalId

@description('The principal ID of the workspace project system assigned identity.')
output workspaceProjectManagedIdentityPrincipalId string = aiPlatformBaseline.outputs.workspaceProjectManagedIdentityPrincipalId

@description('The resource ID of the workspace project.')
output workspaceProjectResourceId string = aiPlatformBaseline.outputs.workspaceProjectResourceId

@description('The name of the workspace project.')
output workspaceProjectName string = aiPlatformBaseline.outputs.workspaceProjectName

@description('The resource ID of the virtual network.')
output virtualNetworkResourceId string = aiPlatformBaseline.outputs.virtualNetworkResourceId

@description('The name of the virtual network.')
output virtualNetworkName string = aiPlatformBaseline.outputs.virtualNetworkName

@description('The resource ID of the subnet in the virtual network.')
output virtualNetworkSubnetResourceId string = aiPlatformBaseline.outputs.virtualNetworkSubnetResourceId

@description('The name of the subnet in the virtual network.')
output virtualNetworkSubnetName string = aiPlatformBaseline.outputs.virtualNetworkSubnetName

@description('The resource ID of the Azure Bastion host.')
output bastionResourceId string = aiPlatformBaseline.outputs.bastionResourceId

@description('The name of the Azure Bastion host.')
output bastionName string = aiPlatformBaseline.outputs.bastionName

@description('The resource ID of the virtual machine.')
output virtualMachineResourceId string = aiPlatformBaseline.outputs.virtualMachineResourceId

@description('The name of the virtual machine.')
output virtualMachineName string = aiPlatformBaseline.outputs.virtualMachineName
