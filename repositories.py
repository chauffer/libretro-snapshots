# https://gist.github.com/ralphbean/5733076
from github import Github
import os

gh = None


def gather_clone_urls(organization):
    org = gh.get_organization(organization)
    for repo in org.get_repos(type="all"):
        yield repo


if __name__ == "__main__":
    gh = Github(os.getenv("GITHUB_TOKEN"))
    for repo in gather_clone_urls(os.getenv("ORGANIZATION")):
        print(repo.clone_url)
