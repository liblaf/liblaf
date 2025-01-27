# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "awesome-list-generator",
#     "githubkit",
#     "icecream",
#     "liblaf-grapes",
#     "typer",
# ]
# ///

import asyncio
from pathlib import Path
from typing import Annotated

import awesome_list_generator as alg
import githubkit
import githubkit.versions.latest.models as ghm
import typer
from icecream import ic
from liblaf import grapes

CATEGORIES: list[alg.Category] = [
    alg.Category(category="auto", title="Automation"),
    alg.Category(category="c/c++", title="C/C++"),
    alg.Category(category="cli", title="CLI"),
    alg.Category(category="copier", title="Copier Template"),
    alg.Category(category="coursework", title="Coursework"),
    alg.Category(category="go", title="Go"),
    alg.Category(category="python", title="Python"),
    alg.Category(category="rust", title="Rust"),
    alg.Category(category="typescript", title="TypeScript"),
    alg.Category(category="web", title="Website"),
]


GITHUB_TO_CATEGORY: dict[str, str] = {}


LANGUAGE_TO_CATEGORY: dict[str, str] = {
    "c": "c/c++",
    "c++": "c/c++",
    "go": "go",
    "javascript": "typescript",
    "python": "python",
    "typescript": "typescript",
}


TOPIC_TO_CATEGORY: dict[str, str] = {
    "ci": "auto",
    "cli": "cli",
    "copier-template": "copier",
    "coursework": "coursework",
    "go": "go",
    "python": "python",
    "rust": "rust",
    "typescript": "typescript",
    "web": "web",
    "website": "web",
}


async def async_main(user: str | None, output: Path) -> None:
    gh: githubkit.GitHub = alg.get_octokit()
    if user is None:
        auth: ghm.PrivateUser | ghm.PublicUser = (
            await gh.rest.users.async_get_authenticated()
        ).parsed_data
        user = auth.login
    projects: list[alg.ProjectConfig] = []
    async for repo in gh.paginate(gh.rest.repos.async_list_for_user, username=user):
        if repo.fork:
            continue
        categories: list[str] = []
        if category := GITHUB_TO_CATEGORY.get(repo.full_name):
            categories.append(category)
        if repo.language:
            language: str = repo.language.lower()
            if category := LANGUAGE_TO_CATEGORY.get(language):
                categories.append(category)
        if repo.topics:
            for topic in repo.topics:
                if category := TOPIC_TO_CATEGORY.get(topic):
                    categories.extend([category])
        project = alg.ProjectConfig(categories=categories, github=repo.full_name)
        ic(project.github, project.categories)
        projects.append(project)
    cfg = alg.Config(categories=CATEGORIES, projects=projects)
    grapes.serialize(
        output,
        cfg.model_dump(exclude_unset=True, exclude_defaults=True, exclude_none=True),
    )


def main(
    user: Annotated[str | None, typer.Argument()] = None,
    output: Annotated[Path, typer.Option("-o", "--output")] = Path("projects.yaml"),
) -> None:
    asyncio.run(async_main(user=user, output=output))


if __name__ == "__main__":
    typer.run(main)
