#!/usr/bin/python3
from dataclasses import dataclass, field
from functools import reduce
from typing import Iterable, Optional


@dataclass
class file:
    name: str
    parent: Optional["file"] = None
    size: int = 0
    children: list["file"] = field(default_factory=list)

    @property
    def root(self):
        root = self
        while root.parent != None:
            root = root.parent

        return root

    @property
    def is_directory(self):
        return bool(len(self.children))

    @property
    def total_size(self):
        return reduce(
            lambda total, file: total + file.total_size, self.children, self.size
        )

    @property
    def depth_first_traversal(self) -> Iterable["file"]:
        yield self
        for child in self.children:
            yield from child.depth_first_traversal


@dataclass
class Commands:
    commands: list[str]
    working_directory: file

    command_pointer: int = 0
    latest_command: str = ""
    latest_args: list[str] = field(default_factory=list)

    def parse_command(self):
        line = self.commands[self.command_pointer]
        line = line.strip("$ ")

        parts = line.split()

        self.latest_command = parts[0]
        self.latest_args = parts[1:]

    def run_command(self):
        command_handlers = {
            "cd": self.handle_cd,
            "ls": self.handle_ls,
        }

        handler = command_handlers[self.latest_command]
        handler()

    def handle_cd(self):
        arg = self.latest_args[0]
        self.command_pointer += 1

        if arg == "/":
            self.working_directory = self.working_directory.root
            return self.working_directory

        if arg == "..":
            self.working_directory = self.working_directory.parent
            return self.working_directory

        for child in self.working_directory.children:
            if child.name == arg:
                self.working_directory = child
                return child

        raise ValueError("Unexpected error...")

    def handle_ls(self):
        self.command_pointer += 1

        while self.command_pointer < len(self.commands) and not self.commands[
            self.command_pointer
        ].startswith("$ "):
            size, file_name = self.commands[self.command_pointer].split()

            if not size.isnumeric():
                size = 0

            size = int(size)
            new_file = file(file_name, self.working_directory, size)
            self.working_directory.children.append(new_file)

            self.command_pointer += 1

    def parse_commands(self):
        while self.command_pointer < len(self.commands):
            self.parse_command()
            self.run_command()

        return self.working_directory.root


def part1():
    with open("7des/input.txt", "r") as f:
        command_list = f.readlines()

    root = file("")
    commands = Commands(command_list, root)
    commands.parse_commands()

    small_directories = filter(
        lambda f: f.is_directory and f.total_size <= 100_000, root.depth_first_traversal
    )
    print(sum(map(lambda f: f.total_size, small_directories)))


def part2():
    with open("7des/input.txt", "r") as f:
        command_list = f.readlines()

    root = file("")
    commands = Commands(command_list, root)
    commands.parse_commands()

    max_space = 70_000_000 - 30_000_000
    current_size = root.total_size

    candidates = filter(
        lambda f: f.is_directory and current_size - f.total_size <= max_space,
        root.depth_first_traversal,
    )
    smallest_dir = min(candidates, key=lambda f: f.total_size)

    print(smallest_dir.total_size)


if __name__ == "__main__":
    part1()
    part2()
