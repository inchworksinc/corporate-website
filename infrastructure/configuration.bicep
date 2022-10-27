@description('Environment name')
@allowed([
  'dev'
  'test'
  'uat'
  'bfx'
  'prd'
])
param environment string

var environmentConfigurationMap = {
  dev: {
    sku: 'B1' // 1 core, 1.75 GB RAM and 10 GB storage. Slots are not supported on this tier.
    monitorable: 'N' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    virtualNetworkName: 'vnet-network-non-prod-eastus2-001'
    virtualNetworkResourceGroupName: 'rg-network-nonprod-eastus2-001'
    subnetName: 'AppServiceSubnet' // Name of the subnet dedicated to App Service
    allowedIpAddressCIDRs: [{
      name: 'Anjaneya Datla Home IP'
      address: '47.14.119.47/32'
    }] // List of the IP's allowed to view the App in non-production environments
  }
  test: { // test/qa environment
    sku: 'S2' // 2 cores, 3.50 GB RAM and 50 GB storage. Slots are supported on this tier. Temporarily using this tier in non-prod to test blue green deployments.
    virtualNetworkName: '8fa19545-fca3-4e39-8316-8d41fc9d7d96-iw-vnet-eastus2'
    virtualNetworkResourceGroupName: 'iw-vnet-eastus2'
    subnetName: 'snet-app-prd-eastus2-01' // Name of the subnet dedicated to App Service
    monitorable: 'N' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    allowedIpAddressCIDRs: [{
      name: 'Anjaneya Datla Home IP'
      address: '47.14.119.47/32'
    }] // List of the IP's allowed to view the App in non-production environments
  }
  uat: { // uat environment
    sku: 'B1' // 1 core, 1.75 GB RAM and 10 GB storage. Slots are not supported on this tier.
    monitorable: 'N' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    virtualNetworkName: '8fa19545-fca3-4e39-8316-8d41fc9d7d96-iw-vnet-eastus2'
    virtualNetworkResourceGroupName: 'iw-vnet-eastus2'
    subnetName: 'snet-app-prd-eastus2-01' // Name of the subnet dedicated to App Service
    allowedIpAddressCIDRs: [{
      name: 'Anjaneya Datla Home IP'
      address: '47.14.119.47/32'
    }] // List of the IP's allowed to view the App in non-production environments
  }
  bfx: { // breakfix/staging environment
    sku: 'B1' // 1 core, 1.75 GB RAM and 10 GB storage. Slots are not supported on this tier.
    monitorable: 'Y' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    virtualNetworkName: '8fa19545-fca3-4e39-8316-8d41fc9d7d96-iw-vnet-eastus2'
    virtualNetworkResourceGroupName: 'iw-vnet-eastus2'
    subnetName: 'snet-app-prd-eastus2-01' // Name of the subnet dedicated to App Service
    allowedIpAddressCIDRs: [{
      name: 'Anjaneya Datla Home IP'
      address: '47.14.119.47/32'
    }] // List of the IP's allowed to view the App in non-production environments
  }
  prd: { // production environment
    sku: 'S2' // 2 cores, 3.50 GB RAM and 50 GB storage. Slots are supported on this tier.
    monitorable: 'Y' // Flag to indicate if the app needs to be monitored on dynatrace. Y for Yes, N for No
    virtualNetworkName: '8fa19545-fca3-4e39-8316-8d41fc9d7d96-iw-vnet-eastus2'
    virtualNetworkResourceGroupName: 'iw-vnet-eastus2'
    subnetName: 'snet-app-prd-eastus2-01' // Name of the subnet dedicated to App Service
    allowedIpAddressCIDRs: [{
      name: 'Internet'
      address: '0.0.0.0/0'
    }] // This IP should point to the CDN so that users can reach the app only via the CDN.
  }
}

output settings object = environmentConfigurationMap[environment]
