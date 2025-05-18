import re

with open('users_customuser_inserts.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all value tuples in all INSERT statements (handles multiple tuples per statement)
matches = re.findall(r'INSERT INTO.*?VALUES\s*(.+?);', content, re.DOTALL)

row_count = 0
for match in matches:
    # Find all tuples in this INSERT statement
    tuples = re.findall(r'\((.*?)\)', match, re.DOTALL)
    row_count += len(tuples)

print(f"Total number of rows: {row_count}")