@description('Workload name')
param workload string

@description('Environment name')
param environment string

@description('Artifact name')
param artifact string

@description('Region for all resources in this module')
param location string

@description('Environment specific configuration settings')
param configuration object = {}

@description('Resource Tags')
param tags object = {}

@description('Runtime stack')
param linuxFxVersion string = 'node|16-lts'

@description('An App service plan to host the app')
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'plan-${workload}-${artifact}-${environment}-${location}'
  location: location
  tags: tags
  sku: {
    name: configuration.sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

@description('An App service to run the app')
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: 'app-${workload}-${artifact}-${environment}-${location}'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      appSettings:[
        {
        name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
        value: 'true'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'environment'
          value: environment
        }
        {
          name: 'SCM_MAX_ZIP_PACKAGE_COUNT'
          value: '1' // keeping only the recent zip uploaded to app service
        }
    ]
    healthCheckPath: '/'
    ipSecurityRestrictions: [ for ip in configuration.allowedIpAddressCIDRs: {
        action: 'Allow'
        priority: 100
        name: ip.name
        ipAddress: ip.address
      }]
    }
  }
}




@description('An Application Insights resource for logging')
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'app-${workload}-${artifact}-${environment}-${location}'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

@description('An App service slot to carryout blue green deployment')
resource appservice_slot 'Microsoft.Web/sites/slots@2020-06-01' = if(environment == 'prd' || environment == 'qa'){ // creating a slot in qa for testing purposes. The condition for checking tst can be removed once testing blue green is done.
  name: '${appService.name}/green'
  kind: 'app'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
  }
}


output appService object = appService

