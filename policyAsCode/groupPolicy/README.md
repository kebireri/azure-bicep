## Overview
This project implements **Azure Governance using Policy as Code** with **Bicep**.  
It automates the creation and management of Azure Policy definitions, initiatives, and assignments to enforce organizational standards across cloud resources.

The initiative combines three key governance rules:
1. **Department Tag Enforcement** – denies deployments that lack a `department` tag.  
2. **Allowed Locations** – restricts resource creation to approved Azure regions.  
3. **Cost Center Tag Remediation** – automatically adds or fixes the `costCenter` tag where missing.

By managing all of this in **code**, the project enables consistent, repeatable, and auditable cloud governance, aligning with modern **Infrastructure as Code (IaC)** and **DevOps** practices.