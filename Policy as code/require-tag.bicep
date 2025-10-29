targetScope = 'subscription'
resource policyTag 'Microsoft.Authorization/policyDefinitions@2025-03-01' = {
   name: 'addResourceTag'
   properties: {
     displayName: 'department'
     description: 'Include the department tag'
     policyRule: {
       if: {
         not : {
           field: 'tags.department'
           exists: true
         }
       }
        then: {
          effect: 'deny'
        }
     }
   }
    
}
