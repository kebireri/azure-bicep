param location string = 'eastus'
param vmSize string = 'Standard_B2s'  // small + widely available

param adminUsername string
@secure()
param adminPassword string

resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01' = {
   name: 'labvnet'
  location: location
  properties: {
   addressSpace: {
     addressPrefixes: [
       '10.13.37.0/24'
     ]
   }
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefix: '10.13.37.0/24'
        }
       }
    ]
  }
}


resource nic 'Microsoft.Network/networkInterfaces@2024-10-01' = {
  name: 'labvmnic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
               id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, 'subnet1')
            }
          }
         }
       ]
    }
}


resource vm 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: 'myVM'
  location: 'eastus'
   properties: {
     hardwareProfile: {
       vmSize: vmSize
     }
      osProfile: {
         computerName: 'myVM'
         adminUsername: adminUsername
         adminPassword: adminPassword
      }
       storageProfile: {
         imageReference: {
           publisher: 'MicrosoftWindowsServer'
           offer: 'WindowsServer'
           sku: '2022-Datacenter'
           version: 'latest'
         }
       }
        networkProfile: {
          networkInterfaces: [
            {
              id: nic.id
            }
          ]
   }
  }
}
