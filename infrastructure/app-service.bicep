@description('Workload name')
param workload string

@description('Environment name')
param environment string

@description('Region for all resources in this module')
param location string

@description('Environment specific configuration settings')
param configuration object = {}

@description('Resource Tags')
param tags object = {}

@description('Runtime stack')
param linuxFxVersion string = 'node|16-lts'

@description('Default DNS Zone name for azure services')
param privateDNSZoneName string = 'privatelink.azurewebsites.net'

@description('Virtual Network Id')
param virtualNetworkId string

@description('Private Endpoint Subnet Id')
param subnetId string

@description('An App service plan to host the app')
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'plan-${workload}-${environment}-${location}-01'
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
resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: 'app-${workload}-${environment}-${location}-01'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlan.id
    //virtualNetworkSubnetId: appServiceSubnetId
    siteConfig: {
      //vnetRouteAllEnabled: true
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
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
  name: 'app-${workload}-${environment}-${location}-01'
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// @description('An App service slot to carryout blue green deployment')
// resource appservice_slot 'Microsoft.Web/sites/slots@2020-06-01' = if(environment == 'prd' || environment == 'qa'){ // creating a slot in qa for testing purposes. The condition for checking tst can be removed once testing blue green is done.
//   name: '${appService.name}/green'
//   kind: 'app'
//   location: location
//   tags: tags
//   properties: {
//     serverFarmId: appServicePlan.id
//   }
// }


resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: 'pep-${workload}-${environment}-${location}-01'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'plconnection-${workload}-${environment}'
        properties: {
          privateLinkServiceId: appService.id
          groupIds: [
            'sites'
          ]
        }
      }
    ]
  }
}

resource privateDnsZones 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDNSZoneName
  location: 'global'
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones
  name: '${privateDnsZones.name}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-03-01' = {
  parent: privateEndpoint
  name: 'privatednsgroupname'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${workload}-${environment}-config'
        properties: {
          privateDnsZoneId: privateDnsZones.id
        }
      }
    ]
  }
}

output appService object = appService

