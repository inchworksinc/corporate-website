@description('Workload name abbreviation')
param workload string

@description('Environment name abbreviation')
param environment string

@description('Business Unit name. In this case its the Marketing Unit')
param businessUnit string = 'marketing'

@description('Resource Group location')
param location string = resourceGroup().location

@description('Deployment Identity name')
param deploymentIdentity string

@description('A module that defines all the environment specific configuration')
module configModule 'configuration.bicep' = {
  name: '${resourceGroup().name}-config-module'
  scope: resourceGroup()
  params: {
    environment: environment
  }
}
@description('A variable to hold all environment specific variables')
var config = configModule.outputs.settings

@description('The tags to be added for this workload')
var tags = {
  Workload: workload
  BusinessUnit: businessUnit
  Environment: environment
  DeploymentIdentity: deploymentIdentity
  Monitorable: config.monitorable
}

@description('Obtaining reference to the subnet dedicated to the App Service Management with delegation to Microsoft.Web/serverfarms')
resource appServiceSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name: '${config.virtualNetworkName}/${config.subnetName}'
  scope: resourceGroup(config.virtualNetworkResourceGroupName)
}


@description('A module to configure App Service resources')
module appServiceModule 'app-service.bicep' = {
  name: '${resourceGroup().name}-app-service-module'
  scope: resourceGroup()
  params: {
    workload: workload
    environment: environment
    location: location
    configuration: config
    appServiceSubnetId: appServiceSubnet.id
    tags: tags
  }
}
