## v1.1.0.9000 (Development Version)

- Update to LogoCLim v2.1.0.9000.
- Updated the *Climate Variable Inspection* world visualization mechanics.
- Removed `inspection` as global variable and dropped the switches `inspect-tmin`, `inspect-tmax`, and `inspect-prec`. Added a single switch `inspect-var?`, along with a chooser, `inspection-var`, to select the climate variable to inspect. The model now don't halt when toggling the switch during the simulation.
- Updated the documentation to reflect these changes.

## v1.1.0 (2025-09-16)

- Updated *Juvenile* color in *Logônias* for better contrast.
- Modified climate variable inspection: the model now halts if a switch is toggled during the simulation.
- Upgraded [`LogoClim`](https://github.com/sustentarea/logoclim) to v2.1.0.
- Revised 12-month moving average for climate variables to use values directly from [`LogoClim`](https://github.com/sustentarea/logoclim).
- Fixed 12-month moving average counter for *Logônia* plants.
- Fixed `logistic-regression` to return `false` when encountering `false` values.
- Refactored code for improved readability and maintainability.
- Updated the documentation.

## v1.0.0 (2025-09-13)

First release! 🎉
