 # Splitwise Application

This repository contains the codebase for a Splitwise-like application built with Ruby on Rails. The application enables users to track expenses among friends, allowing them to share bills, view their own expenses, and see expenses of their friends.

## Getting Started

To get started with the application, follow these steps:

1. Clone the repository to your local machine:
   git clone https://github.com/ahmadadnan16/splitwise_task
2. Install dependencies: bundle install
3. set up databse: rails db:setup
4. run server: rails s


## Basic Functionality

The application consists of three main sections:

1. **Sharing the Expense - Itemized Bill**
- Allows users to register expenses, specifying the total amount spent, the users involved, and how the amount is divided.
- Each item in the bill can be assigned to a specific person or split equally among all users.
- Tax can be added to the total amount, which is then evenly split among all users.

2. **Dashboard - Listing My Expenses**
- Provides users with an overview of their expenses.
- Displays the total balance, total amount owed by the user, and total amount owed to the user.
- Lists friends whom the user owes and the amount owed, as well as friends who owe the user and the amount owed.

3. **List Friend Expenses**
- Allows users to view expenses made by their friends.
- Each expense record includes the date, description of the expense, who paid for it, and whether the user has borrowed or lent money.
