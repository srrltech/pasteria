import re

def find_deadcode(file_path):
    with open(file_path, "r") as f:
        lines = f.readlines()

    patterns = [
        (r"local\s+_\s*=", "Assignment to _ (throwaway variable)"),
        (r"^(\s*)([a-zA-Z0-9_]+)\s*=\s*nil;\s*$", "Variable explicitly set to nil (often used for forward declaration or clearing, could be dead if repeated)"),
        (r"local\s+([a-zA-Z0-9_]+)\s*=\s*nil;\s*$", "Local variable initialized to nil")
    ]

    with open("deadcode_patterns.log", "w") as out:
        for i, line in enumerate(lines):
            for pattern, description in patterns:
                if re.search(pattern, line):
                    out.write(f"Line {i+1}: {description}\n")
                    out.write(f"Context:\n")
                    start = max(0, i - 2)
                    end = min(len(lines), i + 3)
                    for j in range(start, end):
                        prefix = ">> " if j == i else "   "
                        out.write(f"{prefix}{j+1}: {lines[j].rstrip()}\n")
                    out.write("-" * 40 + "\n")
                    break # Avoid multiple matches for the same line

if __name__ == "__main__":
    find_deadcode("hysteriaNL_fix.lua")
