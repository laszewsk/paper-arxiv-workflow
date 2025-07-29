import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import glob

# Specify the path to your CSV files
csv_files = glob.glob('bin/*.csv')

# Initialize an empty list to store DataFrames
dataframes = []

# Loop through each CSV file and read it
for file in csv_files:
    df = pd.read_csv(file)
    dataframes.append(df)

# Concatenate all DataFrames into one
all_data = pd.concat(dataframes, ignore_index=True)

# Extracting the relevant columns
ranks = all_data['Rank']
rmax_values = all_data['Rmax [TFlop/s]']

# Create a DataFrame for Seaborn
plot_data = pd.DataFrame({'Rank': ranks, 'Rmax': rmax_values})

# Set the style for the plot
sns.set(style='whitegrid')

# Plotting the Rmax values using Seaborn
plt.figure(figsize=(10, 6))
sns.lineplot(data=plot_data, x='Rank', y='Rmax', marker='o', color='skyblue')  # Line plot with markers
plt.xlabel('Rank')
plt.ylabel('Rmax [TFlop/s]')
plt.title('Rmax [TFlop/s] for Top Supercomputers')

# Set x-ticks to show only ranks that are multiples of 50
plt.xticks([rank for rank in ranks if rank % 50 == 0])

# Set x-axis limits based on rank values (1 to 500)
plt.xlim(1, 500)

# Set y-axis limits based on the min and max values of Rmax
plt.ylim(min(rmax_values), max(rmax_values))

# Limit the number of y-axis tick marks to 10
ax = plt.gca()  # Get the current axis
ax.yaxis.set_major_locator(ticker.MaxNLocator(nbins=10))  # Set max 10 ticks on y-axis

# Invert the y-axis for a Cartesian view
ax.invert_yaxis()

plt.grid()  # Optional: Add a grid for better readability

# Save the plot as PDF and PNG with 300 DPI
plt.savefig('supercomputers_rmax.pdf', format='pdf')
plt.savefig('supercomputers_rmax.png', format='png', dpi=300)

# Show the plot
plt.show()
