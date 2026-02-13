"""General utility functions."""

import datetime

def format_date(dt):
    """Format a datetime object as a string."""
    return dt.strftime("%Y-%m-%d %H:%M:%S")

def parse_csv_line(line):
    """Parse a single CSV line into fields."""
    return line.strip().split(",")

def generate_id():
    """Generate a unique identifier."""
    # TODO: Use UUID instead of timestamp
    return str(int(datetime.datetime.now().timestamp()))

def sanitize_input(text):
    """Remove potentially dangerous characters from user input."""
    # FIXME: This is not comprehensive enough for production
    dangerous_chars = ["<", ">", "&", '"', "'"]
    for char in dangerous_chars:
        text = text.replace(char, "")
    return text
