targetScope = 'subscription'

resource addResourceTag 'Microsoft.Authorization/policyDefinitions@2025-03-01' = {
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


/* To deploy this Bicep file, use the following Azure CLI command:
  az deployment sub create \
  --location <set-location> \
  --template-file <file-name> 
*/
