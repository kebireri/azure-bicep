targetScope = 'subscription'


param allowedLocations array = [
  'eastus'
  'westus'
  'centralus'
  'eastus2'
  'westus2'
]
resource governanceAssignment 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'govenance-assignment'

// Additional bits to grant the assignment its own managed identity for remediation
  identity: {
    type: 'SystemAssigned'    // grants the assignment its own MI
  }


  properties: {
    displayName: 'Governance Assignment'
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'governance-initiative')
    parameters: {
      allowedLocations: {
        value: allowedLocations
      }
    }
  }
}

// To deploy this Bicep file, use the following Azure CLI command:
 // az deployment sub create \
 // --location <set-location> \
 // --template-file <file-name> 

 // To build this Bicep file into an ARM template, use the following Azure CLI command:
 // az bicep build --file <file-name>

 //To validate this Bicep file, use the following Azure CLI command:
 // az deployment sub validate --location <select-location> --template-file <file-name>
