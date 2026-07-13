# Changelog

All notable changes to this project will be documented below.

The format is based on [Keep a Changelog](https://keepachangelog.com/). The project also follows [Semantic Versioning](https://semver.org/) and [Conventional Commits](https://www.conventionalcommits.org/).

## v1.2.1 (2026-07-13)

### Added

- A [Zenodo](https://zenodo.org/) DOI was created for this and future releases of the project.

### Changed

- The documentation was updated.

## v1.2.0 (2026-07-13)

### Added

- Automated unit tests using the [`check-netlogo`](https://github.com/danielvartan/netlogo-actions) action from the [`LogoActions`](https://github.com/danielvartan/logoactions) project. Tests run on Windows, macOS, and Linux with the latest NetLogo release at each commit.
- [`renv`](https://rstudio.github.io/renv/) to manage R dependencies for the Quarto notebooks.

### Changed

- Upgraded [`LogoClim`](https://github.com/sustentarea/logoclim) to v2.2.0.
- Updated the *Climate Variable Inspection* world visualization mechanics.
- Removed `inspection` as a global variable and dropped the switches `inspect-tmin`, `inspect-tmax`, and `inspect-prec`. Added a single switch `inspect-var?`, along with a chooser, `inspection-var`, to select the climate variable to inspect. The model no longer halts when toggling the switch during the simulation.
- Refactored code in the Quarto notebooks for reproducing the model data.
- Updated data files, following the latest changes in the [`LogoClim`](https://github.com/sustentarea/logoclim) model.
- Updated the Code of Conduct to Contributor Covenant v3.0.
- Updated all dependencies to their latest versions.
- Documentation updated to reflect all changes.

## v1.1.0 (2025-09-16)

### Changed

- Updated *Juvenile* color in *Logônias* for better contrast.
- Modified climate variable inspection: the model now halts if a switch is toggled during the simulation.
- Upgraded [`LogoClim`](https://github.com/sustentarea/logoclim) to v2.1.0.
- Revised 12-month moving average for climate variables to use values directly from [`LogoClim`](https://github.com/sustentarea/logoclim).
- Refactored code for improved readability and maintainability.
- Updated the documentation.

### Fixed

- Fixed 12-month moving average counter for *Logônia* plants.
- Fixed `logistic-regression` to return `false` when encountering `false` values.

## v1.0.0 (2025-09-13)

First release! 🎉
