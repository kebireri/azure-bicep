targetScope = 'subscription'

resource addAndMoify 'Microsoft.Authorization/policyDefinitions@2025-03-01' = {
  name: 'addAndMoify'
  properties: {
    displayName: 'costCenter'
    description: 'Add or modify the cost center tag on resources'
    mode: 'All'
    policyRule: { 
      if: {
        anyOf: [
          // Tag does not exist
          {
            field: 'tags.costCenter'
            exists: false
          }
          // Tag exists but is empty
          {
            allof: [
              {
                field: 'tags.costCenter'
                exists: true
              }
              
              {
                field: 'tags.costCenter'
                equals: ''
              }
            
            ] 
          }
        ]
        
      }

      then: {
        effect: 'modify'
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/797f4846-ba00-4fd7-ba43-dac1f8f63013' // Contributor Role
          ]
          operations: [
            {
              operation: 'addOrReplace'
              field: 'tags.costCenter'
              value: 'Finance'
            }
          ]
        }
      }
    }
  }
}
