import re
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 remove_deadcode.py <file>")
        return
    file = sys.argv[1]

    with open(file, "r") as f:
        lines = f.readlines()

    new_lines = []

    for i in range(len(lines)):
        line = lines[i]

        # Pattern 1: x = nil; followed shortly by x = ...;
        match_nil = re.match(r"^(\s*)([a-zA-Z0-9_]+)\s*=\s*nil;\s*$", line)
        if match_nil:
            indent = match_nil.group(1)
            var_name = match_nil.group(2)

            is_dead = False
            for j in range(i+1, min(len(lines), i+30)): # Increased search depth to 30
                next_line = lines[j].strip()
                if not next_line or next_line.startswith("--"):
                    continue
                if next_line.startswith(f"{var_name} =") or next_line.startswith(f"local {var_name} =") or next_line.startswith(f"{var_name},"):
                    is_dead = True
                    break # Only break if we find a reassignment
                if re.match(r"^[a-zA-Z0-9_]+\s*=\s*", next_line) or re.match(r"^local\s+[a-zA-Z0-9_]+\s*=\s*", next_line):
                     continue # skip other assignments
                break # If we hit anything else, it's not immediately dead

            if is_dead:
                continue

        # Pattern 2: local _ = globals.realtime; or local _ = pairs;
        match_throwaway = re.match(r"^\s*local\s+_\s*=\s*(.+?);\s*$", line)
        if match_throwaway:
            expr = match_throwaway.group(1).strip()
            if re.match(r"^[a-zA-Z_][a-zA-Z0-9_]*(\.[a-zA-Z_][a-zA-Z0-9_]*)*$", expr) or expr == '""' or expr == "false" or expr == "true" or expr.isdigit():
                continue # deadcode

        # Pattern 3: local x = nil; immediately followed by x = ...;
        match_local_nil = re.match(r"^(\s*)local\s+([a-zA-Z0-9_]+)\s*=\s*nil;\s*$", line)
        if match_local_nil:
            indent = match_local_nil.group(1)
            var_name = match_local_nil.group(2)

            is_dead = False
            for j in range(i+1, min(len(lines), i+30)):
                next_line = lines[j].strip()
                if not next_line or next_line.startswith("--"):
                    continue
                if next_line.startswith(f"{var_name} =") or next_line.startswith(f"{var_name},"):
                    is_dead = True
                    break
                if re.match(r"^[a-zA-Z0-9_]+\s*=\s*", next_line) or re.match(r"^local\s+[a-zA-Z0-9_]+\s*=\s*", next_line):
                     continue # skip other assignments
                break

            if is_dead:
                new_lines.append(f"{indent}local {var_name};\n")
                continue

        new_lines.append(line)

    with open(file, "w") as f:
        f.writelines(new_lines)

if __name__ == "__main__":
    main()
