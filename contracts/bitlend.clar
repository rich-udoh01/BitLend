;; Title: BitLend - Decentralized Lending Protocol
;; Version: 1.0.0
;; Author: BitLend Protocol Team
;;
;; Summary:
;; A credit-based decentralized lending protocol on the Stacks blockchain
;; that enables users to borrow STX tokens based on their credit score and
;; collateral requirements.
;;
;; Description:
;; BitLend is a Bitcoin-friendly lending protocol that creates a decentralized
;; credit system on Stacks. It implements a scoring system that rewards responsible
;; borrowing behavior with better loan terms and lower collateral requirements.
;; The protocol enables permissionless lending and borrowing while maintaining
;; appropriate risk management through a dynamic credit scoring mechanism.
;;
;; Features:
;; - Credit score system (50-100) that influences loan terms
;; - Collateral requirements that decrease with higher credit scores
;; - Interest rates that decrease with higher credit scores
;; - Automatic handling of repayments and defaults
;; - Incentives for maintaining good borrowing behavior

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))
(define-constant ERR-INVALID-AMOUNT (err u3))
(define-constant ERR-LOAN-NOT-FOUND (err u4))
(define-constant ERR-LOAN-DEFAULTED (err u5))
(define-constant ERR-INSUFFICIENT-SCORE (err u6))
(define-constant ERR-ACTIVE-LOAN (err u7))
(define-constant ERR-NOT-DUE (err u8))

;; Credit score thresholds
(define-constant MIN-SCORE u50)
(define-constant MAX-SCORE u100)
(define-constant MIN-LOAN-SCORE u70)

;; Data Maps
(define-map UserScores
    { user: principal }
    {
        score: uint,
        total-borrowed: uint,
        total-repaid: uint,
        loans-taken: uint,
        loans-repaid: uint,
        last-update: uint
    }
)

(define-map Loans
    { loan-id: uint }
    {
        borrower: principal,
        amount: uint,
        collateral: uint,
        due-height: uint,
        interest-rate: uint,
        is-active: bool,
        is-defaulted: bool,
        repaid-amount: uint
    }
)
