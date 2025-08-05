#!/usr/bin/env python3
import json, sys, pathlib
from pathlib import Path

DATA = Path.home() / ".todo.json"

def load() -> list[str]:
    return json.loads(DATA.read_text()) if DATA.exists() else []

def save(todos: list[str]):
    DATA.write_text(json.dumps(todos, ensure_ascii=False, indent=2))

def main():
    if len(sys.argv) < 2:
        print("Usage: todo <add|list|done> [text|id]")
        return

    cmd, *args = sys.argv[1:]
    todos = load()

    match cmd:
        case "add":
            text = " ".join(args)
            todos.append(text)
            save(todos)
            print(f"Added: {text}")
        case "list":
            for idx, text in enumerate(todos, 1):
                print(f"{idx}. {text}")
        case "done":
            idx = int(args[0]) - 1
            removed = todos.pop(idx)
            save(todos)
            print(f"Done: {removed}")
        case _:
            print("Unknown command")

if __name__ == "__main__":
    main()
