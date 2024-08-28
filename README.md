# GA-PSO Hybrid Optimization Algorithm

## Overview

This MATLAB project implements a hybrid optimization algorithm that combines Genetic Algorithm (GA) and Particle Swarm Optimization (PSO). The algorithm is designed to optimize a set of parameters (genes) for various problems, making it flexible and adaptable to different optimization scenarios.

## Features

- **Hybrid Algorithm**: Combines the exploration abilities of GA with the exploitation capabilities of PSO.
- **Customizable**: Easily adapt the algorithm to optimize different types of problems by modifying the fitness functions.
- **Scalable**: Adjust the number of genes and population size to suit the complexity of your problem.

## Getting Started

### Prerequisites

- MATLAB installed on your system.
- Basic understanding of optimization algorithms.

### Installation

1. Clone this repository to your local machine.
```bash
git clone https://github.com/izzuddinafif/MATLAB-GA-PSO.git
```
2. Open MATLAB and navigate to the project directory.
### Usage

1. Open `main_script.m` in MATLAB.
2. Adjust the parameters at the top of the script as per your optimization problem.
3. Define your custom fitness functions if necessary.
4. Run the script.

For more detailed instructions, see the [User Guide](docs/user_guide.md).

## Documentation

- [User Guide](docs/user_guide.md): Step-by-step instructions on how to use the algorithm.
- [Developer Guide](docs/developer_guide.md): Technical details on the implementation and how to modify or extend the algorithm.
- [Example Usage](docs/example_usage.md): Examples of how to set up and run the algorithm for different types of optimization problems.

## Customization

To optimize genes using your own functions:

1. Modify the `calculate_total` and `calculate_fitness` functions to suit your problem.
2. Adjust the `gen_count`, `upper_bounds`, and `lower_bounds` parameters in `main_script.m` to match your custom functions.

For more details on customization, refer to the [Developer Guide](docs/developer_guide.md).

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

If you have any questions or need further assistance, please reach out to [izzuddinafif\@gmail.com](mailto:izzuddinafif@gmail.com?subject=GA-PSO).
