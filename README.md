# Uber Demand-Supply Data Analysis

## Project Overview
This project conducts a comprehensive analysis of Uber ride request data to identify demand-supply gaps, assess trip success rates, and uncover revenue leakage opportunities. By leveraging exploratory data analysis and SQL-based insights, this project provides actionable recommendations for optimizing driver allocation and improving service reliability.

## Objectives
- **Identify Demand-Supply Gaps**: Analyze unmet demand and supply constraints across different time periods and pickup locations
- **Improve Trip Success Rate**: Determine factors affecting trip completion and identify operational bottlenecks
- **Highlight Revenue Leakage Areas**: Pinpoint periods and locations with high cancellation rates and unavailable car situations
- **Analyze Driver Utilization**: Evaluate driver availability patterns and utilization efficiency
- **Optimize Resource Allocation**: Provide location and time-based recommendations for supply optimization

## Project Structure
```
Uber_demand-suppply_Data_Analysis/
├── README.md                          # Project documentation
├── Cab_request_data/
│   └── Uber Request Data.csv         # Raw ride request dataset
├── Exploratory_data_analysis/
│   └── EDA.ipynb                     # Jupyter notebook with exploratory analysis
└── SQL_Insights/
    └── Uber_Insights.sql            # SQL queries for business insights
```

## Dataset Description
**File**: `Cab_request_data/Uber Request Data.csv`

**Data Attributes**:
| Column | Description |
|--------|-------------|
| `Request id` | Unique identifier for each ride request |
| `Pickup point` | Location of ride request (e.g., Airport, City) |
| `Driver id` | Unique identifier assigned to the driver |
| `Status` | Trip outcome (Trip Completed, Cancelled, No Cars Available) |
| `Request timestamp` | Date and time when the ride was requested |
| `Drop timestamp` | Date and time when the trip was completed |

## Analysis Components

### 1. Exploratory Data Analysis (EDA)
- **File**: `Exploratory_data_analysis/EDA.ipynb`
- **Technologies**: Python, Pandas, Matplotlib, Seaborn
- **Activities**:
  - Data loading and quality assessment
  - Missing value analysis
  - Temporal pattern identification
  - Pickup point performance visualization
  - Trip status distribution analysis

### 2. SQL-Based Insights
- **File**: `SQL_Insights/Uber_Insights.sql`
- **Purpose**: Structured queries for KPI computation
- **Key Analyses**:
  - Overall trip success rate calculation
  - Demand-supply gap by request status
  - Hourly demand vs. supply analysis for peak period identification
  - Day-wise performance metrics
  - Pickup point-specific demand-supply analysis

## Key Metrics & KPIs

### Trip Success Rate
- Percentage of completed trips relative to total requests
- Indicator of overall service quality and operational efficiency

### Demand-Supply Gap
- Count of unmet demands (Cancelled trips, No Cars Available)
- Identifies periods and locations with supply constraints

### Revenue Leakage Analysis
- Analysis of cancellations and unavailable cars by time and location
- Quantifies lost revenue opportunities

### Peak Demand Periods
- Hourly and day-wise demand patterns
- Informs driver scheduling and resource allocation strategies

## How to Use This Repository

### Step 1: Explore the Data
Start with the Jupyter notebook to understand data characteristics:
```
- Open: Exploratory_data_analysis/EDA.ipynb
- Review: Data distributions, patterns, and initial insights
```

### Step 2: Run SQL Queries
Execute structured queries for business insights:
```
- Open: SQL_Insights/Uber_Insights.sql
- Execute queries to generate KPIs and performance metrics
```

### Step 3: Generate Reports
Use insights to create actionable recommendations and reports for stakeholders.

## Key Insights & Findings

### Supply-Demand Mismatch
- Certain pickup points experience higher "No Cars Available" frequencies
- Specific time slots show significant unmet demand

### Cancellation Patterns
- Cancellations concentrated at particular locations and times
- Indicates potential service quality or pricing issues

### Driver Allocation Opportunity
- Uneven driver distribution across pickup points
- Potential for dynamic allocation to improve success rates

## Recommendations

1. **Increase Driver Capacity**: Deploy additional drivers during peak demand hours identified in the analysis
2. **Optimize Pickup Locations**: Concentrate resources at high-demand, low-supply areas
3. **Pricing Strategy**: Implement surge pricing during high-demand, low-supply periods to manage demand
4. **Service Improvement**: Investigate root causes of cancellations at problematic locations
5. **Dynamic Allocation**: Implement real-time driver redistribution based on demand patterns

## Technical Stack
- **Language**: Python, SQL
- **Tools**: Jupyter Notebook, Database (SQL-compatible)
- **Libraries**: Pandas, NumPy, Matplotlib, Seaborn (for EDA)

## Author
**Bhavesh Kumar**

## Project Status
✓ Data Collection Complete  
✓ EDA In Progress  
✓ SQL Analysis Complete  
⏳ Business Recommendations: Pending

## Version History
- **v1.0** (January 2026): Initial project setup and analysis

---

**Last Updated**: January 16, 2026

*For questions or contributions, please contact the project author.*
