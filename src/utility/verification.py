import hashlib

from utility.hash_util import hash_block
from wallet import Wallet


class Verification:

    @staticmethod
    def valid_proof(transactions, last_hash, proof):
        guess = f"{[tx.to_ordered_dict() for tx in transactions]}{last_hash}{proof}".encode()
        guess_hash = hashlib.sha3_256(guess).hexdigest()
        print(guess_hash)
        return guess_hash[:2] == "00"

    @classmethod
    def verify_chain(cls, blockchain):
        for (index, block) in enumerate(blockchain):
            if index == 0:
                continue
            if block.previous_hash != hash_block(blockchain[index - 1]):
                return False
            if not cls.valid_proof(block.transactions[:-1], block.previous_hash, block.proof):
                print("Proof of work is invalid! ")
                return False
        return True

    @staticmethod
    def verify_transaction(transaction, get_balance, check_funds=True):
        if check_funds:
            sender_balance = get_balance(transaction.sender)
            return sender_balance >= transaction.amount and Wallet.verify_transaction(transaction)
        else:
            return Wallet.verify_transaction(transaction)

    @classmethod
    def verify_transactions(cls, open_transactions, get_balance):
        return all([cls.verify_transaction(tx, get_balance) for tx in open_transactions])
