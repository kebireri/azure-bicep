## Overview
This project implements **Azure Governance using Policy as Code** with **Bicep**.  
It automates the creation and management of Azure Policy definitions, initiatives, and assignments to enforce organizational standards across cloud resources.

The initiative combines three key governance rules:
1. **Department Tag Enforcement** – denies deployments that lack a `department` tag.  
2. **Allowed Locations** – restricts resource creation to approved Azure regions.  
3. **Cost Center Tag Remediation** – automatically adds or fixes the `costCenter` tag where missing.

By managing all of this in **code**, the project enables consistent, repeatable, and auditable cloud governance, aligning with modern **Infrastructure as Code (IaC)** and **DevOps** practices.


                    Architectural Diagram

        +----------------------------------+
        | Policy Definitions (x3)          |   (live at Subscription)
        | - Require Department Tag (deny)  |
        | - Allowed Locations (deny)       |
        | - Ensure CostCenter (modify)     |
        +----------------------------------+
                        |  referenced by ID
                        v
        +----------------------------------+
        | Policy Initiative (Policy Set)   |   (lives at Subscription)
        | - Groups the 3 definitions       |
        | - Optional param mapping         |--> e.g., initiative.allowedLocations
        +----------------------------------+          ↳ maps to locations policy param
                        |  policySetDefinitionId
                        v
        +----------------------------------+
        | Policy Assignment (of Initiative)|   (applies the pack)
        | Scope: Subscription or RG        |
        | - Parameters (values only)       |--> e.g., ['uksouth','ukwest'] (if exposed)
        | - Managed Identity (optional)    |--> needed for modify/DFNE remediation
        +----------------------------------+
                        |  runs against resources in scope
                        v
        +----------------------------------+
        | Compliance Evaluation            |   (continuous scans / on-demand)
        | - Compliant / Non-compliant      |
        +----------------------------------+
                        |  optional (for modify/DFNE)
                        v
        +----------------------------------+
        | Remediation Task                 |
        | - Uses assignment's MI + roles   |
        | - Fixes existing non-compliance  |
        +----------------------------------+