#!/usr/bin/python
import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument(
    "-n",
    "--name",
    default="PATH",
    help=r"name of the envrionment virable to deal with, default is PATH",
)
subparsers = parser.add_subparsers(
    title="command", dest="command", required=True, metavar="command"
)
parser_list: argparse.ArgumentParser = subparsers.add_parser(
    name="list", help=r"list ${PATH}"
)
parser_prepend: argparse.ArgumentParser = subparsers.add_parser(
    name="prepend", help=r"prepend paths to ${PATH}"
)
parser_prepend.add_argument("paths", action="extend", nargs="*")
parser_append: argparse.ArgumentParser = subparsers.add_parser(
    name="append", help=r"append paths to ${PATH}"
)
parser_append.add_argument("paths", action="extend", nargs="*")
parser_remove: argparse.ArgumentParser = subparsers.add_parser(
    name="remove", help=r"remove paths from ${PATH}"
)
parser_remove.add_argument("paths", action="extend", nargs="*")


def deduplicate(arr: list[str]) -> list:
    result: list[str] = []
    for elem in arr:
        if elem not in result:
            result.append(elem)
    return result


if __name__ == "__main__":
    args: argparse.Namespace = parser.parse_args()
    paths: list[str] = os.getenv(key=args.name, default="").split(":")
    if args.command == "list":
        for path in paths:
            print(path)
    elif args.command in ["prepend", "append", "remove"]:
        args.paths = list(map(os.path.abspath, args.paths))
        args.paths = list(filter(os.path.exists, args.paths))
        if args.command == "prepend":
            paths = args.paths + paths
        elif args.command == "append":
            paths.extend(args.paths)
        elif args.command == "remove":
            for path in args.paths:
                if path in paths:
                    paths.remove(path)
        paths = deduplicate(paths)
        print(":".join(paths))
    else:
        raise ValueError(f"invalid command {args.command}")
