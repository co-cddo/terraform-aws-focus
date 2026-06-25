# Contributing

Thank you for your interest in this module. It is maintained by the
OCTO Observability team (`@co-cddo/octo-observability`)
at the Department for Science, Innovation & Technology.

## Getting help

- **Questions or ideas?** Open a [GitHub issue](../../issues/new).
- **Security concerns?** See [SECURITY.md](SECURITY.md) — do not raise a public issue.
- **General contact:** Mention `@co-cddo/octo-observability` on the relevant issue or PR, or email [observability@dsit.gov.uk](mailto:observability@dsit.gov.uk).

## Making a contribution

1. Fork the repository and create a branch: `<type>/<short-description>`
   (e.g. `fix/s3-bucket-policy`).
2. Make your changes. Run `terraform fmt` and `terraform validate` before pushing.
3. Open a pull request against `main`. A member of the team will review it.
4. Address review feedback. Once approved, a maintainer will merge.

## Code standards

- Follow [Conventional Commits](https://www.conventionalcommits.org/): `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`
- Keep Terraform formatted: `terraform fmt -recursive`
- Do not commit secrets, account IDs, or ARNs

## Licence

By contributing, you agree that your contributions will be licensed under the
[MIT Licence](LICENCE).
