targetScope = 'subscription'

resource governanceInitiative 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'governance-initiative'
  properties: {
    displayName: 'Governance Initiative'
    description: 'An initiative to enforce governance policies including location restrictions and tagging requirements.'
    metadata: {
      category: 'Governance'
      version: '1.0.0'
    }

    parameters: {
      allowedLocations: { 
        type: 'Array'
        metadata: { 
          displayName: 'Allowed Locations'
          description: 'Regions permitted for resource creation (must be within the policys allowedValues.)'
        } 
      }
    }
    policyDefinitions: [
      {
        policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'addResourceTag')
      }
      {
        policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'preSelectedLocations')
        parameters: {
          allowedLocations: {
            value: '[parameters(allowedLocations)]'
          }
        }
      }
      {
        policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'addAndMoify')
      }
    ] 
  }
}
