targetScope = 'subscription'

// The main bicep module to provision Azure resources.
// For a more complete walkthrough to understand how this file works with azd,
// see https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/make-azd-compatible?pivots=azd-create

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

// Optional parameters to override the default azd resource naming conventions.
// Add the following to main.parameters.json to provide values:
// "resourceGroupName": {
//      "value": "myGroupName"
// }
param resourceGroupName string = ''

var abbrs = loadJsonContent('./abbreviations.json')

// tags that should be applied to all resources.
var tags = {
  // Tag all resources with the environment name.
  'azd-env-name': environmentName
}

// Generate a unique token to be used in naming resources.
// Remove linter suppression after using.
#disable-next-line no-unused-vars
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

// Name of the service defined in azure.yaml
// A tag named azd-service-name with this value should be applied to the service host resource, such as:
//   Microsoft.Web/sites for appservice, function
// Example usage:
//   tags: union(tags, { 'azd-service-name': apiServiceName })
//#disable-next-line no-unused-vars
//var apiServiceName = 'python-api'

// Organize resources in a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

// Add resources to be provisioned below.
// A full example that leverages azd bicep modules can be seen in the todo-python-mongo template:
// https://github.com/Azure-Samples/todo-python-mongo/tree/main/infra

module aiPlatformBaseline 'ai-platform-baseline.bicep' = {
  name: '${environmentName}-Deployment'
  scope: resourceGroup
  params: {
    environmentName: environmentName
    resourceToken: resourceToken
    tags: tags
  }
}

// Add outputs from the deployment here, if needed.
//
// This allows the outputs to be referenced by other bicep deployments in the deployment pipeline,
// or by the local machine as a way to reference created resources in Azure for local development.
// Secrets should not be added here.
//
// Outputs are automatically saved in the local azd environment .env file.
// To see these outputs, run `azd env get-values`,  or `azd env get-values --output json` for json output.
output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_SUBSCRIPTION_ID string = subscription().subscriptionId
output AZURE_RESOURCE_GROUP_NAME string = resourceGroup.name

// The application ID of the application insights component.
output APPLICATION_INSIGHTS_APPLICATION_ID string = aiPlatformBaseline.outputs.applicationInsightsApplicationId

// The connection string of the application insights component.
output APPLICATION_INSIGHTS_CONNECTION_STRING string = aiPlatformBaseline.outputs.applicationInsightsConnectionString

// The instrumentation key of the application insights component.
output APPLICATION_INSIGHTS_INSTRUMENTATION_KEY string = aiPlatformBaseline.outputs.applicationInsightsInstrumentationKey

// The name of the application insights component.
output APPLICATION_INSIGHTS_NAME string = aiPlatformBaseline.outputs.applicationInsightsName

// The resource ID of the application insights component.
output APPLICATION_INSIGHTS_RESOURCE_ID string = aiPlatformBaseline.outputs.applicationInsightsResourceId

// The name of the Azure Bastion host.
output BASTION_NAME string = aiPlatformBaseline.outputs.bastionName

// The resource ID of the Azure Bastion host.
output BASTION_RESOURCE_ID string = aiPlatformBaseline.outputs.bastionResourceId

// The name of the container registry.
output CONTAINER_REGISTRY_NAME string = aiPlatformBaseline.outputs.containerRegistryName

// The resource ID of the container registry.
output CONTAINER_REGISTRY_RESOURCE_ID string = aiPlatformBaseline.outputs.containerRegistryResourceId

// The name of the key vault.
output KEY_VAULT_NAME string = aiPlatformBaseline.outputs.keyVaultName

// The resource ID of the key vault.
output KEY_VAULT_RESOURCE_ID string = aiPlatformBaseline.outputs.keyVaultResourceId

// The URI of the key vault.
output KEY_VAULT_URI string = aiPlatformBaseline.outputs.keyVaultUri

// The name of the log analytics workspace.
output LOG_ANALYTICS_WORKSPACE_NAME string = aiPlatformBaseline.outputs.logAnalyticsWorkspaceName

// The resource ID of the log analytics workspace.
output LOG_ANALYTICS_WORKSPACE_RESOURCE_ID string = aiPlatformBaseline.outputs.logAnalyticsWorkspaceResourceId

// The name of the storage account.
output STORAGE_ACCOUNT_NAME string = aiPlatformBaseline.outputs.storageAccountName

// The resource ID of the storage account.
output STORAGE_ACCOUNT_RESOURCE_ID string = aiPlatformBaseline.outputs.storageAccountResourceId

// The name of the virtual machine.
output VIRTUAL_MACHINE_NAME string = aiPlatformBaseline.outputs.virtualMachineName

// The resource ID of the virtual machine.
output VIRTUAL_MACHINE_RESOURCE_ID string = aiPlatformBaseline.outputs.virtualMachineResourceId

// The name of the virtual network.
output VIRTUAL_NETWORK_NAME string = aiPlatformBaseline.outputs.virtualNetworkName

// The resource ID of the virtual network.
output VIRTUAL_NETWORK_RESOURCE_ID string = aiPlatformBaseline.outputs.virtualNetworkResourceId

// The name of the subnet in the virtual network.
output VIRTUAL_NETWORK_SUBNET_NAME string = aiPlatformBaseline.outputs.virtualNetworkSubnetName

// The resource ID of the subnet in the virtual network.
output VIRTUAL_NETWORK_SUBNET_RESOURCE_ID string = aiPlatformBaseline.outputs.virtualNetworkSubnetResourceId

// The principal ID of the workspace hub system assigned identity, if applicable.
output WORKSPACE_HUB_MANAGED_IDENTITY_PRINCIPAL_ID string = aiPlatformBaseline.outputs.workspaceHubManagedIdentityPrincipalId

// The name of the workspace hub.
output WORKSPACE_HUB_NAME string = aiPlatformBaseline.outputs.workspaceHubName

// The resource ID of the workspace hub.
output WORKSPACE_HUB_RESOURCE_ID string = aiPlatformBaseline.outputs.workspaceHubResourceId

// The principal ID of the workspace project system assigned identity.
output WORKSPACE_PROJECT_MANAGED_IDENTITY_PRINCIPAL_ID string = aiPlatformBaseline.outputs.workspaceProjectManagedIdentityPrincipalId

// The name of the workspace project.
output WORKSPACE_PROJECT_NAME string = aiPlatformBaseline.outputs.workspaceProjectName

// The resource ID of the workspace project.
output WORKSPACE_PROJECT_RESOURCE_ID string = aiPlatformBaseline.outputs.workspaceProjectResourceId
