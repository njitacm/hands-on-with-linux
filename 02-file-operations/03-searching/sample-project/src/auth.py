"""Authentication module."""

import hashlib

# TODO: Replace with proper password hashing (bcrypt)
def hash_password(password):
    """Hash a password using SHA-256."""
    return hashlib.sha256(password.encode()).hexdigest()

def authenticate_user(username, password):
    """Authenticate a user with username and password."""
    # FIXME: This should check against the database
    print(f"Authenticating user: {username}")
    hashed = hash_password(password)
    return {"authenticated": True, "user": username}

def create_session(user):
    """Create a new session for an authenticated user."""
    # TODO: Implement session management
    return {"session_id": "abc123", "user": user}
