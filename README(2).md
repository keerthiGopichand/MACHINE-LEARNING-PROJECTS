
# E-commerce time series model sales and demand 

This project focuses on building a robust time-series forecasting solution to predict daily sales and daily demand across multiple product categories for an e-commerce platform. The solution leverages advanced forecasting models and machine learning techniques to optimize inventory management, improve operational efficiency, and enhance customer satisfaction.

## Problem Statement
Accurate time-series forecasting is crucial for optimizing inventory and supply chain management, reducing costs, and improving customer satisfaction in the highly competitive e-commerce industry. This project aims to:

Predict daily sales for the e-commerce platform.
Forecast daily demand across multiple product categories.

## Business Benefits

- Inventory Optimization: Helps maintain optimal stock levels, - reducing the risk of over-stocking or under-stocking.
- Marketing Effectiveness: Evaluates the impact of marketing campaigns on sales and demand.
- Operational Efficiency: Reduces storage, shipping, and handling costs by aligning inventory levels with demand.
- Customer Satisfaction: Ensures product availability, leading to timely deliveries and improved customer satisfaction.

## Key Business Metrics

- Inventory Turnover Rate: Measures how quickly inventory is sold and replaced.
- Customer Satisfaction Score (CSAT): Ensures product availability for timely deliveries.
- Operational Costs: Helps control costs related to storage and shipping.
- Stockout Rate: Reduces the frequency of stockouts, ensuring products are available when needed.

# Features Engineered and Methodology
## Data Preprocessing
- Filtered orders with delivered status.
- Merged datasets to create a unified view of orders, products, and categories.
- Engineered features such as holidays, lag features, and rolling statistics.
- Handled duplicate product categories and missing values.
Forecasting Models

## Daily Sales Forecasting:

- SARIMAX: A seasonal ARIMA model with exogenous variables (e.g., holidays).
- XGBoost: A machine learning approach using lag features, rolling statistics, and temporal features.

## Demand Forecasting Across Product Categories:

- Built a global model for all product categories using XGBoost.
- Engineered features such as lags, rolling means, day of the week, and holiday indicators.

## Key Insights

- SARIMAX: Captures seasonality and trends but struggles with accuracy for complex patterns.
- XGBoost: Outperforms SARIMAX in accuracy, especially for daily sales forecasting.
- Global Model for Demand Forecasting: Simplifies maintenance and deployment by training a single model for all product categories.

## Results

Daily Sales Forecasting:

- SARIMAX RMSE: ~14,000
- XGBoost RMSE: ~3,000 (significantly better performance)

Demand Forecasting Across Product Categories:

- RMSE varies by category, with the global XGBoost model providing accurate predictions for most categories.

## Visualizations
- Daily Sales Trends: Visualizes sales patterns, seasonality, and outliers (e.g., Black Friday).
- ETS Decomposition: Highlights trends, seasonality, and residuals in sales data.
- Forecast Plots: Compares actual vs. predicted sales and demand.
## Future Work
- Incorporate external factors such as weather, promotions, and competitor pricing.
- Experiment with deep learning models (e.g., LSTMs) for improved accuracy.
- Develop a web-based dashboard for real-time forecasting and visualization.
