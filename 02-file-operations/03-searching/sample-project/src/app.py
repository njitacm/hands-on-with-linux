#!/usr/bin/env python3
"""Main application entry point."""

import os
from database import connect_db
from auth import authenticate_user

# TODO: Add error handling for database connection
def main():
    db = connect_db()
    print("Application started successfully")
    print(f"Running on port {os.getenv('PORT', 8080)}")

    # FIXME: This should use proper logging instead of print
    print("Server is ready to accept connections")

if __name__ == "__main__":
    main()
