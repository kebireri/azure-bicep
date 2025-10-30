
resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
   name: 'mystoragesccountnamekev'
   location: 'eastus'
   sku: {
     name: 'Standard_LRS'
   }
  kind: 'BlobStorage'
  properties: {
     accessTier: 'Hot'
     allowBlobPublicAccess: true
   }
}
