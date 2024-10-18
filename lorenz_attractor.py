from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt
from random import random

# Standard Simulation Parameters
sigma = 10
beta = 8/3
rho = 28

# Customizable parameters
num_ics = 2

tspan = (0, 50) # in seconds

# Simulation parameters for integration, decreases error allowance
options = {"rtol": 1e-9, "atol": 1e-6}

# Possible graphing colors
colors = [
    (0.2, 0.6, 0.8),  # Light Blue
    (0.9, 0.1, 0.1),  # Soft Red
    (0.4, 0.8, 0.4),  # Soft Green
    (0.9, 0.7, 0.2),  # Golden Yellow
    (0.6, 0.4, 0.8),  # Lavender Purple
    (0.3, 0.7, 0.9),  # Sky Blue
    (0.9, 0.5, 0.3),  # Peach
    (0.5, 0.7, 0.3),  # Olive Green
    (0.8, 0.2, 0.5),  # Rose Pink
    (0.2, 0.8, 0.6)   # Mint Green
]

# Generate num random initial coniditions, each coordinate a float in range [-1, 1]
def make_ics(num : int):
    if num < 0:
        return
    
    ics = []
    for i in range(num):
        ic = [0, 0, 0]
        for val in range(len(ic)):
            ic[val] = round((random()*2 - 1.0), 2)
        ics.append(ic)
    return ics

# Lorenz System Equations
def lorenz(t, Y, sigma, beta, rho):
        x, y, z = Y
        dxdt = [sigma*(y-x),
                x*(rho-z)-y,
                x*y-beta*z]
        return dxdt

# Main function of the program. Plots solutions to Lorenz Equations for given ICs.
def lorenz_plotter(num_ics):
    ics = make_ics(num_ics)

    # Set up plot
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1, projection="3d")
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.set_zlabel("z")
    ax.set_title(f"Lorenz Attractor (rho={rho})")

    # Run IC though ODE solver and plot results
    for i, ic in enumerate(ics):
        solution = solve_ivp(lorenz, tspan, ic, args=(sigma, beta, rho), rtol=options["rtol"], atol=options["atol"])

        x, y, z = solution.y

        ax.plot(x, y, z, color=colors[i], label=f'Initial conditions: {ic}')

    # handle buttonpress
    fig.canvas.mpl_connect('key_press_event', onPress)

    ax.legend(loc="upper center")

    plt.show()

# escape exits program, any other key resets ICs
def onPress(event):
    if event.key=='escape':
        plt.close('all')
    else:
        plt.close()
        lorenz_plotter(num_ics)

# begins process
lorenz_plotter(num_ics)