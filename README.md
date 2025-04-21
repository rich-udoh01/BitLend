# BitLend – Decentralized Lending Protocol on Stacks

**BitLend** is a credit-based decentralized lending protocol built on the [Stacks](https://www.stacks.co) blockchain that enables users to borrow STX tokens using a dynamic credit scoring system. The protocol rewards responsible borrowing with lower interest rates and collateral requirements, enabling a more inclusive and risk-adjusted lending environment.

## Overview

BitLend introduces a **Bitcoin-secured** credit economy by leveraging Stacks’ smart contract capabilities. It integrates a **credit score mechanism** that evolves based on user behavior, enabling **permissionless**, **trust-minimized**, and **efficient lending and borrowing**.

## Features

- **Dynamic Credit Score (50–100):** Adjusts based on repayment behavior and loan defaults.
- **Collateral Optimization:** Higher credit scores reduce collateral requirements.
- **Flexible Interest Rates:** Lower interest for users with better credit scores.
- **Automated Loan Management:** Handles repayments, loan closures, and defaults.
- **Incentivized Responsibility:** Good behavior improves loan terms over time.

## Architecture

### Data Maps

- `UserScores`: Tracks user credit scores, loan history, and repayment behavior.
- `Loans`: Stores loan details, including terms, status, and repayment amounts.
- `UserLoans`: Maintains a list of a user's currently active loan IDs.

### Variables

- `next-loan-id`: Tracks the unique ID for newly issued loans.
- `total-stx-locked`: Aggregates the total amount of STX locked as collateral.

## Credit Scoring System

The credit score ranges from **50 to 100**, with a minimum of **70** required to request a loan. Key scoring behavior:

- ✅ Successful repayments increase score by up to 2 points.
- ❌ Loan defaults decrease score by up to 10 points.
- 🧮 Scores directly influence:
  - **Collateral ratio**
  - **Interest rate**

## Core Functionality

### `initialize-score`

Initializes a user’s credit score. Must be called once before borrowing.

```clojure
(define-public (initialize-score) ...)
```

---

### `request-loan`

Initiates a loan with specified amount, collateral, and duration.

- Verifies user’s credit score (must be ≥ 70).
- Calculates dynamic interest and collateral ratio.
- Transfers loan amount and locks collateral.

```clojure
(define-public (request-loan (amount uint) (collateral uint) (duration uint)) ...)
```

### `repay-loan`

Allows partial or full repayment of a loan. Returns collateral upon full repayment and updates the user's credit score.

```clojure
(define-public (repay-loan (loan-id uint) (amount uint)) ...)
```

### `mark-loan-defaulted`

Admin-only function that marks overdue loans as defaulted and penalizes the borrower’s credit score.

```clojure
(define-public (mark-loan-defaulted (loan-id uint)) ...)
```

---

## Helper Functions

- `calculate-required-collateral`: Lower scores require higher collateral.
- `calculate-interest-rate`: Score-based interest adjustment.
- `calculate-total-due`: Computes loan repayment including interest.
- `update-credit-score`: Adjusts user score based on repayment/default outcome.
- `update-user-loans`: Tracks a user's active loans (up to 20 max).

## Read-Only Functions

- `get-user-score`: Returns a user’s credit score and repayment history.
- `get-loan`: Fetches loan details by ID.
- `get-user-active-loans`: Returns list of active loans for a user.

## Errors & Safeguards

All major operations enforce validation checks:

| Error Code      | Description                         |
|-----------------|-------------------------------------|
| `u1`            | Unauthorized access                 |
| `u2`            | Insufficient balance/collateral     |
| `u3`            | Invalid loan amount                 |
| `u4`            | Loan not found                      |
| `u5`            | Loan already defaulted              |
| `u6`            | Insufficient credit score           |
| `u7`            | Too many active loans               |
| `u8`            | Loan not yet due                    |
| `u9`            | Invalid loan duration               |
| `u10`           | Invalid loan ID                     |

## Example Use Case

1. **User calls** `initialize-score`.
2. **Requests loan** using `request-loan`, providing STX as collateral.
3. **Repays** with `repay-loan` over time.
4. If overdue, admin calls `mark-loan-defaulted`.

## Built With

- [Clarity Language](https://docs.stacks.co/concepts/clarity/overview)
- [Stacks Blockchain](https://www.stacks.co)
- Bitcoin-secured design principles

## Contributing

Interested in enhancing BitLend? Feel free to fork and submit a PR. Join the community, share your ideas, and help build decentralized finance on Bitcoin.
