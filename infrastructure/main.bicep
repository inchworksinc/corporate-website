@description('Workload name')
param workload string

@description('Environment name')
param environment string

@description('Artifact name')
param artifact string

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
  Artifact: artifact
  Workload: workload
  BusinessUnit: businessUnit
  Environment: environment
  DeploymentIdentity: deploymentIdentity
  Monitorable: config.monitorable
}

@description('A module to configure App Service resources')
module appServiceModule 'app-service.bicep' = {
  name: '${resourceGroup().name}-app-service-module'
  scope: resourceGroup()
  params: {
    workload: workload
    artifact: artifact
    environment: environment
    location: location
    configuration: config
    tags: tags
  }
}

@description('A module to configure App Service resources')
module subnetModule 'subnet.bicep' = {
  name: '${resourceGroup().name}-subnet-module'
  scope: resourceGroup('rg-network-nonprod-eastus2-001')
  params: {
    vnet: vnet
  }
}
