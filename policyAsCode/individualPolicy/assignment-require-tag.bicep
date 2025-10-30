targetScope = 'subscription'

var policyDefinitionId = subscriptionResourceId('Microsoft.Authorization/policyDefinitions', 'addResourceTag')

resource assignAddResourceTag 'Microsoft.Authorization/policyAssignments@2025-03-01' = {
  name: 'assign-addResourceTag'
  properties: {
    displayName: 'Enforce department tag assignment'
    policyDefinitionId: policyDefinitionId
    description: 'This policy assignment enforces the presence of the department tag on resources.'
  }
}





/* To deploy this Bicep file, use the following Azure CLI command:
  az deployment sub create \
  --location <set-location> \
  --template-file <file-name> 
*/
