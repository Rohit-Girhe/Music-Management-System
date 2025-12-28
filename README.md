# Music Store Management System 🎵

## 📌 Project Overview
The **Music Store Management System** is a SQL-based project designed to manage and analyze the data of a digital music store. This project demonstrates the implementation of a relational database to handle various aspects of the business, including music inventory (artists, albums, tracks), customer data, employee management, and sales transactions.

The repository includes scripts for creating the database schema, populating it with data, and performing advanced data analysis to derive business insights.

## 📂 Repository Structure
- **`Music_Store_.sql`**: The primary database setup script. It creates the database `music_store`, defines all necessary tables, and sets up relationships (Primary and Foreign Keys).
- **`task_que_ans.sql`**: A collection of SQL queries solving specific business problems (e.g., finding top-selling artists, analyzing customer spending, etc.).
- **`Music Store Dataset/`**: Contains CSV files used to populate the database tables.
- **`ER Diagram`**: Entity Relationship Diagrams visualizing the database schema.

## 🗂 Database Schema
The database is normalized and consists of the following key tables:

### **1. Music Inventory**
- **`artist`**: Stores artist details.
- **`album`**: Links albums to artists.
- **`track`**: Detailed track information including length, size, price, and genre.
- **`genre`**: Music categories (e.g., Rock, Jazz, Pop).
- **`media_type`**: Formats of the audio files (e.g., MPEG audio file).

### **2. User Management**
- **`employee`**: Staff details, job titles, and reporting hierarchy (reports_to).
- **`customer`**: Customer profiles including geographical location and assigned support representative.

### **3. Sales & Transactions**
- **`invoice`**: Header information for sales transactions (date, billing address, total amount).
- **`invoice_line`**: Line items for each invoice, linking specific tracks to sales.
- **`playlist`** & **`playlist_track`**: Managing user-created collections of tracks.

## 📊 Key Insights & Analysis
The project answers critical business questions through SQL queries found in `task_que_ans.sql`. Examples include:

1.  **Employee Seniority**: Identifying the senior-most employee based on job title.
2.  **Top Countries**: Analyzing which countries generate the most invoices.
3.  **Best Customers**: Identifying the highest-spending customers.
4.  **Genre Popularity**: Determining the most popular music genre for each country.
5.  **Rock Music Analysis**: Listing all Rock music listeners and top Rock bands.
6.  **Artist Earnings**: Calculating how much money each customer has spent on specific artists.

## 🛠 Technologies Used
- **SQL** (Structured Query Language)
- **Database Management System**: MySQL / SQL Server
- **Concepts**: DDL (Data Definition Language), DQL (Data Query Language), Joins, Aggregations, Subqueries, CTEs (Common Table Expressions).

## 🚀 How to Run
1.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/your-username/music-store-management.git](https://github.com/your-username/music-store-management.git)
    ```
2.  **Set Up the Database**:
    - Open your SQL tool (e.g., MySQL Workbench).
    - Run the `Music_Store_.sql` script to create the tables.
3.  **Import Data**:
    - Import the CSV files from the `Music Store Dataset` folder into their respective tables in the order of dependencies (e.g., import Artists before Albums).
4.  **Run Analysis**:
    - Execute the queries in `task_que_ans.sql` to view the insights.

## 🤝 Contribution
Contributions are welcome! If you have suggestions for optimizing queries or new analysis ideas, please create a pull request.

---
*This project is for educational purposes to demonstrate SQL proficiency and database management skills.*
