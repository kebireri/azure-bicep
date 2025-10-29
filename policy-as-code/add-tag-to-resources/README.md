# Azure Policy – Deny Resource Creation Without Department Tag

This project defines and enforces an Azure Policy that **denies the creation of any resource that does not include a `department` tag**.



---


                +-----------------------------+
                |  Policy Definition          |   (lives at subscription)
                |  Scope: Subscription        |
                +-----------------------------+
                            |
                            |  referenced by ID
                            ↓
                +-----------------------------+
                |  Policy Assignment          |   (applies the rule)
                |  Scope: Subscription        |
                |                             |
                +-----------------------------+

                    Architectural diagram

---

The project consists of two Bicep files:

### 1. `definition-require-tag` – Policy Definition

This file creates a **custom Azure Policy definition** at the subscription level.

**What it does:**
- Checks every new or updated resource for a `department` tag.
- If the tag is missing, the policy blocks the deployment (`effect: deny`).

**Purpose:**
Defines *what the rule is* — it tells Azure *how* to check resources and *what to do* if they fail the rule.

---

### 2. `assignment-require-tag` – Policy Assignment (Enforcement)

This file creates a **policy assignment** that applies the definition across the subscription.

**What it does:**
- Links to the policy definition created in `addResourceTag.bicep`.
- Enforces it at the subscription level so Azure blocks non-compliant resources.
- Gives the assignment a display name and description for easy tracking in the Azure Portal.

**Purpose:**
Defines *where* and *how* the policy is enforced — it activates the rule for real.