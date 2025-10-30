targetScope = 'subscription'


resource preSelectedLocations 'Microsoft.Authorization/policyDefinitions@2025-03-01' = {
  name: 'preSelectedLocations'
  properties: { 
    displayName: 'allowed location'
    description: 'Restrict resource deployment to pre-selected locations'
    mode: 'All'
    metadata: {
      category: 'General'
      version: '1.0.0'}
    
    parameters: { 
      allowedLocations: { 
        type: 'Array'
        metadata: { 
          displayName: 'Allowed Locations'
          description: 'The list of locations that can be specified when deploying resources.'
        } 
        defaultValue: ['eastus']
        allowedValues: [
          'eastus'
          'westus'
          'centralus'
          'eastus2'
          'westus2'
        ]        
      }
    }
    policyRule: { 
      if: { 
        field: 'location'
        notIn: '[parameters(allowedLocations)]'
        } 
      then: { 
        effect: 'deny' 
      } 
    }
  } 
}
 
      
     